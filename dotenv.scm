;;;; dotenv.scm - MIT License
;;;; Author: Masood Ahmed

(module dotenv (load-dotenv)
  (import scheme
          chicken.base
          chicken.io
          chicken.string
          chicken.process-context
          chicken.file
          (prefix srfi-13 s-))

  (define (load-dotenv #!optional (filepath ".env"))
    (if (file-exists? filepath)
        (with-input-from-file filepath
          (lambda ()
            (let loop ([line (read-line)])
              (unless (eof-object? line)
                (let ([trimmed (s-string-trim-both line)])
                  (unless (or (s-string-null? trimmed)
                              (s-string-prefix? "#" trimmed))
                    (let ([index (s-string-index trimmed #\=)])
                      (when index
                        (let ([key (s-string-trim-both (s-string-take trimmed index))]
                              [val (s-string-trim-both (s-string-drop trimmed (+ index 1)))])
                          (set-environment-variable! key val))))))
                (loop (read-line))))))
        (error "dotenv: File not found" filepath))))
