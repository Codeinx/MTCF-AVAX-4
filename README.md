
---

# DegenGames Smart Contract

## Overview

The `DegenGames` smart contract is an ERC20 token implementation with additional functionality for minting, burning, transferring tokens, redeeming items, and withdrawing funds. The contract is designed to operate on the Ethereum blockchain and utilizes the OpenZeppelin library for security and standardization.

## Features

- **ERC20 Token**: Implements the standard ERC20 functionality.
- **Ownable**: Allows the contract owner to perform certain restricted actions.
- **Minting**: The owner can mint new tokens.
- **Burning**: Users can burn their tokens.
- **Item Redemption**: Users can redeem tokens for predefined items.
- **Fund Withdrawal**: The owner can withdraw funds from the contract.

## Contract Details

- **Token Name**: Degen
- **Token Symbol**: DGN

### Item Prices

- **Toolbox**: 10 DGN
- **Nitro**: 8 DGN
- **Suspensions**: 6 DGN
- **Hydraulics**: 4 DGN

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- Node.js
- npm or yarn
- Hardhat
- An Ethereum wallet

### Installation

1. Clone the repository
   ```sh
   git clone https://github.com/your-repository.git
   cd your-repository
   ```

2. Install dependencies
   ```sh
   npm install
   ```

### Deployment

To deploy the smart contract to the Ethereum network:

1. Compile the smart contract
   ```sh
   npx hardhat compile
   ```

2. Deploy the smart contract
   ```sh
   npx hardhat run scripts/deploy.js --network [network-name]
   ```

### Usage

Once deployed, you can interact with the smart contract using the following methods:

#### Minting Tokens

```solidity
function mint(address _receiver, uint256 _amount) external onlyOwner
```

Mint new tokens to a specified address. This function can only be called by the contract owner.

#### Transferring Tokens

```solidity
function transferDGNToken(address _receiver, uint256 _amount) external returns (bool success)
```

Transfer tokens to another address.

#### Burning Tokens

```solidity
function burn(uint256 _amount) external
```

Burn a specified amount of tokens from the caller's balance.

#### Redeeming Items

```solidity
function redeemItems(ItemsToRedeem _item) external
```

Redeem tokens for a specified item. The item prices are predefined in the contract.

#### Withdrawing Funds

```solidity
function withdrawFunds() external onlyOwner
```

Withdraw all funds from the contract to the owner's address.

### Example

Here is an example of how to interact with the smart contract using Hardhat:

```javascript
const { ethers } = require("hardhat");

async function main() {
  const DegenGames = await ethers.getContractFactory("DegenGames");
  const degenGames = await DegenGames.deploy();
  await degenGames.deployed();

  console.log("DegenGames deployed to:", degenGames.address);

  // Minting tokens
  await degenGames.mint("0xYourAddress", ethers.utils.parseEther("100"));

  // Transferring tokens
  await degenGames.transferDGNToken("0xRecipientAddress", ethers.utils.parseEther("10"));

  // Redeeming an item
  await degenGames.redeemItems(0); // 0 corresponds to Toolbox
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

## Testing

To run tests, use the following command:

```sh
npx hardhat test
```

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- OpenZeppelin for their ERC20 and Ownable implementations

---