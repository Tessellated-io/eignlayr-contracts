// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../permissions/Pausable.sol";
import "@openzeppelin-upgrades/contracts/proxy/utils/Initializable.sol";
import "../interfaces/IRegistryPermission.sol";

contract RegistryPermission is Initializable, Pausable, IRegistryPermission {
    mapping(address => bool) public operatorPermission;
    address public permissionPerson;

    event AddOperatorPermission(address operator, bool status);
    event ChangeOperatorPermission(address operator, bool status);

    constructor() {
        _disableInitializers();
    }

    function initialize(address personAddress) public initializer {
        permissionPerson = personAddress;
    }

    function addOperatorPermission(address operator) external {
        require(msg.sender == permissionPerson, "RegistryPermission.addOperatorPermission: Only permission person can add permission for operator");
        operatorPermission[operator] = true;
        emit AddOperatorPermission(operator, true);
    }

    function ChangeOperatorPermission(address operator, bool status) external {
        require(msg.sender == permissionPerson, "RegistryPermission.ChangeOperatorPermission: Only permission person can change status for operator");
        require(operatorPermission[operator] != status, "RegistryPermission.ChangeOperatorPermission: Status is same, don't need to change");
        operatorPermission[operator] = status;
        emit ChangeOperatorPermission(operator, status);
    }

    function getOperatorPermission(address operator) external returns (bool) {
        return operatorPermission[operator];
    }

    function setPermissionPerson(address personAddress) onlyOwner {
        permissionPerson = personAddress;
    }
}
