;; RefTeX with YaTeX
;;
;(add-hook 'yatex-mode-hook 'turn-on-reftex)
;(add-hook 'yatex-mode-hook
;          '(lambda ()
;             (reftex-mode 1)
;            (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
;             (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))

(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(add-hook 'yatex-mode-hook
          #'(lambda ()
              (reftex-mode 1)
              (define-key reftex-mode-map
                (concat YaTeX-prefix ">") 'YaTeX-comment-region)
              (define-key reftex-mode-map
                (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))

;; RefTeXで使用するbibファイルの位置を指定する
(setq reftex-default-bibliography '("/Users/masaya/Dropbox/tex/ref.bib"))
;;-----------------------------------------------------------------------
;;; Tex-master に関しては safe にする
;;; from AUCTeX tex.el 
(put 'TeX-master 'safe-local-variable
     (lambda (x)
       (or (stringp x)
	   (member x (quote (t nil shared dwim))))))

(setq YaTeX-close-paren-always 'never)
;;------------------------------------------------------------------------------
;;
;; Skim との連携
;;
;; http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Emacs#de8b4fcd
;; inverse search
(require 'server)
(unless (server-running-p) (server-start))

;; forward search
;; http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?YaTeX#f978a43b
(defun skim-forward-search ()
  (interactive)
  (progn
    (process-kill-without-query
     (start-process  
      "displayline"
      nil
      "/Applications/Skim.app/Contents/SharedSupport/displayline"
      (number-to-string (save-restriction
                          (widen)
                          (count-lines (point-min) (point))))
      (expand-file-name
       (concat (file-name-sans-extension (or YaTeX-parent-file
                                             (save-excursion
                                               (YaTeX-visit-main t)
                                               buffer-file-name)))
               ".pdf"))
      buffer-file-name))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c s") 'skim-forward-search)))
;; refでsubsectionも参照
(setq YaTeX::ref-labeling-section-level 3)
