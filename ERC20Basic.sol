pragma solidity ^0.5.0;

/**
  * @title ERC20Basic
  * @dev Simpler version of ERC20 interface
  * @dev see https://github.com/ethereum/EIPs/issues/179
  */
contract ERC20Basic {
  function totalSupply() public view returns (uint);
  function balanceOf(address who) public view returns (uint);
  function transfer(address to, uint value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint value);
}