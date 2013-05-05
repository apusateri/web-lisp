(in-package :web-lisp)

(defun lisp-web-app (env)
	"Web application built from added routes"
	(match-route *url-routes* (getf env :path-info)))

(defun start-web (&key (port 8080))
	"Run the web application"
	(format t "~%~%Loading web-lisp Application Server through Clack/Hunchentoot~%~%")
	(clack:clackup #'lisp-web-app
		:port port))