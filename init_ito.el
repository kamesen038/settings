;; ---------------------------------------------------------
;;; TeX-master に関しては safe にする
;;; from AUCTeX tex.el 
(put 'TeX-master 'safe-local-variable
     (lambda (x)
       (or (stringp x)
	   (member x (quote (t nil shared dwim))))))
;;--------------------------------------------------------
(global-set-key (kbd "C-k") 'backward-kill-word)
;;auto install
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/lisp/")
;(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
;;browse-kill-ring
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'browse-kill-ring)
(global-set-key (kbd "C-x y") 'browse-kill-ring)
(defface separator '((t (:foreground "slate gray" :bold t))) nil)
(setq browse-kill-ring-separator "--separator------------------------------"
          browse-kill-ring-separator-face 'separator
          browse-kill-ring-highlight-current-entry t
          browse-kill-ring-highlight-inserted-item t)
;;;;;;;;;;;;
;---------
(defun MyTeX-jump-to-next ()
  (interactive)
  (cond
   ((= (following-char) ?$ )  (skip-chars-forward "$") )
   ((= (following-char) 40 ) (skip-chars-forward "(") )
   ((= (following-char) 41 ) (skip-chars-forward ")") )
   ((= (following-char) 91 ) (skip-chars-forward "[") )
   ((= (following-char) 93 ) (skip-chars-forward "]") )
   (t
    (skip-chars-forward "^{}()[]\n\$")
    (skip-chars-forward "}")
    (skip-chars-forward "{")
    )))

;(add-hook 'yatex-mode-hook
;	  '(lambda() 
;	     (local-set-key [(alt j)] 'MyTeX-jump-to-next)
;            (local-set-key [(control j)] 'MyTeX-jump-to-next) 
;	    ))
;-----------
;;section型コマンドの引数入力時、アドイン関数がなければ ミニバッファでの読み込みをせずに入力を完了させる
;(setq YaTeX-skip-default-reader t)

;; --------------------------------------------------------
;;Other window
; (defun other-window-or-split ()
;   (interactive)
;   (when (one-window-p)
;     (split-window-horizontally))
;   (other-window 1))
;;--My window commands--
;;; windmove
(windmove-default-keybindings 'meta)
;; Mac (windmove-default-keybindings 'super)
(defun windmove-right-cycle()
  (interactive)
  (condition-case nil (windmove-right)
    (error (condition-case nil (windmove-left)
	          (error (condition-case nil (windmove-up) (error (condition-case nil (windmove-down) (error (windmove-right))))))))))


(global-set-key (kbd "C-t") 'windmove-right-cycle)
(global-set-key (kbd "C-0") 'delete-window)
(global-set-key (kbd "C-9") 'split-window-horizontally)

;-----------------
;;;;;;;;;;;;;;;
;; revert
(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  ;;(message "force-reverting value is %s" force-reverting)
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))
;; reload buffer
(global-set-key "\M-r" 'revert-buffer-no-confirm)
;; YaTeX の設定
;; ---------------------------------------------------------

;; Add library path
(add-to-list 'load-path "~/.emacs.d/lisp/yatex")
;; YaTeX mode
(setq auto-mode-alist
    (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq tex-command "platex")
(setq dviprint-command-format "dvipdfmx %s")
;; use Preview.app
(setq dvi2-command "open -a Preview")
(defvar YaTeX-dvi2-command-ext-alist    
  '(("xdvi" . ".dvi")                   
      ("ghostview\\|gv" . ".ps")
      ("acroread\\|pdf\\|Preview\\|open" . ".pdf")))
;; ------------------------------------------------------------------------
;; @ coding system

   ;; 日本語入力のための設定
  ;; (set-keyboard-coding-system 'cp932)

  ;; (prefer-coding-system 'utf-8-dos)
  ;; (set-file-name-coding-system 'cp932)
;; (setq default-process-coding-system '(cp932 . cp932))
;起動時
;; (if (boundp 'window-system)
;;     (setq default-frame-alist
;;           (append (list
;;                    ;'(foreground-color . "black")  ; 文字色
;;                    ;'(background-color . "white")  ; 背景色
;;                    ;'(border-color     . "white")  ; ボーダー色
;;                    ;'(mouse-color      . "black")  ; マウスカーソルの色
;;                    ;'(cursor-color     . "black")  ; カーソルの色
;;                    ;'(cursor-type      . box)      ; カーソルの形状
;;                    '(top . 30) ; ウィンドウの表示位置（Y座標）
;;                    '(left . 720) ; ウィンドウの表示位置（X座標）
;;                    '(width . 80) ; ウィンドウの幅（文字数）
;;                    '(height . 38) ; ウィンドウの高さ（文字数）
;;                    )
;;                   default-frame-alist)))
;; (setq initial-frame-alist default-frame-alist )
(defconst my-save-frame-file
  "~/.emacs.d/.framesize"
  "フレームの位置、大きさを保存するファイルのパス")
(defun my-save-frame-size()
  "現在のフレームの位置、大きさを`my-save-frame-file'に保存します"
  (interactive)
  (let* ((param (frame-parameters (selected-frame)))
         (current-height (frame-height))
         (current-width (frame-width))
         (current-top-margin (if (integerp (cdr (assoc 'top param)))
                                 (cdr (assoc 'top param))
                                 0))
         (current-left-margin (if (integerp (cdr (assoc 'left param)))
                                  (cdr (assoc 'left param))
                                  0))
         (buf nil)
         (file my-save-frame-file)
         )
    ;; ファイルと関連付けられたバッファ作成
    (unless (setq buf (get-file-buffer (expand-file-name file)))
      (setq buf (find-file-noselect (expand-file-name file))))
    (set-buffer buf)
    (erase-buffer)
    ;; ファイル読み込み時に直接評価させる内容を記述
    (insert
     (concat
      "(set-frame-size (selected-frame) "(int-to-string current-width)" "(int-to-string current-height)")\n"
      "(set-frame-position (selected-frame) "(int-to-string current-left-margin)" "(int-to-string current-top-margin)")\n"
      ))
    (save-buffer)))
(defun my-load-frame-size()
  "`my-save-frame-file'に保存されたフレームの位置、大きさを復元します"
  (interactive)
  (let ((file my-save-frame-file))
    (when (file-exists-p file)
        (load-file file))))

(add-hook 'emacs-startup-hook 'my-load-frame-size)
(add-hook 'kill-emacs-hook 'my-save-frame-size)
(run-with-idle-timer 60 t 'my-save-frame-size)
;;-------------------------------------------------------------------------
;;multiply the frames
(global-set-key "\M-2" 'make-frame)
(global-set-key "\M-0" 'delete-frame)
(global-set-key "\M-1" 'other-frame)
;; ------------------------------------------------------------------------
;; 自動改行をoffにする
(setq text-mode-hook 'turn-off-auto-fill)
   ;; 対応する括弧を光らせる
   (show-paren-mode)

   ;; C-hでback space
   (global-set-key "\C-h" 'delete-backward-char)
;; ------------------------------------------------------------------------
   ;; IME OFF時の初期カーソルカラー
;;(set-cursor-color "indianred")
   ;;
(mac-auto-ascii-mode 1)
;; -----------------------------------------------------------------------
;;行番号
(global-linum-mode t)
;;----------------------------------------------------------
   ;; spell check
(setq ispell-program-name "aspell")
   ;; 日本語混じりのTeX文書でスペルチェック
(eval-after-load "ispell"
'(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
   ;; YaTeX起動時に，flyspell-modeも起動する
(add-hook 'yatex-mode-hook 'flyspell-mode)
(custom-set-variables 
'(flyspell-auto-correct-binding [(control ?\:)]))

;; -----------------------------------------------------------------------
   ;;color theme
(load-theme 'manoj-dark t)
   ;; refでsubsectionも参照
(setq YaTeX::ref-labeling-section-level 3)

;; ------------------------------------------------------------------
  ;;yatex
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; reftex
(add-hook 'yatex-mode-hook '(lambda () (reftex-mode t)))

(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))

(with-eval-after-load 'yatex
  (setq YaTeX-inhibit-prefix-letter t)
  (setq YaTeX-kanji-code nil)
  (setq YaTeX-use-LaTeX2e t)
  (setq YaTeX-use-AMS-LaTeX t)
  (setq YaTeX-dvi2-command-ext-alist
        '(("Preview\\|TeXShop\\|TeXworks\\|Skim\\|mupdf\\|xpdf\\|Firefox\\|Adobe" . ".pdf")))
;  (setq tex-command "/Library/TeX/texbin/ptex2pdf -l -ot '-synctex=1'")
  (setq tex-command "/Library/TeX/texbin/ptex2pdf -i -l -ot '-synctex=1'")
  (setq bibtex-command (cond ((string-match "uplatex\\|-u" tex-command) "/Library/TeX/texbin/upbibtex")
                             ((string-match "platex" tex-command) "/Library/TeX/texbin/pbibtex")
                             ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "/Library/TeX/texbin/bibtexu")
                             ((string-match "pdflatex\\|latex" tex-command) "/Library/TeX/texbin/bibtex")
                             (t "/Library/TeX/texbin/pbibtex")))
  (setq makeindex-command (cond ((string-match "uplatex\\|-u" tex-command) "/Library/TeX/texbin/mendex")
                                ((string-match "platex" tex-command) "/Library/TeX/texbin/mendex")
                                ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "/Library/TeX/texbin/texindy")
                                ((string-match "pdflatex\\|latex" tex-command) "/Library/TeX/texbin/makeindex")
                                (t "/Library/TeX/texbin/mendex")))
  ;; (setq dvi2-command "/usr/bin/open -a Preview")
  (setq dvi2-command "/usr/bin/open -a Skim")
  (setq dviprint-command-format "/usr/bin/open -a \"Adobe Reader\" `echo %s | sed -e \"s/\\.[^.]*$/\\.pdf/\"`")
  (auto-fill-mode -1)
  (reftex-mode 1))

(require 'server)
(unless (server-running-p) (server-start))

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
             (define-key YaTeX-mode-map (kbd "C-c f") 'skim-forward-search)))

(defun yatex-mode-my-hook ()
  (define-key YaTeX-mode-map (kbd "<f8>") 'YaTeX-typeset-menu)
  (define-key YaTeX-mode-map (kbd "s-R") 'YaTeX-typeset-menu)
  (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
  (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)
  )

;;;Yatex auto fill
(setq YaTeX-greek-key-alist-private
       '(("v" "varphi" "φ-")
	 ("f" "phi" "φ")
	 ("F" "Phi" "Φ")
	 ("h" "eta" "η")
	 ("vb" "vb*" "vector greek")
	 ("vth" "vb*{\\theta}" "vector θ")
	 ("OO" "mho" "~|_|~")
	 ;("<" "bra{" "<~|")
	 ;(">" "ket{" "|~>")
	 ))
;;;;
;;数式モードの";"補間の強化
(setq YaTeX-math-sign-alist-private
      '(("q"         "quad"          "__")
	("qq"        "qquad"         "____")
	("l-"        "varlimsup"     "___\nlim")
	("l_"        "varliminf"     "lim\n---")
	("il"        "varinjlim"     "lim\n-->")
       ;("st"        "text{ s.~t. }" "s.t.")
	("pl"        "varprojlim"    "lim\n<--")
	("|V"        "downarrow"    " |\n V")
	("H" "mathcal{H}" "Hilbert sp")
	("Q" "mathbb{Q}" "ℚ")
	("Z" "mathbb{Z}" "ℤ")
	("R" "mathbb{R}" "ℝ")
	("C" "mathbb{C}" "ℂ")
	("N" "mathbb{N}" "ℕ")
	(">->" "rightarrowtail" "↣")
	("->>" "twoheadrightarrow" "↠")
	("'" "dot" "・\n~")
	("''" "ddot" "・・\n~")
	("n" "nonumber\\\\" "*\\")
	;with physics package
	("b" "bra" "<~|")
	("k" "ket" "|~>")
	;("<>" "braket" "<~|~>")
	("bk" "braket" "<~|*>")
	("p" "dyad" "|~><~|")
	("kb" "ketbra" "|~><*|")
	("e" "ev" "<~|O|~> (O of ~)")
	("m" "mel" "<~|O|*>")
	("tr" "tr" "tr")
	("Tr" "Tr" "Tr")
	("||" "norm" "||~||")
	("/6" "pdv" "∂\n---\n ∂~")
	("/d" "dv" "d\n---\n d~")
	("d" "dd" "d")
	("fd" "fdv" "func der")
	("cc" "qcc" "_c.c._")
	("if" "qif" "_if_")
	("O" "order" "O()")
	("[]" "comm" "[,]")
	("{}" "acomm" "{,}")
	("v" "vb" "vector bold")
	("v*" "vb*" "vector greek(italic)")
	))
;;数式モードの0","補間
(setq YaTeX-math-funcs-list
      '(("s"	"sin"           "sin")
	("c"    "cos"           "cos") 
	("t"    "tan"           "tan")
	("hs"	"sinh"          "sinh")
	("hc"   "cosh"          "cosh")
	("ht"   "tanh"          "tanh")
	("S"	"arcsin"        "arcsin")
	("C"    "arccos"        "arccos")
	("T"    "arctan"        "arctan")
	("se"   "sec"           "sec")
	("cs"   "csc"           "csc")
	("cot"  "cot"           "cot")
	("l"    "log"            "log")
	("L"    "ln"           "ln")
	("e"    "exp"           "exp")
	("M"    "max"           "max")
	("m"    "min"           "min")
	("su"   "sup"           "sup")
	("in"   "inf"           "inf")
	("di"   "dim"           "dim")
	("de"   "det"           "det")
	("i"    "Im"       "Im")
	("r"    "Re"       "Re")
	("BB"   "vb{B}"    "vector B")
	("<"    "langle"  "<")
	(">"    "rangle"  ">")
	("[c"    "left\lceil"  " _\n|")
	("]c"    "right\\rceil"  "_\n |")
	("["    "left\lfloor"  "|\n--")
	("]"    "right\\rfloor"  " |\n--")
	;("i" "imath"             "i")
	;("j"   "jmath"           "j")
	;("I"    "Im"            "Im")
	;("R"    "Re"            "Re")
	))
;(setq YaTeX-math-key-list-private
;      '(("," . YaTeX-math-funcs-list)
;	))

 (setq yatex-mode-load-hook
       '(lambda()
	  (YaTeX-define-begend-key "ba" "align")
	  (YaTeX-define-begend-key "bA" "align*")
	  ;theorems
	  (YaTeX-define-begend-key "bp" "proof")
	  (YaTeX-define-begend-key "bt" "theorem")
	  (YaTeX-define-begend-key "bl" "lemma")
	  (YaTeX-define-begend-key "bd" "definition")
	  (YaTeX-define-begend-key "bP" "proposition")
	  (YaTeX-define-begend-key "bD" "document")
	  (YaTeX-define-begend-key "bC" "corollary")
	  ))


;;(add-hook-lambda 'yatex-mode-hook 'my-yatex-mode-hook)
