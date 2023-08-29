// SPDX-License-Identifier: MIT-3.0-only
pragma solidity ^0.8.17;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract ERC20Token is ERC20 {
  IERC20 public token;

  constructor() ERC20("TetherUSD", "USDT") {
     _mint(msg.sender, 1000000 * 10 ** 18);
  }
  // link - 0xE72eB75aC580FaAe287FC3b7fd6eAEAC1Acbc877
 // usdt - 0x9aD6E31387162C9623D6D19C2621204bF8Fe50C6
}


