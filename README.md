# planning

**Classe Planning**

Cette classe est conçue pour faciliter la création et la gestion des emplois du temps hebdomadaires. Elle permet aux utilisateurs de trouver des créneaux horaires disponibles au cours d'une semaine donnée tout en tenant compte des créneaux occupés préexistants.

### Exemple d'utilisation

`planning = Planning.new(busy_slots)`  --> création d'un objet planning avec le tableau des créneaux occupés.
` wanted_hour = 2` --> nombre d'heures souhaitées pour trouver un créneau disponible.
` available_slots = planning.find_available_slots(wanted_hour)` 
` puts available_slots` ` 
