(module dotenv (load-dotenv)
  (import scheme
    chicken.base
    chicken.io
    chicken.string
    chicken.process-context
    chicken.file
    readline)

  (define (string-trim-both str)
    (string-translate* str '(("\r" . "") ("\n" . "") (" " . " "))))

  (define (load-dotnev #!optional (filepath ".env"))
    (if (file-exists? filepath)
      (with-input-from-file filepath
        (lambda ()
          (let loop ([line (readline)])
            (unless (eof-object? line)
              (let ([trimmed (string-trim-both line)])
                (unless (or (string-null? trimmed)
                         (string-prefix? "#" trimmed))
                  (let ([parts (string-split trimmed "=")])
                    (when (>= (length parts) 2)
                      (let ([key (car parts)]
                            [val (string-intersperse (car parts) "=")])
                        (setenv key val))))))
              (loop (read-line))))))
      (error "dotenv: File not found" filepath))))
