;; custom emacs packages directory
(add-to-list 'load-path "~/elisp")
;; psgml local install
(add-to-list 'load-path "~/elisp/psgml")
(add-to-list 'load-path "~/elisp/nxml-mode")
(setq sgml-local-catalogs (cons "~/elisp/sgml/html/dtd/catalog" ()))
;; My actual customizations I use across different systems are in this
;; file.  This .emacs contains stuff specific to emacs on my sdf account.
(load-file "~/.dotemacs")

;; Custom section below.  Hands off
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(debug-on-error t)
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(paren-sexp-mode t)
 '(save-place t nil (saveplace))
 '(show-paren-mode nil nil (paren)))

(put 'narrow-to-region 'disabled nil)
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(paren-face-match ((((class color)) (:background "blue")))))
