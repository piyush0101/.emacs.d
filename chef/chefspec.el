(define-minor-mode chefspec-mode
  "Minor mode enabling chefspec key commands."
  :keymap
  '(("\C-c.t" . chefspec-file)
    ("\C-c.a" . chefspec-project)))

(defun chefspec-file ()
  "Run chefspec on provided spec file."
  (interactive)
  (let* ((project-root (projectile-project-root))
         (command (concat "cd " project-root
                          " && chef exec rspec "
                          (buffer-file-name)
                          " --format=documentation --color")))
    (async-shell-command command)))

(defun chefspec-project ()
  "Run chefspec tests for the whole project."
  (interactive)
  (let* ((project-root (projectile-project-root))
         (command (concat "cd " project-root
                          " && chef exec rspec "
                          " --format=documentation --color")))
    (async-shell-command command)))

(provide 'chefspec)
