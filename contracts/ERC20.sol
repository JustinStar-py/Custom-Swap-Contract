// SPDX-License-Identifier: MIT-3.0-only
pragma solidity ^0.8.17;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract LinkToken is ERC20 {
  IERC20 public token;

  constructor() ERC20("ChainLink Token", "LINK") {
     _mint(msg.sender, 1000 * 10 ** 18);
  }
}

contract BTCToken is ERC20 {
  IERC20 public token;

  constructor() ERC20("BTCToken Token", "LINK") {
     _mint(msg.sender, 1000 * 10 ** 18);
  }
}

