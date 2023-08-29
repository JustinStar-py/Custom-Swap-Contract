// SPDX-License-Identifier: MIT-3.0-only
pragma solidity ^0.8.17;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract ERC20Token is ERC20 {
  IERC20 public token;

  constructor() ERC20("TetherUSD", "USDT") {
     _mint(msg.sender, 1000000 * 10 ** 18);
  }
  
}


