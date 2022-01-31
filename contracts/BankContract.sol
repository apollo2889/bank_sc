pragma solidity ^0.8.0;

contract Bank {
    address public bankOwner;
    string public bankName;
    mapping(address => uint256) public customerBalance;

    constructor() {
        bankOwner = msg.sender;
    }

    function depositMoney() public payable {
        require(msg.value != 0, "You need to deposit some ethereum");
        customerBalance[msg.sender] += msg.value;
    }

    function setBankName(string memory _name) external {
        require(msg.sender == bankOwner, "You must be the owner to set the name of bank");
        bankName = _name;
    }

    function withDrawMoney(address payable _to, uint256 _total) public payable {
        require(_total <= customerBalance[msg.sender], "You have insufficient eth to withdraw");
        customerBalance[msg.sender] -= _total;
        _to.transfer(_total);
    }

    function getCustomerBalance() external view returns (uint256) {
        return customerBalance[msg.sender];
    }

    function getBankBalance() public view returns (uint256) {
        require(msg.sender == bankOwner, "You must be the owner of the bank to see all balances.");
        return address(this).balance;
    }
}