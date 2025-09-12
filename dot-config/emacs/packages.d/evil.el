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


  (evil-define-key '(normal visual) 'global (kbd "C-d") 'my/evil-scroll-down)
  (evil-define-key '(normal visual) 'global (kbd "C-u") 'my/evil-scroll-up)

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
