(define (problem transport-valuable-cargo-numeric)
    (:domain mprime-strips)

    (:objects
        ; Luoghi
        rome milan - location

        ; Veicoli e Carico
        truck1 - vehicle
        package1 - cargo

        ; Risorse (Fuel e Space sono tipi di risorse nel dominio)
        fuel_rome - fuel
        space_rome space_milan - space-resource
    )

    (:init
        ; --- Posizioni Iniziali ---
        (vehicle-at truck1 rome)
        (cargo-at package1 rome)

        ; --- Assegnazione Risorse ai Luoghi ---
        (at-location fuel_rome rome)
        (at-location space_rome rome)
        (at-location space_milan milan)

        ; --- Definizioni Numeriche (Fluents) ---
        
        ; Dimensioni del pacco
        (= (size package1) 1)

        ; Stato del Carburante
        ; Il dominio richiede >= 10 per fare rifornimento.
        (= (amount fuel_rome) 11)
        ; Il camion parte vuoto (o con poco carburante)
        (= (fuel-level truck1) 0)

        ; Stato dello Spazio (Space Resource)
        ; Load aumenta l'amount -> Roma può partire da 0
        (= (amount space_rome) 0)
        
        ; Unload diminuisce l'amount e richiede amount >= size.
        ; Affinché si possa scaricare a Milano, deve esserci "spazio" (valore risorsa) sufficiente.
        (= (amount space_milan) 5) 
    )

    (:goal
        (and
            ; L'obiettivo è che il pacco sia a Milano
            (cargo-at package1 milan)
        )
    )
)