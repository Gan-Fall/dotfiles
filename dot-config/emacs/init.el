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
(global-display-line-numbers-mode 1)

;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
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
(load "/home/ganfall/.config/emacs/packages.d/evil-numbers.el")
(load "/home/ganfall/.config/emacs/packages.d/evil-surround.el")
(load "/home/ganfall/.config/emacs/packages.d/projectile.el")
(load "/home/ganfall/.config/emacs/packages.d/magit.el")
(load "/home/ganfall/.config/emacs/packages.d/org.el")
(load "/home/ganfall/.config/emacs/packages.d/general.el") ;; Before last?
(load "/home/ganfall/.config/emacs/packages.d/hydra.el") ;; Binding I made here depends on general.el
(load "/home/ganfall/.config/emacs/packages.d/doom-themes.el") ;; Maybe load last?
;; In theory load order shouldn't matter if I set :after keywords properly

(rune/leader-keys
  "b" '(:ignore t :which-key "buffer")
  "b i" '(ibuffer :which-key "buffer edit")
  "b s" '(consult-buffer :which-key "buffer switch")

  ;; File browsing / Embark
  "." '(find-file :which-key "find-file")
  "C-." '(embark-act :which-key "embark act")
  "M-." '(embark-dwim :which-key "embark at point")
  "," '(consult-recent-file :which-key "recent-file")
  "e" '(:ignore t :which-key "embark")
  "e ." '(embark-dwim :which-key "embark at point")
  "e e" '(embark-act :which-key "embark")
  "e b" '(embark-bindings :which-key "embark bindings")
  "p v" '(dired-jump :which-key "Vim Ex")
  
  ;; Evil-numbers
  ;"C-a" '(evil-numbers/inc-at-pt :which-key "Increase number(s)") ; redundant with evil-numbers config
  "C-x" '(evil-numbers/dec-at-pt :which-key "Decrease number(s)")
  "+" '(evil-numbers/inc-at-pt :which-key "Increase number(s)")
  "-" '(evil-numbers/dec-at-pt :which-key "Decrease number(s)")

  ;; Magit
  "g" '(:ignore t :which-key "Magit")
  "g s" '(magit-status :which-key "Magit status")

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

(load-theme 'doom-gruvbox t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326"
     default))
 '(package-selected-packages
   '(doom-modeline doom-themes embark-consult evil-collection
		   evil-numbers general helpful hydra magit marginalia
		   orderless projectile rainbow-delimiters vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
