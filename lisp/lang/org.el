;;; package -- org-config
;;; Commentary:
;;; Code:

(setq-default org-agenda-files '("~/Nutstore Files/GTD"))
(use-package org
  :ensure org-plus-contrib
  :defer t
  :config (require 'ox-freemind))
(setq-default org-confirm-babel-evaluate nil)
(add-hook 'org-mode-hook (lambda ()
                           (if (fboundp 'org-display-inline-images)
                               (org-display-inline-images t t))

                           (if (fboundp 'org-indent-mode)
                               (org-indent-mode))
                           (setq truncate-lines nil)))

(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)


(require 'ob-python)
(require 'ob-shell)
(require 'ob-plantuml)
(require 'ob-java)
(require 'ob-js)
(require 'ob-python)
(require 'ob-latex)

(setq org-latex-compiler "xelatex")
(if (eq system-type 'darwin)
    (progn (setenv "PATH" (concat "/Library/TeX/texbin" (getenv "PATH")))
(setq exec-path (append '("/Library/TeX/texbin") exec-path))))
(provide 'lang/org)
;;; org-config.el ends here
