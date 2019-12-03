;; alu

(let ((gc-cons-threshold most-positive-fixnum))

  ;; Set repositories
  (require 'package)
  (setq-default
   load-prefer-newer t
   package-enable-at-startup nil)

  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                      (not (gnutls-available-p))))
	     (proto (if no-ssl "http" "https"))))
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
  
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (package-initialize)
  
  ;; Install dependencies
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package t))
  (setq-default
   use-package-always-defer t
   use-package-always-ensure t)

  ;; Use latest Org
  (use-package org :ensure org-plus-contrib)

  ;; Tangle configuration
  (org-babel-load-file (expand-file-name "configuration.org" user-emacs-directory))
  (garbage-collect))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ws-butler yasnippet-snippets yaml-mode webpaste web-mode use-package toc-org smartparens shackle selected rjsx-mode rainbow-mode rainbow-delimiters paradox org-sticky-header org-plus-contrib multiple-cursors markdown-mode magit json-mode js-doc highlight-indent-guides highlight helm-projectile helm-org helm-describe-modes helm-descbinds helm-ag google-translate gitignore-mode gitconfig-mode gitattributes-mode flycheck eyebrowse expand-region exec-path-from-shell emmet-mode doom-themes doom-modeline dockerfile-mode define-word csv-mode company anzu alert aggressive-indent))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
