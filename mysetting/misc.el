;;; ~/.doom.d/mysetting/misc.el -*- lexical-binding: t; -*-

(define-key process-menu-mode-map (kbd "C-k") 'joaot/delete-process-at-point)
(global-set-key (kbd "M-p") 'move-up-half)
(global-set-key (kbd "M-n") 'move-down-half)

(defun joaot/delete-process-at-point ()
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

(defun er-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(map! :leader
      (:prefix ("v" . "misc")
        :desc "copy filename"          "f"  #'er-copy-file-name-to-clipboard
        ;; :desc "uplist"                 "u"  #'backward-up-list
        :desc "downlist"               "d"  #'down-list
        ;; :desc "clip mon"            "c"  #'clipmon-autoinsert-toggle
        )

      )
