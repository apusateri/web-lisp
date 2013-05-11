(defpackage :web-lisp
	(:use :common-lisp)
	(:export	:add-route
				:env
				:powered-by
				:render
				:start-web))

(ql:quickload :clack)
(ql:quickload :cl-ppcre)

(load "routes.lisp")
(load "application.lisp")
(load "templates.lisp")