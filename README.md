# CHICKEN Scheme dotenv

A lightweight, dependency-conscious utility to load environment variables from `.env` files into your CHICKEN Scheme process.

[![CHICKEN Egg](https://img.shields.io/badge/CHICKEN-Egg-orange)](https://api.call-cc.org/5/doc/dotenv)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## Installation
Once indexed in the CHICKEN coop, you can install this egg via:

```bash
chicken-install dotenv
```

## Usage

Create a `.env` file in your project root:

```text
DATABASE_URL=postgres://user:pass@localhost:5432/db
API_SECRET=your_hidden_key_here
# This is a comment and will be ignored
DEBUG=true
```

Load it in your Scheme application:

```scheme
(import dotenv)

;; Loads ".env by default
(load-dotenv)

;; Or specify a custom path
:; (load-dotenv "config/.env.production")

(display (get-environment-variable "DATABASE_URL"))
```

## Features

* **Precise Trimming:** Only removes leading/trailing whitespace, preserving spaces inside values.
* **Comment Support:** Safely ignores lines starting with `#.
* **Value Integrity:** Handles values that contain `=` signs correctly by splitting only at the first occurrence.
* **Minimalist:** Built on top of SRFI-13 for reliable string manipulation.

## Development & Testing

To run the test suite locally:

```bash
chicken-install -test
```

## Contributing

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/foo`).
3. Commit your changes.
4. Push to the branch.
5. Create a new Pull Request.

## About

- **/Author:** [Masood Ahmed](https://github.com/masoodrb)
- **License:** MIT

