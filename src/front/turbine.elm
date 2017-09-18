module Turbine exposing (Model, Msg, initModel, view, setTargetLevel, setId, update)

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
    , level : Int
    , steamWarn : Bool
    , status : TurbineStatus
    }


setTargetLevel : String -> Model -> Model
setTargetLevel v t =
    { t | targetLevel = String.toInt v |> Result.withDefault 0 }


setId : Int -> Model -> Model
setId nId t =
    { t | id = nId }


initModel : Model
initModel =
    { id = 0
    , outputEnabled = False
    , targetLevel = 0
    , level = 0
    , steamWarn = False
    , status = Off
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetLevel levelStr ->
            setTargetLevel levelStr model

        ToggleEnabled ->
            { model | outputEnabled = not model.outputEnabled }


view : Model -> Html Msg
view t =
    div [ H.id ("turbine-" ++ (toString t.id)), H.class "turbine-panel" ] [ levelIndicator t, rpmSlider t, outputToggle t ]


levelIndicator : Model -> Html Msg
levelIndicator t =
    div [] [ text ("Level: " ++ toString t.level) ]


rpmSlider : Model -> Html Msg
rpmSlider t =
    input
        [ type_ "range"
        , class "rpm-slider"
        , H.min "0"
        , H.max "3"
        , value <| toString t.targetLevel
        , onInput SetLevel
        ]
        []


outputToggle : Model -> Html Msg
outputToggle t =
    input
        [ type_ "button"
        , class ("output-btn output-" ++ (enableString t))
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
