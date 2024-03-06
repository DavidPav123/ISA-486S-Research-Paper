with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;

procedure Spark is
    type Task_Type is record
        Task_Number : Integer;
    end record;

    package Task_Vectors is new Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Task_Type);

    protected type Task_Queue_Protected is
        procedure Get_And_Remove_First(Item : out Task_Type);
        procedure Append(Item : in Task_Type);
    private
        Queue : Task_Vectors.Vector;
    end Task_Queue_Protected;

    protected body Task_Queue_Protected is
        procedure Get_And_Remove_First(Item : out Task_Type) is
        begin
            if Queue.Length > 0 then
                Item := Queue(Queue.First);
                Queue.Delete_First;
            else
                Item := (Task_Number => -1); -- Return an invalid task when the queue is empty
            end if;
        end Get_And_Remove_First;

        procedure Append(Item : in Task_Type) is
        begin
            Queue.Append(Item);
        end Append;
    end Task_Queue_Protected;

    task type Worker(ID : Integer; Queue : access Task_Queue_Protected) is
        entry Start;
    end Worker;

    task body Worker is
        Current_Task : Task_Type;
    begin
        accept Start do
            null;
        end Start;

        loop
            Queue.Get_And_Remove_First(Current_Task);

            exit when Current_Task.Task_Number = -1; -- Exit when the queue is empty

            Put_Line ("Thread " & Integer'Image(ID) & " processing task " & Integer'Image (Current_Task.Task_Number));

            -- Do not append the task back to the queue
        end loop;
    end Worker;

    Task_Queue : aliased Task_Queue_Protected;

    Worker_1 : Worker(ID => 1, Queue => Task_Queue'Access);
    Worker_2 : Worker(ID => 2, Queue => Task_Queue'Access);
    Worker_3 : Worker(ID => 3, Queue => Task_Queue'Access);
    Worker_4 : Worker(ID => 4, Queue => Task_Queue'Access);

    begin
        for I in 1 .. 1_000_000 loop
            Task_Queue.Append ((Task_Number => I));
        end loop;

        Worker_1.Start;
        Worker_2.Start;
        Worker_3.Start;
        Worker_4.Start;

        Put_Line ("All tasks have been processed.");
    end Spark;