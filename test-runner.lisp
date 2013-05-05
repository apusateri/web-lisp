(load "package.lisp")

(defun plain-text-content ()
	(string "This is some plain text that will be emitted by the web server"))

(defun xml-content ()
	(string "<xml><message>This is an XML message emitted by the web server</message></xml>"))

(defun simple-html ()
	(web-lisp:render #p"templates/simple.html"))

(defun layout-html ()
	(web-lisp:render #p"templates/layout-inner.html" :layout #p"templates/layout-outer.html"))

(web-lisp:add-route "/plain" #'plain-text-content)
(web-lisp:add-route "/xml" #'xml-content :content-type "text/xml")
(web-lisp:add-route "/simple" #'simple-html)
(web-lisp:add-route "/layout" #'layout-html)

(defun serve ()
	(web-lisp:start-web))