module Commands exposing (..)

import Db.DbModels exposing (..)
import RemoteData exposing (WebData)
import Messages
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)


fetchSensorDbUrl : String
fetchSensorDbUrl =
    "http://localhost:4001/"



-- Methods for fetching data for each resource


fetchSensorsData : Cmd Messages.Msg
fetchSensorsData =
    Http.get (fetchSensorDbUrl ++ "sensors") sensorsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.SensorsResponse


fetchPartNumbersData : Cmd Messages.Msg
fetchPartNumbersData =
    Http.get (fetchSensorDbUrl ++ "part_numbers") partNumbersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.PartNumbersResponse


fetchSensorTypesData : Cmd Messages.Msg
fetchSensorTypesData =
    Http.get (fetchSensorDbUrl ++ "sensor_types") sensorTypesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.SensorTypesResponse


fetchProjectsData : Cmd Messages.Msg
fetchProjectsData =
    Http.get (fetchSensorDbUrl ++ "projects") projectsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.ProjectsResponse


fetchCustomersData : Cmd Messages.Msg
fetchCustomersData =
    Http.get (fetchSensorDbUrl ++ "customers") customersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.CustomersResponse


fetchStatusCodesData : Cmd Messages.Msg
fetchStatusCodesData =
    Http.get (fetchSensorDbUrl ++ "status_codes") statusCodesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.StatusCodesResponse


fetchMountingLocationsData : Cmd Messages.Msg
fetchMountingLocationsData =
    Http.get (fetchSensorDbUrl ++ "mounting_locations") mountingLocationsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.MountingLocationsResponse


fetchOperatorsData : Cmd Messages.Msg
fetchOperatorsData =
    Http.get (fetchSensorDbUrl ++ "operators") operatorsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OperatorsResponse


fetchStatusLogData : Cmd Messages.Msg
fetchStatusLogData =
    Http.get (fetchSensorDbUrl ++ "status_log") statusLogDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Messages.StatusLogResponse



-- Decoders


sensorsDecoder : Decode.Decoder Sensors
sensorsDecoder =
    Decode.list sensorDecoder


sensorDecoder : Decode.Decoder Sensor
sensorDecoder =
    decode Sensor
        |> required "id" Decode.int
        |> required "sn" Decode.string
        |> required "pn" Decode.int
        |> required "sensor_type" Decode.int
        |> required "calibration_certificate" Decode.string
        |> required "project" Decode.int
        |> required "current_status" Decode.int
        |> required "mounting_location" Decode.int


partNumbersDecoder : Decode.Decoder PartNumbers
partNumbersDecoder =
    Decode.list partNumberDecoder


partNumberDecoder : Decode.Decoder PartNumber
partNumberDecoder =
    decode PartNumber
        |> required "id" Decode.int
        |> required "pn" Decode.string
        |> required "calibration_procedure" Decode.string


sensorTypesDecoder : Decode.Decoder SensorTypes
sensorTypesDecoder =
    Decode.list sensorTypeDecoder


sensorTypeDecoder : Decode.Decoder SensorType
sensorTypeDecoder =
    decode SensorType
        |> required "id" Decode.int
        |> required "description" Decode.string


projectsDecoder : Decode.Decoder Projects
projectsDecoder =
    Decode.list projectDecoder


projectDecoder : Decode.Decoder Project
projectDecoder =
    decode Project
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "customer" Decode.int


customersDecoder : Decode.Decoder Customers
customersDecoder =
    Decode.list customerDecoder


customerDecoder : Decode.Decoder Customer
customerDecoder =
    decode Customer
        |> required "id" Decode.int
        |> required "name" Decode.string


statusCodesDecoder : Decode.Decoder StatusCodes
statusCodesDecoder =
    Decode.list statusCodeDecoder


statusCodeDecoder : Decode.Decoder StatusCode
statusCodeDecoder =
    decode StatusCode
        |> required "id" Decode.int
        |> required "step" Decode.int
        |> required "current_status" Decode.string
        |> required "next_action" Decode.string


mountingLocationsDecoder : Decode.Decoder MountingLocations
mountingLocationsDecoder =
    Decode.list mountingLocationDecoder


mountingLocationDecoder : Decode.Decoder MountingLocation
mountingLocationDecoder =
    decode MountingLocation
        |> required "id" Decode.int
        |> required "description" Decode.string


operatorsDecoder : Decode.Decoder Operators
operatorsDecoder =
    Decode.list operatorDecoder


operatorDecoder : Decode.Decoder Operator
operatorDecoder =
    decode Operator
        |> required "id" Decode.int
        |> required "name" Decode.string


statusLogDecoder : Decode.Decoder StatusLog
statusLogDecoder =
    Decode.list statusLogItemDecoder


statusLogItemDecoder : Decode.Decoder StatusLogItem
statusLogItemDecoder =
    decode StatusLogItem
        |> required "id" Decode.int
        |> required "sensor_id" Decode.int
        |> required "status_code_id" Decode.int
        |> required "operator_id" Decode.int
        |> required "time" Decode.string



-- END
