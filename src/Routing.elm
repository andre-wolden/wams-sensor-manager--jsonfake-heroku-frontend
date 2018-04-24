module Routing exposing (..)

import Navigation exposing (..)
import UrlParser exposing (..)
import Models exposing (Route(..))


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Home top
        , map SensorsNewRoute (s "new_sensor")
        , map PartNumbersRoute (s "partnumbers")
        , map PartNumbersNewRoute (s "partnumbers" </> s "new")
        , map ProjectsRoute (s "projects")
        , map ProjectRoute (s "project" </> string)
        , map ProjectNewRoute (s "projects" </> s "new")
        , map CustomersRoute (s "customers")
        , map CustomerRoute (s "customer" </> string)
        , map CustomerNewRoute (s "customers" </> s "new")
        , map CustomerNewRegisteredRoute (s "customers" </> s "registered")
        , map OperatorsRoute (s "operators")
        , map OperatorRoute (s "operator" </> string)
        , map OperatorNewRoute (s "operators" </> s "new")
        , map SensorTypesRoute (s "sensor_types")
        , map SensorTypesNewRoute (s "sensor_types" </> s "new")
        , map Index (s "index")
        , map OopeSomethingWentWrongRoute (s "oops")
        , map MountingLocationsRoute (s "mounting_locations")
        , map MountingLocationsNewRoute (s "mounting_locations" </> s "new")
        , map StatusLog (s "status_log")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


getIndexPath : String
getIndexPath =
    "#index"


getNewSensorPath : String
getNewSensorPath =
    "#new_sensor"


getProjectsPath : String
getProjectsPath =
    "#projects"


getProjectNewRoute : String
getProjectNewRoute =
    "#projects/new"


getCustomersPath : String
getCustomersPath =
    "#customers"


getCustomerNewPath : String
getCustomerNewPath =
    "#customers/new"


getOperatorsPath : String
getOperatorsPath =
    "#operators"


getPartNumberPath : String
getPartNumberPath =
    "#partnumbers"


getPartNumberNewPath : String
getPartNumberNewPath =
    "#partnumbers/new"


getOperatorNewPath : String
getOperatorNewPath =
    "#operators/new"


getSensorTypesPath : String
getSensorTypesPath =
    "#sensor_types"


getSensorTypesNewPath : String
getSensorTypesNewPath =
    "#sensor_types/new"


getMountingLocationsPath : String
getMountingLocationsPath =
    "#mounting_locations"


getMountingLocationsNewPath : String
getMountingLocationsNewPath =
    "#mounting_locations/new"


getLogPath : String
getLogPath =
    "#status_log"
