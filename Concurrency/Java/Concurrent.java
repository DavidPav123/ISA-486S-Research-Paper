public class Concurrent {

    private static final int THREAD_POOL_SIZE = 4;
    private static final int TASKS_COUNT = 1000000;

    // Task class
    static class Task {
        int taskNumber;

        public Task(int taskNumber) {
            this.taskNumber = taskNumber;
        }
    }

    // Worker class
    static class Worker implements Runnable {
        private final Task[] taskQueue;
        private static int taskIndex = 0;

        public Worker(Task[] taskQueue) {
            this.taskQueue = taskQueue;
        }

        @Override
        public void run() {
            while (true) {
                int index;

                // Synchronized block to safely increment taskIndex
                synchronized (Worker.class) {
                    if (taskIndex >= TASKS_COUNT)
                        break;
                    index = taskIndex++;
                }

                // Process the task
                System.out.printf("Thread %s processing task %d\n", Thread.currentThread().getName(),
                        taskQueue[index].taskNumber);
                // Increment taskNumber as a placeholder for actual calculation
                taskQueue[index].taskNumber++;
            }
        }
    }

    public static void main(String[] args) {
        Task[] taskQueue = new Task[TASKS_COUNT];
        Thread[] threads = new Thread[THREAD_POOL_SIZE];

        // Initialize task queue
        for (int i = 0; i < TASKS_COUNT; i++) {
            taskQueue[i] = new Task(i);
        }

        // Create and start worker threads
        for (int i = 0; i < THREAD_POOL_SIZE; i++) {
            threads[i] = new Thread(new Worker(taskQueue), "Worker-" + i);
            threads[i].start();
        }

        // Wait for all threads to complete
        for (int i = 0; i < THREAD_POOL_SIZE; i++) {
            try {
                threads[i].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        System.err.println("All tasks have been processed.");
    }
}
