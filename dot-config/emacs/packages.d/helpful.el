(use-package helpful
  :bind (("C-h f" . helpful-callable)
	 ("C-h v" . helpful-variable)
	 ("C-h k" . helpful-key)
	 ("C-h x" . helpful-command)
	 ("C-h F" . helpful-function)
	 ("C-h C-." . helpful-at-point)) )
