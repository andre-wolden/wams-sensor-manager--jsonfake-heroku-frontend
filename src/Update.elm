module Update exposing (..)

import Models exposing (..)
import Messages exposing (Msg)
import Routing exposing (parseLocation)
import Commands
import Commands.SensorCommands
import Commands.PartNumberCommands
import Commands.ProjectCommands
import Commands.CustomerCommands
import Commands.OperatorCommands
import Commands.MountingLocationCommands
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Messages.NoOp ->
            ( model, Cmd.none )

        Messages.OnLocationChange location ->
            ( { model
                | route = parseLocation location
                , debugMessage = (toString (parseLocation location))
              }
            , Cmd.none
            )

        -- SensorDbresponses
        Messages.SensorsResponse response ->
            let
                oldDb =
                    model.db

                newDb =
                    { oldDb | sensors = response }
            in
                ( { model | db = newDb }, Cmd.none )

        Messages.PartNumbersResponse response ->
            let
                oldDb =
                    model.db

                newDb =
                    { oldDb | part_numbers = response }
            in
                ( { model | db = newDb }, Cmd.none )

        Messages.SensorTypesResponse response ->
            let
                oldDb =
                    model.db

                newDb =
                    { oldDb | sensor_types = response }
            in
                ( { model | db = newDb }, Cmd.none )

        Messages.ProjectsResponse response ->
            let
                oldDb =
                    model.db

                newDb =
                    { oldDb | projects = response }
            in
                ( { model | db = newDb }, Cmd.none )

        Messages.CustomersResponse response ->
            let
                oldDb =
                    model.db

                newDb =
                    { oldDb | customers = response }
            in
                ( { model | db = newDb }, Cmd.none )

        Messages.StatusCodesResponse response ->
            let
                oldDb =
                    model.db

                newDb =
                    { oldDb | status_codes = response }
            in
                ( { model | db = newDb }, Cmd.none )

        Messages.MountingLocationsResponse response ->
            let
                oldDb =
                    model.db

                newDb =
                    { oldDb | mounting_locations = response }
            in
                ( { model | db = newDb }, Cmd.none )

        Messages.OperatorsResponse response ->
            let
                oldDb =
                    model.db

                newDb =
                    { oldDb | operators = response }
            in
                ( { model | db = newDb }, Cmd.none )

        Messages.StatusLogResponse response ->
            let
                oldDb =
                    model.db

                newDb =
                    { oldDb | status_log = response }
            in
                ( { model | db = newDb }, Cmd.none )

        -- Sensors
        Messages.OnInputNewSensor_sn sn ->
            let
                current =
                    model.new_sensor

                updated =
                    { current | sn = sn }
            in
                ( { model | new_sensor = updated }, Cmd.none )

        Messages.OnInputNewSensor_pn pn ->
            let
                current =
                    model.new_sensor

                updated =
                    { current | pn = pn }
            in
                ( { model | new_sensor = updated }, Cmd.none )

        Messages.OnInputNewSensor_sensor_type sensor_type ->
            let
                current =
                    model.new_sensor

                updated =
                    { current | sensor_type = sensor_type }
            in
                ( { model | new_sensor = updated }, Cmd.none )

        Messages.OnInputNewSensor_calibration_certificate cc ->
            let
                current =
                    model.new_sensor

                updated =
                    { current | calibration_certificate = cc }
            in
                ( { model | new_sensor = updated }, Cmd.none )

        Messages.OnInputNewSensor_project project ->
            let
                current =
                    model.new_sensor

                updated =
                    { current | project = project }
            in
                ( { model | new_sensor = updated }, Cmd.none )

        Messages.OnInputNewSensor_mounting_location mounting_location ->
            let
                current =
                    model.new_sensor

                updated =
                    { current | mounting_location = mounting_location }
            in
                ( { model | new_sensor = updated }, Cmd.none )

        Messages.SaveNewSensor sensor ->
            ( model, Commands.SensorCommands.saveSensor sensor )

        Messages.OnSensorSaved (Ok sensor) ->
            ( { model | route = Index }, Commands.fetchSensorsData )

        Messages.OnSensorSaved (Err error) ->
            ( model, Cmd.none )

        -- PartNumber
        Messages.OnInputNewPartNumber_PartNumber string ->
            let
                part_number =
                    model.new_part_number

                updated_new_part_number =
                    { part_number | pn = string }
            in
                ( { model | new_part_number = updated_new_part_number }, Cmd.none )

        Messages.OnInputNewPartNumber_CalibrationProcedure string ->
            let
                part_number =
                    model.new_part_number

                updated_new_part_number =
                    { part_number | calibration_procedure = string }
            in
                ( { model | new_part_number = updated_new_part_number }, Cmd.none )

        Messages.SaveNewPartNumber new_partnumber ->
            ( { model
                | debugMessage = (new_partnumber.pn)
                , route = PartNumbersRoute
              }
            , Commands.PartNumberCommands.savePartNumber new_partnumber
            )

        Messages.OnPartNumberSaved (Ok response) ->
            ( { model
                | debugMessage = (toString response)
                , route = PartNumbersRoute
              }
            , Commands.fetchPartNumbersData
            )

        Messages.OnPartNumberSaved (Err error) ->
            ( { model | debugMessage = (toString error) }, Cmd.none )

        -- Project
        Messages.OnInputNewProject_Name updated_name ->
            let
                old =
                    model.new_project

                updated =
                    { old | name = updated_name }
            in
                ( { model | new_project = updated, debugMessage = updated_name }, Cmd.none )

        Messages.OnInputNewProject_CustomerId int ->
            let
                old =
                    model.new_project

                updated =
                    { old | customer = int }
            in
                ( { model | new_project = updated }, Cmd.none )

        Messages.SaveNewProject project ->
            ( { model | debugMessage = (project.name) }, Commands.ProjectCommands.saveProject project )

        Messages.OnProjectSaved (Ok response) ->
            ( { model | route = ProjectsRoute }, Commands.fetchProjectsData )

        Messages.OnProjectSaved (Err error) ->
            ( model, Cmd.none )

        -- Customer
        Messages.OnInputNewCustomer_Name updated_name ->
            let
                old =
                    model.new_customer

                updated =
                    { old | name = updated_name }
            in
                ( { model | new_customer = updated, debugMessage = updated_name }, Cmd.none )

        Messages.SaveNewCustomer customer ->
            ( { model
                | debugMessage = (customer.name)
                , route = CustomersRoute
              }
            , Commands.CustomerCommands.saveCustomer customer
            )

        Messages.OnCustomerSaved (Ok response) ->
            ( { model
                | debugMessage = (toString response)
                , route = CustomersRoute
              }
            , Commands.fetchCustomersData
            )

        Messages.OnCustomerSaved (Err error) ->
            ( { model | route = OopeSomethingWentWrongRoute }
            , Cmd.none
            )

        Messages.NewCustomerRegistered ->
            ( { model | route = CustomerNewRegisteredRoute }, Cmd.none )

        -- Operator
        Messages.OnInputNewOperator_Name updated_name ->
            let
                old =
                    model.new_operator

                updated =
                    { old | name = updated_name }
            in
                ( { model | new_operator = updated, debugMessage = updated_name }, Cmd.none )

        Messages.SaveNewOperator operator ->
            ( { model | debugMessage = (operator.name) }, Commands.OperatorCommands.saveOperator operator )

        Messages.OnOperatorSaved (Ok response) ->
            ( { model | route = OperatorsRoute }, Commands.fetchOperatorsData )

        Messages.OnOperatorSaved (Err error) ->
            ( model, Cmd.none )

        -- Mounting Locations
        Messages.OnInputMountingLocation string ->
            let
                current =
                    model.new_mounting_location

                updated =
                    { current | description = string }
            in
                ( { model | new_mounting_location = updated }, Cmd.none )

        Messages.SaveMountingLocation mounting_location ->
            ( model, Commands.MountingLocationCommands.saveMountingLocation mounting_location )

        Messages.OnMountingLocationSaved (Ok response) ->
            let
                current =
                    model.new_mounting_location

                updated =
                    { current | description = "" }
            in
                ( { model | new_mounting_location = updated }, Commands.fetchMountingLocationsData )

        Messages.OnMountingLocationSaved (Err error) ->
            ( model, Cmd.none )

        -- Sensor all view stuff
        Messages.ExpandRow int ->
            let
                updatedDebugMessage =
                    "Expanding row...?"
            in
                if model.expandedRow == int then
                    ( { model | expandedRow = 0 }, Cmd.none )
                else
                    ( { model | expandedRow = int }, Cmd.none )

        Messages.IncrementSensorStatus sensor ->
            let
                current =
                    sensor

                incremented =
                    { sensor | current_status = sensor.current_status + 1 }
            in
                ( model, Commands.SensorCommands.updateSensor incremented )

        Messages.DecrementSensorStatus sensor ->
            let
                current =
                    sensor

                decremented =
                    { sensor | current_status = sensor.current_status - 1 }
            in
                ( model, Commands.SensorCommands.updateSensor decremented )

        Messages.OnSensorUpdated (Ok response) ->
            ( { model | route = Index }, Commands.fetchSensorsData )

        Messages.OnSensorUpdated (Err error) ->
            ( model, Cmd.none )

        Messages.OnInputCalibrationCertificateName cc_name ->
            ( { model | calibration_certificate_name = cc_name }, Cmd.none )

        Messages.SaveCalibrationCertificate sensor ->
            let
                withCalibrationCertificate =
                    { sensor | calibration_certificate = model.calibration_certificate_name }
            in
                ( model, Commands.SensorCommands.updateSensor withCalibrationCertificate )



-- END
