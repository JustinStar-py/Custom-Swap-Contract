// SPDX-License-Identifier: MIT

// ██╗░░██╗██╗░░░██╗██████╗░██████╗░░█████╗░  ░██████╗░██╗░░░░░░░██╗░█████╗░██████╗░
// ██║░░██║╚██╗░██╔╝██╔══██╗██╔══██╗██╔══██╗  ██╔════╝░██║░░██╗░░██║██╔══██╗██╔══██╗
// ███████║░╚████╔╝░██║░░██║██████╔╝███████║  ╚█████╗░░╚██╗████╗██╔╝███████║██████╔╝
// ██╔══██║░░╚██╔╝░░██║░░██║██╔══██╗██╔══██║  ░╚═══██╗░░████╔═████║░██╔══██║██╔═══╝░
// ██║░░██║░░░██║░░░██████╔╝██║░░██║██║░░██║  ██████╔╝░░╚██╔╝░╚██╔╝░██║░░██║██║░░░░░
// ╚═╝░░╚═╝░░░╚═╝░░░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝  ╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝╚═╝░░░░░

pragma solidity = 0.8.17;
pragma abicoder v2;

import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract SingleSwap {
    address public constant routerAddress = 0xE592427A0AEce92De3Edee1F18E0157C05861564;

    ISwapRouter public immutable swapRouter = ISwapRouter(routerAddress);

    address public constant LINK = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
    address public constant WETH = 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6;

    IERC20 public LinkToken = IERC20(LINK);
    IERC20 public WethToken = IERC20(WETH);

    // For this example, we will set the pool fee to 0.3%.
    uint24 public constant poolFee = 3000;

    constructor() {}



    function swapExactInputSingle(address _tokenIn, address _tokenOut, uint256 _amountIn)
        external
        returns (uint256 amountOut)
    {

        IERC20(_tokenIn).transferFrom(msg.sender, address(this), _amountIn);
        IERC20(_tokenIn).approve(address(swapRouter), _amountIn);

        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: _tokenIn,
                tokenOut: _tokenOut,
                fee: poolFee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: _amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        amountOut = swapRouter.exactInputSingle(params);
    }

    function swapExactOutputSingle(address _tokenIn, uint256 _amountOut, uint256 _amountInMaximum)
        external
        returns (uint256 amountIn)
    {
        IERC20(_tokenIn).approve(address(swapRouter), _amountInMaximum);

        ISwapRouter.ExactOutputSingleParams memory params = ISwapRouter
            .ExactOutputSingleParams({
                tokenIn: LINK,
                tokenOut: WETH,
                fee: poolFee,
                recipient: address(this),
                deadline: block.timestamp,
                amountOut: _amountOut,
                amountInMaximum: _amountInMaximum,
                sqrtPriceLimitX96: 0
            });

        amountIn = swapRouter.exactOutputSingle(params);

        if (amountIn < _amountInMaximum) {
            IERC20(_tokenIn).approve(address(swapRouter), 0);
            IERC20(_tokenIn).transfer(address(this), _amountInMaximum - amountIn);
        }
    }
}