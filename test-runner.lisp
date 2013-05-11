(load "web.lisp")

; Routes

(web-lisp:add-route "/" ()
	(defparameter title "(web-lisp)")
	(web-lisp:render #p"templates/index.html"))

(web-lisp:add-route "/getting-started" ()
	(defparameter title "Getting Started")
	(web-lisp:render #p"templates/getting-started.html"))

(web-lisp:add-route "/environment" ()
	(defparameter title "Environment Variables")
	(web-lisp:render #p"templates/environment.html"))

(web-lisp:add-route "/plain" (:content-type "text/plain")
	(string "This is some plain text that will be emitted by the web server"))

(web-lisp:add-route "/xml" (:content-type "text/xml")
	(string "<xml><message>This is an XML message emitted by the web server</message></xml>"))

(web-lisp:add-route "/simple" ()
	(defparameter title "Simple HTML Page")
	(web-lisp:render #p"templates/simple.html"))

(web-lisp:add-route "/layout" ()
	(defparameter title "Layout HTML Page")
	(web-lisp:render #p"templates/layout-inner.html" :layout #p"templates/layout-outer.html"))

(web-lisp:add-route "/functions" ()
	(defparameter title "Calling Functions")
	(web-lisp:render #p"templates/functions.html"))

(web-lisp:add-route "/snippets" ()
	(defparameter title "Snippets")
	(web-lisp:render #p"templates/snippets.html"))


; Helper Functions

(defun fib (n)
	"Simple fibonacci number function"
	(if (< n 2)
		n
		(+ (fib (- n 1)) (fib (- n 2)))))

(defun fib-trec (n)
	"Tail-recursive Fibonacci number function"
	(labels ((calc-fib (n a b)
		(if (= n 0)
			a
			(calc-fib (- n 1) b (+ a b)))))
		(calc-fib n 0 1)))

(defun header ()
	"<h1>(web-lisp)</h1><a href='/'>Home</a><br />")

(defun random-number ()
	(random 100))

; Start Server

(defun main ()
	(web-lisp:start-web))

; auto-run
(main)