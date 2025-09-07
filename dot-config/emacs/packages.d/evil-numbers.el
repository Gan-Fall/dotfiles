(use-package evil-numbers
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
