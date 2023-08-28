// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract dataFeeds is ReentrancyGuard {
   using SafeMath for uint256;

   address public owner;   

   constructor() {
         owner = msg.sender;
   }  
   
   // Mapping to store token addresses and their corresponding prices
   mapping(address => uint256) public tokenPrices;   

   modifier onlyOwner() {
       require(msg.sender == owner, "Only the contract owner can perform this action.");
       _;
   } 
   
   // Function to set prices for multiple tokens using a JSON object
   function setMultipleTokenPrices (address[] memory tokenAddresses, uint256[] memory prices) external onlyOwner {
     require(tokenAddresses.length == prices.length, "Array lengths must match");  
     
     for (uint256 i = 0; i < tokenAddresses.length; i++) {
         tokenPrices[tokenAddresses[i]] = prices[i];
     }
   } 
   
   function calcuMul(address tokenIn, address tokenOut, uint256 amountIn) public view returns (uint256 Mul) {
      uint256 tokenInPrice = tokenPrices[tokenIn];
      uint256 tokenOutPrice = tokenPrices[tokenOut];   

      Mul = (tokenInPrice * amountIn / tokenOutPrice);
   }

   function getTokenPrice(address tokenAddress) public view returns (uint256) {
     return tokenPrices[tokenAddress];
   }
}