use std::sync::{
    atomic::{AtomicUsize, Ordering},
    Arc,
};
use std::thread;

const THREAD_POOL_SIZE: usize = 4;
const TASKS_COUNT: usize = 1_000_000;

// Task struct
struct Task {
    task_number: usize,
}

// Worker function
fn worker(task_queue: Arc<Vec<Task>>, task_index: Arc<AtomicUsize>) {
    loop {
        let index = task_index.fetch_add(1, Ordering::SeqCst);
        if index >= TASKS_COUNT {
            break;
        }

        // Simulate task processing by printing and modifying the task_number
        // In a real application, ensure access to `task_queue[index]` is thread-safe or otherwise properly managed
        println!(
            "Thread {:?} processing task {}",
            thread::current().id(),
            task_queue[index].task_number
        );
    }
}

fn main() {
    // Initialize task queue
    let mut task_queue = Vec::with_capacity(TASKS_COUNT);
    for i in 0..TASKS_COUNT {
        task_queue.push(Task { task_number: i });
    }
    let task_queue = Arc::new(task_queue);

    // Atomic counter for task index
    let task_index = Arc::new(AtomicUsize::new(0));

    // Create and start worker threads
    let mut threads = Vec::with_capacity(THREAD_POOL_SIZE);
    for _ in 0..THREAD_POOL_SIZE {
        let task_queue_clone = Arc::clone(&task_queue);
        let task_index_clone = Arc::clone(&task_index);

        let thread = thread::spawn(move || {
            worker(task_queue_clone, task_index_clone);
        });
        threads.push(thread);
    }

    // Wait for all threads to complete
    for thread in threads {
        thread.join().unwrap();
    }

    println!("All tasks have been processed.");
}
