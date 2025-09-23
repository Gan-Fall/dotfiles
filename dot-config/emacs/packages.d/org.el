(defun efs/org-font-setup ()
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Iosevka Aile" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
  :hook ((org-mode . variable-pitch-mode)
	 (org-mode . visual-line-mode))
  :bind
  (("C-c j" . org-capture)) ;; alternative for `describe-bindings'
  :custom
  (org-clock-sound "~/Downloads/bell.wav")
  (org-ellipsis " ▾")
  (org-startup-indented t)
  (org-startup-with-inline-images t)
  (org-startup-with-latex-preview t)
  (org-hide-emphasis-markers t)
  (org-read-date-force-compatible-dates nil)
  (org-agenda-files
    '("~/Documents/org/Agenda.org"
     "~/Documents/org/Journal.org"
     "~/Documents/org/Tasks.org"
     "~/Documents/org/Archive.org"
     "~/Documents/org/Habits.org"
     "~/Documents/org/Birthdays.org"))
  (org-agenda-start-with-log-mode t)
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-habit-graph-column 60)
  (org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))
  (org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))
  (org-tag-alist
	 '((:startgroup)
	   ; Put mutually exclusive tags here
	   ("unnegotiable" . ?u)
	   ("somewhatoptional" . ?O)
	   ("optional" . ?o)
	   (:endgroup)
	   (:startgroup)
	   ("maxprio" . ?m)
	   ("canwait" . ?c)
	   ("noprio" . ?N)
	   (:endgroup)
	   ("@errand" . ?E)
	   ("@home" . ?H)
	   ("@work" . ?W)
	   ("agenda" . ?a)
	   ("emacs" . ?e)
	   ("planning" . ?p)
	   ("batch" . ?b)
	   ("note" . ?n)
	   ("idea" . ?i)))
  ;; Configure custom agenda views
  (org-agenda-custom-commands
	 '(("d" "Dashboard"
	    ((agenda "" ((org-deadline-warning-days 7)))
	     (todo "NEXT"
		   ((org-agenda-overriding-header "Next Tasks")))
	     (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

	   ("n" "Next Tasks"
	    ((todo "NEXT"
		   ((org-agenda-overriding-header "Next Tasks")))))

	   ("W" "Work Tasks" tags-todo "+work-email")

	   ;; Low-effort next actions
	   ("e" tags-todo "+TODO=\"TODO\"+Effort<15&+Effort>0"
	    ((org-agenda-overriding-header "Low Effort Tasks")
	     (org-agenda-max-todos 20)
	     (org-agenda-files org-agenda-files)))

	   ("w" "Workflow Status"
	    ((todo "WAIT"
		   ((org-agenda-overriding-header "Waiting on External")
		    (org-agenda-files org-agenda-files)))
	     (todo "REVIEW"
		   ((org-agenda-overriding-header "In Review")
		    (org-agenda-files org-agenda-files)))
	     (todo "PLAN"
		   ((org-agenda-overriding-header "In Planning")
		    (org-agenda-todo-list-sublevels nil)
		    (org-agenda-files org-agenda-files)))
	     (todo "BACKLOG"
		   ((org-agenda-overriding-header "Project Backlog")
		    (org-agenda-todo-list-sublevels nil)
		    (org-agenda-files org-agenda-files)))
	     (todo "READY"
		   ((org-agenda-overriding-header "Ready for Work")
		    (org-agenda-files org-agenda-files)))
	     (todo "ACTIVE"
		   ((org-agenda-overriding-header "Active Projects")
		    (org-agenda-files org-agenda-files)))
	     (todo "COMPLETED"
		   ((org-agenda-overriding-header "Completed Projects")
		    (org-agenda-files org-agenda-files)))
	     (todo "CANC"
		   ((org-agenda-overriding-header "Cancelled Projects")
		    (org-agenda-files org-agenda-files)))))))
  (org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/Documents/org/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n %i" :empty-lines 1)
      ("tr" "Task with ref" entry (file+olp "~/Documents/org/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/Documents/org/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
      ("jr" "Journal with ref" entry
           (file+olp+datetree "~/Documents/org/Journal.org")
           "* %<%I:%M %p> - %a :journal:reflink:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)
      ("jm" "Musing" entry
           (file+olp+datetree "~/Documents/org/Journal.org")
           "\n* %<%I:%M %p> - Journal :musing:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)

      ("w" "Workflows")
      ("we" "Checking Email" entry (file+olp+datetree "~/Documents/org/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)
      
      ("h" "Habits")
      ("hd" "Add Habit - Daily" entry (file "~/Documents/org/Habits.org")
           "* TODO %? :habit:\nSCHEDULED: %(org-insert-time-stamp nil nil nil nil nil \" +1d\")\n:PROPERTIES:\n:STYLE:    habit\n:END:" :empty-lines 0)

      ("m" "Metrics Capture")
      ("mw" "Weight" table-line (file+headline "~/Documents/org/Metrics.org" "Weight")
       "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))
  :config
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  ;; Save Org buffers after refiling!
  ;(add-advice 'org-refile :after 'org-save-all-org-buffers)
  (efs/org-font-setup))

(use-package org-bullets
  :after org
  :hook org-mode)

(use-package visual-fill-column
  :custom
  (visual-fill-column-width 100)
  (visual-fill-column-center-text t)
  :hook org-mode)

(defun my/pomodoro (pomodoros break?)
  (interactive "p")
  (if (> pomodoros 0)
      (begin
       (if break?
	   (org-timer-set-timer 5)
	   (org-timer-set-timer 25))
       (my/pomodoro (- pomodoros 1) t) )))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

(push '("conf-unix" . conf-unix) org-src-lang-modes)

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.config/emacs/Emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))
