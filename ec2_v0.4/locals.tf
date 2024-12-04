locals {
  common_tags = {
    Project_Code          = var.Project_Code
    ApplicationId         = var.ApplicationId
    ApplicationName       = var.ApplicationName
    environment           = var.environment
    CostCenter            = var.CostCenter
    DataClassification    = var.DataClassification
    SCAClassification     = var.SCAClassification
    IACRepo               = var.IACRepo
    ProductOwner          = var.ProductOwner
    ProductSupport        = var.ProductSupport
    BusinessOwner         = var.BusinessOwner
    CSBIA_Availability    = var.CSBIA_Availability
    CSBIA_Confidentiality = var.CSBIA_Confidentiality
    CSBIA_ImpactScore     = var.CSBIA_ImpactScore
    CSBIA_Integrity       = var.CSBIA_Integrity
    BusinessOPU_HCU       = var.BusinessOPU_HCU
    BusinessStream        = var.BusinessStream
    #SRNumber                = var.SRNumber
  }
}
