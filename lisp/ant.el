;;; ant.el --- Ant integration library.

;;; Commentary:
;;; Code:
(defvar ant-command-history nil
  "Ant command history variable.")

(defun ant(&optional args)
  "Runs ant in the current project. Starting at the directory
   where the file being visited resides, a search is made for
   build.xml recursively. A maven command is made from the first
   directory where the build.xml file is found is then displayed in
   the minibuffer. The command can be edited as needed and then
   executed. Errors are navigate to as in any other compile mode"
  (interactive)
  (let ((fn (buffer-file-name)))
    (let ((dir (file-name-directory fn)))
      (while (and (not (file-exists-p (concat dir "/build.xml")))
                  (not (equal dir (file-truename (concat dir "/..")))))
        (setf dir (file-truename (concat dir "/.."))))
      (if (not (file-exists-p (concat dir "/build.xml")))
          (message "No build.xml found")
        (compile (read-from-minibuffer "Command: "
                                       (concat "ant -emacs -f "
                                       dir "/build.xml compile") nil
                                       nil
                                       'ant-command-history))))))

(provide 'ant)


;;; ant.el ends here
