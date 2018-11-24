import Browser
import Html exposing (Html, Attribute, div, input, text, textarea, button, h3)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Http
import Json.Decode as D
import Json.Encode as E

-- MAIN


main =
  Browser.element
      { init = init
      , update = update
      , view = view
      , subscriptions = subscriptions
      }



-- MODEL


type alias Model =
  { coordinates : String
  , signature : String
  , address : String              
  , transactionId : String
  , southwestX : String
  , southwestY : String
  , northeastX : String
  , northeastY : String
  }


type alias User =
    { coordinates : String
    , signature : String
    , address : String
    }


type alias Transaction =
    { transactionId : String
    , southwestX : String
    , southwestY : String
    , northeastX : String
    , northeastY : String
    }


-- JSON


userEncode : User -> E.Value
userEncode user =
    E.object
        [ ("user", E.object
               [ ("coordinates", E.string user.coordinates)
               , ("signature", E.string user.signature)
               , ("address", E.string user.address)
               ]
          )
        ]
              
postUser : Model -> Cmd Msg
postUser model =
    let
        body =
            { coordinates = model.coordinates
            , signature = model.signature
            , address = model.address
            }
    in
    Http.post
        { url = "/api/users"
        , body = Http.jsonBody (userEncode body)
        , expect = Http.expectString PostUser
        }

transactionEncode : Transaction -> E.Value
transactionEncode transaction =
    E.object
        [ ( "transaction", E.object
                               [ ("transactionId", E.string transaction.transactionId)
                               , ("southwestX", E.string transaction.southwestX)
                               , ("southwestY", E.string transaction.southwestY)
                               , ("northeastX", E.string transaction.northeastX)
                               , ("northeastY", E.string transaction.northeastY)
                               ]
          )
        ]

postTransaction : Model -> Cmd Msg
postTransaction model =
    let
        body =
           { transactionId = model.transactionId
           , southwestX = model.southwestX
           , southwestY = model.southwestY
           , northeastX = model.northeastX
           , northeastY = model.northeastY
           }
    in
        Http.post
            { url = "/api/transactions"
            , body = Http.jsonBody (transactionEncode body)
            , expect = Http.expectString PostTransaction
            }
    
init : () -> (Model, Cmd Msg)
init _=
  ( { coordinates = ""
    , signature = ""
    , address = ""
    , transactionId = ""
    , southwestX = ""
    , southwestY = ""
    , northeastX = ""
    , northeastY = ""
    }
  , Cmd.none
  )

    
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none    


-- UPDATE


type Msg
  = Coordinates String
  | Signature String
  | Address String
  | RegisterLocation
  | PostUser (Result Http.Error String)
  | TransactionId String
  | SouthwestX String
  | SouthwestY String
  | NortheastX String
  | NortheastY String
  | RainDoge
  | PostTransaction (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
  case msg of
    Coordinates newCoordinates ->
      ( { model | coordinates = newCoordinates }, Cmd.none )

    Address newAddress ->
      ( { model | address = newAddress }, Cmd.none )

    Signature newSignature ->
      ( { model | signature = newSignature }, Cmd.none )

    RegisterLocation ->
        ( model, postUser model )

    PostUser (Ok _) ->
        ( model, Cmd.none )

    PostUser (Err _) ->
        ( model, Cmd.none )

    TransactionId newId ->
      ( { model | transactionId = newId }, Cmd.none )

    SouthwestX x ->
      ( { model | southwestX = x }, Cmd.none )

    SouthwestY y ->
      ( { model | southwestY = y }, Cmd.none )

    NortheastX x ->
      ( { model | northeastX = x }, Cmd.none )

    NortheastY y ->
      ( { model | northeastY = y }, Cmd.none )

    RainDoge ->
        ( model, postTransaction model )

    PostTransaction (Ok _) ->
        ( model, Cmd.none )

    PostTransaction (Err _) ->
        ( model, Cmd.none )


-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ addressRegistryView model
        , rainDogeView model
        ]

addressRegistryView: Model -> Html Msg
addressRegistryView model =
  div []
    [ h3 [] [ text "Register Coordinates with Address:" ]
    , div [] [ input [ placeholder "Dogecoin Address", value model.address, onInput Address ] [] ]
    , div [] [ input [ placeholder "Coordinates", value model.coordinates, onInput Coordinates ] [] ]
    , div [] [ input [ placeholder "Signature", value model.signature, onInput Signature ] [] ]
    , div [] [ button [ onClick RegisterLocation ] [ text "Register Location" ] ]
    ]

rainDogeView: Model -> Html Msg
rainDogeView model =
    div []
        [ h3 [] [ text "Rain doge: " ]
        , div [] [ input [ placeholder "Transaction ID", value model.transactionId, onInput TransactionId ] [] ]
        , div []
            [ h3 [] [ text "Southwest Corner:" ]
            , div [] [ input [ placeholder "42.4222", value model.southwestX, onInput SouthwestX ] [] ]
            , div [] [ input [ placeholder "123.456", value model.southwestY, onInput SouthwestY ] [] ]
            ]
        , div []
            [ h3 [] [ text "Northeast Corner:" ]
            , div [] [ input [ placeholder "42.4222", value model.northeastX, onInput NortheastX ] [] ]
            , div [] [ input [ placeholder "42.123.456", value model.northeastY, onInput NortheastY ] [] ]
            ]
        , div [] [ button [ onClick RainDoge ] [ text "Rain Doge" ] ]
        ]
