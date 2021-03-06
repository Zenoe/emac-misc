;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)
;; (package! evil-matchit :recipe (:fetcher github :repo "redguardtoo/evil-matchit" :commit "7d65b4167b1f0086c2b42b3aec805e47a0d355c4"))

;; https://github.com/bburns/clipmon
;; (package! clipmon)
(package! wgrep)

(cond
 ;; ((string-equal system-type "windows-nt")
 ;;  (progn
 ;;    (message "Microsoft Windows")))
 ;; ((string-equal system-type "darwin") ;  macOS
 ;;  (progn
 ;;    (message "Mac OS X")))
 ((string-equal system-type "gnu/linux")
  (progn
    (package! xclip)
    )))

;; (package! ag)
