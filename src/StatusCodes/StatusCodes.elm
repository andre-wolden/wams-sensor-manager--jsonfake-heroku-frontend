module StatusCodes.StatusCodes exposing (..)


type alias StatusCode =
    { id : Int
    , status : Code
    , status_description : String
    , next_todo : String
    }


type Code
    = Initiated
    | Registered
    | FactoryAcceptanceTested
    | Received
    | Installed
    | CalibrationTested
    | CalibrationCertificateOk
    | Delivered


statusCodes : List StatusCode
statusCodes =
    [ delivered
    , calibrationCertificateOk
    , calibrationTested
    , installed
    , received
    , factoryAcceptanceTested
    , registered
    , initiated
    ]


initiated : StatusCode
initiated =
    { id = 1
    , status = Initiated
    , status_description = "Initiated"
    , next_todo = "Register"
    }


registered : StatusCode
registered =
    { id = 2
    , status = Registered
    , status_description = "Registered"
    , next_todo = "Supplier FAT"
    }


factoryAcceptanceTested : StatusCode
factoryAcceptanceTested =
    { id = 3
    , status = FactoryAcceptanceTested
    , status_description = "FAT completed"
    , next_todo = "Receive to stock"
    }


received : StatusCode
received =
    { id = 4
    , status = Received
    , status_description = "On stock"
    , next_todo = "Mount sensor"
    }


installed : StatusCode
installed =
    { id = 5
    , status = Installed
    , status_description = "Sensor Mounted"
    , next_todo = "Perform calibration testing"
    }


calibrationTested : StatusCode
calibrationTested =
    { id = 6
    , status = CalibrationTested
    , status_description = "Calibration testing completed"
    , next_todo = "Perform calibration analysis and create Calibration Certificate"
    }


calibrationCertificateOk : StatusCode
calibrationCertificateOk =
    { id = 7
    , status = CalibrationCertificateOk
    , status_description = "Calibration Certificate Completed"
    , next_todo = "Deliver"
    }


delivered : StatusCode
delivered =
    { id = 8
    , status = Delivered
    , status_description = "Delivered"
    , next_todo = "DONE!"
    }



-- END
