module ReactorCtrl exposing (main)

import Reactor
import Turbine
import Html exposing (Html, h1, div, text, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    { reactor : Reactor.Model
    , turbines : List Turbine.Model
    }


model : Model
model =
    { reactor = Reactor.initModel
    , turbines = [ Turbine.initModel, (Turbine.setId 1 Turbine.initModel) ]
    }


type Msg
    = TurbineMsg Int Turbine.Msg
    | ReactorMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TurbineMsg ident subMsg ->
            case (get ident model.turbines) of
                Nothing ->
                    ( model, Cmd.none )

                Just t ->
                    let
                        result =
                            changeAt (Turbine.update subMsg) ident model.turbines
                    in
                        case result of
                            Ok t ->
                                ( { model | turbines = t }, Cmd.none )

                            Err _ ->
                                ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )


get : Int -> List a -> Maybe a
get index list =
    case list of
        [] ->
            Nothing

        x :: xs ->
            if index == 0 then
                Just x
            else
                get (index - 1) xs


changeAt : (a -> a) -> Int -> List a -> Result String (List a)
changeAt f i l =
    if i < 0 then
        Err "Negative Index"
    else
        case l of
            [] ->
                Err "Index out of bounds"

            x :: xs ->
                if i == 0 then
                    Ok <| f x :: xs
                else
                    Result.map ((::) x) <| changeAt f (i - 1) xs


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Hello World!" ]
        , turbineContainer model
        ]


turbineContainer : Model -> Html Msg
turbineContainer model =
    div [ class "turbinecontainer" ]
        (model.turbines |> List.map wrappedTurbine)


wrappedTurbine : Turbine.Model -> Html Msg
wrappedTurbine model =
    div []
        [ Html.map (TurbineMsg model.id) <| Turbine.view model ]


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , init = ( model, Cmd.none )
        }
