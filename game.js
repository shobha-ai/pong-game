const canvas = document.getElementById('gameCanvas');
const ctx = canvas.getContext('2d');

const player = {
    x: canvas.width / 2,
    y: canvas.height / 2,
    width: 20,
    height: 20,
    speed: 4,
    color: '#fff'
};

const door = {
    x: canvas.width - 50,
    y: canvas.height / 2 - 40,
    width: 30,
    height: 80,
    color: '#8B4513'
};

const table = {
    x: 100,
    y: 200,
    width: 150,
    height: 80,
    color: '#A0522D'
};

const note = {
    x: 150,
    y: 225,
    width: 20,
    height: 15,
    color: '#FFFFE0'
};

const keys = {
    ArrowUp: false,
    ArrowDown: false,
    ArrowLeft: false,
    ArrowRight: false
};

let doorLocked = true;
let hasKey = false;

function drawObjects() {
    // Draw door
    ctx.fillStyle = door.color;
    ctx.fillRect(door.x, door.y, door.width, door.height);

    // Draw table
    ctx.fillStyle = table.color;
    ctx.fillRect(table.x, table.y, table.width, table.height);

    // Draw note
    ctx.fillStyle = note.color;
    ctx.fillRect(note.x, note.y, note.width, note.height);
}

function drawPlayer() {
    ctx.fillStyle = player.color;
    ctx.fillRect(player.x, player.y, player.width, player.height);
}

function checkCollision(rect1, rect2) {
    return (
        rect1.x < rect2.x + rect2.width &&
        rect1.x + rect1.width > rect2.x &&
        rect1.y < rect2.y + rect2.height &&
        rect1.y + rect1.height > rect2.y
    );
}

function updatePlayerPosition() {
    if (keys.ArrowUp && player.y > 0) {
        player.y -= player.speed;
    }
    if (keys.ArrowDown && player.y < canvas.height - player.height) {
        player.y += player.speed;
    }
    if (keys.ArrowLeft && player.x > 0) {
        player.x -= player.speed;
    }
    if (keys.ArrowRight && player.x < canvas.width - player.width) {
        player.x += player.speed;
    }
}

function gameLoop() {
    // Clear canvas
    ctx.fillStyle = '#000';
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    updatePlayerPosition();
    drawObjects();
    drawPlayer();

    requestAnimationFrame(gameLoop);
}

// Keyboard event listeners
window.addEventListener('keydown', (e) => {
    if (e.key in keys) {
        keys[e.key] = true;
    }
    if (e.key === 'e') {
        interact();
    }
});

window.addEventListener('keyup', (e) => {
    if (e.key in keys) {
        keys[e.key] = false;
    }
});

function interact() {
    if (checkCollision(player, note)) {
        showMessage("You found a small, rusty key hidden under the note. It says: 'Freedom lies behind the barrier.'");
        hasKey = true;
        // Hide the note after it's read
        note.x = -100;
    } else if (checkCollision(player, door)) {
        if (doorLocked && hasKey) {
            doorLocked = false;
            showMessage("The key fits. The lock clicks open.");
            setTimeout(() => showMessage("To be continued..."), 3000);
        } else if (doorLocked) {
            showMessage("The door is locked. A heavy, old lock. No keyhole is visible from this side.");
        } else {
            showMessage("You've already unlocked this door.");
        }
    } else {
        hideMessage();
    }
}

const messageContainer = document.getElementById('message-container');

function showMessage(text) {
    messageContainer.textContent = text;
    messageContainer.style.display = 'block';
}

function hideMessage() {
    messageContainer.style.display = 'none';
}

// Start the game
gameLoop();