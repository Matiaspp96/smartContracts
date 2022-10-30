// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import '@openzeppelin/contracts/access/AccessControl.sol';
import './IBonvo.sol';

contract Categories is AccessControl, IBonvo {
    bytes32 public constant ADMIN_CATEGORIES = keccak256("ADMIN_CATEGORIES");
    AssetCategory[] categories;

    constructor(){
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function setAdminCategoriesRole(address newAdminCategories) public onlyRole(DEFAULT_ADMIN_ROLE) {
        grantRole(ADMIN_CATEGORIES, newAdminCategories);
    }

    function removeAdminCategoriesRole(address adminCategories) public onlyRole(DEFAULT_ADMIN_ROLE) {
        require(hasRole(ADMIN_CATEGORIES, adminCategories), "Addres is not categories admin");
        revokeRole(ADMIN_CATEGORIES, adminCategories);
    }

    function addCategory(string calldata _name) public onlyRole(ADMIN_CATEGORIES) {
        require(bytes(_name).length > 0, "Not valid name");
        uint id = categories.length;
        AssetCategory memory assetCategory = AssetCategory({
            idCategory: id,
            name: _name
        });
        categories.push(assetCategory);
    }

    function removeCategory(uint idCategory) public onlyRole(ADMIN_CATEGORIES) {
        require(categories[idCategory].idCategory > 0, "Inexistent category");
        delete(categories[idCategory]);
    }

    function patchCategory(uint idCategory, string memory _name) public onlyRole(ADMIN_CATEGORIES) {
        require(categories[idCategory].idCategory > 0, "Inexistent category");
        require(bytes(_name).length > 0, "Not valid name for cateogory");
        categories[idCategory].name = _name;
    }
}