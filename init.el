(menu-bar-mode -1)
(tool-bar-mode -1)
(tab-bar-mode 1)
(scroll-bar-mode -1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono Medium" :foundry "outline" :slant normal :weight normal :height 143 :width normal)))))


(setq inhibit-startup-message t)
;;disable word wrap
(set-default 'truncate-lines t)
;; sets line numbers
;(global-display-line-numbers-mode)
(global-linum-mode)
;;syntax highlighting
(setq font-lock-maximum-decoration t)

;; Add a package archive
;; ---------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(atom-one-dark))
 '(custom-safe-themes
   '("7cad0c3eda8e7308e5ee6e8f39768c406a251023ccb32e491af6123633e1b6b2" "171d1ae90e46978eb9c342be6658d937a83aaa45997b1d7af7657546cae5985b" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "88c3005019a807d6c0c537e55292216398b375e734077cdca3287c77206eff32" "521682d356435276b4bfb60cd134681aeaf4f2e4ee625456c04285da725ebf7c" "1adf31a9ad794fa40e9c2338b0325afbeb11c9031cdc7273fca5e4db3e631593" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "969a67341a68becdccc9101dc87f5071b2767b75c0b199e0ded35bd8359ecd69" "b84d6991c35c2a270aa9c3aa16c280d6d4c3316486a93aff122d5ea46ce77c89" default))
 '(package-selected-packages
   '(fzf evil-nerd-commenter tree-sitter-langs tree-sitter neotree company e gruvbox-theme)))

;; Plugin to add 

;;airline-themes
;;flatui-them



;; autocomplete plugin
(add-hook 'after-init-hook 'global-company-mode)

;; airline
;;(require 'airline-themes)
(load-theme 'gruvbox-dark-medium t)

;; neotree
(add-to-list 'load-path "/directory/containing/neotree/")
(require 'neotree)
(defun my-neotree-project-dir-toggle ()
  "Open NeoTree using the project root, using projectile, find-file-in-project,
or the current buffer directory."
  (interactive)
  (require 'neotree)
  (let* ((filepath (buffer-file-name))
         (project-dir
          (with-demoted-errors "neotree-project-dir-toggle error: %S"
              (cond
               ((featurep 'projectile)
                (projectile-project-root))
               ((featurep 'find-file-in-project)
                (ffip-project-root))
               (t ;; Fall back to version control root.
                (if filepath
                    (vc-call-backend
                     (vc-responsible-backend filepath) 'root filepath)
                  nil)))))
         (neo-smart-open t))

    (if (and (fboundp 'neo-global--window-exists-p)
             (neo-global--window-exists-p))
        (neotree-hide)
      (neotree-show)
      (when project-dir
        (neotree-dir project-dir))
      (when filepath
        (neotree-find filepath)))))

;; key bindings
;; ---------------

;; for neo tree
(define-key global-map (kbd "M-e") 'my-neotree-project-dir-toggle)

;; Tree Sitter
(require 'tree-sitter)
(require 'tree-sitter-langs)

;;(tree-sitter-require 'cpp)
;;(tree-sitter-require 'python)

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook 'tree-sitter-hl-mode)


;;AutoPairs
;;-----------------

(add-to-list 'load-path "~/.emacs.d/autopair-0.6.1");; comment if autopair.el is in standard load path 
(require 'autopair)
(autopair-global-mode);; enable autopair in all buffers

;; nerdcommenter
;;-------------

(evilnc-default-hotkeys)

;; Emacs key bindings
(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-c l") 'evilnc-quick-comment-or-uncomment-to-the-line)
(global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
(global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs)

;; FZF
;; -------
(global-set-key (kbd "M-u") 'fzf)

