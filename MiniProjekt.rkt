(load "html.rkt")
(load "courseHelp.rkt")

(define out (open-output-file "calendar.html" #:exists 'replace))
(define nameInvalid "Name not a valid string")
(define calInvalid "input not a calendar")

(define (createApp Name Year Month Date seconds)
  "here goes markup")

(define (NotInt i) (NOT(integer? i)))

(define (createTime . input) (Time? input))

(define (Time? timeList)
  (cond ((NOT(list? timeList)) (error "times not a list"))
        ((find-in-list NotInt timeList) (error "times not in integer format"))
        ((NOT(= 4 (length timeList))) (error "times need year, month, date, seconds"))
        (else timeList)))

(define (createApp name startTime endTime desc)
  (cond ((NOT(string? name)) (error nameInvalid))
        ((NOT(string? desc)) (error "description not a string"))
        (else (list name (Time? startTime) (Time? endTime) desc))))


(define (createCal name cals apps)
  (cond ((NOT(string? name)) (error nameInvalid))
        ((NOT(list? cals)) (error "calendars should be in a list"))
        ((NOT(list? apps)) (error "apps should be in a list"))
        (else (cons name (cons cals apps)))))

(define (addAppointment cal app)
  (createCal (car cal) (car(cdr cal)) (append (cdr(cdr cal)) app)))

(define (notCal? cal) #f)




(define (printCal cal)
  (cond ((notCal? cal) (error calInvalid))
        (else (printCalHelper cal))))

(define (printCalHelper cal)
  (html
   (body
    (calendarName (car cal))
    (appName app1)
    )
   )
  )

(define (getApps cal)
  (cond ((notCal? cal) (error calInvalid))
        (else (cdr(cdr cal)))))

(define (getSubCals cal)
  (cond ((notCal? cal) (error calInvalid))
        (else (car(cdr cal)))))

(define (getAllApps cal)
  (getAppsFromCals (getSubCals cal) (getApps cal)))

(define (getAppsFromCals cal res)
  (cond ((null? cal) res)
        (else (append res (flatten (map getAllApps cal))))))

(define (getAppsFromCal cal)
  (cond ((null? cal) '())
        (else (concat (map getAppsFromCal (getSubCals cal)) (getApps cal)))))


(define tim (createTime 1 2 3 4))
(define app1 (createApp "01" tim tim "desc"))
(define app2 (createApp "02" tim tim "desc"))
(define app3 (createApp "03" tim tim "desc"))
(define app4 (createApp "04" tim tim "desc"))
(define app5 (createApp "05" tim tim "desc"))
(define app6 (createApp "06" tim tim "desc"))
(define app7 (createApp "07" tim tim "desc"))
(define app8 (createApp "08" tim tim "desc"))

(define cal1 (createCal "01" '() (list app1)))
(define cal2 (createCal "02" (list cal1) (list app3)))
(define cal3 (createCal "03" '() '()))
(define cal4 (createCal "04" (list cal2 cal3) (list app6)))

(getAppsFromCal cal4)


