module Lib where

import qualified Fadno.Xml.ParseXsd as Xsd
import qualified Fadno.Xml.EmitTypes as Emit

parseXsd :: IO (Emit.EmitState)
parseXsd = do
  restSchema <- Xsd.parseFile "xsd/IntuitRestServiceDef.xsd"
  financeSchema <- Xsd.parseFile "xsd/Finance.xsd"
  baseTypesSchema <- Xsd.parseFile "xsd/IntuitBaseTypes.xsd"
  nameTypesSchema <- Xsd.parseFile "xsd/IntuitNamesTypes.xsd"
  reportSchema <- Xsd.parseFile "xsd/Report.xsd"
  salesTaxSchema <- Xsd.parseFile "xsd/SalesTax.xsd"
  xsdSchema <- Xsd.loadXsdSchema "xsd/XMLSchema.xsd"
  let allSchemas = restSchema <> xsdSchema <> baseTypesSchema <> nameTypesSchema <> financeSchema <> reportSchema <> salesTaxSchema
  snd <$> (Emit.runEmit (Emit.Env allSchemas) mempty (Emit.emitSchema allSchemas))
