module Messages exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Db.DbModels exposing (..)
import Http exposing (Error)


type Msg
    = NoOp
      -- Routing Msgs
    | OnLocationChange Location
      -- HTTP Response Msgs
    | SensorsResponse (WebData Sensors)
    | PartNumbersResponse (WebData PartNumbers)
    | SensorTypesResponse (WebData SensorTypes)
    | ProjectsResponse (WebData Projects)
    | CustomersResponse (WebData Customers)
    | StatusCodesResponse (WebData StatusCodes)
    | MountingLocationsResponse (WebData MountingLocations)
    | OperatorsResponse (WebData Operators)
    | StatusLogResponse (WebData StatusLog)
      -- Sensor
    | OnInputNewSensor_sn String
    | OnInputNewSensor_pn Int
    | OnInputNewSensor_sensor_type Int
    | OnInputNewSensor_calibration_certificate String
    | OnInputNewSensor_project Int
    | OnInputNewSensor_mounting_location Int
    | SaveNewSensor Sensor
    | OnSensorSaved (Result Http.Error Sensor)
      -- Saving New Part PartNumber
    | OnInputNewPartNumber_PartNumber String
    | OnInputNewPartNumber_CalibrationProcedure String
    | SaveNewPartNumber PartNumber
    | OnPartNumberSaved (Result Http.Error PartNumber)
      -- Saving New Project
    | OnInputNewProject_Name String
    | OnInputNewProject_CustomerId Int
    | SaveNewProject Project
    | OnProjectSaved (Result Http.Error Project)
      -- Saving New Customer
    | OnInputNewCustomer_Name String
    | SaveNewCustomer Operator
    | OnCustomerSaved (Result Http.Error Customer)
    | NewCustomerRegistered
      -- Saving New Operator
    | OnInputNewOperator_Name String
    | SaveNewOperator Operator
    | OnOperatorSaved (Result Http.Error Operator)
      -- Mounting Locatino
    | OnInputMountingLocation String
    | SaveMountingLocation MountingLocation
    | OnMountingLocationSaved (Result Http.Error MountingLocation)
      -- Sensor all viewOops
    | ExpandRow Int
      -- Exandable stuff screen
    | IncrementSensorStatus Sensor
    | DecrementSensorStatus Sensor
    | OnSensorUpdated (Result Http.Error Sensor)
    | OnInputCalibrationCertificateName String
    | SaveCalibrationCertificate Sensor
