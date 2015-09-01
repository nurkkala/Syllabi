(defun org-dblock-write:block-update-time (params)
  "From org manual A.7"
  (let ((fmt (or (plist-get params :format) "%d. %m. %Y")))
    (insert "Last block update at: "
	    (format-time-string fmt (current-time)))))

(defvar schedule-property-names '("Talk" "Homework"))

(defun visit-org-file (filename)
  (let ((buffer (find-file-noselect filename)))
    (message "Visiting file %s" filename)
    ))

(defun schedule-course ()
  (interactive)
  (let (outline)
    (org-map-entries (lambda ()
		       (let* ((components (org-heading-components))
			      (level (nth 0 components))
			      (headline (nth 4 components))
			      properties)
			 (dolist (prop-name schedule-property-names)
			   (let ((val (org-entry-get nil prop-name)))
			     (when val
			       (push val properties)
			       (push prop-name properties)
			       )))
			 (push (list level headline properties) outline)))
		     t 'file)
    (with-output-to-temp-buffer "*Schedule*"
      (pp (reverse outline)))
    ))

(with-output-to-temp-buffer "zip"
    (pp (with-current-buffer "syllabus.org"  (org-element-parse-buffer))))

(defun parse-link ()
  (interactive)
  (with-output-to-temp-buffer "link"
    (pp (org-element-link-parser))))


