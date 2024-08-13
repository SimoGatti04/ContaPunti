document.addEventListener('DOMContentLoaded', () => {
    const player1 = {
        nameElement: document.getElementById('player1Name'),
        scoreElement: document.getElementById('player1Score'),
        section: document.getElementById('player1')
    };

    const player2 = {
        nameElement: document.getElementById('player2Name'),
        scoreElement: document.getElementById('player2Score'),
        section: document.getElementById('player2')
    };

    const resetButton = document.getElementById('resetButton');

    function loadData() {
        const data = JSON.parse(localStorage.getItem('playerData')) || {
            player1Name: 'Player 1',
            player2Name: 'Player 2',
            player1Score: 0,
            player2Score: 0
        };

        player1.nameElement.value = data.player1Name;
        player2.nameElement.value = data.player2Name;
        player1.scoreElement.textContent = data.player1Score;
        player2.scoreElement.textContent = data.player2Score;
    }

    function saveData() {
        const data = {
            player1Name: player1.nameElement.value,
            player2Name: player2.nameElement.value,
            player1Score: parseInt(player1.scoreElement.textContent),
            player2Score: parseInt(player2.scoreElement.textContent)
        };
        localStorage.setItem('playerData', JSON.stringify(data));
    }

    function incrementScore(player) {
        player.scoreElement.textContent = parseInt(player.scoreElement.textContent) + 1;
        saveData();
    }

    function decrementScore(player) {
        const currentScore = parseInt(player.scoreElement.textContent);
        player.scoreElement.textContent = Math.max(currentScore - 1, 0);
        saveData();
    }

    player1.section.addEventListener('click', () => incrementScore(player1));
    player2.section.addEventListener('click', () => incrementScore(player2));

    player1.section.addEventListener('touchstart', handleTouchStart);
    player1.section.addEventListener('touchend', handleTouchEnd);
    player2.section.addEventListener('touchstart', handleTouchStart);
    player2.section.addEventListener('touchend', handleTouchEnd);

    let touchStartX;

    function handleTouchStart(event) {
        touchStartX = event.touches[0].clientX;
    }

    function handleTouchEnd(event) {
        const touchEndX = event.changedTouches[0].clientX;
        const player = event.target.closest('.player-section').id === 'player1' ? player1 : player2;
        if (touchStartX - touchEndX > 50) {
            decrementScore(player);
        }
    }

    resetButton.addEventListener('click', () => {
        player1.scoreElement.textContent = '0';
        player2.scoreElement.textContent = '0';
        saveData();
    });

    player1.nameElement.addEventListener('change', saveData);
    player2.nameElement.addEventListener('change', saveData);

    loadData();
});
