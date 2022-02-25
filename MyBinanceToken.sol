// The following statement indicate what Licensing this code is built under
// SPDX-License-Identifier: GPL-3.0

// The following Pragma statement indicates this program has been complied using version 8.0.7 or greater
pragma solidity ^ 0.8 .7;

contract Token {
    // Number of Tokens available in the supply
    // wei	        1 wei	    1	                        10^-18 ETH
    // kwei	        10^3 wei	1,000	                    10^-15 ETH
    // mwei	        10^6 wei	1,000,000	                10^-12 ETH
    // gwei	        10^9 wei	1,000,000,000	            10^-9 ETH
    // microether	10^12 wei	1,000,000,000,000	        10^-6 ETH
    // milliether	10^15 wei	1,000,000,000,000,000	     10^-3 ETH
    // ether	    10^18 wei	1,000,000,000,000,000,000	1 ETH
    uint public tokenSupply = 10000 * 10 ** 18;

    // Name of the Token Give your own Name
    string public name = "ShanToken";

    // Give 4 letter Symbol for your Token/Coin
    string public symbol = "SHAN";

    // Define Number of Units/decimal places for your coin/currency/token
    uint public decimals = 18;

    // Store the Owner address of this Contract to a state variable 
    string public owner;

    // Thie data structure is used to store balances for all address
    mapping(address => uint) public blanaces;

    // This data structure is used to  store allowances infromation
    mapping(address => mapping(address => uint)) public allowance;

    // Declaring an event to capture transfer event
    event Transfer(address indexed from, address indexed to, uint value);

    // Declaring an event to capture Approval event
    event Approval(address indexed owner, address indexed spender, uint value);

    // This is constructor
    constructor() {
        owner = msg.sender;
        blanaces[owner] = tokenSupply;
    }

    // Use this method to find out Balance amount for an address
    function balanceOf(address _owner) public view returns(uint) {
        return blanaces[_owner];
    }

    // call this method to Transfer money ("value") from caller account to receipent account
    // This method checks if the Caller has sufficient funds to transfer to receipent 
    function transfer(address to, uint value) public returns(bool) {

        // This method checks if the Caller has sufficient funds to transfer to receipent 
        require(blanaces[msg.sender] >= value, "Low balance");

        // adjust the balances for Caller and the receipent
        blanaces[to] += value;
        blanaces[msg.sender] -= value;

        // Emit the Transfer Event with requried inputs
        emit Transfer(msg.sender, to, value);

        // return true
        return true;
    }

    // call this method to Transfer money ("value") from an address ("from") account to receipent ("to") account
    // This method checks if the from account has sufficient funds to transfer funds to the receipent 
    // This method also checks if the  caller has sufficient funds and approval to transfer funds to the receipent 
    function transferFrom(address from, address to, uint value) public returns(bool) {
        // Check balance funds before proceeding with Transaction
        require(blanaces[from] >= value, "Low Balance");
        require(allowance[from][msg.sender] >= value, "Low Allowance");

        // Adjust balance amount for from and to accounts
        blanaces[to] += value;
        blanaces[from] -= value;

        // Emit Transfer Event with required data
        emit Transfer(from, to, value);
    }

    // call this method to approve the caller to pay money upto a limit value 
    function approve(address spender, uint value) public returns(bool) {

        // Add allowance limits for Spender
        allowance[msg.sender][spender] = value;

        // Emit Approval Event with required data
        emit Approval(msg.sender, spender, value);

        // return true
        return true;
    }
}