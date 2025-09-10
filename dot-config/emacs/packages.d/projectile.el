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
  (setq projectile-project-search-path '("~/Documents/Projects/" "~/.dotfiles" "~/Documents/org"))
  :config
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (global-set-key (kbd "C-c p") 'projectile-command-map)
  (projectile-mode 1))
