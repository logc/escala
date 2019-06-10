;;; packages.el --- escala layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Luis Osa <luis@babieca.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `escala-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `escala/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `escala/pre-init-PACKAGE' and/or
;;   `escala/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst escala-packages
  '(
    lsp-mode
    lsp-ui
    scala-mode
    sbt-mode

    company-lsp
    flycheck
    )
)

(defun escala/init-scala-mode ()
  (use-package scala-mode
    :defer t
    ;; Configure file extensions
    :mode "\\.s\\(cala\\|bt\\)$"))

(defun escala/init-sbt-mode ()
  (use-package sbt-mode
    :defer t
    :config
    ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
    ;; allows using SPACE when in the minibuffer
    (substitute-key-definition
     'minibuffer-complete-word
     'self-insert-command
     minibuffer-local-completion-map)
    :init (spacemacs/set-leader-keys-for-major-mode 'scala-mode
            "b." 'sbt-hydra
            "bb" 'sbt-command)))

(defun escala/pre-init-lsp-ui ()
  (use-package lsp-ui
    :defer t))

(defun escala/pre-init-company-lsp ()
  (use-package company-lsp
    :defer t))

(defun escala/post-init-flycheck ()
  (global-flycheck-mode))

(defun escala/post-init-lsp-mode ()
  (setq lsp-prefer-flymake nil))

;;; packages.el ends here
