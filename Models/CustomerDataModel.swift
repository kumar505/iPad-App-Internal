//
//  CustomerDataModel.swift
//  TPL-Sales
//
//  Created by Challa Karthik on 14/09/17.
//  Copyright © 2017 aezion. All rights reserved.
//

import Foundation

class CustomerDataModel {
    
    var RegionId: NSNumber?
    var CustomerId: NSNumber?
    var AreaId: NSNumber?
    var SubAreaId: NSNumber?
    var LightingTypeId: NSNumber?
    var leadSourceId: NSNumber?
    var LeadSourceSubTypeId: NSNumber?
    var PrimaryName: String = ""
    var PrimaryEmail: String = ""
    var PrimaryPhone: String = ""
    var PrimaryPhoneType: String = ""
    var AltPhoneType: String = ""
    var Email: String = ""
    var AltPhone: String = ""
    var Address1: String = ""
    var Address2: String = ""
    var City: String = ""
    var ZipCode: String = ""
    var BillingAddress1: String = ""
    var BillingAddress2: String = ""
    var BillingCity: String = ""
    var BillingZip: String = ""
    var GateCode: String = ""
    var KeyMap: String = ""
    var BillingStateId: NSNumber?
    var FirstName: String?
    var LastName: String?
    var KeyMapSuffix: String?
    var SubDivision: String?
    var HisMobile: String?
    var HerMobile: String?
    var Notes: String?
    var VIPNotes: String?
    var StateId: NSNumber?
    var IsBillingAddrSameAsInstallAddr: Bool?
    var OpenBalance: NSNumber?
    var LoggedInUser: NSNumber?
    var RegionAreaName: String?
    var AdditionalPhone: String?
    var IsLowVoltage: Bool?
    var IsHighVoltage: Bool?
    var HasTrees: Bool?
    var POCName: String?
    var Id: NSNumber?
    
    // Todo: Need to parse this for bulk customer data (For now single is enough)
    
