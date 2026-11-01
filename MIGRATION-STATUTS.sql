-- GVI International : migration des anciens statuts vers les 3 statuts essentiels
-- À exécuter une seule fois dans Supabase > SQL Editor.
-- La provenance est déjà enregistrée dans la colonne public.parcels.origin.

UPDATE public.parcels
SET status = CASE
  WHEN status IN ('Livré', 'Récupéré', 'Arrivé à destination') THEN 'Livré'
  WHEN status = 'En transit' THEN 'En transit'
  ELSE 'Réceptionné'
END
WHERE status NOT IN ('Réceptionné', 'En transit', 'Livré');

-- Vérification du résultat
SELECT status, COUNT(*) AS nombre_colis
FROM public.parcels
GROUP BY status
ORDER BY status;
