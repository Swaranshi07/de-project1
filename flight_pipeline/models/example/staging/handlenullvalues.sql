{{ config(
    materialized='table',
    schema='staging'
) }}

  

SELECT 
    * EXCLUDE (
        flight_status,
        airline_iata, airline_icao, airline_name,
        arrival_airport, arrival_iata, arrival_icao, arrival_terminal,
        arrival_gate, arrival_baggage, arrival_timezone,
        departure_airport, departure_iata, departure_icao, departure_terminal,
        departure_gate, departure_timezone,
        flight_airline_iata, flight_airline_icao, flight_airline_name,
        flight_iata, flight_icao, flight_number
    ),

    IFNULL(flight_status, 'unknown') AS flight_status,

    IFNULL(airline_iata, 'unknown') AS airline_iata,
    IFNULL(airline_icao, 'unknown') AS airline_icao,
    IFNULL(airline_name, 'unknown') AS airline_name,

    IFNULL(arrival_airport, 'unknown') AS arrival_airport,
    IFNULL(arrival_iata, 'unknown') AS arrival_iata,
    IFNULL(arrival_icao, 'unknown') AS arrival_icao,
    IFNULL(arrival_terminal, 'unknown') AS arrival_terminal,
    IFNULL(arrival_gate, 'unknown') AS arrival_gate,
    IFNULL(arrival_baggage, 'unknown') AS arrival_baggage,
    IFNULL(arrival_timezone, 'unknown') AS arrival_timezone,

    IFNULL(departure_airport, 'unknown') AS departure_airport,
    IFNULL(departure_iata, 'unknown') AS departure_iata,
    IFNULL(departure_icao, 'unknown') AS departure_icao,
    IFNULL(departure_terminal, 'unknown') AS departure_terminal,
    IFNULL(departure_gate, 'unknown') AS departure_gate,
    IFNULL(departure_timezone, 'unknown') AS departure_timezone,

    IFNULL(flight_airline_iata, 'unknown') AS flight_airline_iata,
    IFNULL(flight_airline_icao, 'unknown') AS flight_airline_icao,
    IFNULL(flight_airline_name, 'unknown') AS flight_airline_name,
    IFNULL(flight_iata, 'unknown') AS flight_iata,
    IFNULL(flight_icao, 'unknown') AS flight_icao,
    IFNULL(flight_number, 'unknown') AS flight_number

FROM {{ ref('selected_columns') }}


