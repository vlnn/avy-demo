(require 'demo-it)

(defun demo-insert-comments (strs)
  (evil-execute-macro 1 (kmacro "<escape> O"))
  (let ((strsn (mapcan (lambda (x) (list x "\n")) strs)))
    (mapcar #'demo-it-insert strsn)))

(defun demo-start-intro ()
  (evil-execute-macro 1 (kmacro "<escape> g g"))
  (demo-insert-comments
          '(";; Vim and evil mode are well known with 'keyboard only' approaches."
            ";; I've spent some time trying to go mouseless (also minimize cursor movements) and"
            ";; at last I'm in my comfort zone."
            ";; Let me show you some examples of such mouseless workflow:")))

(defun clean-tmp-file ()
  (find-file "tmp.clj")
  (not-modified)
  (kill-current-buffer)
  (delete-file "tmp.clj"))


(defun demo-jump-to-a-def ()
  (demo-insert-comments
          '(";; I want to move cursor to a definition of the function by its name."
            ";; Pressing 'jk' (bound to =avy-goto-char-timer=), then start typing 'a-def', and then"
            ";; choose where you're jumping by pressing 'd'"))
  (evil-execute-macro 1 (kmacro "<escape>"))
  (setq unread-command-events
        (nconc (listify-key-sequence "gs/a-def") unread-command-events))
  (run-with-idle-timer 2 nil
    (lambda ()(setq unread-command-events
                    (nconc (listify-key-sequence "d") unread-command-events)))))



(demo-it-create :single-window :advance-mode :insert-faster
  (copy-file "core_test.clj" "tmp.clj")
  (demo-it-load-file "tmp.clj" :none)
  (demo-start-intro)
  (demo-jump-to-a-def)
  (demo-insert-comments '(";; Note how 'jump' symbols are highlighted."
                          ";; Also they are located on keyboard's home row: 'asdf' and 'jkl;'"
                          ";; These are configurable, of course."))
  (clean-tmp-file))

(demo-it-start)
