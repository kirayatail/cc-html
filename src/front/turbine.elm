module Turbine exposing (Model, Msg, initModel, view, setLevel, setId, update)

import Html exposing (Html, div, text, input, button)
import Html.Events exposing (onInput, onClick)
import Html.Attributes as H exposing (..)


type TurbineStatus
    = Warmup
    | Idle
    | Active
    | Off
    | ActiveCooling


type Msg
    = SetLevel String
    | ToggleEnabled


type alias Model =
    { id : Int
    , outputEnabled : Bool
    , targetLevel : Int
    , steamWarn : Bool
    , status : TurbineStatus
    }


setLevel : String -> Model -> Model
setLevel v t =
    { t | targetLevel = String.toInt v |> Result.withDefault 0 }


setId : Int -> Model -> Model
setId nId t =
    { t | id = nId }


initModel : Model
initModel =
    { id = 0
    , outputEnabled = False
    , targetLevel = 0
    , steamWarn = False
    , status = Off
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetLevel levelStr ->
            setLevel levelStr model

        ToggleEnabled ->
            { model | outputEnabled = not model.outputEnabled }


view : Model -> Html Msg
view t =
    div [ H.id ("turbine-" ++ (toString t.id)) ] [ rpmSlider t, outputToggle t ]


rpmSlider : Model -> Html Msg
rpmSlider t =
    input
        [ type_ "range"
        , H.min "0"
        , H.max "2"
        , value <| toString t.targetLevel
        , onInput SetLevel
        ]
        []


outputToggle : Model -> Html Msg
outputToggle t =
    input
        [ type_ "button"
        , class ("output-" ++ (enableString t))
        , onClick ToggleEnabled
        , value (enableString t)
        ]
        []


enableString : Model -> String
enableString t =
    if t.outputEnabled then
        "On"
    else
        "Off"
