pragma solidity ^0.5.0;

import "./StandardToken.sol";

/**
  * @title MintableToken
  * @dev Minting of total balance
  */
contract MintableToken is StandardToken {
  event MintFinished();

  bool public mintingFinished = false;

  modifier canMint() {
    require(!mintingFinished);
    _;
  }

  /**
    * @dev Function to mint tokens
    * @param to The address that will receive the minted tokens.
    * @param amount The amount of tokens to mint
    * @return A boolean that indicated if the operation was successful.
    */
  function mint(address to, uint amount) public whenNotPaused onlyOwner canMint returns (bool) {
    _mint(to, amount);
    return true;
  }

  /**
    * @dev Function to stop minting new tokens.
    * @return True if the operation was successful.
    */
  function finishMinting() public whenNotPaused onlyOwner canMint returns (bool) {
    mintingFinished = true;
    emit MintFinished();
    return true;
  }
}