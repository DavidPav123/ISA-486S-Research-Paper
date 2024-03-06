import random

# Define the number of random numbers we want to generate
num_random_numbers = 1_000

# Define the range for the random numbers
min_value = 1
max_value = 1_000_000

# The filename where to save the random numbers
filename = "/workspaces/ISA-486S-Research-Paper/Sorting/random_numbers.txt"

# Generate the random numbers and write them to the file
with open(filename, 'w') as file:
    for _ in range(num_random_numbers):
        # Generate a random number within the specified range
        rand_num = random.randint(min_value, max_value)
        # Write the random number to the file, followed by a new line
        file.write(f"{rand_num}\n")

