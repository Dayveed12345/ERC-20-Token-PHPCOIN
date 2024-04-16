// function name() public view returns (string)
// function symbol() public view returns (string)
// function decimals() public view returns (uint8)
// function totalSupply() public view returns (uint256)
// function balanceOf(address _owner) public view returns (uint256 balance)
// function transfer(address _to, uint256 _value) public returns (bool success)
// function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
// function approve(address _spender, uint256 _value) public returns (bool success)
// function allowance(address _owner, address _spender) public view returns (uint256 remaining)
// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract PhpCoin {
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    // Account 3--->0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    //the_last_php_bender----->0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint256 private _amount;

    constructor() {
        _name = "PHPCOIN";
        _symbol = "PCN";
        _totalSupply = 100 ether;
        _balances[msg.sender] = _totalSupply; // Assign total supply to contract creator
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf() public view returns (uint256) {
        return _balances[msg.sender]; // Return balance from '_balances' mapping
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_balances[msg.sender] >= _value, "Insufficient Balance");

        _balances[msg.sender] -= _value; // Deduct the transferred amount from the sender's balance
        _balances[_to] += _value; // Add the transferred amount to the recipient's balance

        emit Transfer(msg.sender, _to, _value); // Emit a transfer event as per ERC20 standard

        return true; // Return true to indicate successful transfer
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_allowances[_from][_to] >= _value, "You are not approved to withdraw Such amount from this account ");
        _allowances[_from][_to] -= _value;
        _balances[_from] -= _value;
        _balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        _allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return _allowances[_owner][_spender];
    }
}
