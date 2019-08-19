;;; ~/.doom.d/mysetting/misc.el -*- lexical-binding: t; -*-

(define-key process-menu-mode-map (kbd "C-k") 'joaot/delete-process-at-point)

(global-set-key (kbd "M-1")
               (lambda()
                 (interactive)
                 ( +workspace/switch-to 0 )
                 ))
(global-set-key (kbd "M-2")
               (lambda()
                 (interactive)
                 ( +workspace/switch-to 1 )
                 ))

;; (global-set-key (kbd "M-p") 'move-up-half)
;; (global-set-key (kbd "M-n") 'move-down-half)
(global-set-key (kbd "C-;") 'comment-line)


(global-set-key (kbd "M-3")
               (lambda()
                 (interactive)
                 ( +workspace/switch-to 2 )
                 ))
(global-set-key (kbd "M-4")
               (lambda()
                 (interactive)
                 ( +workspace/switch-to 3 )
                 ))

(global-set-key (kbd "M-5")
               (lambda()
                 (interactive)
                 ( +workspace/switch-to 4 )
                 ))

(global-set-key (kbd "C-s") 'save-buffer)

;; (global-set-key (kbd "M-p") 'move-up-half)
;; (global-set-key (kbd "M-n") 'move-down-half)
(global-set-key (kbd "C-;") 'comment-line)
(defun gotofunname ()
  (interactive)
  (beginning-of-defun)
  (if ( string-equal "(" (string (char-after)) )
      (evil-forward-word-begin 2)
    (evil-forward-word-begin 1)
    )
  )

(defun searchb4spaceorbracket ()
  (interactive)
  (push-mark (point) nil t)
  (let ((oldpt ( point ))
        )
    ;; (while (not (eolp))
    (while (not (memq (char-after) '(?\t ?\n ?\s ?\( ?\) ?\] ?\[)))
      (let* ((current-character (char-after))
             )
        )
      (evil-forward-char 1))

    ;; (message "%d, %d" oldpt (point))
    (if (> (point) oldpt)
        (backward-char 1)
      t
      )
    (if (= (point) oldpt)
        (deactivate-mark)
      t
      )
    )
  )

(defun joaot/delete-process-at-point()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
    (cond ((and process
                (processp process))
           (delete-process process)
           (revert-buffer))
          (t
           (error "no process at point!")))))
(defun move-up-half ()
  (interactive)
  (setq first-line (window-start (selected-window)))
  (move-to-window-line  ( / (count-lines ( point )  first-line ) 2 ) )
  )

(defun move-down-half ()
  (interactive)
  (setq last-line (window-end (selected-window)))
  (move-to-window-line  (- ( / (count-lines ( point )  last-line ) 2 ) ))
  )

(defun tag-word-or-region (tag)
    "Surround current word or region with a given tag."
    (interactive "sEnter tag (without <>): ")
    (let (bds start-tag end-tag)
    (setq start-tag (concat "<" tag ">"))
    (setq end-tag (concat "</" tag ">"))
    (if (and transient-mark-mode mark-active)
        (progn
            (goto-char (region-end))
            (insert end-tag)
            (goto-char (region-beginning))
            (insert start-tag))
        (progn
            (setq bds (bounds-of-thing-at-point 'symbol))
            (goto-char (cdr bds))
            (insert end-tag)
            (goto-char (car bds))
            (insert start-tag)))))

(defun surround-region-with-if (tag)
    "Surround region with if/when statement."
    (interactive "sEnter if/when/: ")
    ;; (unless tag (setq tag "if"))
    ;; default to be if
    (if (= (length tag) 0)
        (setq tag "if"))
    (let (bds start-tag end-tag)
    (setq start-tag (concat tag "(){\n"))
    (setq end-tag (concat "\n}"))
    (if (and transient-mark-mode mark-active)
        (progn
            (goto-char (region-end))
            (insert end-tag)
            (goto-char (region-beginning))
            (insert start-tag))
        (progn
            (setq bds (bounds-of-thing-at-point 'symbol))
            (goto-char (cdr bds))
            (insert end-tag)
            (goto-char (car bds))
            (insert start-tag))))
    (goto-char (region-beginning))
    (search-forward "(")
    (evil-insert-state)
    )

(defun copy_file_name ()
  "Copy the current file name to the kill ring."
  (interactive)
  (if-let* ((filename (or buffer-file-name (bound-and-true-p list-buffers-directory))))
      (message (kill-new (abbreviate-file-name ( file-name-nondirectory filename ))))
    (error "Couldn't find filename in current buffer")))

(map! :leader
      (:prefix ("v" . "misc")
        :desc "copy filename"          "f"  #'copy_file_name
        ;; :desc "uplist"                 "u"  #'backward-up-list
        :desc "downlist"               "d"  #'down-list
        ;; :desc "clip mon"            "c"  #'clipmon-autoinsert-toggle
        :desc "goto function name"  "a" #'gotofunname
        :desc ""  "v" #'+helm/workspace-buffer-list
        )

      )

(map! (:when (featurep! :feature evil)
        :m  "ze"    #'searchb4spaceorbracket
        )
      )
