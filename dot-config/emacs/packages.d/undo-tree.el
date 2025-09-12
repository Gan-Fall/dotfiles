(use-package undo-tree
  :custom
  (undo-tree-enable-undo-in-region t))
(global-undo-tree-mode 1)

(defadvice undo-tree-make-history-save-file-name
    (after undo-tree activate)
  (setq ad-return-value (concat ad-return-value ".zst")))
