;;; oauth2-request.el --- OAuth2 request package interface  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Naoya Yamashita

;; Author: Naoya Yamashita <conao3@gmail.com>
;; Version: 0.0.1
;; Keywords: convenience
;; Package-Requires: ((emacs "26.1") (oauth2 "0.14") (request "0.3"))
;; URL: https://github.com/conao3/oauth2-request.el

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; OAuth2 request package interface.


;;; Code:

(require 'gv)
(require 'oauth2)
(require 'request)

(defgroup oauth2-request nil
  "OAuth2 `request' package interface."
  :group 'convenience
  :link '(url-link :tag "Github" "https://github.com/conao3/oauth2-request.el"))

;; Included at Emacs-27.2
(defalias 'oauth2-request-plist-get #'plist-get)
(gv-define-expander oauth2-request-plist-get
  (lambda (do plist prop)
    (macroexp-let2 macroexp-copyable-p key prop
      (gv-letplace (getter setter) plist
        (macroexp-let2 nil p `(cdr (plist-member ,getter ,key))
          (funcall do
                   `(car ,p)
                   (lambda (val)
                     `(if ,p
                          (setcar ,p ,val)
                        ,(funcall setter `(cons ,key (cons ,val ,getter)))))))))))

(provide 'oauth2-request)

;;; oauth2-request.el ends here
