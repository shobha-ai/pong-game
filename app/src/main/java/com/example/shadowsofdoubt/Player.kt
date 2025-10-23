package com.example.shadowsofdoubt

import android.graphics.RectF

data class Player(
    var x: Float,
    var y: Float,
    val width: Float,
    val height: Float
) {
    val rect: RectF
        get() = RectF(x, y, x + width, y + height)
}