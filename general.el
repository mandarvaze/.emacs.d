(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

;; ref: http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
;; save all backup files (foo~) to this directory.
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      auto-save-timeout 20   ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200 ; number of keystrokes between auto-saves (default: 300)
      )

;; ;; linum mode
;; (global-linum-mode 1)


;; ;;; winner-mode, undo window configration
(when (fboundp 'winner-mode)
  (winner-mode 1))
;; winner-undo -> C-c <left>
;; winner-redo -> C-c <right>

;; helm 
(require 'helm-config)
 (helm-mode 1)
(require 'helm-swoop)

;; Change the keybinds to whatever you like :)
;; (global-set-key (kbd "M-i") 'helm-swoop)
;; (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
;; (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
;; (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
(global-set-key (kbd "<f1>") 'helm-swoop)
;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)
;; ----------------------------------------------------------------------

; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; (add-to-list 'load-path "~/git/.emacs.d/elpa/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; recentf files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(global-set-key "\C-r" 'helm-recentf)

;; prefer horizentally split window
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; font
(set-default-font "Source Code Pro")
(set-face-attribute 'default nil :height 140)
;; (when (window-system)
;;   (set-frame-font "Source Code Pro")
;;   (set-face-attribute 'default nil :font "Source Code Pro" :height 140)
;;   (set-face-font 'default "Source Code Pro"))

;; windows path convention
(setenv "CYGWIN" "nodosfilewarning")
;; kill *scratch* buffer if possible
(kill-buffer "*scratch*")
;; (kill-buffer "*GNU Emacs*")
(setq inhibit-startup-message t)        ; Disable startup message

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<right>") 'mc/mark-next-like-this)
(global-set-key (kbd "C-S-<left>") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; C-tab to switch bteween buffers.
;; (global-set-key [C-tab] 'other-window)

;; full path of current buffer
(defun yt/copy-full-path-to-kill-ring ()
  "copy buffer's full path to kill ring"
  (interactive)
  (when buffer-file-name
    (kill-new (file-truename buffer-file-name))))
(global-set-key [C-f1] 'yt/copy-full-path-to-kill-ring) ; Or any other key you want


;; git
(require 'magit)




(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;; projectile related 
(require 'projectile)
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-switch-project-action 'projectile-dired)
(setq projectile-remember-window-configs t )
(setq projectile-completion-system 'helm)



;; spell, grammar 
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'flyspell-mode)
(setq ispell-dictionary "british"
      ispell-extra-args '() ;; TeX mode "-t"
      ispell-silently-savep t)

;; visible notication for invalid options 
(setq visible-bell t) 
;; move between windows, alternatives: window_number.el
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

;; highlights FIXME: TODO: and BUG: in prog-mode 
(add-hook 'prog-mode-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("\\<\\(YT\\|FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

;; 
(nyan-mode 1)
;; Change "yes or no" to "y or n"
(fset 'yes-or-no-p 'y-or-n-p)



(defun yt/reload-dot-emacs ()
  "Save the .emacs buffer if needed, then reload .emacs."
  (interactive)
  (let ((dot-emacs "~/.emacs"))
    (and (get-file-buffer dot-emacs)
         (save-buffer (get-file-buffer dot-emacs)))
    (load-file dot-emacs))
  (message "Re-initialized!"))

(add-hook 'prog-mode-hook 'hs-minor-mode)
(global-set-key (kbd "<f3>") 'hs-toggle-hiding)
(global-set-key (kbd "S-<f3>") 'hs-show-all) ;; S->show 
(global-set-key (kbd "C-<f3>") 'hs-hide-all) 
;;   hs-hide-block                      C-c @ C-h
;;   hs-show-block                      C-c @ C-s
;;   hs-hide-all                        C-c @ C-M-h
;;   hs-show-all                        C-c @ C-M-s
;;   hs-hide-level                      C-c @ C-l
;;   hs-toggle-hiding 
;;   hs-mouse-toggle-hiding             [(shift mouse-2)]
;;   hs-hide-initial-comment-block
