(in-package :web-lisp)

(defparameter *url-routes* '())

(defun route-matches (path route)
	"Determine if a route matches a path - this will need to be changed for regex compatibility"
	(string= path route))

(defun add-route-helper (route function &key (status 200) (content-type "text/html"))
	"Add a route to the current application's route table"
	(setf *url-routes*  (append `((,route ,function ,status ,content-type)) *url-routes*)))

(defmacro add-route (route (&key (status 200) (content-type "text/html")) &body body)
	"Absolutely fucking fancy macro to create a function for you and add it to the routes"
	(let ((funcname (gensym)))
		`(progn
			(defun ,funcname (env) 
				(progn 
					(defparameter env env)
					,@body))
			(add-route-helper ,route #',funcname :status ,status :content-type ,content-type))))

(defun get-route-equal (route path env)
	"Get the route that matches the path"
	(if (route-matches path (car route))
		`(,(nth 2 route)
			(:content-type ,(nth 3 route)) 
			(,(funcall (cadr route) env)))))

(defun read-routes (routes env)
	(loop for route in routes
		when (not (null (get-route-equal route (getf env :path-info) env))) collect (get-route-equal route (getf env :path-info) env)))

(defun match-route (routes env)
	(let ((match (read-routes routes env)))
		(if (null match)
			(progn 
				'(404 (:content-type "text/plain") ("Not Found")))
			(progn
				(car match)))))