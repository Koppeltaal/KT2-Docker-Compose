\connect domain_admin_dev
UPDATE public.smart_service
SET public_key = pg_read_file('/secrets/public.pem')
WHERE client_id = '552bfe09-3ea6-4bf8-9ecc-876276934aaa';
