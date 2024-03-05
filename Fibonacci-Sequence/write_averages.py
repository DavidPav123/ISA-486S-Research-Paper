def time_to_seconds(timestr):
    # Check if the time string is in the expected format (e.g., '0m0.001s')
    if "m" in timestr:
        # Split the string by 'm' to separate minutes and seconds
        minutes, seconds = timestr.split("m")
        # Convert minutes to seconds and add to seconds after stripping the trailing 's'
        return float(minutes) * 60 + float(seconds[:-1])
    return 0.0


def write_averages(input_text, output_destination):
    blocks = input_text.strip().split("\n\n")

    total_sum = 0
    count = 0
    output_lines = []

    for block in blocks:
        lines = block.strip().split("\n")
        if len(lines) >= 3:
            try:
                user_time_str = [line for line in lines if "user" in line][0].split()[
                    -1
                ]
                sys_time_str = [line for line in lines if "sys" in line][0].split()[-1]
                user_time = time_to_seconds(user_time_str)
                sys_time = time_to_seconds(sys_time_str)

                total_time = user_time + sys_time
                total_sum += total_time
                count += 1

                output_lines.extend(lines)
                output_lines.append(f"Sum of user and sys time: {total_time:.3f}s\n\n")
            except (IndexError, ValueError) as e:
                print(f"Error processing block: {e}")
        else:
            print("Insufficient lines in a block to extract times.")

    if count > 0:
        average_time = total_sum / count
        output_lines.append(
            f"Average of user and sys times across all outputs: {average_time:.3f}s"
        )
    else:
        average_time = 0
        output_lines.append("No valid time data found for averaging.")

    with open(
        f"{output_destination}/output_averages.txt", "w"
    ) as f:
        f.write("\n".join(output_lines))

    print(f"Output with times and average has been written to {output_destination}/output_averages.txt")
