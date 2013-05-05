(in-package :web-lisp)

(defun do-eval (match register-1)
	(if (not (null match))
		(format nil "~a" (eval (read-from-string register-1)))))

(defun render-eval (line)
	(cl-ppcre:regex-replace-all "~{(.*)~}" line #'do-eval :simple-calls t))

(defmacro render-file (file)
	`(with-open-file (file-stream
		,file :direction :input)
		(format nil "~{~a~%~}"
		(loop for line = (read-line file-stream nil 'eof)
			until (eq line 'eof)
			collect (render-eval line)))))

(defmacro render-layout (layout content)
	`(with-open-file (file-stream
		,layout :direction :input)
		(format nil "~{~a~%~}"
		(loop for line = (read-line file-stream nil 'eof)
			until (eq line 'eof)
			collect (render-eval (render-layout-eval line ,content))))))

(defmacro render (file &key layout)
	(if (not (null layout))
		`(render-layout ,layout ,file)
		`(render-file ,file)))

(defun render-layout-eval (line content)
	(cl-ppcre:regex-replace-all "~{ body ~}" line (concatenate 'string "~{ (web-lisp:render #p\"" (namestring content) "\") ~}")))