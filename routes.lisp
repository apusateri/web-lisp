(in-package :web-lisp)

(defparameter *url-routes* '())

(defun add-route (route function &key (method :get) (status 200) (content-type "text/html"))
	"Add a route to the current application's route table"
	(setf *url-routes*  (append `((,route ,function ,method ,status ,content-type)) *url-routes*)))

(defun get-route-equal (route path)
	(if (string= path (car route))
		`(,(nth 3 route)
			(:content-type ,(nth 4 route)) 
			(,(funcall (cadr route))))))

(defun read-routes (routes path)
	(loop for route in routes
		when (not (null (get-route-equal route path))) collect (get-route-equal route path)))

(defun match-route (routes path)
	(let ((match (read-routes routes path)))
		(if (null match)
			(progn 
				'(404 (:content-type "text/plain") ("Not Found")))
			(progn
				(car match)))))

;(defun get-route (route)
;	"Returns the function that's been mapped to this URL route"
;	(car (cdr (assoc route *url-routes* :test #'string=))))