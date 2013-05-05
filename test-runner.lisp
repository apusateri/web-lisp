(load "package.lisp")

(in-package :web-lisp)

(defun test-method-1 ()
	(string "test method 1"))

(defun test-method-2 ()
	(string "test method 2"))

(defun test-method-3 ()
	(string "test method 3"))

(defun test-render ()
	(render "templates/index.html"))

(add-route "/url1" #'test-method-1)
(add-route "/url2" #'test-method-2)
(add-route "/something" #'test-method-3)
(add-route "/" #'test-render)

(start-web)