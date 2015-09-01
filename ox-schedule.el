(require 'ox)


(org-export-define-backend 'schedule
  '( (bold . org-schedule-verbose)
     (center-block . org-schedule-verbose)
     (clock . org-schedule-verbose)
     (code . org-schedule-verbose)
     (comment . org-schedule-verbose)
     (comment-block . org-schedule-verbose)
     (drawer . org-schedule-drawer)
     (dynamic-block . org-schedule-verbose)
     (entity . org-schedule-verbose)
     (example-block . org-schedule-verbose)
     (export-block . org-schedule-verbose)
     (export-snippet . org-schedule-verbose)
     (fixed-width . org-schedule-verbose)
     (footnote-definition . org-schedule-verbose)
     (footnote-reference . org-schedule-verbose)
     (headline . org-schedule-headline)
     (horizontal-rule . org-schedule-verbose)
     (inline-src-block . org-schedule-verbose)
     (inlinetask . org-schedule-verbose)
     (italic . org-schedule-verbose)
     (item . org-schedule-nop)
     (keyword . org-schedule-verbose)
     (latex-environment . org-schedule-verbose)
     (latex-fragment . org-schedule-verbose)
     (line-break . org-schedule-verbose)
     (link . org-schedule-link)
     (paragraph . org-schedule-contents)
     (plain-list . org-schedule-nop)
     (plain-text . org-schedule-plain-text)
     (planning . org-schedule-verbose)
     (property-drawer . org-schedule-verbose)
     (quote-block . org-schedule-verbose)
     (quote-section . org-schedule-verbose)
     (radio-target . org-schedule-verbose)
     (section . org-schedule-verbose)
     (special-block . org-schedule-verbose)
     (src-block . org-schedule-verbose)
     (statistics-cookie . org-schedule-verbose)
     (strike-through . org-schedule-verbose)
     (subscript . org-schedule-verbose)
     (superscript . org-schedule-verbose)
     (table . org-schedule-verbose)
     (table-cell . org-schedule-verbose)
     (table-row . org-schedule-verbose)
     (target . org-schedule-verbose)
     (template . org-schedule-template)
     (timestamp . org-schedule-verbose)
     (underline . org-schedule-verbose)
     (verbatim . org-schedule-verbose)
     (verse-block . org-schedule-verbose) )
  :menu-entry
  '(?S "Export as Schedule"
       ((?S "As buffer" org-schedule-export-as-buffer))))

(defvar org-schedule-property-names '(:TALK :HOMEWORK))

(defun org-schedule-verbose (element contents info)
  (format "%s:[%s]" (car element) contents))

(defun org-schedule-contents (element contents info) contents)

(defun org-schedule-nop (element contents info) nil)

(defun org-schedule-drawer (drawer contents info)
  (let* ((name (org-element-property :drawer-name drawer)))
    (format "DRAWER %s\n%s" name contents)))

(defun org-schedule-headline (headline contents info)
  "Transcode HEADLINE element for schedule."
  (let* ((level (org-export-get-relative-level headline info))
	 (headline-text (org-export-data (org-element-property :title headline) info))
	 (talk (org-element-property :TALK headline))
	 (homework (org-element-property :HOMEWORK headline))
	 attrs)

    (when talk
      (push (format "talk=\"%s\"" talk) attrs))
    (when homework
      (push (format "homework=\"%s\"" homework) attrs))

    (format "<topic text=\"%s\" level=\"%d\"%s>\n%s</topic>"
	    headline-text level
	    (if attrs (concat " " (mapconcat 'identity attrs " ")) "")
	    (if contents (concat contents "\n") ""))))

(defun org-schedule-link (link contents info)
  "Transcode LINK element for schedule."
  (format "<link type=\"%s\" path=\"%s\"/>"
	  (org-element-property :type link)
	  (org-element-property :path link)))

(defun org-schedule-plain-text (text info) text)

(defun org-schedule-template (contents info) contents)

(defun org-schedule-export-as-buffer (&optional async subtreep visible-only
						ext-plist post-process)
  (interactive)
  (org-export-to-buffer 'schedule "*Schedule Export*"
     async subtreep visible-only ext-plist post-process))
