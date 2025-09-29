const canvas = document.getElementById('gameCanvas');
const ctx = canvas.getContext('2d');

// Paddle and ball properties
const paddleHeight = 50, paddleWidth = 5, ballSize = 5;
let paddle1Y = 75, paddle2Y = 75, ballX = 200, ballY = 100;
let ballSpeedX = 3, ballSpeedY = 2;

// Touch/mouse event for player paddle
let touchY = 0;
canvas.addEventListener('touchmove', (e) => {
  touchY = e.touches[0].clientY - canvas.getBoundingClientRect().top - paddleHeight / 2;
});
canvas.addEventListener('mousemove', (e) => {
  touchY = e.clientY - canvas.getBoundingClientRect().top - paddleHeight / 2;
});

// Game loop
function draw() {
  // Clear canvas
  ctx.fillStyle = 'black';
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  // Update player paddle
  paddle1Y = touchY;

  // Draw paddles
  ctx.fillStyle = 'white';
  ctx.fillRect(0, paddle1Y, paddleWidth, paddleHeight); // Player
  ctx.fillRect(canvas.width - paddleWidth, paddle2Y, paddleWidth, paddleHeight); // AI

  // Draw ball
  ctx.beginPath();
  ctx.arc(ballX, ballY, ballSize, 0, Math.PI * 2);
  ctx.fillStyle = 'white';
  ctx.fill();

  // Move ball
  ballX += ballSpeedX;
  ballY += ballSpeedY;

  // Ball collisions with walls
  if (ballY < 0 || ballY > canvas.height) ballSpeedY = -ballSpeedY;

  // Ball collisions with paddles
  if (ballX < paddleWidth && ballY > paddle1Y && ballY < paddle1Y + paddleHeight ||
      ballX > canvas.width - paddleWidth - ballSize && ballY > paddle2Y && ballY < paddle2Y + paddleHeight) {
    ballSpeedX = -ballSpeedX;
  }

  // Reset ball if out of bounds
  if (ballX < 0 || ballX > canvas.width) {
    ballX = 200;
    ballY = 100;
  }

  // Simple AI for paddle2
  paddle2Y += (ballY - (paddle2Y + paddleHeight / 2)) * 0.1;

  requestAnimationFrame(draw);
}

draw();
