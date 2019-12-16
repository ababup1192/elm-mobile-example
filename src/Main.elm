module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (attribute, class, type_, value)
import Html.Events exposing (onInput)
import Svg as Svg
import Svg.Attributes as SvgAttr


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { searchWord : String }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { searchWord = ""
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = UpdateSearchWord String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateSearchWord searchWord ->
            ( { model | searchWord = searchWord }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ searchView model.searchWord
        , div [ class "UUbT9" ]
            [ ul [ class "aajZCb" ]
                [ li [ class "sbct" ]
                    [ div [ class "sbic sb42" ]
                        []
                    , div [ class "sbtc" ]
                        [ div [ class "sbl1" ]
                            [ span []
                                [ text "test                                "
                                , b []
                                    [ text "test" ]
                                ]
                            ]
                        ]
                    , div [ class "sbei" ]
                        []
                    , div [ class "sbab" ]
                        [ span [ class "sbqa" ]
                            [ text "x" ]
                        ]
                    ]
                , li [ class "sbct" ]
                    [ div [ class "sbic sb43" ]
                        []
                    , div [ class "sbtc" ]
                        [ div [ class "sbl1" ]
                            [ span []
                                [ text "test                                "
                                , b []
                                    [ text "test" ]
                                ]
                            ]
                        ]
                    , div [ class "sbei" ]
                        []
                    , div [ class "sbab" ]
                        [ div [ class "sbqb" ]
                            []
                        ]
                    ]
                ]
            ]
        ]


searchView : String -> Html Msg
searchView searchWord =
    div [ class "search" ]
        [ button [ class "Cdl0yb", type_ "button" ]
            [ div []
                [ span []
                    [ Svg.svg [ attribute "focusable" "false", SvgAttr.viewBox "0 0 24 24", attribute "xmlns" "http://www.w3.org/2000/svg" ]
                        [ Svg.path [ SvgAttr.d "M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" ]
                            []
                        ]
                    ]
                ]
            ]
        , div [ class "SDkEP" ]
            [ div [ class "a4bIc" ]
                [ input [ value searchWord, onInput UpdateSearchWord, attribute "autocapitalize" "off", attribute "autocomplete" "off", class "gLFyf", attribute "maxlength" "2048", type_ "search" ]
                    []
                ]
            ]
        , button [ class "Tg7LZd" ]
            [ div [ class "gBCQ5d" ]
                [ span [ class "z1asCe" ]
                    [ Svg.svg [ attribute "focusable" "false", SvgAttr.viewBox "0 0 24 24", attribute "xmlns" "http://www.w3.org/2000/svg" ]
                        [ Svg.path [ SvgAttr.d "M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z" ]
                            []
                        ]
                    ]
                ]
            ]
        ]
