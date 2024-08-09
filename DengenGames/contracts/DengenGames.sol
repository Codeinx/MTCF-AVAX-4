// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

error NotEnoughXcel(string message, uint requiredAmount);

contract XcelShoes is ERC20, Ownable {
    enum RedeemItems { Nike, NewBalance, Adidas, Crocs }

    mapping(address => string[]) public _redeemedItems;

    constructor() ERC20("Xcel", "XL") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transferXcel(address to, uint256 amount) external returns (bool success) {
        if (amount > balanceOf(msg.sender)) {
            revert NotEnoughXcel("Xcel Token not enough", amount);
        }
        success = transfer(to, amount);
    }

    function burn(uint256 amount) external {
        if (amount > balanceOf(msg.sender)) {
            revert NotEnoughXcel("Xcel Token not enough", amount);
        }
        _burn(msg.sender, amount);
    }

    function redeemItems(RedeemItems item) external {
        uint256 price = 0;
        if (item == RedeemItems.Nike) {
            price = 4 * 1e18;
        } else if (item == RedeemItems.NewBalance) {
            price = 3 * 1e18;
        } else if (item == RedeemItems.Adidas) {
            price = 2 * 1e18;
        } else if (item == RedeemItems.Crocs) {
            price = 1 * 1e18;
        } else {
            price = 0;
        }

        if (price > balanceOf(msg.sender)) {
            revert NotEnoughXcel("Xcel Token not enough", price);
        }

        _burn(msg.sender, price); // Burn the tokens instead of transferring them

        string[] storage currentRedeemedItems = _redeemedItems[msg.sender];
        currentRedeemedItems.push(_itemToString(item));
    }

    function withdrawFunds() external onlyOwner {
        _transfer(address(this), msg.sender, balanceOf(address(this)));
    }

    function getBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function _itemToString(RedeemItems item) internal pure returns (string memory) {
        if (item == RedeemItems.Nike) {
            return "Nike";
        } else if (item == RedeemItems.NewBalance) {
            return "NewBalance";
        } else if (item == RedeemItems.Adidas) {
            return "Adidas";
        } else if (item == RedeemItems.Crocs) {
            return "Crocs";
        } else {
            return "";
        }
    }

    function displayRedeemedItems(address user) public view returns (string[] memory) {
        return _redeemedItems[user];
    }
}