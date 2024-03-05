import subprocess
import os
from write_averages import write_averages

"""[
        "/workspaces/ISA-486S-Research-Paper/read-write/C/read-write",
        "/workspaces/ISA-486S-Research-Paper/read-write/C/Results",
    ],
    [
        "/workspaces/ISA-486S-Research-Paper/read-write/C++/read-write",
        "/workspaces/ISA-486S-Research-Paper/read-write/C++/Results",
    ],
    [
        "/workspaces/ISA-486S-Research-Paper/read-write/Rust/target/release/Rust",
        "/workspaces/ISA-486S-Research-Paper/read-write/Rust/Results",
    ],
    [
        "/workspaces/ISA-486S-Research-Paper/read-write/spark/bin/spark",
        "/workspaces/ISA-486S-Research-Paper/read-write/spark/Results",
    ],
    [
        "java -cp /workspaces/ISA-486S-Research-Paper/read-write/Java/ readwrite",
        "/workspaces/ISA-486S-Research-Paper/read-write/Java/Results",
    ],"""

paths = [
    [
        "/workspaces/ISA-486S-Research-Paper/read-write/C/read-write",
        "/workspaces/ISA-486S-Research-Paper/read-write/C/Results",
    ],
    [
        "/workspaces/ISA-486S-Research-Paper/read-write/C++/read-write",
        "/workspaces/ISA-486S-Research-Paper/read-write/C++/Results",
    ],
    [
        "/workspaces/ISA-486S-Research-Paper/read-write/Rust/target/release/Rust",
        "/workspaces/ISA-486S-Research-Paper/read-write/Rust/Results",
    ],
    [
        "/workspaces/ISA-486S-Research-Paper/read-write/spark/bin/spark",
        "/workspaces/ISA-486S-Research-Paper/read-write/spark/Results",
    ],
    [
        "java -cp /workspaces/ISA-486S-Research-Paper/read-write/Java/ readwrite",
        "/workspaces/ISA-486S-Research-Paper/read-write/Java/Results",
    ],
]
for path in paths:
    results_arr = []
    for i in range(5):
        result = subprocess.run(
            f"time ({path[0]})",
            shell=True,
            executable="/bin/bash",
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )
        results_arr.append(result.stderr)
        os.remove("/workspaces/ISA-486S-Research-Paper/read-write/destination.txt")

    joined_results = "".join(results_arr)
    write_averages(joined_results, path[1])

    """for i in range(5):
        subprocess.call(
            f'valgrind --tool=massif --massif-out-file="{path[1]}/massif{i}.txt" --pages-as-heap=yes {path[0]}',
            shell=True,
            executable="/bin/bash",
            stdout=subprocess.PIPE,
        )"""
