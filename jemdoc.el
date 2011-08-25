;;; Jemdoc.el -- Mode for viewing and editing Jemdoc files on emacs

;; @author Billy Okal <sudo@makokal.com>
;; Copyright 2011
;; Licence GPL


(defgroup jemdoc-faces nil
  "Jemdoc highlighting"
  :group 'jdocs)

;; ---------------------------------------------------------------------
;; == Colors
(defface jemdoc-title-1-face
  `((((class color)
      (background dark))
     (:foreground "brown3" :bold t :height 1.2 :inherit variable-pitch))
    (((class color)
      (background light))
     (:foreground "brown3" :bold t :height 1.2 :inherit variable-pitch))
    (t (:weight bold :inherit variable-pitch)))
  "Face for Jemdoc titles at level 1."
  :group 'jemdoc-faces)

(defface jemdoc-title-2-face
  `((((class color)
      (background dark))
     (:foreground "DeepPink2" :bold t :height 1.1 :inherit variable-pitch))
    (((class color)
      (background light))
     (:foreground "DeepPink2" :bold t :height 1.1 :inherit variable-pitch))
    (t (:weight bold :inherit variable-pitch)))
  "Face for Jemdoc titles at level 2."
  :group 'jemdoc-faces)

(defface jemdoc-title-3-face
  `((((class color)
      (background dark))
     (:foreground "sienna3" :bold t))
    (((class color)
      (background light))
     (:foreground "sienna3" :bold t))
    (t (:weight bold)))
  "Face for Jemdoc titles at level 3."
  :group 'jemdoc-faces)

(defface jemdoc-title-4-face
  `((((class color)
      (background dark))
     (:foreground "burlywood3"))
    (((class color)
      (background light))
     (:foreground "burlywood3"))
    (t ()))
  "Face for Jemdoc titles at level 4."
  :group 'jemdoc-faces)

(defface info-node
  '((((class color) (background light)) (:foreground "brown" :bold t :italic t))
    (((class color) (background dark)) (:foreground "white" :bold t :italic t))
    (t (:bold t :italic t)))
  "Face for Info node names."
  :group 'jemdoc-faces)

(defvar jemdoc-title-1 'jemdoc-title-1-face)
(defvar jemdoc-title-2 'jemdoc-title-2-face)
(defvar jemdoc-title-3 'jemdoc-title-3-face)
(defvar jemdoc-title-4 'jemdoc-title-4-face)

(defvar general-font-lock-red1 font-lock-warning-face)
(defvar general-font-lock-red2 font-lock-comment-face)
(defvar general-font-lock-red3 font-lock-string-face)

(defvar general-font-lock-green1 font-lock-type-face)
(defvar general-font-lock-green2 font-lock-constant-face)

(defvar general-font-lock-blue1 font-lock-keyword-face)
(defvar general-font-lock-blue2 font-lock-function-name-face)
(defvar general-font-lock-blue3 font-lock-builtin-face)

(defvar general-font-lock-yellow1 font-lock-variable-name-face)
(defvar general-font-lock-yellow2 font-lock-comment-face)

;; settings

(defvar jemdoc-mode-hook nil
  "Normal hook run when entering Jemdoc Text mode.")

(defvar jemdoc-mode-abbrev-table nil
  "Abbrev table in use in jemoc-mode buffers.")
(define-abbrev-table 'doc-mode-abbrev-table ())

(defconst jemdoc-font-lock-keywords
  (eval-when-compile
    (list

     ;; Header levels
     (cons "^=? +.*"		'jemdoc-title-1)
     (cons "^== +.*"		'jemdoc-title-2)
     (cons "^=== +.*"		'jemdoc-title-3)
     (cons "^==== +.*"		'jemdoc-title-4)

     ;; Delimited blocks
     (cons "^[-=+*_]\\{6,\\} *\$" 'general-font-lock-yellow1)
     (cons "^\\.\\{6,\\} *\$"	'general-font-lock-yellow2)
     (cons "^\\.[A-Z].*\$"	'general-font-lock-yellow2)

     ;; Misc specials
     ;(cons "^.*\\?\\? *\$"	'jemdoc-title-4)
     ;(cons "^.*[:;][:;-] *\$"	'general-font-lock-blue2)

     ;; Comment Lines
     (cons "^#.*"		'general-font-lock-blue3)

     ;; Auxiliary directives
     (cons "^~~~ .*"	        'general-font-lock-green1)
     ;(cons "^~~~ +.*"		'general-font-lock-blue3)

     ;; Annotation
     (cons "\\*[A-Z]+\\*:"	'general-font-lock-red1)

     ))
 "Default expressions to highlight in jemdoc mode.")


(define-derived-mode jemdoc-mode text-mode "Jemdoc"
  "Major mode for editing AsciiDoc text files.
Turning on Doc mode runs the normal hook `jemdoc-mode-hook'."
  (interactive)
  (modify-syntax-entry ?\'  ".")
  ;(flyspell-mode nil)

  (make-local-variable 'paragraph-start)
  (setq paragraph-start (concat "$\\|>" page-delimiter))
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
  (make-local-variable 'paragraph-ignore-fill-prefix)
  (setq paragraph-ignore-fill-prefix t)

  (make-local-variable 'require-final-newline)
  (setq require-final-newline t)

  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults 
	'(jemdoc-font-lock-keywords 
	  nil				; KEYWORDS-ONLY: no
	  nil				; CASE-FOLD: no
	  ((?_ . "w"))			; SYNTAX-ALIST
	  ))
  (run-hooks 'doc-mode-hook))

(provide 'jemdoc-mode)
