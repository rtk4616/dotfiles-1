;; Emacs client script for Pida.
;; David Soulayrol <david.soulayrol@anciens.enib.fr>
;;
;; This script is automatically generated by pida when destroyed.
;; Leave untouched or modify it at your own risk.

(defconst pida-connection-terminator "
"
  "The terminator used to send notifications to pida")

(defconst pida-connection-port 5001
  "The port used to communicate with pida")

(defvar pida-connection nil
  "The socket to comunicate with pida")


;; open-network-stream name buffer-or-name host service
(setq pida-connection 
      (open-network-stream "pida-connection" nil "localhost" pida-connection-port))
(process-kill-without-query pida-connection nil)

(defun pida-send-message (message)
  (process-send-string "pida-connection"
		       (concat message pida-connection-terminator)))

  
(defun pida-ping ()
  (pida-send-message "pida-pong ready"))

;; hook to the events pida is interested in.
(add-hook 
 'find-file-hooks
 '(lambda () 
    (pida-send-message (concat "find-file-hooks " buffer-file-name))))

(add-hook 
 'after-save-hook
 '(lambda () 
    (pida-send-message (concat "after-save-hook " buffer-file-name))))

(add-hook
 'kill-buffer-hook 
 '(lambda ()
    (pida-send-message (concat "kill-buffer-hook " buffer-file-name))))

(add-hook
 'window-configuration-change-hook
 '(lambda ()
    (pida-send-message (concat "window-configuration-change-hook " buffer-file-name))))

(add-hook
 'kill-emacs-hook
 '(lambda ()
    (pida-send-message "kill-emacs-hook")
    (delete-process pida-connection)))

;; <d_rol> is there a way to prevent emacs from showing the "GNU Emacs"
;;         first buffer ?
;; <pgas> d_rol: M-x customize-variable RET inhibit-splash-screen RET
(setq inhibit-splash-screen 1)
