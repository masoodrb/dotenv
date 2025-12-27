(module dotenv (load-dotenv)
        (import scheme
                chicken.base
                chicken.io
                chicken.string
                chicken.process-context)


        (define (string-trim-both str)
          (string-translate* str '(("\r" . "" ) ("\n" . "") (" " . " ")))))

