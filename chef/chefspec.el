;;; chefspec.el --- Chefspec minor mode -*-

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; This library provides a chefspec minor mode to simplify tasks of
;; running chefspec tests on an entire project or a single spec
;; file. Following key mappings are supported:
;;
;; C-c.t Run all tests in a single spec file.
;; C-c.a Run all chefspec tests in a project.

;;; Code:

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
