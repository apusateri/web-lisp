(in-package :web-lisp)

(defun do-eval (match register-1)
	(format nil "~a" (eval (read-from-string register-1))))

(defun render-eval (line)
	(cl-ppcre:regex-replace-all "~{(.*)~}" line #'do-eval :simple-calls t))

(defun render (file)
	(with-open-file (file-stream
		file :direction :input)
		(format nil "~{~a~%~}"
		(loop for line = (read-line file-stream nil 'eof)
			until (eq line 'eof)
			collect (render-eval line)))))