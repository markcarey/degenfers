// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MockDegen is ERC20, ERC20Permit {
    constructor() ERC20("Mock Degen", "mDEGEN") ERC20Permit("Mock Degen") {
        _mint(msg.sender, 69000000 * 10 ** decimals());
    }
}