    func parseServerData(response: NSDictionary) -> CustomerDataModel {
        
        if let data = response.object(forKey: "data") as? NSDictionary {
            
            if let custId = data.object(forKey: "Id") as? NSNumber {
                customer.Id = custId
            }
            
            if let custPrimName = data.object(forKey: "PrimaryName") as? String {
                customer.PrimaryName = custPrimName
            }
            
            if let custPrimEmail = data.object(forKey: "PrimaryEmail") as? String {
                customer.PrimaryEmail = custPrimEmail
            }
            
            if let custPrimPhone = data.object(forKey: "PrimaryPhone") as? String {
                customer.PrimaryPhone = custPrimPhone
            }
            
            if let custPrimaryPhoneType = data.object(forKey: "PrimaryPhoneType") as? String {
                customer.PrimaryPhoneType = custPrimaryPhoneType
            }
            
            if let custAltPhone = data.object(forKey: "AltPhone") as? String {
                customer.AltPhone = custAltPhone
            }
            
            if let custAltPhoneType = data.object(forKey: "AltPhoneType") as? String {
                customer.AltPhoneType = custAltPhoneType
            }
            
            if let custRegionId = data.object(forKey: "RegionId") as? NSNumber {
                customer.RegionId = custRegionId
            }
            
            if let custCustomerId = data.object(forKey: "CustomerId") as? NSNumber {
                customer.CustomerId = custCustomerId
            }
            
            if let custAreaId = data.object(forKey: "AreaId") as? NSNumber {
                customer.AreaId = custAreaId
            }
            
            if let custSubAreaId = data.object(forKey: "SubAreaId") as? NSNumber {
                customer.SubAreaId = custSubAreaId
            }
            
            if let custLightingTypeId = data.object(forKey: "LightingTypeId") as? NSNumber {
                customer.LightingTypeId = custLightingTypeId
            }
            
            if let custLeadSourceId = data.object(forKey: "LeadSourceId") as? NSNumber {
                customer.leadSourceId = custLeadSourceId
            }
            
            if let custLeadSourceSubTypeId = data.object(forKey: "LeadSourceSubTypeId") as? NSNumber {
                customer.LeadSourceSubTypeId = custLeadSourceSubTypeId
            }
            
            if let custFirstName = data.object(forKey: "FirstName") as? String {
                customer.FirstName = custFirstName
            }
            
            if let custLastName = data.object(forKey: "LastName") as? String {
                customer.LastName = custLastName
            }
            
            if let custKeyMap = data.object(forKey: "KeyMap") as? String {
                customer.KeyMap = custKeyMap
            }
            
            if let custEmail = data.object(forKey: "Email") as? String {
                customer.Email = custEmail
            }
            
            if let custKeyMapSuffix = data.object(forKey: "KeyMapSuffix") as? String {
                customer.KeyMapSuffix = custKeyMapSuffix
            }
            
            if let custGateCode = data.object(forKey: "GateCode") as? String {
                customer.GateCode = custGateCode
            }
            
            if let custSubDivision = data.object(forKey: "SubDivision") as? String {
                customer.SubDivision = custSubDivision
            }
            
            if let custHisMobile = data.object(forKey: "HisMobile") as? String {
                customer.HisMobile = custHisMobile
            }
            
            if let custHerMobile = data.object(forKey: "HerMobile") as? String {
                customer.HerMobile = custHerMobile
            }
            
            if let custAddress1 = data.object(forKey: "Address1") as? String {
                customer.Address1 = custAddress1
            }
            
            if let custAddress2 = data.object(forKey: "Address2") as? String {
                customer.Address2 = custAddress2
            }
            
            if let custCity = data.object(forKey: "City") as? String {
                customer.City = custCity
            }
            
            if let custZipCode = data.object(forKey: "ZipCode") as? String {
                customer.ZipCode = custZipCode
            }
            
            if let custNotes = data.object(forKey: "Notes") as? String {
                customer.Notes = custNotes
            }
            
            if let custVIPNotes = data.object(forKey: "VIPNotes") as? String {
                customer.VIPNotes = custVIPNotes
            }
            
            if let custStateId = data.object(forKey: "StateId") as? NSNumber {
                customer.StateId = custStateId
            }
            
            if let custIsBillingAddrSameAsInstallAddr = data.object(forKey: "IsBillingAddrSameAsInstallAddr") as? Bool {
                customer.IsBillingAddrSameAsInstallAddr = custIsBillingAddrSameAsInstallAddr
            }
            
            if let custBillingAddress1 = data.object(forKey: "BillingAddress1") as? String {
                customer.BillingAddress1 = custBillingAddress1
            }
            
            if let custBillingAddress2 = data.object(forKey: "BillingAddress2") as? String {
                customer.BillingAddress2 = custBillingAddress2
            }
            
            if let custBillingAddress2 = data.object(forKey: "BillingAddress2") as? String {
                customer.BillingAddress2 = custBillingAddress2
            }
            
            if let custBillingCity = data.object(forKey: "BillingCity") as? String {
                customer.BillingCity = custBillingCity
            }
            
            if let custBillingZip = data.object(forKey: "BillingZip") as? String {
                customer.BillingZip = custBillingZip
            }
            
            if let custBillingStateId = data.object(forKey: "BillingZip") as? NSNumber {
                customer.BillingStateId = custBillingStateId
            }
            
            if let custOpenBalance = data.object(forKey: "OpenBalance") as? NSNumber {
                customer.OpenBalance = custOpenBalance
            }
            
            if let custLoggedInUser = data.object(forKey: "LoggedInUser") as? NSNumber {
                customer.LoggedInUser = custLoggedInUser
            }
            
            if let custRegionAreaName = data.object(forKey: "RegionAreaName") as? String {
                customer.RegionAreaName = custRegionAreaName
            }
            
            if let custLoggedInUser = data.object(forKey: "LoggedInUser") as? NSNumber {
                customer.LoggedInUser = custLoggedInUser
            }
            
            if let custAdditionalPhone = data.object(forKey: "AdditionalPhone") as? String {
                customer.AdditionalPhone = custAdditionalPhone
            }
            
            if let custIsLowVoltage = data.object(forKey: "IsLowVoltage") as? Bool {
                customer.IsLowVoltage = custIsLowVoltage
            }
            
            if let custHasTrees = data.object(forKey: "HasTrees") as? Bool {
                customer.HasTrees = custHasTrees
            }
            
            if let custPOCName = data.object(forKey: "POCName") as? String {
                customer.POCName = custPOCName
            }
        }
        
        return customer
    }
    
}
