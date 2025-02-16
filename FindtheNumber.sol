// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GuessTheNumber {
    address public owner;
    uint8 private secretNumber;
    bool public gameActive;

    event NumberGuessed(address indexed player, uint8 guessedNumber, bool success);
    event GameRestarted(uint8 newSecretNumber);

    constructor(uint8 _secretNumber) {
        owner = msg.sender;
        secretNumber = _secretNumber;
        gameActive = true;
    }

    function guess(uint8 _number) public {
        require(gameActive, "Le jeu est termine.");
        require(_number >= 1 && _number <= 10, "Choisissez un nombre entre 1 et 10.");

        if (_number == secretNumber) {
            gameActive = false; // Désactive le jeu une fois gagné
            emit NumberGuessed(msg.sender, _number, true);
        } else {
            emit NumberGuessed(msg.sender, _number, false);
        }
    }

    function restartGame(uint8 _newSecretNumber) public {
        require(msg.sender == owner, "Seul l'admin peut relancer le jeu.");
        require(_newSecretNumber >= 1 && _newSecretNumber <= 10, "Le nombre doit etre entre 1 et 10.");

        secretNumber = _newSecretNumber;
        gameActive = true;
        emit GameRestarted(_newSecretNumber);
    }
}
