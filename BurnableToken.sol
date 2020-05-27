pragma solidity ^0.5.0;

import "./MintableToken.sol";

/**
  * @title Burnable Token
  * @dev Token that can be irreversibly burned (destroyed).
  */
contract BurnableToken is MintableToken {
  /**
    * @dev Burns a specific amount of tokens.
    * @param value The amount of token to be burned.
    */
  function burn(uint value) public whenNotPaused onlyOwner returns (bool) {
    _burn(value);
    return true;
  }
}