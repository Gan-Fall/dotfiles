(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Configure the bell
(setq visible-bell t)
;;(setq ring-bell-function 'ignore)

(set-face-attribute 'default nil :font "SpaceMono Nerd Font Mono")

;; Line numbers
(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

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

(load "/home/ganfall/.config/emacs/packages.d/doom-modeline.el")
(load "/home/ganfall/.config/emacs/packages.d/emacs_vertico_savehist_orderless.el")
(load "/home/ganfall/.config/emacs/packages.d/marginalia.el")
(load "/home/ganfall/.config/emacs/packages.d/embark.el")
(load "/home/ganfall/.config/emacs/packages.d/consult.el")
(load "/home/ganfall/.config/emacs/packages.d/embark-consult.el") ;; Must be loaded after both embark and consult
(load "/home/ganfall/.config/emacs/packages.d/helpful.el")
(load "/home/ganfall/.config/emacs/packages.d/rainbow-delimiters.el")
(load "/home/ganfall/.config/emacs/packages.d/evil.el")
(load "/home/ganfall/.config/emacs/packages.d/evil-collection.el")
(load "/home/ganfall/.config/emacs/packages.d/general.el") ;; Before last?
(load "/home/ganfall/.config/emacs/packages.d/hydra.el") ;; Binding I made here depends on general.el
(load "/home/ganfall/.config/emacs/packages.d/doom-themes.el") ;; Maybe load last?
;; In theory load order shouldn't matter if I set :after keywords properly


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(rune/leader-keys
  "b" '(:ignore t :which-key "buffer")
  "bi" '(ibuffer :which-key "buffer edit")
  "bs" '(consult-buffer :which-key "buffer switch"))

(load-theme 'doom-gruvbox)
