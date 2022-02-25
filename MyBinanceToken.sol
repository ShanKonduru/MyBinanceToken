// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract Token{
    uint public tokenSupply = 10000 * 10**18;
    string public name = "ShanToken";
    string public symbol = "SHAN";
    uint public decimals = 18;
    mapping (address => uint ) public blanaces;
    mapping (address => mapping (address => uint )) public allowance;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor(){
        blanaces[msg.sender] = tokenSupply;
    }

    function balanceOf(address owner) public view returns (uint){
        return blanaces[owner];
    }

    function transfer(address to, uint value) public returns(bool){
        require(blanaces[msg.sender]>=value, "Low balance");
        blanaces[to] += value;
        blanaces[msg.sender] -= value;

        emit Transfer(msg.sender, to, value);

        return true; 
    }

    function transferFrom(address from, address to, uint value) public returns (bool){
        require(blanaces[from]>=value, "Low Balance");
        require(allowance[from][msg.sender] >= value, "Low Allowance" );

        blanaces[to] += value;
        blanaces[from] -= value;
        emit Transfer(from, to, value);
    }

    function approve(address spender, uint value) public returns(bool){
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}