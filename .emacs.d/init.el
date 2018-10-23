; Requires emacs 25.2.2 but 25.x.x will probably work. Probably.
; Some settings
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq ffip-use-rust-fd t)
(setq column-number-mode t)
(add-to-list 'load-path "~/.emacs.d/lisp")

; General key bindings
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)
(global-set-key (kbd "<select>") 'end-of-line)
(global-set-key (kbd "M-r") 'replace-string)
(global-set-key (kbd "<f1>") 'find-file-in-project)
(global-set-key (kbd "<f2>") 'find-file-in-project-at-point)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

; Indentation fixes
(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

; MELPA
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (twig-mode ws-butler pyimport pyimpsort helm-phpunit phpunit magit groovy-mode jenkins csv-mode flymake-phpcs flymake-php helm-flymake fill-column-indicator find-file-in-project epc markdown-mode docker-compose-mode dockerfile-mode json-mode smarty-mode logview apache-mode undo-tree rjsx-mode jsx-mode jedi helm-git-grep helm-git ac-php ac-helm ac-etags))))
(when (not package-archive-contents)
  (package-refresh-contents))
(package-install-selected-packages)

; Helm
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(helm-mode 1)

; Jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t) ; optional

; PHP tweaks
(add-hook 'php-mode-hook
          (lambda ()
            (local-set-key (kbd "M-P") 'php-insert-doc-block)
            (flymake-mode)
            (flymake-php-load)
            
            (auto-complete-mode t)
            (require 'ac-php)
            (setq ac-sources  '(ac-source-php ) )
            (yas-global-mode 1)
            (ac-php-core-eldoc-setup ) ;; enable eldoc
            (define-key php-mode-map  (kbd "C-x y") 'ac-php-find-symbol-at-point)   ;goto define
            (define-key php-mode-map  (kbd "C-x t") 'ac-php-location-stack-back)    ;go back
            )
          )
(add-hook 'after-save-hook
          (lambda()
            (when (eq major-mode 'php-mode)
              (message "php-mode save hook: Remake ac tags")
              (ac-php-remake-tags)
              )
            )
          )

(require 'ws-butler)
(add-hook 'php-mode-hook #'ws-butler-mode)
(add-hook 'python-mode-hook #'ws-butler-mode)

; undo-tree
(global-undo-tree-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
