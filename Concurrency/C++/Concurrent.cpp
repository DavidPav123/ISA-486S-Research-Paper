#include <iostream>
#include <thread>
#include <atomic>
#include <vector>

#define THREAD_POOL_SIZE 4
#define TASKS_COUNT 1000000

// Task structure
struct Task
{
    int taskNumber;  // Task number or other parameters for the task
};

// Task queue
std::vector<Task> taskQueue(TASKS_COUNT);
std::atomic<int> taskIndex(0);

// Thread function to process tasks
void worker() {
    while (true) {
        int index = taskIndex.fetch_add(1);
        if (index >= TASKS_COUNT) break;

        // Simple calculation or task processing
        std::cout << "Thread " << std::this_thread::get_id() << " processing task " << taskQueue[index].taskNumber << std::endl;
        // For example, increment taskNumber (this is just a placeholder for an actual calculation)
        taskQueue[index].taskNumber++;
    }
}

int main() {
    std::vector<std::thread> threads;

    // Initialize task queue
    for (int i = 0; i < TASKS_COUNT; i++) {
        taskQueue[i].taskNumber = i;
    }

    // Create worker threads
    for (int i = 0; i < THREAD_POOL_SIZE; i++) {
        threads.push_back(std::thread(worker));
    }

    // Wait for all threads to complete
    for (auto& thread : threads) {
        thread.join();
    }

    std::cerr << "All tasks have been processed.\n";

    return 0;
}