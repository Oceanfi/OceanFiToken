// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract OracleTest {
    uint256 public constant PRECISION = 1000000;

    uint256 private minTokenAmount = 0;
    uint256 private maxTokenAmount = 1500000;

    address public pairAddress;
    address public stableToken;
    address public token;

    constructor(address _pairAddress, address _stableToken, address _token) {
        pairAddress = _pairAddress;
        stableToken = _stableToken;
        token = _token;
    }

    function getInfoOfPair() public pure returns (uint256, uint256) {
        uint256 balanceStableToken = 100 * 10 ** 18;
        uint256 balanceToken = 150 * 10 ** 18;

        return (balanceStableToken, balanceToken);
    }

    //function to convert amount in usd to token amount
    function convertUsdBalanceDecimalToTokenDecimal(uint256 _balanceUsd) public view returns (uint256) {
        (uint256 balanceStableToken, uint256 balanceToken) = getInfoOfPair();
        uint256 amountTokenDecimal = (_balanceUsd * balanceToken) / balanceStableToken;
        uint256 _minTokenAmount = (_balanceUsd * minTokenAmount) / PRECISION;
        uint256 _maxTokenAmount = (_balanceUsd * maxTokenAmount) / PRECISION;
        require(amountTokenDecimal >= _minTokenAmount, "Price is too low");
        require(amountTokenDecimal <= _maxTokenAmount, "Price is too hight");

        return amountTokenDecimal;
    }
}
