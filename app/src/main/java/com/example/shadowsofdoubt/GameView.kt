package com.example.shadowsofdoubt

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.view.MotionEvent
import android.view.SurfaceView
import android.view.SurfaceHolder

class GameView(context: Context) : SurfaceView(context), SurfaceHolder.Callback {

    private val thread: GameThread
    private val player: Player

    init {
        holder.addCallback(this)
        thread = GameThread(holder, this)
        player = Player(100f, 100f, 50f, 50f)
    }

    override fun surfaceCreated(holder: SurfaceHolder) {
        thread.setRunning(true)
        thread.start()
    }

    override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {
        // Handle surface size changes if necessary
    }

    override fun surfaceDestroyed(holder: SurfaceHolder) {
        var retry = true
        while (retry) {
            try {
                thread.setRunning(false)
                thread.join()
                retry = false
            } catch (e: InterruptedException) {
                e.printStackTrace()
            }
        }
    }

    fun update() {
        // Update game state, for now, this is empty
    }

    override fun draw(canvas: Canvas?) {
        super.draw(canvas)
        if (canvas != null) {
            // Draw background
            canvas.drawColor(Color.BLACK)

            // Draw player
            val paint = Paint()
            paint.color = Color.WHITE
            canvas.drawRect(player.rect, paint)
        }
    }

    override fun onTouchEvent(event: MotionEvent?): Boolean {
        if (event != null) {
            when (event.action) {
                MotionEvent.ACTION_DOWN, MotionEvent.ACTION_MOVE -> {
                    player.x = event.x - player.width / 2
                    player.y = event.y - player.height / 2
                }
            }
        }
        return true
    }
}