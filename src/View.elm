module View exposing (..)

import Models exposing (Model)
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (Msg)
import Views.Sensor.All
import Views.Sensor.New
import Views.PartNumber.All
import Views.PartNumber.New
import Views.Project.ById
import Views.Project.All
import Views.Project.New
import Views.Customer.ById
import Views.Customer.All
import Views.Customer.New
import Views.Customer.Registered
import Views.Operator.ById exposing (..)
import Views.Operator.All exposing (..)
import Views.Operator.New exposing (..)
import Views.SensorType.All
import Views.SensorType.New
import Views.MountingLocation.All
import Views.MountingLocation.New
import Views.Common.Oops exposing (..)
import Views.Log.All
import Routing
import RemoteData
import CommonComponents.Spinner


view : Model -> Html Msg
view model =
    div []
        [ nav [ class "navbar navbar-expand-lg navbar-light bg-dark text-light" ]
            [ div [ id "icon-container" ] [ a [ class "navbar-brand" ] [ img [ src "assets/immortal.png" ] [] ] ]
            , a [ class "nav-link text-light", href Routing.getIndexPath ] [ text "ALL" ]
            , button
                [ class "navbar-toggler"
                , attribute "data-toggle" "collapse"
                , attribute "data-target" "#navbarSupportedContent"
                , attribute "aria-controls" "navbarSupportedContent"
                , attribute "aria-expanded" "false"
                , attribute "aria-label" "Toggle navigation"
                ]
                [ span [ class "navbar-toggler-icon" ] []
                ]
            , div [ class "collapse navbar-collapse", id "navbarSupportedContent" ]
                [ ul [ class "navbar-nav mr-auto woldenNavbarLeft" ]
                    [ li [ class "nav-item active" ]
                        [ a [ class "nav-link text-light", href Routing.getProjectsPath ] [ text "Projects" ] ]
                    , li [ class "nav-item active" ]
                        [ a [ class "nav-link text-light", href Routing.getCustomersPath ] [ text "Customers" ] ]
                    , li [ class "nav-item active" ]
                        [ a [ class "nav-link text-light", href Routing.getPartNumberPath ] [ text "PNs" ] ]
                    , li [ class "nav-item active" ]
                        [ a [ class "nav-link text-light", href Routing.getOperatorsPath ] [ text "Operators" ] ]
                    , li [ class "nav-item active" ]
                        [ a [ class "nav-link text-light", href Routing.getSensorTypesPath ] [ text "Types" ] ]

                    -- , li [ class "nav-item active" ]
                    --     [ a [ class "nav-link text-light", href Routing.getIndexPath ] [ text "Codes" ] ]
                    , li [ class "nav-item active" ]
                        [ a [ class "nav-link text-light", href Routing.getMountingLocationsPath ] [ text "Mounting" ] ]
                    , li [ class "nav-item active" ]
                        [ a [ class "nav-link text-light", href Routing.getLogPath ] [ text "Log" ] ]
                    ]
                ]
            ]
        , div [ id "page" ]
            [ page model
            ]
        , div [ class "push-to-bottom jumbotron" ]
            [ p [] [ text "asdf" ] -- (toString model.db) ]
            , p [] [ text (toString model.new_sensor) ]
            ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.Home ->
            div []
                [ p [] []
                , Views.Sensor.All.insertSensorTable model
                ]

        Models.Index ->
            div [ class "col-10" ]
                [ h3 [] [ text " List of Sensors" ]
                , p [] []
                , Views.Sensor.All.insertSensorTable model
                ]

        -- Sensor new
        Models.SensorsNewRoute ->
            div []
                [ h3 [] [ text "New Sensor" ]
                , Views.Sensor.New.viewNewSensorPage model
                ]

        -- PartNumbers
        Models.PartNumbersRoute ->
            div []
                [ h3 [] [ text "Part Numbers" ]
                , Views.PartNumber.All.viewAllPartNumbers model.db.part_numbers
                ]

        Models.PartNumbersNewRoute ->
            Views.PartNumber.New.viewNewPartNumber model

        -- Project
        Models.ProjectsRoute ->
            div []
                [ h3 [] [ text "Projects" ]
                , Views.Project.All.viewAllProjects model.db.projects model.db.customers
                ]

        Models.ProjectRoute idString ->
            Views.Project.ById.viewProjectById model.db.projects idString

        Models.ProjectNewRoute ->
            Views.Project.New.viewNewProject model

        -- Customer
        Models.CustomersRoute ->
            div []
                [ h3 [] [ text "Customers" ]
                , Views.Customer.All.viewAllCustomers model.db.customers
                ]

        Models.CustomerRoute idString ->
            Views.Customer.ById.viewCustomerById model.db.customers idString

        Models.CustomerNewRoute ->
            Views.Customer.New.viewNewCustomer model

        Models.CustomerNewRegisteredRoute ->
            Views.Customer.Registered.viewRegistered model

        -- Operator
        Models.OperatorsRoute ->
            div []
                [ h3 [] [ text "Operators" ]
                , Views.Operator.All.viewAllOperators model.db.operators
                ]

        Models.OperatorRoute idString ->
            Views.Operator.ById.viewOperatorById model.db.operators idString

        Models.OperatorNewRoute ->
            Views.Operator.New.viewNewOperator model

        Models.NotFoundRoute ->
            text "Not Found Route"

        Models.OopeSomethingWentWrongRoute ->
            Views.Common.Oops.viewOops

        -- Sensor types
        Models.SensorTypesRoute ->
            div []
                [ h3 [] [ text "Sensor Types" ]
                , Views.SensorType.All.viewAllSensorTypes model.db.sensor_types
                ]

        Models.SensorTypesNewRoute ->
            Views.SensorType.New.viewNewSensorType model

        -- Mounting MountingLocationsRoute
        Models.MountingLocationsRoute ->
            div []
                [ h3 [] [ text "Mounting Locations" ]
                , Views.MountingLocation.All.viewMountingLocationAll model
                ]

        Models.MountingLocationsNewRoute ->
            Views.MountingLocation.New.viewMountingLocationNewForm model

        -- Status Logg
        Models.StatusLog ->
            case model.db.status_log of
                RemoteData.NotAsked ->
                    CommonComponents.Spinner.insertSpinner

                RemoteData.Loading ->
                    CommonComponents.Spinner.insertSpinner

                RemoteData.Failure error ->
                    CommonComponents.Spinner.insertSpinner

                RemoteData.Success status_log ->
                    Views.Log.All.viewLog status_log



-- END
