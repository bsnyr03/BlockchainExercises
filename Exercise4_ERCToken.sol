// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import"@openzeppelin/contracts/access/Ownable.sol";

contract BarisToken is ERC20, Ownable{

    mapping(address => bool) public whiteList;

    constructor() ERC20("BarisToken", "BAT") Ownable(msg.sender) {
        _mint(msg.sender, 1000 * 10 ** decimals());
        whiteList[msg.sender] = true;
    }

    function addToWhiteList(address account) external onlyOwner {
        whiteList[account] = true;
    }

    function removeFromWhiteList(address account) external onlyOwner {
        whiteList[account] = false;
    }

    function transfer(address to, uint256 amount) public override returns (bool){
        require(whiteList[to], "Recipient not whitelisted");
        return super.transfer(to, amount);
    }   

    function transferFrom(address from, address to, uint256 amount) public override returns (bool){
        require(whiteList[from], "Sender not whitelisted");
        require(whiteList[to], "Recipient not whitelisted"); 
        return super.transferFrom(from, to, amount);
    }
}