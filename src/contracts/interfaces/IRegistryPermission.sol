// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 * @title Interface for the primary 'RegistryPermission' contract for Mantle.
 * @author mantle, Inc.
 * @notice See the `RegistryPermission` contract itself for implementation details.
 */
interface IRegistryPermission {
    function addOperatorPermission(address operator) external;
    function changeOperatorPermission(address operator, bool status) external;
    function getOperatorPermission(address operator) external view returns (bool);
}
