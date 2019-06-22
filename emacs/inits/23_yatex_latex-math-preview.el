;;latex-math-preview

;;(setq yatex-mode-load-hook
;;       '(lambda()
;;	  (YaTeX-define-begend-key "ba" "align")
;;	  (YaTeX-define-begend-key "bA" "align*")
;;	  ;theorems
;;	  (YaTeX-define-begend-key "bp" "proof")
;;	  (YaTeX-define-begend-key "bt" "theorem")
;;	  (YaTeX-define-begend-key "bl" "lemma")
;;	  (YaTeX-define-begend-key "bd" "definition")
;;	  (YaTeX-define-begend-key "bP" "proposition")
;;	  (YaTeX-define-begend-key "bD" "document")
;;	  (YaTeX-define-begend-key "bC" "corollary")
;;	  ))

(autoload 'latex-math-preview-expression "latex-math-preview" nil t)
(autoload 'latex-math-preview-insert-symbol "latex-math-preview" nil t)
(autoload 'latex-math-preview-save-image-file "latex-math-preview" nil t)


(add-hook 'yatex-mode-hook
         '(lambda ()
         (YaTeX-define-key "\C-p" 'latex-math-preview-expression)
     ;    (YaTeX-define-key "\C-p p" 'latex-math-preview-save-image-file)
         (YaTeX-define-key "\C-j" 'latex-math-preview-insert-symbol)
     ;    (YaTeX-define-key "\C-j j" 'latex-math-preview-last-symbol-again)
					;    (YaTeX-define-key "\C-b" 'latex-math-preview-beamer-frame)
	 ))
(setq latex-math-preview-in-math-mode-p-func 'YaTeX-in-math-mode-p)

