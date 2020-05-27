pragma solidity ^0.5.0;

/**
  * @title Ownable
  * @dev Owner validator
  */
contract Ownable {
  address private _owner;
  address private _operator;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
  event OperatorTransferred(address indexed previousOperator, address indexed newOperator);

  /**
    * @dev The Ownable constructor sets the original `owner` of the contract to the sender
    * account.
    */
  constructor() public {
    _owner = msg.sender;
    _operator = msg.sender;
    emit OwnershipTransferred(address(0), _owner);
    emit OperatorTransferred(address(0), _operator);
  }

  /**
    * @return the address of the owner.
    */
  function owner() public view returns (address) {
    return _owner;
  }

  /**
    * @return the address of the operator.
    */
  function operator() public view returns (address) {
    return _operator;
  }

  /**
    * @dev Throws if called by any account other than the owner.
    */
  modifier onlyOwner() {
    require(isOwner());
    _;
  }

  /**
    * @dev Throws if called by any account other than the owner or operator.
    */
  modifier onlyOwnerOrOperator() {
    require(isOwner() || isOperator());
    _;
  }


  /**
    * @return true if `msg.sender` is the owner of the contract.
    */
  function isOwner() public view returns (bool) {
    return msg.sender == _owner;
  }

  /**
    * @return true if `msg.sender` is the operator of the contract.
    */
  function isOperator() public view returns (bool) {
    return msg.sender == _operator;
  }

  /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param newOwner The address to transfer ownership to.
    */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));

    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }

  /**
    * @dev Allows the current operator to transfer control of the contract to a newOperator.
    * @param newOperator The address to transfer ownership to.
    */
  function transferOperator(address newOperator) public onlyOwner {
    require(newOperator != address(0));

    emit OperatorTransferred(_operator, newOperator);
    _operator = newOperator;
  }


}