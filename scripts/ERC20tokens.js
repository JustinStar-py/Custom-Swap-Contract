// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
    
    const Clone = await hre.ethers.getContractFactory(`ERC20Token`);
    const clone = await Clone.deploy();

    await clone.deployed();

    console.log(
       `Token contract address deployed to : ${clone.address}`
    );
    
    // link - 0xE72eB75aC580FaAe287FC3b7fd6eAEAC1Acbc877
    // usdt - 0x9aD6E31387162C9623D6D19C2621204bF8Fe50C6
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
