;;;;==================================================
;;;; 配置目录设置
;;;;==================================================
(defvar user-config-directory user-emacs-directory
  "Replace ‘user-emacs-directory’")
;; 保持 .emacs.d 目录整洁
(setq user-emacs-directory (expand-file-name "~/.cache/emacs"))
(setq package-user-dir (expand-file-name user-emacs-directory "elpa"))
;; (message "ppp %s" package-user-dir)

;;;;==================================================
;;;; UI 设置
;;;;==================================================
;; 设置初始主题
(load-theme 'wombat t)
(add-hook 'after-init-hook (lambda()(disable-theme 'wombat)))
;; 移除不需要的 GUI 元素
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; 初始化时隐藏 UI
;; (add-to-list 'initial-frame-alist '(visibility . icon))
;; 初始化完成后显示 UI
;; (add-hook 'window-setup-hook (lambda ()
;;                                (set-frame-parameter nil 'alpha 95)
;;                                (make-frame-visible)
;;                                (select-frame-set-input-focus (selected-frame))))


(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)) ; macOS 下沉浸式标题栏
(add-to-list 'default-frame-alist '(ns-appearance . dark)) ; 使用黑色外观
(add-to-list 'default-frame-alist '(alpha . 95))
;; frame 初始位置
(add-to-list 'default-frame-alist '(width . 100))
(add-to-list 'default-frame-alist '(height . 30))
(add-to-list 'default-frame-alist '(left . 0.5))
(add-to-list 'default-frame-alist '(top . 0.5))

(add-to-list 'initial-frame-alist '(width . 100))
(add-to-list 'initial-frame-alist '(height . 30))
(add-to-list 'initial-frame-alist '(left . 0.5))
(add-to-list 'initial-frame-alist '(top . 0.5))
;;;; 初始化时限制 minibuffer 高度
(defvar default-max-mini-window-height max-mini-window-height)
(setq max-mini-window-height 1)
(add-hook 'after-init-hook (lambda()(setq max-mini-window-height default-max-mini-window-height)))

;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
;;;;==================================================
;;;; GC 设置
;;;;==================================================
;; 设置 GC 阈值，防止在启动时 GC，影响启动速度。
(setq gc-cons-threshold (* 1024 1024 256))
;; (setq gc-cons-percentage 0.6)          ;GC
;; (setq garbage-collection-messages t)    ;显示 GC 信息
;; 空闲 15 秒后进行 GC
(run-with-idle-timer 15 t #'garbage-collect)
;; 失去焦点后进行 GC
(add-hook 'focus-out-hook #'garbage-collect)

;; 初始化后重新设置 GC 阈值
(add-hook 'emacs-startup-hook (lambda()
                                (setq gc-cons-threshold (* 1024 1024 8))))

;;;;==================================================
;;;; 其他设置
;;;;==================================================
;; Emacs 在加载文件时会通过‘file-name-handler-alist’ 加载对应的处理程序。启动时设置为空。启动完成后重新设置。
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; 启动后重新设置一些在启动时修改的选项
(add-hook 'emacs-startup-hook (lambda ()
                                ;; 重新设置‘file-name-handler-alist’
                                (setq file-name-handler-alist file-name-handler-alist-original)
                                (makunbound 'file-name-handler-alist-original)))
;; 禁止启动后激活已经安装的包
(setq package-enable-at-startup nil)
;; ‘site-run-file’ 包含一些初始值。这个文件会在 ‘~/.emacs’ 之前加载。
(setq site-run-file nil)

(provide 'early-init)
