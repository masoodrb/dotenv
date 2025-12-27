(import dotenv (chicken process-context) (chicken file) test)

(test-group "dotenv-parser"
  ;; 1. Setup: Create a dummy .env file
  (with-output-to-file ".env.test"
    (lambda ()
      (print "DB_HOST=localhost")
      (print "DB_USER=root")
      (print "# This is a comment")
      (print "") ;; Empty line
      (print "API_KEY=secret_key_with=equals")))

  ;; 2. Run the loader
  (test "Loading returns normally" #t (begin (load-dotenv ".env.test") #t))

  ;; 3. Verify values
  (test "Standard key-value pair" "localhost" (get-environment-variable "DB_HOST"))
  (test "Handles values containing equals signs" "secret_key_with=equals" (get-environment-variable "API_KEY"))
  
  ;; 4. Verify ignores
  (test "Comments are not loaded" #f (get-environment-variable "# This is a comment"))

  ;; 5. Cleanup
  (delete-file ".env.test"))

(test-exit)
