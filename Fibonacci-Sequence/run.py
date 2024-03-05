import subprocess
from write_averages import write_averages

paths = [
    [
        "/workspaces/ISA-486S-Research-Paper/Fibonacci-Sequence/C/Fibonacci",
        "/workspaces/ISA-486S-Research-Paper/Fibonacci-Sequence/C/Results",
    ],
    [
        "/workspaces/ISA-486S-Research-Paper/Fibonacci-Sequence/C++/Fibonacci",
        "/workspaces/ISA-486S-Research-Paper/Fibonacci-Sequence/C++/Results",
    ],
    [
        "/workspaces/ISA-486S-Research-Paper/Fibonacci-Sequence/rust/target/release/rust",
        "/workspaces/ISA-486S-Research-Paper/Fibonacci-Sequence/rust/Results",
    ],
    [
        "/workspaces/ISA-486S-Research-Paper/Fibonacci-Sequence/spark/bin/spark",
        "/workspaces/ISA-486S-Research-Paper/Fibonacci-Sequence/spark/Results",
    ],
    [
        "java -cp /workspaces/ISA-486S-Research-Paper/Fibonacci-Sequence/Java/ Fibonacci",
        "/workspaces/ISA-486S-Research-Paper/Fibonacci-Sequence/Java/Results",
    ],
]
for path in paths:
    results_arr = []
    for i in range(5):
        print(f"Run {i}")
        result = subprocess.run(
            f"time ({path[0]})",
            shell=True,
            executable="/bin/bash",
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )
        results_arr.append(result.stderr)
        print(f"Finished Run {i}")

    joined_results = "".join(results_arr)
    write_averages(joined_results, path[1])

    for i in range(5):
        print(f"Run {i}")
        subprocess.call(
            f'valgrind --tool=massif --massif-out-file="{path[1]}/massif{i}.txt" --pages-as-heap=yes {path[0]}',
            shell=True,
            executable="/bin/bash",
            stdout=subprocess.PIPE,
        )
        print(f"Finished Run {i}")
