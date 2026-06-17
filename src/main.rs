use std::env;
use std::fs;
use std::process;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 3 {
        eprintln!("Usage: {} <command> <filename>", args[0]);
        process::exit(64);
    }

    let command = &args[1];
    let filename = &args[2];

    let source = match fs::read_to_string(filename) {
        Ok(s) => s,
        Err(e) => {
            eprintln!("Error reading {filename}: {e}");
            process::exit(66);
        }
    };

    match command.as_str() {
        "tokenize" => {
            // ─── STAGE 1 STARTS HERE ──────────────────────────────────────
            // Your job: turn `source` (a String of Lox code) into tokens,
            // print each one on its own line, then print a final `EOF  null`.
            // If you hit any lexical errors along the way, exit with code 65
            // at the very end (after printing everything you could).
            //
            // Delete the `todo!` below and start building. The walkthrough is
            // in course/01-scanning/01-empty-file.md.
            let _ = &source;
            todo!("Stage 1: scan tokens from `source` and print them");
        }

        // Later chapters add more commands here: "parse", "evaluate", "run".
        _ => {
            eprintln!("Unknown command: {command}");
            process::exit(64);
        }
    }
}
