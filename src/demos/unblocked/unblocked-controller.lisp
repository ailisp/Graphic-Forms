(in-package :graphic-forms.uitoolkit.tests)

(defconstant +revealed-duration+ 2000) ; millis

(defun ctrl-start-game ()
  (model-new)
  (update-status-bar "Ready.")
  (update-panel (get-scoreboard-panel))
  (update-panel (get-tiles-panel)))

(defun ctrl-restart-game ()
  (model-rollback)
  (update-status-bar "Ready.")
  (update-panel (get-scoreboard-panel))
  (update-panel (get-tiles-panel)))

(defun ctrl-reveal-move ()
  (let ((shape (find-shape (model-tiles) #'accept-shape-p)))
    (cond
      (shape
        (let ((shape-pnts (shape-tile-points shape))
              (timer (make-instance 'gfw:timer :initial-delay +revealed-duration+
                                               :delay 0
                                               :dispatcher (gfw:dispatcher (get-unblocked-win)))))
          (draw-tiles-directly (get-tiles-panel) shape-pnts +max-tile-kinds+)
          (gfw:enable timer t)))
      (t
        (gfs::message-box (gfs:handle (get-unblocked-win))
                          "There are no remaining shapes."
                          "Sorry!"
                          (logior gfs::+mb-ok+ gfs::+mb-iconinformation+)
                          0)))))

(defun ctrl-start-selection (shape-pnts panel point button)
  (let* ((tiles (model-tiles))
         (tile-pnt (window->tiles point))
         (tile-kind (obtain-tile tiles tile-pnt))
         (tmp-table (make-hash-table :test #'equalp)))
    (unless (or (null shape-pnts) (find tile-pnt shape-pnts :test #'eql-point))
      (draw-tiles-directly panel shape-pnts tile-kind))
    (if (and (eql button :left-button) (> tile-kind 0))
      (shape-tiles tiles tile-pnt tmp-table))
    (cond
      ((> (hash-table-count tmp-table) 1)
         (let ((shape-pnts (shape-tile-points tmp-table)))
           (draw-tiles-directly panel shape-pnts +max-tile-kinds+)
           (values tile-kind shape-pnts)))
      (t (values nil nil)))))

(defun ctrl-finish-selection (shape-pnts shape-kind panel point button)
  (let ((tile-pnt (window->tiles point)))
    (when (and (eql button :left-button) shape-pnts)
      (if (and tile-pnt (find tile-pnt shape-pnts :test #'eql-point))
        (let ((prev-level (model-level))
              (orig-score (score-of *game*)))
          (update-model-score shape-pnts)
          (update-status-bar (format nil
                                     "Removed ~d tiles for ~d points."
                                     (length shape-pnts)
                                     (- (score-of *game*) orig-score)))
          (if (> (model-level) prev-level)
            (progn
              (regenerate-model-tiles)
              (update-status-bar "Ready."))
            (update-model-tiles shape-pnts))
          (update-panel (get-scoreboard-panel))
          (update-panel (get-tiles-panel)))
        (draw-tiles-directly panel shape-pnts shape-kind)))))
