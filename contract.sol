// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract DecentralizedQuizCompetition {

    // Struct to represent a quiz question
    struct Question {
        string questionText;
        string correctAnswer;  // The correct answer for the question
    }

    // Struct to represent a participant's answer
    struct Participant {
        bool hasParticipated;  // If the participant has submitted an answer
        bool isCorrect;        // If the submitted answer was correct
    }

    // The quiz questions
    Question[] public questions;
    
    // Mapping to store participant's answer results (address -> questionIndex -> answer status)
    mapping(address => mapping(uint256 => Participant)) public participants;

    // Token used for rewards
    IToken public rewardToken;

    // Quiz organizer address
    address public organizer;

    // Event to log when a participant submits an answer
    event AnswerSubmitted(address indexed participant, uint256 indexed questionIndex, bool isCorrect);

    // Event to log when the organizer rewards winners
    event WinnersRewarded(address indexed winner, uint256 rewardAmount);

    // Constructor to initialize the token and the organizer
    constructor(address tokenAddress) {
        rewardToken = IToken(tokenAddress);
        organizer = msg.sender;
    }

    // Function 1: Submit an answer to a specific quiz question
    function submitAnswer(uint256 questionIndex, string calldata answer) external {
        // Ensure the participant hasn't already submitted an answer
        require(!participants[msg.sender][questionIndex].hasParticipated, "You have already participated in this question.");

        // Ensure the question exists
        require(questionIndex < questions.length, "Invalid question index.");

        // Get the correct answer for the question
        string memory correctAnswer = questions[questionIndex].correctAnswer;

        // Check if the answer is correct
        bool isCorrect = (keccak256(bytes(answer)) == keccak256(bytes(correctAnswer)));

        // Mark the participant's answer
        participants[msg.sender][questionIndex] = Participant({
            hasParticipated: true,
            isCorrect: isCorrect
        });

        // Emit event to log the participant's answer
        emit AnswerSubmitted(msg.sender, questionIndex, isCorrect);
    }

    // Function 2: Award winners (those who answered all questions correctly)
    function awardWinners(uint256 rewardAmountPerWinner) external {
        require(msg.sender == organizer, "Only the organizer can reward winners.");

        // Loop through participants and reward those who got all answers correct
        for (uint256 i = 0; i < questions.length; i++) {
            // If the participant answered all questions correctly, reward them
            if (participants[msg.sender][i].isCorrect) {
                // Transfer reward tokens to the winner
                rewardToken.transfer(msg.sender, rewardAmountPerWinner);

                // Emit event to log the winner's reward
                emit WinnersRewarded(msg.sender, rewardAmountPerWinner);
            }
        }
    }

    // Helper function to add questions to the quiz
    function addQuestion(string calldata questionText, string calldata correctAnswer) external {
        require(msg.sender == organizer, "Only the organizer can add questions.");
        questions.push(Question({
            questionText: questionText,
            correctAnswer: correctAnswer
        }));
    }
}
