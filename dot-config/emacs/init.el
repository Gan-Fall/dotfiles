(setq inhibit-startup-message t)

  (scroll-bar-mode -1)        ; Disable visible scrollbar
  (tool-bar-mode -1)          ; Disable the toolbar
  (tooltip-mode -1)           ; Disable tooltips
  (set-fringe-mode 10)        ; Give some breathing room

  (menu-bar-mode -1)            ; Disable the menu bar

  ;; Make ESC quit prompts
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

  ;; Swap C-g and C-c
(define-key key-translation-map (kbd "C-g") (kbd "C-c"))
(define-key key-translation-map (kbd "C-c") (kbd "C-g"))

  ;; Configure the bell
  (setq visible-bell t)
  ;;(setq ring-bell-function 'ignore)

  (defvar runemacs/default-font-size 160)
  (set-face-attribute 'default nil :font "SpaceMono Nerd Font Mono" :height runemacs/default-font-size)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil :font "SpaceMono Nerd Font Mono" :height 160)

  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil :font "Iosevka Aile" :height 195 :weight 'regular)

  ;; Line numbers
  (column-number-mode)
  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode 1)

  ;; Disable line numbers for some modes
  (dolist (mode '(term-mode-hook
  		eshell-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0))))

  ;; Same but for fill column
  (setq display-fill-column-indicator-column 80)
  (add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)

  (which-key-mode)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

;; Enable Vertico.
(use-package vertico
  ;;:custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("M-." . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-." . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g r" . consult-grep-match)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
  )

(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package helpful
  :bind (("C-h f" . helpful-callable)
	 ("C-h v" . helpful-variable)
	 ("C-h k" . helpful-key)
	 ("C-h x" . helpful-command)
	 ("C-h F" . helpful-function)
	 ("C-h C-." . helpful-at-point)) )

(use-package rainbow-delimiters
   :hook (emacs-lisp-mode scheme-mode lisp-mode))

