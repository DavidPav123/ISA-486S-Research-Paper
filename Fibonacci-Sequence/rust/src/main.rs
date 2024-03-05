use std::io;

fn fibonacci(n: u32) -> u32 {
    if n <= 1 {
        return n;
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
}

fn main() {
    for i in 0..40 {
        print!("{} ", fibonacci(i));
    }
}
