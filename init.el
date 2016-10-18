;; TCP
;;(set 'server-use-tcp t) ;; Necesary to enable multiple instances of the emacs
                        ;; server

;; Miscellaneous
(set 'backup-directory-alist '(("." . "~/.emacs.d/backups")))
(set 'persp-auto-resume-time 0)

;; Don't fuck with me boy
(set 'enable-local-variables :all)

;; Personal information
(set 'user-mail-address "rafcloesen@gmail.com")
(set 'user-full-name "Raf Cloesen")

;; Package Manager
(require 'package)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")
;;; Repositories
;;;; MELPA
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;; GUI:
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;;;Font
(set-face-attribute 'default nil :height 85)
;;; Theme
(load-theme 'zenburn t)

;; Navegation:
(global-set-key (kbd "C-a") 'back-to-indentation)
;;;Windmove
(windmove-default-keybindings)

;; Mode line:
(set 'display-time-24hr-format t)
(display-time)
(column-number-mode)

;; File cleaning:
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(set 'require-final-newline 'visit-save)

;; Winner mode
(winner-mode)

;; Slime
;;(load (expand-file-name "~/quicklisp/slime-helper.el"))
;;(setq inferior-lisp-program "sbcl")

;; StumpWM mode
;; (load-file "~/.emacs.d/lisp/stumpwm-mode.el")
;;(require 'stumpwm-mode)
;;(set 'stumpwm-shell-program "stumpish")

;; Web
;; (setq browse-url-browser-function 'browse-url-default-browser)
;;(set 'browse-url-default-browser 'browse-url-w3)
;;(set 'browse-url-browser-function 'browse-web)
;(set 'browse-url-browser-function 'eww-browse-url)
(set 'browse-url-browser-function 'browse-url-generic)
(set 'shr-external-browser 'browse-url-generic)
(set 'browse-url-generic-program (executable-find "conkeror"))

;; Editing
(set-input-method 'TeX)
(set 'mouse-yank-at-point t)

;; Multiple Cursors
;;(require 'multiple-cursors)
;; Example key binds
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; I cant use C-< for some reason
;;(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;;(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this)

;; Miscellaneous
;;(set 'fill-column 80) ;; buffer-local
(add-hook 'text-mode-hook
	  (lambda ()
	    (set 'fill-column 80)))

;; Programming:
(show-paren-mode 1)

;; Lisp
;;; Paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;;(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;; TODO: Join all prog-mode-hook, inteleave comments.
(add-hook 'prog-mode-hook
	  (lambda ()
	    (set 'c-cleanup-list
		 '(
;;		   space-before-funcall  ;;this one is not working
;;		   contact-empty-funcall ;; so I disable this one to.
		   comment-close-slash
		   ))))
;; TODO: this may be overruled somewhere!
(add-hook 'prog-mode-hook
	  (lambda ()
	    (set 'fill-column 80)))

;; Subword mode
;;(global-subword-mode)
(add-hook 'prog-mode-hook
	  (lambda ()
	    (subword-mode)))

;; Comment autofill
(add-hook 'prog-mode-hook
	  (lambda ()
	    (setq-local comment-auto-fill-only-comments t)
	    (auto-fill-mode)
            (electric-pair-mode)))

;; Column enforce mode
(add-hook 'prog-mode-hook
	  (lambda ()
	    (column-enforce-mode)))

;; Flyspell
(add-hook 'prog-mode-hook
	  (lambda ()
	    (flyspell-prog-mode)))

;; Pretty Lambda
(global-prettify-symbols-mode 1)

;; Semantic
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)

;; Smart Tabs
;; (with-eval-after-load 'smart-tabs-mode
;;   (setf (cdr (assoc 'java smart-tabs-insinuate-alist))
;; 	(cdr (smart-tabs-create-language-advice java jde-mode-hook
;; 						((c-indent-line . c-basic-offset)
;; 						 (c-indent-region . c-basic-offset)))))
;;   (smart-tabs-insinuate 'java))

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Flycheck-java
;; TODO: convert to package and install with package.el
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/flycheck-java"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/s"))
;;(require 's "~/.emacs.d/lisp/s/s.el")
;;(require 'flycheck-java "~/.emacs.d/lisp/flycheck-java/flycheck-java.el")
;;(load "/home/rafcloesen/.emacs.d/lisp/flycheck-java/flycheck-java.el")
;; TODO: fix flycheck-java. Complete refactoring necesary
;; (require 'flycheck-java "/home/rafcloesen/.emacs.d/lisp/flycheck-java/flycheck-java.el")

;;(defun flycheck-java-read-project-def (dir)
;;  (flycheck-java-read-eclipse-project dir))

;; (add-hook 'jde-mode-hook
;; 	  (lambda ()
;; 	    (set 'flycheck-java-ecj-jar-path "/home/rafcloesen/.local/eclipse/plugins/org.eclipse.jdt.core_3.10.0.v20140902-0626.jar")))

;; TODO: write actual method in proper file, for now, workarounds will be used.
;; (defun flycheck-java-read-project-def (dir)
;;   '(:source "1.8"
;;     :target "1.8"
;;     :options "-warn:+over-ann,uselessTypeCheck -proceedOnError -maxProblems 100"
;;     :paths (("tests" . "build/classes") ("src-provided" . "build/classes") ("src" . "build/classes"))
;;     :libs ("lib")
;;     :absolute-lib-paths ("/usr/share/java")))
    ;;:lib-paths ("lib/AnnotationsDoclets.jar")))

;; (flycheck-define-checker java
;;   "Java syntax checker using ecj batch compiler and ant."
;;   :command ("ant" "compile"
;; 	    "-emacs"
;; 	    "-buildfile" (eval (jde-ant-find-build-file default-directory)))
;;   :error-patterns
;;   ((warning line-start (file-name) ":" line ": warning:"
;;             (message (zero-or-more not-newline)) line-end)
;;    (error line-start (file-name) ":" line ": error:"
;;           (message (zero-or-more not-newline)) line-end))
;;   :modes jde-mode java-mode)

;; SpeedBar
(set 'speedbar-tag-hierarchy-method nil)

(with-eval-after-load 'speedbar
  (add-to-list 'speedbar-frame-parameters (cons 'persp-ignore-wconf t)))
;;(add-to-list 'speedbar-frame-parameters (cons 'persp-ignore-wconf t))

(defun speedbar-stumpwm ()
  (interactive)
  (if speedbar-frame
      (with-temp-buffer
	(speedbar)
	(call-process stumpwm-shell-program nil nil nil "only"))
    (with-temp-buffer
      (call-process stumpwm-shell-program nil nil nil "hsplit 4/5")
      (speedbar)
      (call-process stumpwm-shell-program nil nil nil "move-window right")
      (call-process stumpwm-shell-program nil nil nil "move-focus left"))))

;; Sr-speedbar
;; TODO: dont use super key.
;;(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;; ECB
;;(require 'ecb)

;; JDEE
;; TODO: fix jde-parse-class.el, for it is giving an array out of bounds
;; exception in jde-parse-class-get-next-const-val
;; TODO: convert to package and install with package.el
;; (add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
;; (load "jde")

;;(set 'jde-launch-beanshell-on-demand-p nil)

;;; JDEE requires global options to be set with custom-set-variables
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(ecb-options-version "2.40")
;;  '(jde-ant-args "-emacs -Dboard=boards/puzzle20.txt")
;;  '(jde-compile-option-debug (quote ("all" (t nil nil))))
;;  '(jde-complete-function (quote jde-complete-minibuf))
;;  '(jde-import-auto-sort t)
;;  '(jde-jdk (quote ("1.8.0")))
;;  '(jde-jdk-registry
;;    (quote
;;     (("1.8.0" . "/usr/lib/jvm/java-1.8.0-openjdk-amd64"))))
;;  '(jde-project-file-name ".project.el")
;;  '(org-agenda-files
;;    (quote
;;     ("~/Documents/university/kuleuven/2014-2015/semester_II/practica.org"))))

;; ;; (set 'c-cleanup-list 'set-from-style) not working
;; ;; (c-add-style "jde"
;; ;; 	     '("java"
;; ;; 	       (c-cleanup-list . '(brace-else-brace
;; ;; 				  brace-elseif-brace
;; ;; 				  brace-catch-brace
;; ;; 				  empty-defun-braces
;; ;; 				  one-liner-defun
;; ;; 				  defun-close-semi
;; ;; 				  list-close-comma
;; ;; 				  space-before-funcall
;; ;; 				  compact-empty-funcall
;; ;; 				  comment-close-slash))
;; 	       ;;(c-auto-newline . t)
;; ;;	       ))

;; (add-to-list 'c-default-style '(jde-mode . "jde"))
;; ;;(add-to-list 'jde-mode-hook '(lambda () (set 'c-cleanup-list 'set-from-style)))

;; Projectile
(projectile-global-mode)

;; Org Mode

;;; org-projectile
(require 'org-projectile)
(org-projectile:per-repo)
(set 'org-projectile:per-repo-filename "TODOs.org")

(add-to-list 'org-capture-templates (org-projectile:project-todo-entry))
(defun my-capture-for-current-project ()
  (interactive)
  (org-projectile:capture-for-current-project org-projectile:linked-capture-template))

(global-set-key (kbd "C-c n p") 'my-capture-for-current-project)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(set 'org-refile-targets'((nil :maxlevel . 10)))
(add-to-list 'org-agenda-files "~/agenda")


;; Perspective
(persp-mode)

;; Helm
(helm-mode)

(set 'helm-split-window-in-side-p t)
(set 'helm-swoop-split-with-multiple-windows t)
(add-to-list 'helm-boring-file-regexp-list
	     "\\.cache$")

;; prevent swoop from starting a search with thing-at-point
(set 'helm-swoop-pre-input-function (lambda () nil))

(set 'helm-locate-fuzzy-match t)
(set 'helm-locate-command "locate %s -e -A %s")

(helm-autoresize-mode)

(global-set-key [remap switch-to-buffer] 'helm-mini)
(global-set-key [remap find-file] 'helm-for-files)
(global-set-key (kbd "C-x x f") 'helm-find-files)
(global-set-key [remap execute-extended-command] 'helm-M-x)
(global-set-key [remap isearch-forward] 'helm-swoop)
(global-set-key [remap isearch-forward-regexp] 'helm-multi-swoop)
(global-set-key [remap bookmark-jump] 'helm-bookmarks)

;;; Projectile + Perspectives + Helm
(set 'projectile-completion-system 'helm)
(helm-projectile-on)       ;; Replaces the projectile map with the
                           ;; helm-projectile map.
(global-set-key [remap helm-projectile-switch-project] 'persp-projectile-switch-project)

;;; Changed so new frame is created before persp-switch and projectile-switch
;;; Differentiate from same-frame function.
;;; Changed so new frame is created before persp-switch and projectile-switch
(defun persp-projectile-switch-project (project-to-switch)
  "Switch to a project or perspective we have visited before.
If the perspective of corresponding project does not exist, this
function will call `persp-switch' to create one and switch to
that before `projectile-switch-project' invokes
`projectile-switch-project-action'.
Otherwise, this function calls `persp-switch' to switch to an
existing perspective of the project unless we're already in that
perspective."
  (interactive (list (projectile-completing-read "Switch to project: "
		     				 (projectile-relevant-known-projects))))
  (let* ((name (file-name-nondirectory (directory-file-name project-to-switch)))
	 (persp (gethash name perspectives-hash)))
    (cond
     ;; project-specific perspective already exists
     ((and persp (not (equal persp persp-curr)))
      (persp-switch name))
     ;; project-specific perspective doesn't exist
     ((not persp)
      (let ((frame (make-frame `((name . ,name)))))
	(with-selected-frame frame
	  (persp-switch name)
	  (projectile-switch-project-by-name project-to-switch))
	;; Clean up if we switched to a new frame. `helm' for one allows finding
	;; files in new frames so this is a real possibility.
	;; (when (not (equal frame (selected-frame)))
	;;   (with-selected-frame frame
	;;     (persp-kill name)))
	)))))

(defvar helm-source-projectile-projects
  (helm-build-in-buffer-source "Projectile projects"
    :data (lambda ()
            (if (projectile-project-p)
                (cons (abbreviate-file-name (projectile-project-root))
                      (projectile-relevant-known-projects))
              projectile-known-projects))
    :fuzzy-match helm-projectile-fuzzy-match
    :keymap (let ((map (make-sparse-keymap)))
              (set-keymap-parent map helm-map)
              (helm-projectile-define-key map
                (kbd "C-d") 'dired
                (kbd "M-g") 'helm-projectile-vc
                (kbd "M-e") 'helm-projectile-switch-to-eshell
                (kbd "C-s") 'helm-find-files-grep
                (kbd "M-c") 'helm-projectile-compile-project
                (kbd "M-D") 'helm-projectile-remove-known-project)
              map)
    :mode-line helm-ff-mode-line-string
    :action '(("Switch to project" .
               (lambda (project)
                 (let ((projectile-completion-system 'helm))
                   (projectile-persp-switch-project project))))	;perspectives integration.
              ("Open Dired in project's directory `C-d'" . dired)
              ("Open project root in vc-dir or magit `M-g'" . helm-projectile-vc)
              ("Switch to Eshell `M-e'" . helm-projectile-switch-to-eshell)
              ("Grep in projects `C-s'.  With C-u, recurse" . helm-find-files-grep)
              ("Compile project `M-c'. With C-u, new compile command"
               . helm-projectile-compile-project)
              ("Remove project(s) `M-D'" . helm-projectile-remove-known-project)))
  "Helm source for known projectile projects.")

;; Interactively DO
;;(set 'ido-enable-flex-matching t)
;;(set 'ido-everywhere t)
;;(ido-mode 1)
;(ido-mode 'files)

;; flx-ido ;; TODO: maybe uninstall
;; TODO: this necesary?
;;(require 'flx-ido)
;;(ido-mode 1)
;;(ido-everywhere 1)
;;(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
;;(set 'ido-enable-flex-matching t)
;;(set 'ido-use-faces nil)

;; Syncing bookmarks with zsh
(defun local-directory-bookmarks-to-zsh ()
      (interactive)
      (when (and (require 'tramp nil t)
                 (require 'bookmark nil t))
        (set-buffer (find-file-noselect "~/.zsh.bmk" t t))
        (delete-region (point-min) (point-max))
        (insert "# -*- mode:sh -*-\n")
        (let (collect-names)
          (mapc (lambda (item)
                  (let ((name (replace-regexp-in-string "-" "_" (car item)))
                        (file (cdr (assoc 'filename
                                           (if (cddr item) item (cadr item))))))
                    (when (and (not (tramp-tramp-file-p file))
                               (file-directory-p file))
                      (setq collect-names (cons (concat "~" name) collect-names))
                      (insert (format "%s=\"%s\"\n" name (expand-file-name file) name)))))
                bookmark-alist)
          (insert ": " (mapconcat 'identity collect-names " ") "\n"))
        (let ((backup-inhibited t)) (save-buffer))
        (kill-buffer (current-buffer))))

(defadvice bookmark-write-file
    (after local-directory-bookmarks-to-zsh-advice activate)
  (local-directory-bookmarks-to-zsh))


;; TODO: only configuration in init.el, move this method to a separate package
;; and install with package.el
(defun intelligent-close ()
    "quit a frame the same way no matter what kind of frame you are on.

This method, when bound to C-x C-c, allows you to close an emacs frame the
same way, whether it's the sole window you have open, or whether it's
a \"child\" frame of a \"parent\" frame.  If you're like me, and use emacs in
a windowing environment, you probably have lots of frames open at any given
time.  Well, it's a pain to remember to do Ctrl-x 5 0 to dispose of a child
frame, and to remember to do C-x C-x to close the main frame (and if you're
not careful, doing so will take all the child frames away with it).  This
is my solution to that: an intelligent close-frame operation that works in
all cases (even in an emacs -nw session).

Stolen from http://www.dotemacs.de/dotfiles/BenjaminRutt.emacs.html."
    (interactive)
    (if (eq (car (visible-frame-list)) (selected-frame))
	;;for parent/master frame...
	(if (> (length (visible-frame-list)) 1)
	    ;;close a parent with children present
	    (delete-frame (selected-frame))
	  ;;close a parent with no children present
	  (save-buffers-kill-emacs))
      ;;close a child frame
      (delete-frame (selected-frame))))

(global-set-key "\C-x\C-c" 'intelligent-close)

(put 'dired-find-alternate-file 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'erase-buffer 'disabled nil)


;;; Apache Ant

(require 'ant)


;;; Web Mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tag\\'" . web-mode))

(set 'web-mode-engines-alist
     '(("jsp" . "\\.tag\\'")))

(set-default 'web-mode-markup-indent-offset 2)

;;; init.el ends here
