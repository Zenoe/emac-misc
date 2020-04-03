;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(require 'dired)
(require 'xclip)

(defvar myset-folder "~/.doom.d/mysetting/")
(load-file ( concat myset-folder "customsetting.el"))
(load-file ( concat myset-folder "misc.el"))
(load-file ( concat myset-folder "quickedit.el"))

(nvmap "gl" 'evil-last-non-blank)
;; (nvmap "gy" 'paste-next-line)
(nvmap "gh" '+helm/project-search)
(nvmap "gb" 'sp-splice-sexp)
(nvmap "zv" 'selcurrentline)
(nvmap "z;" 'selectBlock)
(nvmap "zs" 'surround-region-with-if)
(nvmap "g;" 'gotoLastChange)
(nvmap "ze" 'searchb4spaceorbracket)
(nvmap "zg" 'sgml-skip-tag-forward)
(nvmap "zG" 'sgml-skip-tag-backward)
(nvmap "zp" 'yank-and-indent)
(nvmap "go" 'comment-line)

(definkey evil-normal-state-map (kbd "M-;")
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

(define-key evil-normal-state-map (kbd "RET")
  (lambda(count)
    (interactive "p")
    (if (= count 1)
        (evil-open-below())
      (evil-open-above()))
    (evil-normal-state)))

 ;; (kbd "S-RET") can not bind to shift-return

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

