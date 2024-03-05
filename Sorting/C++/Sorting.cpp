#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>

void merge(std::vector<int>& arr, int const left, int const mid, int const right) {
    auto const subArrayOne = mid - left + 1;
    auto const subArrayTwo = right - mid;

    // Create temp arrays
    std::vector<int> leftArray(subArrayOne), rightArray(subArrayTwo);

    // Copy data to temp arrays
    for (auto i = 0; i < subArrayOne; i++)
        leftArray[i] = arr[left + i];
    for (auto j = 0; j < subArrayTwo; j++)
        rightArray[j] = arr[mid + 1 + j];

    auto indexOfSubArrayOne = 0, indexOfSubArrayTwo = 0;
    int indexOfMergedArray = left;

    // Merge the temp arrays back into arr
    while (indexOfSubArrayOne < subArrayOne && indexOfSubArrayTwo < subArrayTwo) {
        if (leftArray[indexOfSubArrayOne] <= rightArray[indexOfSubArrayTwo]) {
            arr[indexOfMergedArray] = leftArray[indexOfSubArrayOne];
            indexOfSubArrayOne++;
        }
        else {
            arr[indexOfMergedArray] = rightArray[indexOfSubArrayTwo];
            indexOfSubArrayTwo++;
        }
        indexOfMergedArray++;
    }

    // Copy the remaining elements of leftArray, if there are any
    while (indexOfSubArrayOne < subArrayOne) {
        arr[indexOfMergedArray] = leftArray[indexOfSubArrayOne];
        indexOfSubArrayOne++;
        indexOfMergedArray++;
    }

    // Copy the remaining elements of rightArray, if there are any
    while (indexOfSubArrayTwo < subArrayTwo) {
        arr[indexOfMergedArray] = rightArray[indexOfSubArrayTwo];
        indexOfSubArrayTwo++;
        indexOfMergedArray++;
    }
}

void mergeSort(std::vector<int>& arr, int const begin, int const end) {
    if (begin >= end)
        return; // Returns recursively

    auto mid = begin + (end - begin) / 2;
    mergeSort(arr, begin, mid);
    mergeSort(arr, mid + 1, end);
    merge(arr, begin, mid, end);
}

void readDataAndSort(const std::string& filepath) {
    std::ifstream file(filepath);
    std::vector<int> data;
    std::string line, val;

    // Assuming the data is in the first column
    while (std::getline(file, line)) {
        std::stringstream s(line);
        while (std::getline(s, val, ',')) {
            data.push_back(std::stoi(val));
            break; // Break after reading the first value
        }
    }

    mergeSort(data, 0, data.size() - 1);
}

int main() {
    std::string filepath = "/workspaces/ISA-486S-Research-Paper/Sorting/random_numbers.txt";
    readDataAndSort(filepath);
    return 0;
}
