module Db.DbModels exposing (..)

import RemoteData exposing (WebData)
import StatusCodes.StatusCodes as StatusCodes


type alias SensorDb =
    { sensors : WebData Sensors
    , part_numbers : WebData PartNumbers
    , sensor_types : WebData SensorTypes
    , projects : WebData Projects
    , customers : WebData Customers
    , status_codes : WebData StatusCodes
    , mounting_locations : WebData MountingLocations
    , operators : WebData Operators
    , status_log : WebData StatusLog
    }


type alias Sensors =
    List Sensor


type alias Sensor =
    { id : Int
    , sn : String
    , pn : Int
    , sensor_type : Int
    , calibration_certificate : String
    , project : Int
    , current_status : Int
    , mounting_location : Int
    }


type alias PartNumbers =
    List PartNumber


type alias PartNumber =
    { id : Int
    , pn : String
    , calibration_procedure : String
    }


type alias SensorTypes =
    List SensorType


type alias SensorType =
    { id : Int
    , description : String
    }


type alias Projects =
    List Project


type alias Project =
    { id : Int
    , name : String
    , customer : Int
    }


type alias Customers =
    List Customer


type alias Customer =
    { id : Int
    , name : String
    }


type alias StatusCodes =
    List StatusCode


type alias StatusCode =
    { id : Int
    , step : Int
    , current_status : String
    , next_action : String
    }


type alias MountingLocations =
    List MountingLocation


type alias MountingLocation =
    { id : Int
    , description : String
    }


type alias Operators =
    List Operator


type alias Operator =
    { id : Int
    , name : String
    }


type alias StatusLog =
    List StatusLogItem


type alias StatusLogItem =
    { id : Int
    , sensor_id : Int
    , status_code_id : Int
    , operator_id : Int
    , time : String
    }


type alias SensorDbLoaded =
    { sensors : Sensors
    , part_numbers : PartNumbers
    , sensor_types : SensorTypes
    , projects : Projects
    , customers : Customers
    , status_codes : StatusCodes
    , mounting_locations : MountingLocations
    , operators : Operators
    , status_log : StatusLog
    }



-- END
