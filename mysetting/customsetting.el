;;; ~/.doom.d/mysetting/customSetting.el -*- lexical-binding: t; -*-



(general-evil-setup t)
(xclip-mode 1)
(require 'helm)
(set-face-attribute 'helm-selection nil :background "#EFFFE0" :foreground "black")

;; (set-face-attribute 'region nil :background "#909090" :foreground "#DD00D8" )
;; (set-face-attribute 'lazy-highlight nil :foreground "red" :background "black")

;; (require 'hl-line)
;; (set-face-attribute 'hl-line nil :background "#80f28B")
;; (set-face-background hl-line-face "#A0B3B5")

(setq dired-dwim-target t)

;; hooks
(add-hook 'go-mode-hook '+company/toggle-auto-completion)
;; typescript
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . js-jsx-mode))
;; (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(setq typescript-indent-level 2)

;; (setq js-indent-level 2);; not work
(add-hook 'js2-mode-hook (lambda () (setq js-indent-level 2)))
;;
;; (setq evil-ex-search-case 'sensitive)
;; (add-to-list 'projectile-globally-ignored-files '("yarn.lock" "node_modules"))
;; (global-auto-complete-mode t)
;;
