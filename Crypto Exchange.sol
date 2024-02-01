/// Exchange
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Exchange {
    address public owner;
    mapping(address => mapping(address => uint256)) public balances;
    mapping(address => bool) public authorizedTokens;
    uint256 public fee = 0.1 ether; // 0.1 ETH fee for each trade

    event Deposit(address indexed token, address indexed user, uint256 amount);
    event Withdraw(address indexed token, address indexed user, uint256 amount);
    event Trade(address indexed token, address indexed buyer, address indexed seller, uint256 amount, uint256 price);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    function deposit(address token, uint256 amount) public {
        require(authorizedTokens[token], "Token is not authorized.");
        require(amount > 0, "Amount must be greater than zero.");

        balances[token][msg.sender] += amount;
        emit Deposit(token, msg.sender, amount);
    }

    function withdraw(address token, uint256 amount) public{
        require(balances[token][msg.sender] >= amount, "Insuffient balance.");

        balances[token][msg.sender] -= amount;
        emit Withdraw(token, msg.sender, amount);
    }

    function authorizeToken(address token) public onlyOwner {
        authorizedTokens[token] = true;
    }

    function revokeToken(address token) public onlyOwner {
        authorizedTokens[token] = false;
    }

    function setFee(uint256 newFee) public onlyOwner {
        fee = newFee;
    }

    function trade(address token, address seller, uint256 amount, uint256 price);
        require(msg.value == fee, "Insufficient fee.");
        require(balances[token][seller] >= amount, "Insufficient balance.");
         require(balances[address(this)][msg.sender] >= amount * price, "Insufficient exchange balance.");

    balances[token][seller] -= amount;
    balances[token][msg.sender] += amount;
    balances[address(this)][msg.sender] -= amount * price;
    balances[address(this)][seller] += amount * price;

    emit Trade(token, msg.sender, seller, amount, price);
}