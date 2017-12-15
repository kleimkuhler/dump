use std::io;

fn main() {
    let mut n = String::new();
    
    io::stdin().read_line(&mut n)
        .expect("Failed to read line");

    let n: u32 = n.trim().parse()
        .expect("Please enter integer");

    println!("fib({}) = {}", n, fib(1, 0, 0, 1, n))
}

fn fib(a: u32,
       b: u32,
       p: u32,
       q: u32,
       count: u32
) -> u32 {
    if count == 0 {
        b
    } else if count % 2 == 0 {
        fib(a,
            b,
            ((p * p) + (q * q)),
            ((2 * (p * q)) + (q * q)),
            (count / 2)
        )
    } else {
        fib(((b * q) + (a * q) + (a * p)),
            ((b * p) + (a * q)),
            p,
            q,
            (count - 1)
        )
    }
}
