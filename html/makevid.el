;;; makevid.el --- Make video of single still frame using speech
;;; synthesis on the current buffer

;; Copyright (C) 2008  Sam Peterson

;; Author: Sam Peterson <peabodyenator@gmail.com>
;; Keywords: convenience

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Simple script to make a video of the current buffer.  Run M-x
;; makevid-make-vid in the current buffer to dump a video named
;; output.avi to the current default-directory.  It requires mencoder,
;; lame, mp3info and of course, a tts program such as espeak.

;;; Code:

(defvar makevid-tts-commands-alist
  '((swift . "/opt/swift/bin/swift -o '%s'.wav -f '%s'")
    (festival . "/usr/bin/text2wave < '%s' > '%s'.wav")
    (flite . "/usr/bin/flite '%s' '%s'.wav")
    (espeak . "/usr/bin/espeak -w '%s'.wav -f '%s'"))
  "Alist of tts methods to try creating a wav file")

(defcustom makevid-method 'espeak
  "Method to use for making the wave file from text synth.  Valid
values are 'swift 'festival 'flite and 'espeak")

;; make wave file of the current buffer
(defun makevid-make-wave ()
  "makes a wav file in the current folder by using the current wav method"
  (let* ((data (buffer-string))
	 (more-data (format
		     (cdr (assoc makevid-method makevid-tts-commands-alist))
		     (buffer-file-name) (buffer-file-name))))
    (shell-command more-data)))

(defun makevid-get-length-seconds (file)
  (let ((l (split-string (with-temp-buffer
			   (shell-command
			    (concat "mp3info -x '" file
				    "' | grep Length") (current-buffer))
			   (buffer-string)) ":")))
    ;; 2nd and 3rd fields should be minute and seconds
    (+ (* 60 (string-to-number (nth 1 l)))
       (string-to-number (nth 2 l)))))

(defun makevid-make-vid (file)
  "Prompt for picture and make a video using that file."
  (interactive "fPicture: ")
  (makevid-make-wave)
  (let* (num
	 (wave-file (concat (buffer-file-name) ".wav"))
	 (mp3-file (concat wave-file ".mp3")))
    (shell-command (format "lame '%s'" wave-file))
    (setq num (makevid-get-length-seconds mp3-file))
    (shell-command (format "mencoder mf://'%s' -mf fps=%f -vf harddup -ovc lavc -lavcopts vbitrate=100 -audiofile '%s' -oac copy -ofps %d -o output.avi >/dev/null 2>&1"
		     (expand-file-name file) (/ 1.0 num) mp3-file 30))
    (delete-file wave-file)
    (delete-file mp3-file)))

(provide 'makevid)
;;; makevid.el ends here