;; Alternate way to achieve this
 ;(dolist (mode '(emacs-lisp-mode-hook
 ;		scheme-mode-hook
 ;		lisp-mode-hook))
 ;  (add-hook mode #'rainbow-delimiters-mode))
 ;(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package evil
  :init
  					; (setq evil-want-integration t) ; Not sure if deprecated.
  (setq evil-want-keybinding nil) ; Remove some evil keybinds in other modes which according to system crafters "aren't consistent". TODO: Look into this.
  					; (setq evil-want-C-i-jump nil) ; Remove vim C-i in edit mode functionality
  (setq evil-want-C-u-scroll t)
  					; (setq evil-want-C-u-delete t) ; Whether C-u should delete indent in insert mode.
  :config
  (evil-set-undo-system 'undo-tree)
  (evil-mode)
  					; (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join) ; Preserve emacs C-h to backspace

  ;; Make screen recenter after jump
  (defun my/evil-scroll-down ()
    (interactive)
    (evil-scroll-down nil)
    (evil-scroll-line-to-center nil))
  (defun my/evil-scroll-up ()
    (interactive)
    (evil-scroll-up nil)
    (evil-scroll-line-to-center nil))
  (defun my/evil-search-next ()
    (interactive)
    (evil-search-next)
    (evil-scroll-line-to-center nil))
  (defun my/evil-search-previous ()
    (interactive)
    (evil-search-previous)
    (evil-scroll-line-to-center nil))
  (defun my/evil-move-line-down ()
    (interactive)
    (evil-ex-execute "'<,'>m '>+1")
    (evil-indent-line (point-at-bol) (point-at-eol))
    (evil-visual-line))
  (defun my/evil-move-line-up ()
    (interactive)
    (evil-ex-execute "'<,'>m '<-2")
    (evil-indent-line (point-at-bol) (point-at-eol))
    (evil-visual-line))

  (evil-define-key '(normal visual) 'global (kbd "C-d") 'my/evil-scroll-down)
  (evil-define-key '(normal visual) 'global (kbd "C-u") 'my/evil-scroll-up)
  (evil-define-key '(normal visual) 'global (kbd "n") 'my/evil-search-next)
  (evil-define-key '(normal visual) 'global (kbd "N") 'my/evil-search-previous)
  (evil-define-key 'visual 'global (kbd "K") 'my/evil-move-line-up)
  (evil-define-key 'visual 'global (kbd "J") 'my/evil-move-line-down)

  ;; Set return in normal state to do default action on object
  (evil-define-key 'normal 'global (kbd "RET") 'embark-dwim)

  					;Alternate method
  					;(define-key evil-normal-state-map (kbd "C-d") #'my/evil-scroll-down)
  					;(define-key evil-normal-state-map (kbd "C-u") #'my/evil-scroll-up)

  ;; Disabled for now as I like jumping with relative numbers between folds.
  					; J and K will go to the next "wrapped" line (i.e. the same line but wrapped because it is too long)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  					; Make Control-g work like Control-c
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state))

;; Not sure what this does in system crafters' config
  					;(evil-set-initial-state 'messages-buffer-mode 'normal)
  					;(evil-set-initial-state 'dashboard-mode 'normal)

;; Remember on certain buffers you might want to start on emacs mode instead of evil mode. If you find any add them here.

(use-package evil-numbers
  :after evil
  :config
  (define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)
  (define-key evil-visual-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (define-key evil-visual-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)
  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  ;(define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
  (define-key evil-visual-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  ;(define-key evil-visual-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
  (define-key evil-normal-state-map (kbd "g +") 'evil-numbers/inc-at-pt-incremental)
  (define-key evil-normal-state-map (kbd "g -") 'evil-numbers/dec-at-pt-incremental)
  (define-key evil-visual-state-map (kbd "g +") 'evil-numbers/inc-at-pt-incremental)
  (define-key evil-visual-state-map (kbd "g -") 'evil-numbers/dec-at-pt-incremental)
  (define-key evil-normal-state-map (kbd "g C-a") 'evil-numbers/inc-at-pt-incremental)
  (define-key evil-normal-state-map (kbd "g C-x") 'evil-numbers/dec-at-pt-incremental)
  (define-key evil-visual-state-map (kbd "g C-x") 'evil-numbers/dec-at-pt-incremental)
  (define-key evil-visual-state-map (kbd "g C-a") 'evil-numbers/inc-at-pt-incremental)
)

; C-x ones are disabled for now as C-x is too important

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; System crafters setup
;(use-package projectile
;  :diminish projectile-mode
;  :config (projectile-mode)
;  :custom ((projectile-completion-system 'embark))
;  :bind-keymap
;  ("C-c p" . projectile-command-map)
;  :init
;  ;; NOTE: Set this to the folder where you keep your Git repos!
;  (when (file-directory-p "~/Documents/Projects")
;    (setq projectile-project-search-path '("~/Documents/Projects")))
;  (setq projectile-switch-project-action #'projectile-dired))

(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/Documents/Projects/" "~/.dotfiles" "~/Documents/org" "~/git"))
  :config
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (global-set-key (kbd "C-c p") 'projectile-command-map)
  (projectile-mode 1))

(use-package magit)

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
                      (expand-file-name "~/.dotfiles/emacs/Emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

;;Org capture keybind
(define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil nil)))

(use-package undo-tree
  :custom
  (undo-tree-enable-undo-in-region t))
(global-undo-tree-mode 1)

(defadvice undo-tree-make-history-save-file-name
    (after undo-tree activate)
  (setq ad-return-value (concat ad-return-value ".zst")))

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (rune/leader-keys
    "t" '(:ignore t :which-key "toggles")
    "tt" '(load-theme :which-key "choose theme")
  )
)

(use-package hydra)

(defhydra hydra-text-scale ()
	  "scale text"
	  ("j" text-scale-increase "in")
	  ("k" text-scale-decrease "out")
	  ("q" nil "finished" :exit t))

(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(rune/leader-keys
  "b" '(:ignore t :which-key "buffer")
  "b i" '(ibuffer :which-key "buffer edit")
  "b s" '(consult-buffer :which-key "buffer switch")
  "b k" '(kill-buffer :which-key "buffer kill")

  ;; File browsing / Embark
  "." '(find-file :which-key "find-file")
  "C-." '(embark-act :which-key "embark act")
  "M-." '(embark-dwim :which-key "embark at point")
  "," '(consult-recent-file :which-key "recent-file")
  "e" '(:ignore t :which-key "embark")
  "e ." '(embark-dwim :which-key "embark at point")
  "e e" '(embark-act :which-key "embark")
  "e b" '(embark-bindings :which-key "embark bindings")

  ;; Don't know what to call these
  "p v" '(dired-jump :which-key "Vim Ex")
  "p p" '(my/paste :which-key "Paste from register 0")
  
  ;; Evil-numbers
  ;"C-a" '(evil-numbers/inc-at-pt :which-key "Increase number(s)") ; redundant with evil-numbers config
  "C-x" '(evil-numbers/dec-at-pt :which-key "Decrease number(s)")
  "+" '(evil-numbers/inc-at-pt :which-key "Increase number(s)")
  "-" '(evil-numbers/dec-at-pt :which-key "Decrease number(s)")

  ;; Magit
  "g" '(:ignore t :which-key "Magit")
  "g s" '(magit-status :which-key "Magit status")

  ;; Undo-tree
  "u" '(undo-tree-visualize :which-key "Undo tree")

  ;; Windows
  "w" '(:ignore t :which-key "windows")

  "w l" '(evil-window-right :which-key "Move to the window on the right")
  "w h" '(evil-window-left :which-key "Move to the window on the left")
  "w k" '(evil-window-up :which-key "Move to the window above")
  "w j" '(evil-window-down :which-key "Move to the window below")
  "w <right>" '(evil-window-right :which-key "Move to the window on the right")
  "w <left>" '(evil-window-left :which-key "Move to the window on the left")
  "w <up>" '(evil-window-up :which-key "Move to the window above")
  "w <down>" '(evil-window-down :which-key "Move to the window below")
  "w C-l" '(evil-window-right :which-key "Move to the window on the right")
  "w C-h" '(evil-window-left :which-key "Move to the window on the left")
  "w C-k" '(evil-window-up :which-key "Move to the window above")
  "w C-j" '(evil-window-down :which-key "Move to the window below")
  "w C-<right>" '(evil-window-right :which-key "Move to the window on the right")
  "w C-<left>" '(evil-window-left :which-key "Move to the window on the left")
  "w C-<up>" '(evil-window-up :which-key "Move to the window above")
  "w C-<down>" '(evil-window-down :which-key "Move to the window below")

  "w s" '(evil-window-split :which-key "Split window (Horizontally)")
  "w C-s" '(evil-window-split :which-key "Split window (Horizontally)")
  "w C-S-s" '(evil-window-split :which-key "Split window (Horizontally)")
  "w v" '(evil-window-vsplit :which-key "Split window (Vertically)")
  "w C-v" '(evil-window-vsplit :which-key "Split window (Vertically)")
  "w C-S-v" '(evil-window-vsplit :which-key "Split window (Vertically)")
  "w n" '(evil-window-new :which-key "New window")
  "w C-n" '(evil-window-new :which-key "New window")
  "w x" '(evil-window-exchange :which-key "Exchange windows")
  "w C-x" '(evil-window-exchange :which-key "Exchange windows")
  "w c" '(evil-window-delete :which-key "Delete window")
  "w C-c" '(evil-window-delete :which-key "Delete window")
  "w f" '(ffap-other-window :which-key "Open file under cursor in another window")
  "w C-f" '(ffap-other-window :which-key "Open file under cursor in another window")
  "w o" '(evil-window-delete :which-key "Delete other windows")
  "w C-o" '(evil-window-delete :which-key "Delete other windows")
  "w p" '(evil-window-mru :which-key "MRU")
  "w C-p" '(evil-window-mru :which-key "MRU")

  "w w" '(evil-window-next :which-key "Next window")
  "w W" '(evil-window-prev :which-key "Previous window")
  "w C-w" '(evil-window-next :which-key "Next window")
  "w C-S-w" '(evil-window-prev :which-key "Previous window")
  "w r" '(evil-window-rotate-downwards :which-key "Rotate window down")
  "w R" '(evil-window-rotate-upwards :which-key "Rotate window up")
  "w C-r" '(evil-window-rotate-downwards :which-key "Rotate window down")
  "w C-S-r" '(evil-window-rotate-upwards :which-key "Rotate window up")
  "w t" '(evil-window-top-left :which-key "Top left window")
  "w T" '(tab-window-detach :which-key "Tab window detach")
  "w C-t" '(evil-window-top-left :which-key "Top left window")
  "w b" '(evil-window-bottom-right :which-key "Bottom right window")
  "w C-b" '(evil-window-bottom-right :which-key "Bottom right window")
  "w _" '(evil-window-set-height :which-key "Set height")
  "w C-_" '(evil-window-set-height :which-key "Set height")
  "w |" '(evil-window-set-width :which-key "Set width")

  "w g t" '(evil-tab-next :which-key "Switch to next tab")
  "w g T" '(tab-bar-switch-to-prev-tab :which-key "Switch to previous tab")

  "w =" '(balance-windows :which-key "Balance windows")
  "w C-=" '(balance-windows :which-key "Balance windows")
  "w +" '(evil-window-increase-height :which-key "Increase height")
  "w -" '(evil-window-decrease-height :which-key "Decrease height")
  "w <" '(evil-window-increase-width :which-key "Increase width")
  "w >" '(evil-window-decrease-width :which-key "Decrease width")
  "w 0" '(evil-window-digit-argument :which-key "evil-window-digit-argument")
  "w 1" '(evil-window-digit-argument :which-key "evil-window-digit-argument")
  "w 2" '(evil-window-digit-argument :which-key "evil-window-digit-argument")
  "w 3" '(evil-window-digit-argument :which-key "evil-window-digit-argument")
  "w 4" '(evil-window-digit-argument :which-key "evil-window-digit-argument")
  "w 5" '(evil-window-digit-argument :which-key "evil-window-digit-argument")
  "w 6" '(evil-window-digit-argument :which-key "evil-window-digit-argument")
  "w 7" '(evil-window-digit-argument :which-key "evil-window-digit-argument")
  "w 8" '(evil-window-digit-argument :which-key "evil-window-digit-argument"g)
  "w 9" '(evil-window-digit-argument :which-key "evil-window-digit-argument")
  "w :" '(evil-ex :which-key "Ex")

  "w L" '(evil-window-move-far-right :which-key "Move window to far right")
  "w H" '(evil-window-move-far-left :which-key "Move window to far left")
  "w K" '(evil-window-move-very-top :which-key "Move window to very top")
  "w J" '(evil-window-move-very-bottom :which-key "Move window to very bottom")
  "w C-S-l" '(evil-window-move-far-right :which-key "Move window to far right")
  "w C-S-h" '(evil-window-move-far-left :which-key "Move window to far left")
  "w C-S-k" '(evil-window-move-very-top :which-key "Move window to very top")
  "w C-S-j" '(evil-window-move-very-bottom :which-key "Move window to very bottom")
)

(recentf-mode)

(use-package doom-themes
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(load-theme 'doom-gruvbox t)

(setq custom-file "~/.config/emacs/custom.el")
(load custom-file)
