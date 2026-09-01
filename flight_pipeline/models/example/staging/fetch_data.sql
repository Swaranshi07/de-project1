{{ config(materialized='table', schema='staging') }}

with source as (
    select * from {{ source('flight_info', 'raw_flights') }}
)

select
    ar.value:flight_date::timestamp_ntz as flight_date,
    ar.value:flight_status::string as flight_status,
    ar.value:live::string as live,

    ar.value:aircraft:iata::string as aircraft_iata,
    ar.value:aircraft:icao::string as aircraft_icao,
    ar.value:aircraft:icao24::varchar as aircraft_icao24,
    ar.value:aircraft:registration::string as aircraft_registration,

    ar.value:airline:iata::string as airline_iata,
    ar.value:airline:icao::string as airline_icao,
    ar.value:airline:name::string as airline_name,

    ar.value:arrival:airport::string as arrival_airport,
    ar.value:arrival:iata::string as arrival_iata,
    ar.value:arrival:icao::string as arrival_icao,
    ar.value:arrival:terminal::string as arrival_terminal,
    ar.value:arrival:gate::string as arrival_gate,
    ar.value:arrival:baggage::string as arrival_baggage,
    ar.value:arrival:delay::integer as arrival_delay,
    ar.value:arrival:scheduled::timestamp_tz as arrival_scheduled,
    ar.value:arrival:estimated::timestamp_tz as arrival_estimated,
    ar.value:arrival:actual::timestamp_tz as arrival_actual,
    ar.value:arrival:timezone::string as arrival_timezone,
    ar.value:arrival:actual_runway::string as arrival_actual_runway,
    ar.value:arrival:estimated_runway::string as arrival_estimated_runway,

    ar.value:departure:airport::string as departure_airport,
    ar.value:departure:iata::string as departure_iata,
    ar.value:departure:icao::string as departure_icao,
    ar.value:departure:terminal::string as departure_terminal,
    ar.value:departure:gate::string as departure_gate,
    ar.value:departure:delay::integer as departure_delay,
    ar.value:departure:scheduled::timestamp_tz as departure_scheduled,
    ar.value:departure:estimated::timestamp_tz as departure_estimated,
    ar.value:departure:actual::timestamp_tz as departure_actual,
    ar.value:departure:timezone::string as departure_timezone,
    ar.value:departure:actual_runway::string as departure_actual_runway,
    ar.value:departure:estimated_runway::string as departure_estimated_runway,

    ar.value:flight:codeshared:airline_iata::string as flight_airline_iata,
    ar.value:flight:codeshared:airline_icao::string as flight_airline_icao,
    ar.value:flight:codeshared:airline_name::string as flight_airline_name,
    ar.value:flight:codeshared:flight_iata::string as flight_iata,
    ar.value:flight:codeshared:flight_icao::string as flight_icao,
    ar.value:flight:codeshared:flight_number::string as flight_number

from source s,
LATERAL FLATTEN(INPUT => s.raw_data:data) ar