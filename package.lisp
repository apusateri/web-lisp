(defpackage :web-lisp
	(:use :common-lisp)
	(:export	:start-web
				:add-route
				:render))

(ql:quickload :clack)
(ql:quickload :cl-ppcre)

(load "routes.lisp")
(load "application.lisp")
(load "templates.lisp")