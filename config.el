;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(general-evil-setup t)

(require 'dired)
(require 'xclip)
(xclip-mode 1)
(setq dired-dwim-target t)

(defvar myset-folder "~/.doom.d/mysetting/")
(load-file ( concat myset-folder "misc.el"))
(load-file ( concat myset-folder "quickedit.el"))

;; (set-face-attribute 'helm-selection nil
;;                     :background "purple"
;;                     :foreground "black")

(set-face-attribute 'region nil :background "#404050" :foreground "yellow" )
(set-face-attribute 'lazy-highlight nil :foreground "red" :background "black")

(require 'hl-line)
;; (set-face-attribute 'hl-line nil :background "#80f28B")
(set-face-background hl-line-face "#A0B3B5")

(nvmap "gl" 'evil-last-non-blank)
(nvmap "gy" 'paste-next-line)
(nvmap "g]" '+helm:ag) ; search in current project
(nvmap "g[" 'helm-ag-buffers)
(nvmap "gb" 'sp-splice-sexp)
(nvmap "zv" 'selcurrentline)
(nvmap "zs" 'surround-region-with-if)

(defun selcurrentline ()
  ;;; select current line.
  ;;; will change curosr's position
  (interactive)
     (evil-first-non-blank)
     (evil-visual-char)
     (evil-end-of-line)
   )

(define-key evil-normal-state-map (kbd "M-;")
  ;; insert a character at the end of current line. semicolon default
  (lambda(c)
    (interactive "p")
    (save-excursion
      (let (
            (pt (search-forward "\n"))
            )
        (backward-char)
        (if (= c 1)
            (insert-char ?\;)
          (insert-char c)
          )
        )
      )
    )
  )

(nvmap "gh" '+helm:ag)
(nvmap "gb" 'sp-splice-sexp)
(define-key evil-normal-state-map (kbd "RET")
  (lambda(count)
    (interactive "p")
    (if (= count 1)
        (evil-open-below())
      (evil-open-above()))
    (evil-normal-state)))

 ;; (kbd "S-RET") can not bind to shift-return

(defun cancel-selection ()
  (interactive) ;; without this would cause:  Emacs Lisp error ¡°Wrong type argument: commandp¡±
  (exchange-point-and-mark )
  (evil-normal-state)
  )

(defun switch-to-scratch-buffer ()
  "Switch to the `*scratch*' buffer. Create it first if needed."
  (interactive)
  (let ((exists (get-buffer "*scratch*")))
    (switch-to-buffer (get-buffer-create "*scratch*"))
    ))

(global-set-key (kbd "C-x C-e") 'eval-current-line)
;; rebind C-k to evil-jump-forward 'cuase the default binding TAB is not working
;; int terminal emacs. and I don't use C-k in evil mode
(global-set-key (kbd "C-k") 'evil-jump-forward)


;; (define-key evil-normal-state-map (kbd ", SPC") 'recentf-open-most-recent-file-3)
(define-key evil-insert-state-map (kbd "M-SPC") 'surround-next-text)
(define-key evil-insert-state-map (kbd "M-;") 'yank)
;; (bind-key "C-x C-e" 'eval-current-line)
;; (unbind-key "C-x z")
;; (bind-key "C-x C-z" 'repeat)
;; (bind-key "C-x C-e" 'eval-current-line)

;;http://emacs.stackexchange.com/questions/14553/how-call-the-eval-sexp-function-with-the-right-argument
(defun eval-current-line (arg)
  (interactive "P")
  (evil-set-marker ?8) ;;The number 8 is just abritrary
  (line-end-position)
  ;; (sp-end-of-sexp)
  (eval-last-sexp arg)
  (evil-goto-mark ?8))

(defun surround-next-text ()
  (interactive)
  (insert "(")
  (move-end-of-line 1)
  (insert ")")
  )

(defun paste-next-line ()
  "trim text in kill-ring and paste in the next line with proper indentation"
  (interactive)
  (evil-open-below())
  (insert (trim-string (car kill-ring)))
  (evil-normal-state)
    ;; (yank)
 )

;; (defun was-yanked ()
;;   "When called after a yank, store last yanked value in let-bound yanked."
;;   "http://stackoverflow.com/questions/22960031/save-yanked-text-to-string-in-emacs "
;;   (interactive)
;;   (let (yanked)
;;     (and (eq last-command 'yank)
;;          (setq yanked (car kill-ring)))))

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
(replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string))
)

;; (defun set-selective-display-dlw (&optional level)
;; "Fold text indented same of more than the cursor.
;; If level is set, set the indent level to LEVEL.
;; If 'selective-display' is already set to LEVEL, clicking
;; F5 again will unset 'selective-display' by setting it to 0."
;;   (interactive "P")
;;   (if (eq selective-display (1+ (current-column)))
;;       (set-selective-display 0)
;;     (set-selective-display (or level (1+ (current-column))))))
;;(global-auto-complete-mode t)
(add-hook 'go-mode-hook '+company/toggle-auto-completion)
;; typescript
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(setq typescript-indent-level 2)
(setq javascript-indent-level 2)
;;
(setq evil-ex-search-case 'sensitive)
