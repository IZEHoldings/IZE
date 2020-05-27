pragma solidity ^0.5.0;

import "./BurnableToken.sol";

/**
  * @title LockableToken
  * @dev locking of granted balance
  */
contract LockableToken is BurnableToken {

  using SafeMath for uint;

  /**
    * @dev Lock defines a lock of token
    */
  struct Lock {
    uint amount;
    uint expiresAt;
  }

  mapping (address => Lock[]) public grantedLocks;

  /**
    * @dev Transfer tokens to another
    * @param to address the address which you want to transfer to
    * @param value uint the amount of tokens to be transferred
    */
  function transfer(address to, uint value) public whenNotPaused returns (bool) {
    _verifyTransferLock(msg.sender, value);
    _transfer(msg.sender, to, value);
    return true;
  }

  /**
    * @dev Transfer tokens from one address to another
    * @param from address The address which you want to send tokens from
    * @param to address the address which you want to transfer to
    * @param value uint the amount of tokens to be transferred
    */
  function transferFrom(address from, address to, uint value) public whenNotPaused returns (bool) {
    _verifyTransferLock(from, value);
    _transferFrom(from, to, value);
    return true;
  }

  /**
    * @dev Function to add lock
    * @param granted The address that will be locked.
    * @param amount The amount of tokens to be locked
    * @param expiresAt The expired date as unix timestamp
    */
  function addLock(address granted, uint amount, uint expiresAt) public whenNotPaused onlyOwnerOrOperator {
    require(amount > 0);
    require(expiresAt > now);

    grantedLocks[granted].push(Lock(amount, expiresAt));
  }

  /**
    * @dev Function to delete lock
    * @param granted The address that was locked
    * @param index The index of lock
    */
  function deleteLock(address granted, uint8 index) public whenNotPaused onlyOwnerOrOperator {
    require(grantedLocks[granted].length > index);

    uint len = grantedLocks[granted].length;
    if (len == 1) {
      delete grantedLocks[granted];
    } else {
      if (len - 1 != index) {
        grantedLocks[granted][index] = grantedLocks[granted][len - 1];
      }
      delete grantedLocks[granted][len - 1];
    }
  }

  /**
    * @dev Verify transfer is possible
    * @param from - granted
    * @param value - amount of transfer
    */
  function _verifyTransferLock(address from, uint value) internal view {
    uint lockedAmount = getLockedAmount(from);
    uint balanceAmount = balanceOf(from);

    require(balanceAmount.sub(lockedAmount) >= value);
  }

  /**
    * @dev get locked amount of address
    * @param granted The address want to know the lock state.
    * @return locked amount
    */
  function getLockedAmount(address granted) public view returns(uint) {
    uint lockedAmount = 0;

    uint len = grantedLocks[granted].length;
    for (uint i = 0; i < len; i++) {
      if (now < grantedLocks[granted][i].expiresAt) {
        lockedAmount = lockedAmount.add(grantedLocks[granted][i].amount);
      }
    }
    return lockedAmount;
  }
}