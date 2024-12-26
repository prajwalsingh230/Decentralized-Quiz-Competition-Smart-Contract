# Decentralized Quiz Competition Smart Contract

This smart contract implements a decentralized quiz competition system on the Ethereum blockchain using Solidity. It allows participants to submit answers to quiz questions, and the organizer can reward winners based on correct answers. The contract uses an ERC20 token for rewards.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Smart Contract Structure](#smart-contract-structure)
- [Functions](#functions)
- [Events](#events)
- [Requirements](#requirements)
- [Usage](#usage)
- [License](#license)

## Overview
The **Decentralized Quiz Competition** smart contract allows participants to answer quiz questions and be rewarded with tokens for answering questions correctly. The contract is designed to be flexible and can be deployed with any ERC20 token to handle rewards. The organizer is responsible for adding questions and rewarding winners.

## Features
- **Submit Answers**: Participants can submit answers to quiz questions.
- **Correct Answer Validation**: Answers are validated against the correct answer stored in the contract.
- **Reward Distribution**: Participants who answer all questions correctly are rewarded with ERC20 tokens.
- **Question Management**: The organizer can add new questions to the quiz.
  
## Smart Contract Structure

The contract includes the following key components:
- **Question Struct**: Represents a quiz question with its text and correct answer.
- **Participant Struct**: Represents a participant's submission, storing whether they participated and if their answer was correct.
- **State Variables**:
  - `questions`: An array of all quiz questions.
  - `participants`: A mapping to track participants' answers.
  - `rewardToken`: The ERC20 token used for rewarding winners.
  - `organizer`: The address that can add questions and reward participants.
- **Events**:
  - `AnswerSubmitted`: Emitted when a participant submits an answer.
  - `WinnersRewarded`: Emitted when winners are rewarded.

## Functions

### `constructor(address tokenAddress)`
- **Purpose**: Initializes the contract with the reward token and organizer's address.
- **Parameters**:
  - `tokenAddress`: The address of the ERC20 token contract.

### `submitAnswer(uint256 questionIndex, string calldata answer)`
- **Purpose**: Allows a participant to submit an answer for a specific question.
- **Parameters**:
  - `questionIndex`: The index of the question in the `questions` array.
  - `answer`: The answer submitted by the participant.
- **Requirements**:
  - The participant hasn't already answered the question.
  - The question exists in the quiz.

### `awardWinners(uint256 rewardAmountPerWinner)`
- **Purpose**: Allows the organizer to reward winners who answered all questions correctly.
- **Parameters**:
  - `rewardAmountPerWinner`: The amount of tokens each winner will receive.

### `addQuestion(string calldata questionText, string calldata correctAnswer)`
- **Purpose**: Allows the organizer to add a new question to the quiz.
- **Parameters**:
  - `questionText`: The text of the question.
  - `correctAnswer`: The correct answer to the question.
- **Requirements**: Only the organizer can add questions.

## Events

- **`AnswerSubmitted(address indexed participant, uint256 indexed questionIndex, bool isCorrect)`**
  - Emitted when a participant submits an answer. It logs the participant's address, question index, and whether the answer was correct.

- **`WinnersRewarded(address indexed winner, uint256 rewardAmount)`**
  - Emitted when a participant is rewarded for answering all questions correctly. It logs the winner's address and the reward amount.

## Requirements

- **Solidity Version**: `^0.8.0`
- **ERC20 Token**: The contract relies on an ERC20 token for rewards. Ensure the provided token contract implements the ERC20 standard, including the `transfer` and `balanceOf` functions.
- **Ethereum Network**: This contract is designed for deployment on the Ethereum network or compatible blockchains.

## Usage

### Deploying the Contract
1. Deploy the `DecentralizedQuizCompetition` contract by providing the address of an ERC20 token that will be used for rewards.
2. The deployer of the contract becomes the **organizer** and is authorized to add questions and reward winners.

### Interacting with the Contract
1. **Participants**:
   - Submit answers using the `submitAnswer` function.
   - Check if their answers are correct by listening for the `AnswerSubmitted` event.
   
2. **Organizer**:
   - Add new questions using the `addQuestion` function.
   - Reward winners using the `awardWinners` function. Only participants who answered all questions correctly will be rewarded.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

This `README` file provides an overview and detailed instructions for deploying and interacting with the Decentralized Quiz Competition smart contract.