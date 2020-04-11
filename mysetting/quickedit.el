;;https://www.emacswiki.org/emacs/AutoIndentation
;;Auto-indent yanked (pasted) code
;; (dolist (command '(yank yank-pop))
;;    (eval `(defadvice ,command (after indent-region activate)
;;             (and (not current-prefix-arg)
;;                  (member major-mode '(emacs-lisp-mode lisp-mode
;;                                                       javascript-mode    typescript-mode
;;                                                       clojure-mode    scheme-mode
;;                                                       haskell-mode    ruby-mode
;;                                                       rspec-mode      python-mode
;;                                                       c-mode          c++-mode
;;                                                       objc-mode       latex-mode
;;                                                       plain-tex-mode))
;;                  (let ((mark-even-if-inactive transient-mark-mode))
;;                    (indent-region (region-beginning) (region-end) nil))))))

(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (evil-open-below 1)
  (yank)
  (evil-force-normal-state)
  ;; (kill-line 1)
  (call-interactively 'indent-region))

(defun cancel-selection ()
  (interactive)
  (exchange-point-and-mark )
  (evil-normal-state)
  )

(defun selectBlock ()
  (interactive)
  (evil-visual-char)
  (evil-first-non-blank)
  (exchange-point-and-mark)
  (evil-last-non-blank)
  (evil-jump-item)
  (evil-end-of-line)
  (evil-yank (region-beginning) (region-end) )
  ;; (evil-force-normal-state)
  )

(defun gotoLastChange ()
  (interactive)
  (goto-last-change 1)
  (what-line)
  (evil-scroll-line-to-center (line-number-at-pos))
  )

(defun selcurrentline ()
  ;;; select current line.
  ;;; will change curosr's position
  (interactive)
     (evil-first-non-blank)
     (evil-visual-char)
     (evil-end-of-line)
     (evil-yank (region-beginning) (region-end))
   )

;; (defun paste-next-line ()
;;   "trim text in kill-ring and paste in the next line with proper indentation"
;;   (interactive)
;;   (evil-open-below())
;;   (insert (trim-string (car kill-ring)))
;;   (evil-normal-state)
;;     ;; (yank)
;;  )

;; (defun was-yanked ()
;;   "When called after a yank, store last yanked value in let-bound yanked."
;;   "http://stackoverflow.com/questions/22960031/save-yanked-text-to-string-in-emacs "
;;   (interactive)
;;   (let (yanked)
;;     (and (eq last-command 'yank)
;;          (setq yanked (car kill-ring)))))

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

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
(replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string))
)

(defun force-normal-n-save ()
  (interactive)
(evil-force-normal-state)
(save-buffer)
  )

(defun insert-next-line ()
  ;; go to next line to edit especially in insert state
  (interactive)
  (evil-end-of-line)
  (evil-open-below 1)
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


;; buffer
(defun switch-to-scratch-buffer ()
  "Switch to the `*scratch*' buffer. Create it first if needed."
  (interactive)
  (let ((exists (get-buffer "*scratch*")))
    (switch-to-buffer (get-buffer-create "*scratch*"))
    ))

(defun move-buffer-to-window ()
  (interactive)
  (set-window-buffer (next-window ) (buffer-name))
  (evil-switch-to-windows-last-buffer)
  )
