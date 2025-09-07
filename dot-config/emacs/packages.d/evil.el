(use-package evil
  :init
  ; (setq evil-want-integration t) ; Not sure if deprecated.
  (setq evil-want-keybinding nil) ; Remove some evil keybinds in other modes which according to system crafters "aren't consistent". TODO: Look into this.
  ; (setq evil-want-C-i-jump nil) ; Remove vim C-i in edit mode functionality
  (setq evil-want-C-u-scroll t)
  ; (setq evil-want-C-u-delete t) ; Whether C-u should delete indent in insert mode.
  :config
  (evil-mode)
  ; (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join) ; Preserve emacs C-h to backspace
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state))

  ;; Not sure what this does in system crafters' config
  ;(evil-set-initial-state 'messages-buffer-mode 'normal)
  ;(evil-set-initial-state 'dashboard-mode 'normal)

  ;; Disabled for now as I like jumping with relative numbers.
  ; J and K will go to the next "wrapped" line (i.e. the same line but wrapped because it is too long)
  ; (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  ; (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

;; Remember on certain buffers you might want to start on emacs mode instead of evil mode. If you find any add them here.
