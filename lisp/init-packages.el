;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/"))))

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar ddy/packages '(
               ;; --- Auto-completion ---
               company
               ;; --- Better Editor ---
               hungry-delete
	       helm
	       helm-swoop
               smartparens
	       popwin
               ;; --- Major Mode ---
               js2-mode
               ;; --- Minor Mode ---
               nodejs-repl
               exec-path-from-shell
	       nyan-mode
	       eclim
	       company-emacs-eclim
	       ;; --- Themes ---
	       doom-themes
	       ) "Default packages")

(setq package-selected-packages ddy/packages)

(defun ddy/packages-installed-p ()
  (loop for pkg in ddy/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (ddy/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg ddy/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; setup nodejs-repl
(require 'nodejs-repl)

;; setup js2-mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; setup smartparens
(smartparens-global-mode t)

;; setup nyan-mode cat
(require 'nyan-mode)
(nyan-mode)
(nyan-start-animation)
(setq nyan-wavy-trail t)
(setq nyan-animate-nyancat t)

;; setup doom themes
(require 'doom-themes)
;; Global settings (defaults)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
;; Load the theme (doom-one, doom-molokai, etc);
(load-theme 'doom-dracula t)
;; Enable custom neotree theme (all-the-icons must be installed!)
;; (doom-themes-neotree-config)
;; or for treemacs users
;; (doom-themes-treemacs-config)
;; org-mode's native fontification.
(doom-themes-org-config)

;; setup eclim
(require 'eclim)
(add-hook 'java-mode-hook 'eclim-mode)
(setq eclimd-autostart t)

;; setup company
(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; setup popwin
(require 'popwin)
(popwin-mode t)

;; setup flyspell
(flyspell-mode t)
(add-hook 'org-mode-hook 'flyspell-mode)

;; setup helm
(require 'helm)
(require 'helm-config)

(helm-autoresize-mode 1)
(setq helm-autoresize-max-height 32)
(setq helm-autoresize-min-height 28)
 (helm-mode 1)
;; Locate the helm-swoop folder to your path
(add-to-list 'load-path "~/.emacs.d/elisp/helm-swoop")
(require 'helm-swoop)


;; using hippie to enhance company-mode
(setq hippie-expand-try-function-list '(try-expand-debbrev
                                        try-expand-debbrev-all-buffers
                                        try-expand-debbrev-from-kill
                                        try-complete-file-name-partially
                                        try-complete-file-name
                                        try-expand-all-abbrevs
                                        try-expand-list
                                        try-expand-line
                                        try-complete-lisp-symbol-partially
                                        try-complete-lisp-symbol))



(provide 'init-packages)