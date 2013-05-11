(in-package :web-lisp)

(defvar footer-html 
	"<span style='
		position: fixed; 
		bottom: 0px; 
		right: 0px; 
		background-color: black;
		padding: 4px 20px 4px 20px;
		-mox-border-radius: 8px 0px 0px 0px;
		border-radius: 8px 0px 0px 0px;'>
		<a href='http://github.com/apusateri/web-lisp' target='_blank' style='
			font-family: Arial, Helvetica, sans-serif;
			font-size: 10px;
			color: #eee; 
			text-decoration: none'>
			(powered-by web-lisp)</a>
	</span>")

(defun lisp-web-app (env)
	"Web application built from added routes"
	(match-route *url-routes* env))

(defun start-web (&key (port 8080))
	"Run the web application"
	(format t "~%~%Loading web-lisp Application Server through Clack/Hunchentoot~%~%")
	(clack:clackup #'lisp-web-app
		:port port))

(defun powered-by ()
	footer-html)