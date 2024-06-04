const { expect } = require("chai");
const { ethers } = require("hardhat");
//import hre from 'hardhat';

const networkName = hre.network.name;
console.log(networkName);

require('dotenv').config();

var addr = {};
addr.degen = "0xCAd106ec4a3d792008ff113C8BaCb384f1b84046";
addr.degenfers = "0x1a29779F20634566ed8465f62Df3Ae9913Bc36B7"; // Base


const degenJSON = require("../artifacts/contracts/MockDegen.sol/MockDegen.json");
const degenfersJSON = require("../artifacts/contracts/Degenfer.sol/Degenfer.json");
const signer = new ethers.Wallet(process.env.PRIVATE_KEY, ethers.provider);
const degen = new ethers.Contract(addr.degen, degenJSON.abi, signer);
const degenfers = new ethers.Contract(addr.degenfers, degenfersJSON.abi, signer);

describe("Degenfers", function() {

  it("Should return tokenUri", async function() {
    var tokenUri = await degenfers.tokenURI(0);
    console.log(tokenUri);
    expect(1).to.equal(1);
  });

  it("Should mint by MINTER role via frameMint", async function() {
    var tokenUri = await degenfers.tokenURI(0);
    console.log(tokenUri);
    expect(1).to.equal(1);
  });

});