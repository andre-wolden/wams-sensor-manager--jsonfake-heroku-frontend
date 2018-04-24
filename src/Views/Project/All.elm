module Views.Project.All exposing (..)

import Db.DbModels exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (..)
import RemoteData exposing (WebData)
import CommonComponents.ErrorSymbol
import CommonComponents.Spinner
import Routing


viewAllProjects : WebData Projects -> WebData Customers -> Html Msg
viewAllProjects projects customers =
    case projects of
        RemoteData.NotAsked ->
            CommonComponents.Spinner.insertSpinner

        RemoteData.Loading ->
            CommonComponents.Spinner.insertSpinner

        RemoteData.Failure error ->
            div []
                [ CommonComponents.ErrorSymbol.insertErrorSymbol
                , CommonComponents.Spinner.insertSpinner
                , text ("Failed to retrieve data. Error message: " ++ (toString error))
                ]

        RemoteData.Success projects ->
            case customers of
                RemoteData.NotAsked ->
                    CommonComponents.Spinner.insertSpinner

                RemoteData.Loading ->
                    CommonComponents.Spinner.insertSpinner

                RemoteData.Failure error ->
                    div []
                        [ CommonComponents.ErrorSymbol.insertErrorSymbol
                        , text ("Failed to retrieve data. Error message: " ++ (toString error))
                        ]

                RemoteData.Success customers ->
                    div []
                        [ getProjectsTable projects customers
                        ]


getProjectsTable : Projects -> Customers -> Html Msg
getProjectsTable projects customers =
    div [ class "container" ]
        [ table [ class "table" ]
            [ thead []
                [ tr [ class "row" ]
                    [ th [ class "col" ] [ text "Project" ]
                    , th [ class "col" ] [ text "Customer" ]
                    ]
                ]
            , tbody [] (insertRows projects customers)
            ]
        , a [ class "btn btn-success", href Routing.getProjectNewRoute ] [ text "Add new project" ]
        ]


insertRows : Projects -> Customers -> List (Html Msg)
insertRows projects customers =
    (List.map
        (\p ->
            tr [ class "row" ]
                [ td [ class "col" ] [ text p.name ]
                , td [ class "col" ]
                    (List.map
                        (\c ->
                            if c.id == p.customer then
                                text c.name
                            else
                                text ""
                        )
                        customers
                    )
                ]
        )
        projects
    )



-- End
