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
    """results_arr = []
    for i in range(5):
        print(f"Run {i}")
        with open(
            "/workspaces/ISA-486S-Research-Paper/read-write/destination.txt", "w"
        ):
            pass  # Pass is a no-operation statement, so it effectively does nothing
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
        print(f"Finished Run {i}")

    joined_results = "".join(results_arr)
    write_averages(joined_results, path[1])"""

    for i in range(5):
        print(f"Run {i}")
        with open("/workspaces/ISA-486S-Research-Paper/read-write/destination.txt", 'w'):
            pass  # Pass is a no-operation statement, so it effectively does nothing
        subprocess.call(
            f'valgrind --tool=massif --massif-out-file="{path[1]}/massif{i}.txt" --pages-as-heap=yes {path[0]}',
            shell=True,
            executable="/bin/bash",
            stdout=subprocess.PIPE,
        )
        os.remove("/workspaces/ISA-486S-Research-Paper/read-write/destination.txt")
        print(f"Finished Run {i}")
