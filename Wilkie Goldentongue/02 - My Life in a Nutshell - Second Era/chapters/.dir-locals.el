;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((latex-mode . ((TeX-master . "../Wilkie_Goldentongue_-_My_Life_in_a_Nutshell_-_Second_Era.tex")
								(ispell-local-dictionary . "british-ize-w_accents")
								(LaTeX-command . "latex -shell-escape -synctex=1 --file-line-error-style")
                (eval . (add-hook 'hack-local-variables-hook
                                  (lambda ()
                                    (font-lock-add-keywords nil
                                      '(("\\\\\\(say\\|think\\){\\([^}]+\\)}{\\(\\(?:[^{}]\\|{[^{}]*}\\)*\\)}"
                                         (1 'font-lock-keyword-face)
                                         (2 'font-lock-variable-name-face)
                                         (3 'font-lock-string-face))))
                                    (when (fboundp 'font-lock-flush) (font-lock-flush))
                                    
                                    (setq-local tex-macro-alist
                                                (append '(("say" "Someone" "Something")
                                                          ("think" "Someone" "Something"))
                                                        tex-macro-alist)))
                                  nil t)))))
