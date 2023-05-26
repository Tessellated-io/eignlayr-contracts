// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "../permissions/Pausable.sol";
import "@openzeppelin-upgrades/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin-upgrades/contracts/access/OwnableUpgradeable.sol";
import "../interfaces/IRegistryPermission.sol";

contract RegistryPermission is Initializable, OwnableUpgradeable, IRegistryPermission {
    address public permissionPerson;

    mapping(address => bool) public operatorRegisterPermission;
    mapping(address => bool) public operatorDeregisterPermission;
    mapping(address => bool) public dataStoreRollupPermission;

    event AddOperatorRegisterPermission(address operator, bool status);
    event AddOperatorDeregisterPermission(address operator, bool status);
    event AddDataStoreRollupPermission(address pusher, bool status);
    event ChangeOperatorRegisterPermission(address operator, bool status);
    event ChangeOperatorDeregisterPermission(address operator, bool status);
    event ChangeDataStoreRollupPermission(address pusher, bool status);

    constructor() {
        _disableInitializers();
    }

    function initialize(address personAddress, address initialOwner) public initializer {
        permissionPerson = personAddress;
        _transferOwnership(initialOwner);
    }

    function addOperatorRegisterPermission(address operator) external {
        require(
            msg.sender == permissionPerson,
            "RegistryPermission.addOperatorRegisterPermission: Only permissionPerson can add permission for operator"
        );
        operatorRegisterPermission[operator] = true;
        emit AddOperatorRegisterPermission(operator, true);
    }

    function addOperatorDeregisterPermission(address operator) external {
        require(
            msg.sender == permissionPerson,
            "RegistryPermission.addOperatorDeregisterPermission: Only permissionPerson can add permission for operator"
        );
        operatorDeregisterPermission[operator] = true;
        emit AddOperatorDeregisterPermission(operator, true);
    }

    function addDataStoreRollupPermission(address pusher) external {
        require(
            msg.sender == permissionPerson,
            "RegistryPermission.addDataStoreRollupPermission: Only permissionPerson can add permission for operator"
        );
        dataStoreRollupPermission[pusher] = true;
        emit AddDataStoreRollupPermission(pusher, true);
    }

    function changeOperatorRegisterPermission(address operator, bool status) external {
        require(
            msg.sender == permissionPerson,
            "RegistryPermission.changeOperatorRegisterPermission: Only permission person can change status for operator"
        );
        require(
            operatorRegisterPermission[operator] != status,
            "RegistryPermission.changeOperatorRegisterPermission: Status is same, don't need to change"
        );
        operatorRegisterPermission[operator] = status;
        emit ChangeOperatorRegisterPermission(operator, status);
    }

    function changeOperatorDeregisterPermission(address operator, bool status) external {
        require(
            msg.sender == permissionPerson,
            "RegistryPermission.changeOperatorDeregisterPermission: Only permission person can change status for operator"
        );
        require(
            operatorDeregisterPermission[operator] != status,
            "RegistryPermission.changeOperatorDeregisterPermission: Status is same, don't need to change"
        );
        operatorDeregisterPermission[operator] = status;
        emit ChangeOperatorDeregisterPermission(operator, status);
    }

    function changeDataStoreRollupPermission(address pusher, bool status) external {
        require(
            msg.sender == permissionPerson,
            "RegistryPermission.changeDataStoreRollupPermission: Only permission person can change status for operator"
        );
        require(
            dataStoreRollupPermission[pusher] != status,
            "RegistryPermission.changeDataStoreRollupPermission: Status is same, don't need to change"
        );
        dataStoreRollupPermission[pusher] = status;
        emit ChangeDataStoreRollupPermission(pusher, status);
    }

    function getOperatorRegisterPermission(address operator) external view returns (bool) {
        return operatorRegisterPermission[operator];
    }

    function getOperatorDeregisterPermission(address operator) external view returns (bool) {
        return operatorDeregisterPermission[operator];
    }

    function getDataStoreRollupPermission(address pusher) external view returns (bool) {
        return dataStoreRollupPermission[pusher];
    }

    function setPermissionPerson(address personAddress) external onlyOwner {
        permissionPerson = personAddress;
    }
}
