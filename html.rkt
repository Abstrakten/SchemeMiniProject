(define (tag tag-name . elements)
  (string-append "<" tag-name ">"
                 (apply string-append elements)
                 "</" tag-name ">"))

(define (make-tag name children)
    (apply tag name children))

(define (html . children)
  (make-tag "html" children))

(define (body . children)
  (make-tag "body" children))

(define (calendarName . children)
  (make-tag "h1" children))

(define (appName . children)
  (make-tag "h2" children))
