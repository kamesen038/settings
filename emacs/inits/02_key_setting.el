;;-----------------------------------------------------------------------
;;コマンドmetaキーの修正 
(setq mac-command-key-is-meta nil)
;; left command key
(setq mac-command-modifier 'super)
;; left option
;(setq mac-option-modifier 'alt)
;;
;; right command key
;;右commandキーにmetaキーを割り当てる
(setq mac-right-command-modifier 'meta)
;; right option key
;(setq mac-right-option-modifier 'hyper)
;;
;superに普通のmacのコマンドを割り当てる設定
;;(global-set-key [?\s-c] 'kill-ring-save)
(global-set-key [?\s-c] 'copy-region-as-kill)
(global-set-key [?\s-v] 'yank)
(global-set-key [?\s-x] 'kill-region)
(global-set-key [?\s-z] 'undo)
(global-set-key [?\s-s] 'save-buffer)
(global-set-key [?\s-q] 'save-buffers-kill-terminal)
(global-set-key [?\s-b] 'yank-pop)
(global-set-key [?\s-a] 'mark-whole-buffer)
(global-set-key [?\s-y] 'browse-kill-ring)
(global-set-key [?\s-f] 'isearch-forward)
(global-set-key [?\s-r] 'query-replace)
;; 
(global-set-key  [?\s-[] 'ispell-complete-word);補完
(global-set-key  [?\s-p] 'ispell-buffer);全体スペルチェック

;;multiply the frames
(global-set-key [?\s-0] 'delete-window)
(global-set-key [?\s-1] 'delete-other-windows)
(global-set-key [?\s-2] 'split-window-vertically)
(global-set-key [?\s-3] 'split-window-horizontally)
;(global-set-key [?\s-o] 'other-window)
;(global-set-key [?\s-t] 'windmove-right-cycle)

;;multiply the frames
(global-set-key "\M-0" 'delete-frame)
(global-set-key "\M-1" 'other-frame)
(global-set-key "\M-2" 'make-frame)

;; C-hでback space
(global-set-key "\C-h" 'delete-backward-char)
;; Window 分割・移動を C-t で
(global-set-key [?\s-t] 'other-window-or-split)
