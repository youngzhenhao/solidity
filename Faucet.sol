// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Faucet {

    uint256 public immutable _amount;
    IERC20 public immutable _token;

    mapping(address => bool) public requestedAddress;

    event SendToken(address indexed receiver, uint256 indexed amount); 

    constructor(address token_, uint256 amount_) {
        _token = IERC20(token_);
        _amount = amount_;
    }

    function requestTokens() external {
        require(!requestedAddress[msg.sender], "Can not request multiple times.");
        require(_token.balanceOf(address(this)) >= _amount, "Faucet empty.");

        _token.transfer(msg.sender, _amount);

        requestedAddress[msg.sender] = true;
        emit SendToken(msg.sender, _amount);
    }

    function balance() public view returns(uint256) {
        return _token.balanceOf(address(this));
    }
    

}
