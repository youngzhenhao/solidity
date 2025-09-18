// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract TOKEN is ERC20, Ownable {
    
    uint8 immutable internal _decimals;

    constructor(string memory name_, string memory symbol_, uint8 decimals_, uint256 initSupply_) ERC20(name_, symbol_) Ownable(msg.sender) {
        _decimals = decimals_;
        _mint(msg.sender, initSupply_);
    }

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    function revokeApproval(address spender) public {
        _approve(msg.sender, spender, 0);
    }

    function renounceOwnership() public override onlyOwner {
    }
    
}
