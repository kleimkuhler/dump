extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
    println!("Guess the number!");

    // rand::thread_rng gives random number generator: one that is local to the
    // current thread of execution and seeded by the OS
    // `cargo doc --open` useful for reading create documentation
    let secret_number = rand::thread_rng().gen_range(1, 101);

    loop {
        println!("Please input your guess.");

        // let foo = 5 will make foo immutable by default
        // let mut foo = 5 will make foo mutable
        let mut guess = String::new();

        // guess needed to be mutable so that the method (read_line) can change the
        // string's content by adding the user input
        // & -> reference to guess; references are also immutable by default,
        // therefore we need `&mut guess` instead of just `&guess`

        // read_line resturns result type io::Result which is an enumeration of
        // `Ok` and `Err`
        io::stdin().read_line(&mut guess)
            .expect("Failed to read line");

        // Rust lets you shadow the previous value of `guess` with a new one
        // Useful for converting value of one type to another type
        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
	    Err(_) => continue,
	};

        println!("You guessed: {}", guess);

        // Ordering is an enum like Result, but the variants are `Less`, `Greater`,
        // and `Equal`
        // `match` is used to decide what to do next based on which variant of
        // `Ordering` was returned (these are called arms)
        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal => {
                println!("You win!");
		break;
            }
        }
    }
}