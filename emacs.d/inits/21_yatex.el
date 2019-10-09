

(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))

(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-latex-message-code 'utf-8)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)
(setq YaTeX-dvi2-command-ext-alist
      '(("Preview\\|TeXShop\\|TeXworks\\|Skim\\|mupdf\\|xpdf\\|Firefox\\|Adobe" . ".pdf")))

;(setq tex-command "/Library/TeX/texbin/ptex2pdf -u -l -ot '-synctex=1'");uplatex

;(setq tex-command "/Library/TeX/texbin/ptex2pdf -l -ot '-synctex=1'");platex
;(setq tex-command "/Library/TeX/texbin/platex");platex

;(setq tex-command "xelatex -synctex=1");XeLatexでコンパイル
(setq tex-command "/Library/TeX/texbin/latex");latex

;(setq bibtex-command "/Library/TeX/texbin/latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
(setq bibtex-command (cond ((string-match "uplatex\\|-u" tex-command) "/Library/TeX/texbin/upbibtex")((string-match "platex" tex-command) "/Library/TeX/texbin/pbibtex")((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "/Library/TeX/texbin/bibtexu")((string-match "pdflatex\\|latex" tex-command) "/Library/TeX/texbin/bibtex")(t "/Library/TeX/texbin/pbibtex")))


(setq makeindex-command (cond ((string-match "uplatex\\|-u" tex-command) "/Library/TeX/texbin/mendex")
			      ((string-match "platex" tex-command) "/Library/TeX/texbin/mendex")
			      ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "/Library/TeX/texbin/texindy")
			      ((string-match "pdflatex\\|latex" tex-command) "/Library/TeX/texbin/makeindex")
			      (t "/Library/TeX/texbin/mendex")))
  ;; (setq dvi2-command "/usr/bin/open -a Preview")
(setq dvi2-command "/usr/bin/open -a Skim")
(setq tex-pdfview-command "/usr/bin/open -a Skim")
(setq dviprint-command-format "/usr/bin/open -a \"Adobe Acrobat Reader DC\" `echo %s | gsed -e \"s/\\.[^.]*$/\\.pdf/\"`")

  (auto-fill-mode -1)
;;  (reftex-mode 1)

