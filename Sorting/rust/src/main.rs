use std::error::Error;
use std::fs::File;
use std::process;

fn merge_sort(arr: &mut [i32]) {
    let mid = arr.len() / 2;
    if mid == 0 {
        return;
    }

    merge_sort(&mut arr[..mid]);
    merge_sort(&mut arr[mid..]);

    let mut ret = arr.to_vec();
    merge(&arr[..mid], &arr[mid..], &mut ret[..]);
    arr.copy_from_slice(&ret);
}

fn merge(left: &[i32], right: &[i32], ret: &mut [i32]) {
    let mut left_idx = 0;
    let mut right_idx = 0;
    let mut ret_idx = 0;

    while left_idx < left.len() && right_idx < right.len() {
        if left[left_idx] <= right[right_idx] {
            ret[ret_idx] = left[left_idx];
            left_idx += 1;
        } else {
            ret[ret_idx] = right[right_idx];
            right_idx += 1;
        }
        ret_idx += 1;
    }

    if left_idx < left.len() {
        ret[ret_idx..].copy_from_slice(&left[left_idx..]);
    }
    if right_idx < right.len() {
        ret[ret_idx..].copy_from_slice(&right[right_idx..]);
    }
}

fn read_data_from_csv(file_path: &str) -> Result<Vec<i32>, Box<dyn Error>> {
    let file = File::open(file_path)?;
    let mut rdr = csv::Reader::from_reader(file);
    let mut data = Vec::new();

    for result in rdr.records() {
        let record = result?;
        for field in record.iter() {
            match field.parse::<i32>() {
                Ok(value) => data.push(value),
                Err(e) => eprintln!("Skipping invalid data: {}, error: {}", field, e),
            }
        }
    }

    Ok(data)
}

fn main() {
    let file_path = "/workspaces/ISA-486S-Research-Paper/Sorting/random_numbers.txt";
    let mut data = match read_data_from_csv(file_path) {
        Ok(data) => data,
        Err(err) => {
            eprintln!("Error reading CSV file: {}", err);
            process::exit(1);
        }
    };

    merge_sort(&mut data);
}
