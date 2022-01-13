(import (chicken format)
        (chicken io)
        (chicken process-context))

(define (err msg)
  (format #t "subst: error: ~A~%" msg)
  (exit 1))

(define (char-symbolic? char)
  (and (not (char-numeric? char))
       (not (char-alphabetic? char))
       (and (char>=? char #\!)
            (char<=? char #\~))))

(define target)
(define (char-target? char) (memv char target))
(define (char-not-target? char) (not (char-target? char)))

(define (subst-chars! str proc char)
  (do ((i 0 (+ i 1)))
      ((= i (string-length str)) str)
    (when (proc (string-ref str i))
      (string-set! str i char))))

(define (line-loop ip proc char)
  (do ((line (read-line ip) (read-line ip)))
      ((eof-object? line))
    (display (subst-chars! line proc char))
    (newline)))

(define (main proc char fargs)
  (define ip (current-input-port))
  (if (null? fargs)
      (line-loop ip proc char)
      (for-each (lambda (arg)
                  (set! ip (open-input-file arg))
                  (line-loop ip proc char)
                  (close-input-port ip))
                fargs)))

(define args (command-line-arguments))
(when (< (length args) 2) (err "missing arguments"))
(when (> (string-length (cadr args)) 1) (err "invalid CHAR argument"))
(let* ((parg (car args))
       (proc (cond ((member parg '("a" "alpha" "alphabetic")) char-alphabetic?)
                   ((member parg '("n" "num" "numeric")) char-numeric?)
                   ((member parg '("s" "sym" "symbolic")) char-symbolic?)
                   ((member parg '("w" "white" "whitespace")) char-whitespace?)
                   ((char=? (string-ref parg 0) #\+)
                    (set! target (cdr (string->list parg))) char-target?)
                   ((char=? (string-ref parg 0) #\-)
                    (set! target (cdr (string->list parg))) char-not-target?)
                   (else (err "invalid TARG argument"))))
       (char (string-ref (cadr args) 0)))
  (main proc char (cddr args)))
