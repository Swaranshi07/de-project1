{{ config(
    materialized='table',
    schema='staging'
) }}


select flight_date,
flight_status,
airline_iata,
airline_icao,
airline_name,

arrival_airport,
arrival_iata,
arrival_icao,
arrival_terminal,
arrival_gate,
arrival_baggage,
arrival_delay,
arrival_scheduled,
arrival_timezone,

departure_airport,
departure_iata,departure_icao,
departure_terminal,departure_gate,
departure_delay,departure_scheduled,departure_timezone,

flight_airline_iata,
flight_airline_icao,
flight_airline_name,
flight_iata,
flight_icao,
flight_number

from {{ ref('fetch_data') }}

