(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;; 日本語の設定（UTF-8）
;(set-language-environment 'Japanese)
(set-language-environment "Japanese")
;;-----------------------------------------------------------------------
;;utf-8を使うおまじない
;(prefer-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;(set-defolt-coding-system 'utf-8)
;;-----------------------------------------------------------------------

;;-----------------------------------------------------------------------
;;(package-initialize)
;;行番号を表示
(global-linum-mode t)
;-----------------------------------------------------------------------
;; マウス・スクロールを滑らかにする（Mac Emacs 専用）
 (setq mac-mouse-wheel-smooth-scroll t)
;-----------------------------------------------------------------------

;; ミニバッファに入力時、自動的に英語モード
(when (functionp 'mac-auto-ascii-mode)
  (mac-auto-ascii-mode 1))
;-----------------------------------------------------------------------
;; ツールバーを非表示
;;(tool-bar-mode 0)
;;scratch画面消す
;;(setq initial-scratch-message nil)
;;自動保存消す
(setq auto-save-default nil)
;; バックアップファイルを作らないようにする
(setq make-backup-files nil)
;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
;;起動時のメッセージを消す
(setq inhibit-startup-message t)
;;-----------------------------------------------------------------------
;; 対応する括弧を光らせる
(show-paren-mode)
;;; 現在行を目立たせる
(global-hl-line-mode)

;;----------------------------------------------------------
;; spell check
(setq ispell-program-name "aspell")
;; 日本語混じりのTeX文書でスペルチェック
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;; YaTeX起動時に，flyspell-modeも起動する
;;(add-hook 'yatex-mode-hook 'flyspell-mode)
;;(custom-set-variables 
;;'(flyspell-auto-correct-binding [(control ?\:)]))


;;-------------------------------------------------------------------------
;; 自動改行をoffにする
(setq text-mode-hook 'turn-off-auto-fill)
;;----------------------------------------------------------------------

;; -----------------------------------------------------------------------
;;color theme
(load-theme 'manoj-dark t)
;;(load-theme 'monokai t)

;; 非アクティブウィンドウの背景色を設定
(require 'hiwin)
(hiwin-activate)
(set-face-background 'hiwin-face "gray30")

