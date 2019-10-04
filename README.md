## Ropsten

### ERC20

Address: [`0xcBd047839667b4e0fd8E7EB837C2ad5e357491Cc`](https://ropsten.etherscan.io/token/0xcBd047839667b4e0fd8E7EB837C2ad5e357491Cc)
Minter/pauser: `0x97E152fB3d0C02E9778D8c382F74AF4Da4387283`
Decimals: 18
Initial supply: 250,000,000 to `0x97E152fB3d0C02E9778D8c382F74AF4Da4387283`

### ERC721

Address: [`0xb34EEE566C59506F26c1E73F4EcAb3f0fCD178Fd`](https://ropsten.etherscan.io/address/0xb34EEE566C59506F26c1E73F4EcAb3f0fCD178Fd)
Minter: `0x97E152fB3d0C02E9778D8c382F74AF4Da4387283`

### Marketplace

Address: [`0x92b6c9beDecBEde62C30B531424B784f5eF68c1a`](https://ropsten.etherscan.io/address/0x92b6c9beDecBEde62C30B531424B784f5eF68c1a)


## Deployment

npm run openzeppelin -- init
npm run openzeppelin -- link @openzeppelin/contracts-ethereum-package

### Deploy ERC20

npm run openzeppelin -- create @openzeppelin/contracts-ethereum-package/StandaloneERC20
  > Pick a network: ropsten
  > Do you want to call a function on the instance after creating it?: Y
  > Select which function: initialize(name: string, symbol: string, decimals: uint8, initialSupply: uint256, initialHolder: address, minters: address[], pausers: address[]) 
    > name: BHD
    > symbol: BHD
    > decimal: 18
    > initialSupply: 250000000000000000000000000
    > initialHolder: 0x97E152fB3d0C02E9778D8c382F74AF4Da4387283
    > minters: 0x97E152fB3d0C02E9778D8c382F74AF4Da4387283
    > pausers: 0x97E152fB3d0C02E9778D8c382F74AF4Da4387283

### Deploy ERC721

npm run openzeppelin -- create @openzeppelin/contracts-ethereum-package/StandaloneERC721
  > Pick a network: ropsten
  > Do you want to call a function on the instance after creating it?: Y
  > Select which function: initialize(name: string, symbol: string, minters: address[], pausers: address[])
    > name: Beachhead Weapon
    > symbol: BHWEAPON
    > minters: 0x97E152fB3d0C02E9778D8c382F74AF4Da4387283
    > pausers: 0x97E152fB3d0C02E9778D8c382F74AF4Da4387283

### Deploy the marketplace

npm run openzeppelin -- create marketplace
  > Pick a network: ropsten
  > Do you want to call a function on the instance after creating it?: Y
  > Select which function: initialize()

