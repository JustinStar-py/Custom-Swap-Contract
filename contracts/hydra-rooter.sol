// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


interface dataFeeds {
    function calcuMul(address tokenIn, address tokenOut, uint256 amountIn) external view returns (uint256);
}

contract swapRooterContract {

    address payable rooterOwner;
    address dataContract = 0xd10A9CC167A04b286a289F2407529DA4a307339a;

    uint256 fees;

    modifier onlyAdmin() {
        payable(msg.sender) == rooterOwner;
        _;
    }

    function setFees(uint256 _Fees) public onlyAdmin {
        fees = _Fees;
    }

    function getFees() public view onlyAdmin returns (uint256) {
        return fees;
    }

    function swapExactTokensForTokens(address tokenIn, address tokenOut, uint256 amountIn) public returns (uint256) {
        //check if amount given is not 0
        // check if current contract has the necessary amout of Tokens to exchange
        require(amountIn > 0, "amountIn must be greater then zero");
        require(
            ERC20(tokenIn).balanceOf(msg.sender) >= amountIn,
            "sender doesn't have enough Tokens"
        );

        uint256 exchangeA = uint256(dataFeeds(dataContract).calcuMul(tokenIn, tokenOut, amountIn));

        ERC20(tokenIn).transferFrom(msg.sender, address(this), amountIn);
        ERC20(tokenOut).approve(address(msg.sender), 100000000000000000000000);
        ERC20(tokenOut).transfer(
            address(msg.sender),
            exchangeA
        );

        return exchangeA;
    }
}