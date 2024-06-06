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

(defun demo-jump-to-a-def ()
  (demo-insert-comments
          '(";; I want to move cursor to a definition of the function by its name."
            ";; Run =avy-goto-char-timer= (bound in my setup to 'jk') then start typing 'a-def', and then"
            ";; choose where you're jumping by pressing 'd'"))
  (with-file-contents! "core_test.clj"
    (+default/yank-buffer-contents))
  (demo-it-insert (current-kill 0))
  (evil-execute-macro 1 (kmacro "<escape>"))
  (setq unread-command-events
        (nconc (listify-key-sequence "gs/a-def") unread-command-events))
  (run-with-idle-timer 2 nil
    (lambda ()(setq unread-command-events
                    (nconc (listify-key-sequence "d") unread-command-events)))))

(defun init ()
  (find-file "tmp.clj")
  (goto-char(point-min))
  (delete-line)
  (delete-line)
  (demo-it-load-file "tmp.clj" :none))

(with-temp-file "tmp.clj" "(comment boo)")
(demo-it-create :single-window :advance-mode :insert-fast
  (init)
  (demo-start-intro)
  (demo-jump-to-a-def)
  (demo-insert-comments '(";; Note how 'jump' symbols were highlighted."
                          ";; Also they are located on keyboard's home row: 'asdf' and 'jkl;'"
                          ";; These are also configurable, of course (see =avy-keys="))
  (demo-insert-comments '(";; OK, we've jumped quite fast without using a mouse."
                          ";; Let's run some commands!")))

(demo-it-start)
(delete-file "tmp.clj")
