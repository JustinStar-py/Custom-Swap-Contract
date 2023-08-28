// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


// contract swapRooterContract {
//     address payable rooterOwner;
//     //ratioAX is the percentage of how much TokenA is worth of TokenX
//     bool AcheaperthenX;
//     uint256 fees;

//     modifier onlyAdmin() {
//         payable(msg.sender) == rooterOwner;
//         _;
//     }

//     function setFees(uint256 _Fees) public onlyAdmin {
//         fees = _Fees;
//     }

//     function getFees() public view onlyAdmin returns (uint256) {
//         return fees;
//     }

//     function swapExactTokensForTokens(address tokenIn, address tokenOut, uint256 amountIn) public returns (uint256) {
//         //check if amount given is not 0
//         // check if current contract has the necessary amout of Tokens to exchange
//         require(amountIn > 0, "amountIn must be greater then zero");
//         require(
//             ERC20(tokenIn).balanceOf(msg.sender) >= amountIn,
//             "sender doesn't have enough Tokens"
//         );

//         uint256 exchangeA = uint256(mul(amountIn, ratioAX));
//         uint256 exchangeAmount = exchangeA - uint256((mul(exchangeA, fees)) / 100);
//         require(
//             exchangeAmount > 0,
//             "exchange Amount must be greater then zero"
//         );

//         require(
//             tokenXYZ.balanceOf(address(this)) > exchangeAmount,
//             "currently the exchange doesnt have enough XYZ Tokens, please retry later :=("
//         );

//         tokenABC.transferFrom(msg.sender, address(this), amountIn);
//         tokenXYZ.approve(address(msg.sender), exchangeAmount);
//         tokenXYZ.transferFrom(
//             address(this),
//             address(msg.sender),
//             exchangeAmount
//         );
//         return exchangeAmount;
//     }
// }