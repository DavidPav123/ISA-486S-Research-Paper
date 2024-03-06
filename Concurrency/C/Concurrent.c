#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define THREAD_POOL_SIZE 4
#define TASKS_COUNT 1000000

// Task structure
typedef struct
{
    int taskNumber;  // Task number or other parameters for the task
} Task;

// Task queue
Task taskQueue[TASKS_COUNT];
int taskIndex = 0;

// Thread function to process tasks
void* worker(void* arg) {
    while (1) {
        int index = __sync_fetch_and_add(&taskIndex, 1);
        if (index >= TASKS_COUNT) break;

        // Simple calculation or task processing
        printf("Thread %ld processing task %d\n", (long)pthread_self(), taskQueue[index].taskNumber);
        // For example, increment taskNumber (this is just a placeholder for an actual calculation)
        taskQueue[index].taskNumber++;
    }
    pthread_exit(NULL);
}

int main() {
    pthread_t threads[THREAD_POOL_SIZE];

    // Initialize task queue
    for (int i = 0; i < TASKS_COUNT; i++) {
        taskQueue[i].taskNumber = i;
    }

    // Create worker threads
    for (int i = 0; i < THREAD_POOL_SIZE; i++) {
        pthread_create(&threads[i], NULL, worker, NULL);
    }

    // Wait for all threads to complete
    for (int i = 0; i < THREAD_POOL_SIZE; i++) {
        pthread_join(threads[i], NULL);
    }

    fprintf(stderr, "All tasks have been processed.\n");

    return 0;
}
