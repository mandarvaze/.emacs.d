
;,----
;| ;;;;; EMSS
;`----


;; Adapted with one minor change from Felipe Salazar at
;; http://www.emacswiki.org/emacs/EmacsSpeaksStatistics
(add-to-list 'load-path "~/git/.emacs.d/elpa/ess-13.09-1/lisp")
(require 'ess-site)
(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
(defun my-ess-start-R ()
  (interactive)
  (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
      (progn
        (delete-other-windows)
        (setq w1 (selected-window))
        (setq w1name (buffer-name))
        (setq w2 (split-window w1 nil t))
        (R)
        (set-window-buffer w2 "*R*")
        (set-window-buffer w1 w1name))))
(defun my-ess-eval ()
  (interactive)
  (my-ess-start-R)
  (if (and transient-mark-mode mark-active)
      (call-interactively 'ess-eval-region)
    (call-interactively 'ess-eval-line-and-step)))
(add-hook 'ess-mode-hook
          '(lambda()
             (local-set-key [(shift return)] 'my-ess-eval)))
(add-hook 'inferior-ess-mode-hook
          '(lambda()
             (local-set-key [C-up] 'comint-previous-input)
             (local-set-key [C-down] 'comint-next-input)))
(add-hook 'Rnw-mode-hook
          '(lambda()
             (local-set-key [(shift return)] 'my-ess-eval)))
;; (require 'ess-site)



;; REF: http://stackoverflow.com/questions/2901198/useful-keyboard-shortcuts-and-tips-for-ess-r
;; C-tab to switch between the R command line and the file (similar to josh answer, but much faster):
(global-set-key [C-tab] 'other-window)
;; Control and up/down arrow keys to search history with matching what you've already typed:
(define-key comint-mode-map [C-up] 'comint-previous-matching-input-from-input)
(define-key comint-mode-map [C-down] 'comint-next-matching-input-from-input)


(define-key ess-mode-map (kbd "C-d") 'comment-region)
(define-key ess-mode-map (kbd "C-S-d") 'uncomment-region)
;; C-b = list buffers 
(global-set-key (kbd "C-b") 'bs-show)


;; use ess-transcript-clean-buffer to 
;; 1. clean *R* buffer, remove all outputs
;; 2. save commands history

(setq ess-eval-visibly-p 'nowait)
