pragma solidity ^0.5.0;

/**
  * @title SafeMath
  * @dev Unsigned math operations with safety checks that revert on error.
  */
library SafeMath {

  /**
    * @dev Multiplies two unsigned integers, reverts on overflow.
    */
  function mul(uint a, uint b) internal pure returns (uint) {
    if (a == 0) {
      return 0;
    }

    uint c = a * b;
    require(c / a == b);

    return c;
  }

  /**
    * @dev Integer division of two numbers, truncating the quotient.
    */
  function div(uint a, uint b) internal pure returns (uint) {
    // Solidity only automatically asserts when dividing by 0
    require(b > 0);
    uint c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
    * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
    */
  function sub(uint a, uint b) internal pure returns (uint) {
    require(b <= a);
    uint c = a - b;

    return c;
  }

  /**
    * @dev Adds two numbers, throws on overflow.
    */
  function add(uint a, uint b) internal pure returns (uint) {
    uint c = a + b;
    require(c >= a);

    return c;
  }

  /**
    * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
    * reverts when dividing by zero.
    */
  function mod(uint a, uint b) internal pure returns (uint) {
    require(b != 0);
    return a % b;
  }

}