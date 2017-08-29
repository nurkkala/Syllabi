
(defun schedule-item ()
  (let ((level (org-outline-level))
		(tags (org-get-tags))
		(properties (org-entry-properties)))
	(cond ((member "talk" tags)
		   (org-schedule nil "2017-12-25"))
		  (t nil))))

(defun schedule-course ()
  (interactive)
  (pp (org-map-entries #'schedule-item t 'file)))

;; (defun walk-function ()
;;   (list (org-outline-level)
;; 		(org-entry-properties)))

;; (defun walk-tree ()
;;   (interactive)
;;   (pp (org-map-entries 'walk-function t 'tree)))

;; (defun walk-buffer ()
;;   (interactive)
;;   (pp (org-map-entries 'walk-function "TAGS=\":talk:\"" 'file)))

;; (defun walk-buffer ()
;;   (interactive)
;;   (pp (org-map-entries 'walk-function "TAGS=\":talk:\"" 'file)))
