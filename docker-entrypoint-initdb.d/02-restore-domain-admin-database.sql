--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
--
-- Database "domain_admin_dev" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7
-- Dumped by pg_dump version 14.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: domain_admin_dev; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE domain_admin_dev WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE domain_admin_dev OWNER TO postgres;

\connect domain_admin_dev

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: crudoperation; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.crudoperation AS ENUM (
    'CREATE',
    'READ',
    'UPDATE',
    'DELETE'
);


ALTER TYPE public.crudoperation OWNER TO postgres;

--
-- Name: permissionscope; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.permissionscope AS ENUM (
    'ALL',
    'OWN',
    'GRANTED'
);


ALTER TYPE public.permissionscope OWNER TO postgres;

--
-- Name: smartservicestatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.smartservicestatus AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);


ALTER TYPE public.smartservicestatus OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    id uuid NOT NULL,
    created_by character varying(255),
    created_on timestamp without time zone,
    client_id character varying(255),
    client_secret character varying(255),
    name character varying(255),
    openid_config_endpoint character varying(255),
    username_attribute character varying(255)
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: oauth2_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth2_session (
    id uuid NOT NULL,
    type character varying(80),
    scope text,
    code_challenge text,
    code_challenge_method character varying(128),
    response_type character varying(16),
    client_id character varying(80),
    redirect_uri character varying(128),
    state text,
    launch text,
    aud character varying(128),
    identity_provider uuid,
    user_fhir_reference character varying(80),
    code character varying(80) NOT NULL
);


ALTER TABLE public.oauth2_session OWNER TO postgres;

--
-- Name: oauth2_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oauth2_token (
    id uuid NOT NULL,
    client_id character varying(80),
    access_token text,
    refresh_token text,
    id_token character varying(2048),
    scope text,
    subject character varying(128),
    session_id uuid
);


ALTER TABLE public.oauth2_token OWNER TO postgres;

--
-- Name: permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permission (
    id uuid NOT NULL,
    created_by character varying(255),
    created_on timestamp without time zone,
    operation character varying(255),
    resource_type character varying(255),
    scope character varying(255),
    role_id uuid NOT NULL
);


ALTER TABLE public.permission OWNER TO postgres;

--
-- Name: permission_service_grant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permission_service_grant (
    permission_id uuid NOT NULL,
    smart_service_id uuid NOT NULL
);


ALTER TABLE public.permission_service_grant OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id uuid NOT NULL,
    created_by character varying(255),
    created_on timestamp without time zone,
    name character varying(255)
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: smart_service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.smart_service (
    id uuid NOT NULL,
    created_by character varying(255),
    created_on timestamp without time zone,
    client_id character varying(255),
    fhir_store_device_id character varying(255),
    jwks_endpoint character varying(255),
    name character varying(255),
    public_key character varying(512),
    status character varying(255),
    patient_idp uuid,
    practitioner_idp uuid,
    role_id uuid
);


ALTER TABLE public.smart_service OWNER TO postgres;

--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (id, created_by, created_on, client_id, client_secret, name, openid_config_endpoint, username_attribute) FROM stdin;
\.


--
-- Data for Name: oauth2_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth2_session (id, type, scope, code_challenge, code_challenge_method, response_type, client_id, redirect_uri, state, launch, aud, identity_provider, user_fhir_reference, code) FROM stdin;
\.


--
-- Data for Name: oauth2_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oauth2_token (id, client_id, access_token, refresh_token, id_token, scope, subject, session_id) FROM stdin;
a828b4b9-6f1b-4bcb-9c40-033cbeb187ad	980c7e60-0170-449d-8e88-19baaa020b63	eyJraWQiOiJTSXdjVmxfMGZVY1dSZno0X1hSLWcwTzlFTXZBaHNTWWdEVS1Vdm1KMzJVIiwiYWxnIjoiUlM1MTIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwOi8vYXV0aC1zZXJ2aWNlOjUwMDAvIiwiYXVkIjoiZmhpci1zZXJ2ZXIiLCJpYXQiOjE2ODY1NzM0NzgsIm5iZiI6MTY4NjU3MzQ3OCwiZXhwIjoxNjg2NTczNzc4LCJqdGkiOiJjOWY2OGJkMC0zYzNjLTQ2OGEtYjU2Ni1lY2UxYzBjZmY0ZGEiLCJ0eXBlIjoiYWNjZXNzIiwic2NvcGUiOiJzeXN0ZW0vTG9jYXRpb24uY3J1ZHMgc3lzdGVtL01lZGljYXRpb25TdGF0ZW1lbnQuY3J1ZHMgc3lzdGVtL0VwaXNvZGVPZkNhcmUuY3J1ZHMgc3lzdGVtL0FjdGl2aXR5RGVmaW5pdGlvbi5jcnVkcyBzeXN0ZW0vQXVkaXRFdmVudC5jcnVkcyBzeXN0ZW0vQ29udHJhY3QuY3J1ZHMgc3lzdGVtL0J1bmRsZS5jcnVkcyBzeXN0ZW0vT3JnYW5pemF0aW9uQWZmaWxpYXRpb24uY3J1ZHMgc3lzdGVtL09ic2VydmF0aW9uRGVmaW5pdGlvbi5jcnVkcyBzeXN0ZW0vUmVzZWFyY2hTdHVkeS5jcnVkcyBzeXN0ZW0vUmVzZWFyY2hTdWJqZWN0LmNydWRzIHN5c3RlbS9FZmZlY3RFdmlkZW5jZVN5bnRoZXNpcy5jcnVkcyBzeXN0ZW0vU3BlY2ltZW5EZWZpbml0aW9uLmNydWRzIHN5c3RlbS9NZWRpY2F0aW9uLmNydWRzIHN5c3RlbS9CaW9sb2dpY2FsbHlEZXJpdmVkUHJvZHVjdC5jcnVkcyBzeXN0ZW0vSW1wbGVtZW50YXRpb25HdWlkZS5jcnVkcyBzeXN0ZW0vU2VydmljZVJlcXVlc3QuY3J1ZHMgc3lzdGVtL1NwZWNpbWVuLmNydWRzIHN5c3RlbS9NZWRpY2luYWxQcm9kdWN0TWFudWZhY3R1cmVkLmNydWRzIHN5c3RlbS9TdHJ1Y3R1cmVEZWZpbml0aW9uLmNydWRzIHN5c3RlbS9DbGFpbVJlc3BvbnNlLmNydWRzIHN5c3RlbS9WYWx1ZVNldC5jcnVkcyBzeXN0ZW0vSGVhbHRoY2FyZVNlcnZpY2UuY3J1ZHMgc3lzdGVtL1N0cnVjdHVyZU1hcC5jcnVkcyBzeXN0ZW0vRGV2aWNlRGVmaW5pdGlvbi5jcnVkcyBzeXN0ZW0vTGlicmFyeS5jcnVkcyBzeXN0ZW0vUHJhY3RpdGlvbmVyLmNydWRzIHN5c3RlbS9Db3ZlcmFnZS5jcnVkcyBzeXN0ZW0vUHJvY2VkdXJlLmNydWRzIHN5c3RlbS9PcGVyYXRpb25EZWZpbml0aW9uLmNydWRzIHN5c3RlbS9Db21wYXJ0bWVudERlZmluaXRpb24uY3J1ZHMgc3lzdGVtL0NoYXJnZUl0ZW1EZWZpbml0aW9uLmNydWRzIHN5c3RlbS9Hb2FsLmNydWRzIHN5c3RlbS9NZWRpYS5jcnVkcyBzeXN0ZW0vQ292ZXJhZ2VFbGlnaWJpbGl0eVJlcXVlc3QuY3J1ZHMgc3lzdGVtL09yZ2FuaXphdGlvbi5jcnVkcyBzeXN0ZW0vUmVxdWVzdEdyb3VwLmNydWRzIHN5c3RlbS9NZWFzdXJlUmVwb3J0LmNydWRzIHN5c3RlbS9EZXZpY2UuY3J1ZHMgc3lzdGVtL1JlbGF0ZWRQZXJzb24uY3J1ZHMgc3lzdGVtL0NvbmRpdGlvbi5jcnVkcyBzeXN0ZW0vTWVkaWNhdGlvblJlcXVlc3QuY3J1ZHMgc3lzdGVtL01lc3NhZ2VIZWFkZXIuY3J1ZHMgc3lzdGVtL1N1YnN0YW5jZS5jcnVkcyBzeXN0ZW0vU2NoZWR1bGUuY3J1ZHMgc3lzdGVtL0xpbmthZ2UuY3J1ZHMgc3lzdGVtL0V2ZW50RGVmaW5pdGlvbi5jcnVkcyBzeXN0ZW0vSW1tdW5pemF0aW9uUmVjb21tZW5kYXRpb24uY3J1ZHMgc3lzdGVtL1ZlcmlmaWNhdGlvblJlc3VsdC5jcnVkcyBzeXN0ZW0vRGV2aWNlTWV0cmljLmNydWRzIHN5c3RlbS9BcHBvaW50bWVudC5jcnVkcyBzeXN0ZW0vQ2F0YWxvZ0VudHJ5LmNydWRzIHN5c3RlbS9BY2NvdW50LmNydWRzIHN5c3RlbS9BcHBvaW50bWVudFJlc3BvbnNlLmNydWRzIHN5c3RlbS9NZWRpY2F0aW9uS25vd2xlZGdlLmNydWRzIHN5c3RlbS9EZXRlY3RlZElzc3VlLmNydWRzIHN5c3RlbS9NZWRpY2luYWxQcm9kdWN0UGFja2FnZWQuY3J1ZHMgc3lzdGVtL0NhcGFiaWxpdHlTdGF0ZW1lbnQuY3J1ZHMgc3lzdGVtL1Byb3ZlbmFuY2UuY3J1ZHMgc3lzdGVtL0ltbXVuaXphdGlvbkV2YWx1YXRpb24uY3J1ZHMgc3lzdGVtL09ic2VydmF0aW9uLmNydWRzIHN5c3RlbS9FdmlkZW5jZVZhcmlhYmxlLmNydWRzIHN5c3RlbS9RdWVzdGlvbm5haXJlUmVzcG9uc2UuY3J1ZHMgc3lzdGVtL0NsYWltLmNydWRzIHN5c3RlbS9CYXNpYy5jcnVkcyBzeXN0ZW0vR3JhcGhEZWZpbml0aW9uLmNydWRzIHN5c3RlbS9WaXNpb25QcmVzY3JpcHRpb24uY3J1ZHMgc3lzdGVtL0NvbnNlbnQuY3J1ZHMgc3lzdGVtL01lZGljYXRpb25BZG1pbmlzdHJhdGlvbi5jcnVkcyBzeXN0ZW0vTWVkaWNhdGlvbkRpc3BlbnNlLmNydWRzIHN5c3RlbS9SaXNrRXZpZGVuY2VTeW50aGVzaXMuY3J1ZHMgc3lzdGVtL0RpYWdub3N0aWNSZXBvcnQuY3J1ZHMgc3lzdGVtL0NvbW11bmljYXRpb25SZXF1ZXN0LmNydWRzIHN5c3RlbS9JbWFnaW5nU3R1ZHkuY3J1ZHMgc3lzdGVtL1BhcmFtZXRlcnMuY3J1ZHMgc3lzdGVtL01lZGljaW5hbFByb2R1Y3RQaGFybWFjZXV0aWNhbC5jcnVkcyBzeXN0ZW0vTW9sZWN1bGFyU2VxdWVuY2UuY3J1ZHMgc3lzdGVtL0Vucm9sbG1lbnRSZXF1ZXN0LmNydWRzIHN5c3RlbS9QYXltZW50UmVjb25jaWxpYXRpb24uY3J1ZHMgc3lzdGVtL1NlYXJjaFBhcmFtZXRlci5jcnVkcyBzeXN0ZW0vR3VpZGFuY2VSZXNwb25zZS5jcnVkcyBzeXN0ZW0vRXZpZGVuY2UuY3J1ZHMgc3lzdGVtL1N1YnN0YW5jZVByb3RlaW4uY3J1ZHMgc3lzdGVtL05hbWluZ1N5c3RlbS5jcnVkcyBzeXN0ZW0vUmVzZWFyY2hEZWZpbml0aW9uLmNydWRzIHN5c3RlbS9TdWJzdGFuY2VTb3VyY2VNYXRlcmlhbC5jcnVkcyBzeXN0ZW0vTWVkaWNpbmFsUHJvZHVjdEluZGljYXRpb24uY3J1ZHMgc3lzdGVtL1N1cHBseVJlcXVlc3QuY3J1ZHMgc3lzdGVtL1Rlc3RTY3JpcHQuY3J1ZHMgc3lzdGVtL0V4YW1wbGVTY2VuYXJpby5jcnVkcyBzeXN0ZW0vTWVkaWNpbmFsUHJvZHVjdC5jcnVkcyBzeXN0ZW0vTWVzc2FnZURlZmluaXRpb24uY3J1ZHMgc3lzdGVtL0NvbXBvc2l0aW9uLmNydWRzIHN5c3RlbS9JbW11bml6YXRpb24uY3J1ZHMgc3lzdGVtL0RldmljZVJlcXVlc3QuY3J1ZHMgc3lzdGVtL0RvY3VtZW50UmVmZXJlbmNlLmNydWRzIHN5c3RlbS9FeHBsYW5hdGlvbk9mQmVuZWZpdC5jcnVkcyBzeXN0ZW0vU3VwcGx5RGVsaXZlcnkuY3J1ZHMgc3lzdGVtL1N1YnN0YW5jZVNwZWNpZmljYXRpb24uY3J1ZHMgc3lzdGVtL1BlcnNvbi5jcnVkcyBzeXN0ZW0vRW5yb2xsbWVudFJlc3BvbnNlLmNydWRzIHN5c3RlbS9TbG90LmNydWRzIHN5c3RlbS9CaW5hcnkuY3J1ZHMgc3lzdGVtL1BsYW5EZWZpbml0aW9uLmNydWRzIHN5c3RlbS9GYW1pbHlNZW1iZXJIaXN0b3J5LmNydWRzIHN5c3RlbS9DYXJlVGVhbS5jcnVkcyBzeXN0ZW0vRG9jdW1lbnRNYW5pZmVzdC5jcnVkcyBzeXN0ZW0vSW52b2ljZS5jcnVkcyBzeXN0ZW0vTWVkaWNpbmFsUHJvZHVjdEluZ3JlZGllbnQuY3J1ZHMgc3lzdGVtL0ZsYWcuY3J1ZHMgc3lzdGVtL0NvbW11bmljYXRpb24uY3J1ZHMgc3lzdGVtL0luc3VyYW5jZVBsYW4uY3J1ZHMgc3lzdGVtL1ByYWN0aXRpb25lclJvbGUuY3J1ZHMgc3lzdGVtL0NvbmNlcHRNYXAuY3J1ZHMgc3lzdGVtL1BhdGllbnQuY3J1ZHMgc3lzdGVtL1N1YnNjcmlwdGlvbi5jcnVkcyBzeXN0ZW0vUmVzZWFyY2hFbGVtZW50RGVmaW5pdGlvbi5jcnVkcyBzeXN0ZW0vU3Vic3RhbmNlUmVmZXJlbmNlSW5mb3JtYXRpb24uY3J1ZHMgc3lzdGVtL0NsaW5pY2FsSW1wcmVzc2lvbi5jcnVkcyBzeXN0ZW0vQ2FyZVBsYW4uY3J1ZHMgc3lzdGVtL1Rhc2suY3J1ZHMgc3lzdGVtL0xpc3QuY3J1ZHMgc3lzdGVtL1BheW1lbnROb3RpY2UuY3J1ZHMgc3lzdGVtL0VuZHBvaW50LmNydWRzIHN5c3RlbS9PcGVyYXRpb25PdXRjb21lLmNydWRzIHN5c3RlbS9RdWVzdGlvbm5haXJlLmNydWRzIHN5c3RlbS9UZXN0UmVwb3J0LmNydWRzIHN5c3RlbS9BbGxlcmd5SW50b2xlcmFuY2UuY3J1ZHMgc3lzdGVtL0dyb3VwLmNydWRzIHN5c3RlbS9NZWRpY2luYWxQcm9kdWN0VW5kZXNpcmFibGVFZmZlY3QuY3J1ZHMgc3lzdGVtL0NvdmVyYWdlRWxpZ2liaWxpdHlSZXNwb25zZS5jcnVkcyBzeXN0ZW0vTWVkaWNpbmFsUHJvZHVjdEF1dGhvcml6YXRpb24uY3J1ZHMgc3lzdGVtL0NvZGVTeXN0ZW0uY3J1ZHMgc3lzdGVtL0JvZHlTdHJ1Y3R1cmUuY3J1ZHMgc3lzdGVtL0NoYXJnZUl0ZW0uY3J1ZHMgc3lzdGVtL1N1YnN0YW5jZU51Y2xlaWNBY2lkLmNydWRzIHN5c3RlbS9OdXRyaXRpb25PcmRlci5jcnVkcyBzeXN0ZW0vTWVhc3VyZS5jcnVkcyBzeXN0ZW0vVGVybWlub2xvZ3lDYXBhYmlsaXRpZXMuY3J1ZHMgc3lzdGVtL0VuY291bnRlci5jcnVkcyBzeXN0ZW0vTWVkaWNpbmFsUHJvZHVjdEludGVyYWN0aW9uLmNydWRzIHN5c3RlbS9NZWRpY2luYWxQcm9kdWN0Q29udHJhaW5kaWNhdGlvbi5jcnVkcyBzeXN0ZW0vQWR2ZXJzZUV2ZW50LmNydWRzIHN5c3RlbS9SaXNrQXNzZXNzbWVudC5jcnVkcyBzeXN0ZW0vU3Vic3RhbmNlUG9seW1lci5jcnVkcyBzeXN0ZW0vRGV2aWNlVXNlU3RhdGVtZW50LmNydWRzIiwiYXpwIjoiOTgwYzdlNjAtMDE3MC00NDlkLThlODgtMTliYWFhMDIwYjYzIn0.oyO7FaaNDlh1sf3akhoL9-T0Ee61VtjYmyspWHAGKq-490ydJ6r3CyA8IZ4dG5J67bN1Fef_8y4P8qEgU2iGIosGEs-7X-SFDCD8qQD6O1kMDEvY1_bDj9eoZgZv5ZQf4avaoS90ipx8k1FtKy9_yZQ_UdbqCHDdSLpKQ-e72iOhz0Rq_IQahUOk7v9TYxmq4VnB1Yk5KUBxT5sx7bNkyZinVrsJWD4YVeL8copDJphj8JTpNVfbYQfbditPPE68kqm_JjEjXYS4E4rie-QfjKNjriz5wIagcKc6tqCzdUARUqWK74aTCztGIG2mWQ2hPkrFYYJT0DCy9V-00hB0pQ	\N	\N	system/Location.cruds system/MedicationStatement.cruds system/EpisodeOfCare.cruds system/ActivityDefinition.cruds system/AuditEvent.cruds system/Contract.cruds system/Bundle.cruds system/OrganizationAffiliation.cruds system/ObservationDefinition.cruds system/ResearchStudy.cruds system/ResearchSubject.cruds system/EffectEvidenceSynthesis.cruds system/SpecimenDefinition.cruds system/Medication.cruds system/BiologicallyDerivedProduct.cruds system/ImplementationGuide.cruds system/ServiceRequest.cruds system/Specimen.cruds system/MedicinalProductManufactured.cruds system/StructureDefinition.cruds system/ClaimResponse.cruds system/ValueSet.cruds system/HealthcareService.cruds system/StructureMap.cruds system/DeviceDefinition.cruds system/Library.cruds system/Practitioner.cruds system/Coverage.cruds system/Procedure.cruds system/OperationDefinition.cruds system/CompartmentDefinition.cruds system/ChargeItemDefinition.cruds system/Goal.cruds system/Media.cruds system/CoverageEligibilityRequest.cruds system/Organization.cruds system/RequestGroup.cruds system/MeasureReport.cruds system/Device.cruds system/RelatedPerson.cruds system/Condition.cruds system/MedicationRequest.cruds system/MessageHeader.cruds system/Substance.cruds system/Schedule.cruds system/Linkage.cruds system/EventDefinition.cruds system/ImmunizationRecommendation.cruds system/VerificationResult.cruds system/DeviceMetric.cruds system/Appointment.cruds system/CatalogEntry.cruds system/Account.cruds system/AppointmentResponse.cruds system/MedicationKnowledge.cruds system/DetectedIssue.cruds system/MedicinalProductPackaged.cruds system/CapabilityStatement.cruds system/Provenance.cruds system/ImmunizationEvaluation.cruds system/Observation.cruds system/EvidenceVariable.cruds system/QuestionnaireResponse.cruds system/Claim.cruds system/Basic.cruds system/GraphDefinition.cruds system/VisionPrescription.cruds system/Consent.cruds system/MedicationAdministration.cruds system/MedicationDispense.cruds system/RiskEvidenceSynthesis.cruds system/DiagnosticReport.cruds system/CommunicationRequest.cruds system/ImagingStudy.cruds system/Parameters.cruds system/MedicinalProductPharmaceutical.cruds system/MolecularSequence.cruds system/EnrollmentRequest.cruds system/PaymentReconciliation.cruds system/SearchParameter.cruds system/GuidanceResponse.cruds system/Evidence.cruds system/SubstanceProtein.cruds system/NamingSystem.cruds system/ResearchDefinition.cruds system/SubstanceSourceMaterial.cruds system/MedicinalProductIndication.cruds system/SupplyRequest.cruds system/TestScript.cruds system/ExampleScenario.cruds system/MedicinalProduct.cruds system/MessageDefinition.cruds system/Composition.cruds system/Immunization.cruds system/DeviceRequest.cruds system/DocumentReference.cruds system/ExplanationOfBenefit.cruds system/SupplyDelivery.cruds system/SubstanceSpecification.cruds system/Person.cruds system/EnrollmentResponse.cruds system/Slot.cruds system/Binary.cruds system/PlanDefinition.cruds system/FamilyMemberHistory.cruds system/CareTeam.cruds system/DocumentManifest.cruds system/Invoice.cruds system/MedicinalProductIngredient.cruds system/Flag.cruds system/Communication.cruds system/InsurancePlan.cruds system/PractitionerRole.cruds system/ConceptMap.cruds system/Patient.cruds system/Subscription.cruds system/ResearchElementDefinition.cruds system/SubstanceReferenceInformation.cruds system/ClinicalImpression.cruds system/CarePlan.cruds system/Task.cruds system/List.cruds system/PaymentNotice.cruds system/Endpoint.cruds system/OperationOutcome.cruds system/Questionnaire.cruds system/TestReport.cruds system/AllergyIntolerance.cruds system/Group.cruds system/MedicinalProductUndesirableEffect.cruds system/CoverageEligibilityResponse.cruds system/MedicinalProductAuthorization.cruds system/CodeSystem.cruds system/BodyStructure.cruds system/ChargeItem.cruds system/SubstanceNucleicAcid.cruds system/NutritionOrder.cruds system/Measure.cruds system/TerminologyCapabilities.cruds system/Encounter.cruds system/MedicinalProductInteraction.cruds system/MedicinalProductContraindication.cruds system/AdverseEvent.cruds system/RiskAssessment.cruds system/SubstancePolymer.cruds system/DeviceUseStatement.cruds	\N	\N
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permission (id, created_by, created_on, operation, resource_type, scope, role_id) FROM stdin;
08713f22-15f9-4be0-b7af-abb9b7fa24c3	system	2023-06-12 14:31:35.313462	DELETE	Location	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
750e59e2-c9be-4cfa-b411-1b58cb55403a	system	2023-06-12 14:31:35.314178	READ	MedicationStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8cf6a7d7-b16c-4649-8d36-9ad5c9d3399a	system	2023-06-12 14:31:35.312529	UPDATE	EpisodeOfCare	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
83d457e4-cf76-42de-ac22-1e6fb7dba6f7	system	2023-06-12 14:31:35.310967	READ	ActivityDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d1280ba8-2023-4f41-a396-56bc28741c7a	system	2023-06-12 14:31:35.311118	CREATE	AuditEvent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3e0c4167-85ef-4772-9e1d-d94113ae09f4	system	2023-06-12 14:31:35.311777	READ	Contract	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4796047f-d0d9-4089-8467-3bddb48b4eea	system	2023-06-12 14:31:35.311254	CREATE	Bundle	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
85297375-2003-4f0d-a88d-283dfed13a11	system	2023-06-12 14:31:35.315222	DELETE	OrganizationAffiliation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7013d79e-bc8e-417a-9c36-63610a113643	system	2023-06-12 14:31:35.315067	CREATE	ObservationDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
302688dd-1d7f-4538-ae8f-c11ba1dcd5b2	system	2023-06-12 14:31:35.316171	UPDATE	ResearchStudy	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4dabd7c4-0c2d-45b4-ab7a-32ea8bebfb3f	system	2023-06-12 14:31:35.316184	CREATE	ResearchSubject	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
330f32dc-59de-4aa8-8e91-c814ce984565	system	2023-06-12 14:31:35.312375	CREATE	EffectEvidenceSynthesis	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
666101d8-c5a5-4e55-9e63-3c4948f33c6b	system	2023-06-12 14:31:35.316443	CREATE	SpecimenDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4977f7df-bcf1-411c-bc5d-16e555fc2b36	system	2023-06-12 14:31:35.313652	CREATE	Medication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7181ccb4-85a1-4322-98a2-9f7064e1256d	system	2023-06-12 14:31:35.311212	UPDATE	BiologicallyDerivedProduct	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0e6bb308-33b6-48ba-b764-18e31f28ba32	system	2023-06-12 14:31:35.313121	UPDATE	ImplementationGuide	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4c01f420-4ca0-477c-a65d-74947cb5d92a	system	2023-06-12 14:31:35.316359	CREATE	ServiceRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1abc5d77-3e23-4422-bad6-b00644b07303	system	2023-06-12 14:31:35.316424	READ	Specimen	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
eb8f871c-2c6a-4eb0-bc3e-62863b43bcf7	system	2023-06-12 14:31:35.314373	CREATE	MedicinalProductManufactured	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9c9a864c-da77-4767-a047-69450b8215e4	system	2023-06-12 14:31:35.316672	DELETE	StructureDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
856ad8fd-ea3c-4c2b-b8bf-d01638734d34	system	2023-06-12 14:31:35.311481	READ	ClaimResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c1b7190f-78a0-4cfe-a056-a2540845adf4	system	2023-06-12 14:31:35.317581	CREATE	ValueSet	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3b69d820-9684-4701-8a94-c4a2ec87c6ec	system	2023-06-12 14:31:35.312928	UPDATE	HealthcareService	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b39ab192-2131-4b1e-b829-2d512082b150	system	2023-06-12 14:31:35.316707	READ	StructureMap	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7e5bb31e-b058-46fa-b549-ee3e615ba192	system	2023-06-12 14:31:35.312159	READ	DeviceDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
393c3d82-02d0-4cc4-8971-0e595594bbb8	system	2023-06-12 14:31:35.313296	CREATE	Library	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
45572765-4cc4-4de2-93e1-77ededda184f	system	2023-06-12 14:31:35.315816	UPDATE	Practitioner	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
37c36e34-2836-4478-906b-e6c92f4c014a	system	2023-06-12 14:31:35.311831	CREATE	Coverage	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
69c7391a-5c44-48ab-bc44-62fe55fa09c4	system	2023-06-12 14:31:35.315952	READ	Procedure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8cd4edf2-f174-4cb1-af08-08d5365838b1	system	2023-06-12 14:31:35.315145	DELETE	OperationDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e5698fdd-d205-41d6-b72d-75af975dee4d	system	2023-06-12 14:31:35.311618	CREATE	CompartmentDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
74bb1692-c4bf-44a7-8427-14f6e70832ad	system	2023-06-12 14:31:35.315216	UPDATE	OrganizationAffiliation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e709b1e5-0f61-4792-8520-58b27d07c3aa	system	2023-06-12 14:31:35.311435	UPDATE	ChargeItemDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9b6b16ef-9635-454b-9735-4af0723538d3	system	2023-06-12 14:31:35.315204	CREATE	OrganizationAffiliation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
85663dc6-388a-49f5-9f79-b160abc996e1	system	2023-06-12 14:31:35.31281	UPDATE	Goal	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f5c0091b-757e-49ea-a036-0282360af88d	system	2023-06-12 14:31:35.313644	DELETE	Media	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
72912bda-75ca-4965-aad0-5dc7a6798207	system	2023-06-12 14:31:35.312035	UPDATE	CoverageEligibilityRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d595df0d-208a-4add-9e08-851c732bdac7	system	2023-06-12 14:31:35.315139	UPDATE	OperationDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
793f765c-4784-47cd-af49-c9e3c4a228ea	system	2023-06-12 14:31:35.315197	DELETE	Organization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4edcd4b6-8dce-4631-82f0-9a1e3c3092db	system	2023-06-12 14:31:35.316088	READ	RequestGroup	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8cd1c223-f432-456e-bc14-452e1bc6c7ef	system	2023-06-12 14:31:35.313585	UPDATE	MeasureReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2bf130bb-c0f1-41e0-9c19-6b42905affd4	system	2023-06-12 14:31:35.312138	UPDATE	Device	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
aed5ca1e-eb94-4415-b79c-23ed9aff0294	system	2023-06-12 14:31:35.311206	READ	BiologicallyDerivedProduct	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
010b484d-879f-4f6f-b0a3-2c7b3b2b046f	system	2023-06-12 14:31:35.315112	UPDATE	ObservationDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
32f6700a-3c95-4029-ad59-4baf6e3fb20d	system	2023-06-12 14:31:35.316063	READ	RelatedPerson	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8e0b5fe0-dcba-4ded-8909-e28e6aed807d	system	2023-06-12 14:31:35.311717	UPDATE	Condition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
820263de-1725-46d4-af88-11e17ce06881	system	2023-06-12 14:31:35.314164	DELETE	MedicationRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a009fd4f-8326-4462-9d1f-151dc1d6b0e0	system	2023-06-12 14:31:35.314518	CREATE	MessageHeader	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3b0a7ae1-b7ed-41c5-86b3-015df784ac70	system	2023-06-12 14:31:35.314524	READ	MessageHeader	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
edaf0077-97c3-4e2c-96fe-ce8718ca4140	system	2023-06-12 14:31:35.316811	UPDATE	Substance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2daf97c7-29ab-492b-a220-538e5eb691af	system	2023-06-12 14:31:35.316296	UPDATE	Schedule	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
fece8cfc-a2b2-4aa9-b560-fc4c9f7c1333	system	2023-06-12 14:31:35.313347	DELETE	Linkage	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
294140a2-37b2-4fc8-a36f-713ddc4f081d	system	2023-06-12 14:31:35.312559	READ	EventDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
270cf70a-414b-4bd4-80b1-e05a1d068f7b	system	2023-06-12 14:31:35.313076	READ	ImmunizationRecommendation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ebade464-4268-4c94-a567-e9515cccd567	system	2023-06-12 14:31:35.317613	READ	VerificationResult	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9229fa31-6f4a-41ea-8d27-1e445b0264e6	system	2023-06-12 14:31:35.312192	UPDATE	DeviceMetric	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
85b23db4-9279-4766-b042-7793ef5ea76e	system	2023-06-12 14:31:35.314191	DELETE	MedicationStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c7b23e36-03c9-4c6a-90ee-c5e3066a58a0	system	2023-06-12 14:31:35.31179	DELETE	Contract	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7d27d57f-576a-43e2-b0b0-4501874ebdec	system	2023-06-12 14:31:35.311069	READ	Appointment	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0cfcf575-2219-4b94-8b14-d71bde647e15	system	2023-06-12 14:31:35.31137	CREATE	CatalogEntry	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
629880ec-6975-445a-8153-d10a03dae5d2	system	2023-06-12 14:31:35.316302	DELETE	Schedule	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a408e09a-f0ce-4b3d-959f-82370012c6cf	system	2023-06-12 14:31:35.31643	UPDATE	Specimen	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
dab6b3b1-a57f-4f68-abfa-3845b1a6ccd3	system	2023-06-12 14:31:35.313425	CREATE	Location	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6011762d-e2b3-4f97-b125-d4e5419857e7	system	2023-06-12 14:31:35.311063	CREATE	Appointment	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e7f5324e-fe51-49f4-adde-e5465c1a8fc1	system	2023-06-12 14:31:35.311641	DELETE	CompartmentDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b16b06ac-6674-4c10-a049-bd9404ea0d8c	system	2023-06-12 14:31:35.310952	DELETE	Account	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a67e8a4d-e6f8-4221-a5f4-089bf9b5600c	system	2023-06-12 14:31:35.310934	READ	Account	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3be159f3-9781-4206-95ba-e1271d165345	system	2023-06-12 14:31:35.311092	CREATE	AppointmentResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ff03e58d-7214-41f5-b93d-cb1d9ac32cec	system	2023-06-12 14:31:35.314125	READ	MedicationKnowledge	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ba9c026f-05d1-43ac-a774-da29ca5385ff	system	2023-06-12 14:31:35.311132	UPDATE	AuditEvent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
27277a30-5ac9-4368-8ec5-23897e4a116b	system	2023-06-12 14:31:35.312098	CREATE	DetectedIssue	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
724402f1-9ee0-49b8-852e-4e84754e31e0	system	2023-06-12 14:31:35.314413	READ	MedicinalProductPackaged	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8467ae60-4ef6-4cf8-8767-f7484c2689ff	system	2023-06-12 14:31:35.31128	CREATE	CapabilityStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
75f4d9e4-db4c-4267-837b-ec11312f48d2	system	2023-06-12 14:31:35.315978	READ	Provenance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8aae9d6b-fc21-4d37-9430-163d01d6e153	system	2023-06-12 14:31:35.313056	UPDATE	ImmunizationEvaluation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
46b536d9-76f7-4489-818e-c4ac22ef3099	system	2023-06-12 14:31:35.315958	UPDATE	Procedure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
78d2d3b5-60df-4213-a76b-c78735bbee60	system	2023-06-12 14:31:35.313033	CREATE	ImmunizationEvaluation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b263c05d-1a1b-40ef-bdde-1116dcdcf0d2	system	2023-06-12 14:31:35.313108	CREATE	ImplementationGuide	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e77b5177-4b0a-4cd5-889d-2d6968d83c14	system	2023-06-12 14:31:35.315026	READ	Observation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7afb5fd9-c43a-4c2b-a534-068f0e3b2ec2	system	2023-06-12 14:31:35.311723	DELETE	Condition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cc61fe4a-0ce2-44a1-ace3-c8b7dc3cc4c8	system	2023-06-12 14:31:35.312628	UPDATE	EvidenceVariable	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c8534471-93c3-4a32-9c18-431216677509	system	2023-06-12 14:31:35.316035	UPDATE	QuestionnaireResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
93345468-398d-4c62-a776-331ea35b8a8b	system	2023-06-12 14:31:35.311449	CREATE	Claim	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7d4ee4ab-5985-4cb1-8608-e59e6de21bee	system	2023-06-12 14:31:35.312382	READ	EffectEvidenceSynthesis	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
76f91e3e-6481-4165-bccf-ddca44f0efa0	system	2023-06-12 14:31:35.311152	READ	Basic	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
97c11dd8-ac98-4cce-9e94-cf50bc0eeaca	system	2023-06-12 14:31:35.312801	READ	Goal	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b2550327-5960-46b3-90a5-98570eeac46f	system	2023-06-12 14:31:35.312849	UPDATE	GraphDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
647ce06e-3151-4500-8889-1a1473c3f56d	system	2023-06-12 14:31:35.315133	READ	OperationDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
074cb2e5-5f3d-496d-b877-5d3d10e23048	system	2023-06-12 14:31:35.317656	DELETE	VisionPrescription	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5d91e89d-174f-42a8-949d-b75cca96115c	system	2023-06-12 14:31:35.311744	UPDATE	Consent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d1599b50-1d7f-492f-9e39-ae8e5218b59f	system	2023-06-12 14:31:35.314051	UPDATE	MedicationAdministration	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5415b478-dd23-4a02-bf67-b5740622b7a2	system	2023-06-12 14:31:35.315179	CREATE	Organization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c6bfac01-052f-4421-a6ed-20fc63638a73	system	2023-06-12 14:31:35.315705	READ	Practitioner	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
795b7015-5059-4b61-ae0a-0fde571e1645	system	2023-06-12 14:31:35.314111	DELETE	MedicationDispense	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
76972690-46a2-4360-999f-065781d18b2c	system	2023-06-12 14:31:35.31627	DELETE	RiskEvidenceSynthesis	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
30435d15-60d2-4f29-b2e6-263df3827c4f	system	2023-06-12 14:31:35.315191	UPDATE	Organization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
34b653d3-4fcc-4960-953e-30e709a7b16c	system	2023-06-12 14:31:35.312292	READ	DiagnosticReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
326b8c25-e208-418d-844a-70006eca6a9d	system	2023-06-12 14:31:35.311603	UPDATE	CommunicationRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
da8ad0c9-d799-4d30-996f-02a2b1c03704	system	2023-06-12 14:31:35.313127	DELETE	ImplementationGuide	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5ee5c0f4-3453-41d3-9187-66f2791e81b0	system	2023-06-12 14:31:35.31672	DELETE	StructureMap	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cc693f79-d491-4313-b082-3bff6f96dc87	system	2023-06-12 14:31:35.312967	UPDATE	ImagingStudy	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d4807046-731b-4123-b6bb-8335fd3821d5	system	2023-06-12 14:31:35.315236	READ	Parameters	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
074b755f-3d3b-40ab-ad85-9b9c534149d5	system	2023-06-12 14:31:35.314439	READ	MedicinalProductPharmaceutical	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e2c7a047-b982-4752-ba29-71eef43c4bda	system	2023-06-12 14:31:35.31455	READ	MolecularSequence	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cb690c14-79f8-44bd-b19c-d1678c6cc5f3	system	2023-06-12 14:31:35.313322	CREATE	Linkage	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f2e46731-bf8f-4aa4-96ad-42884e09452d	system	2023-06-12 14:31:35.312475	UPDATE	EnrollmentRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8ab89d32-7217-42f9-a864-9c7b238c138c	system	2023-06-12 14:31:35.315414	READ	PaymentReconciliation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
fe5972d6-0c44-4298-a3bc-3f4b9acf2565	system	2023-06-12 14:31:35.316331	READ	SearchParameter	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9afba049-9bcc-45ba-88a1-420515704832	system	2023-06-12 14:31:35.312908	DELETE	GuidanceResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bea2bb21-7e8b-42b4-bccc-a2cfa84a3908	system	2023-06-12 14:31:35.312588	CREATE	Evidence	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3c4f695a-5468-4d9f-b5aa-c52075dfe555	system	2023-06-12 14:31:35.316907	UPDATE	SubstanceProtein	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ea8c50f5-8de6-464a-bc1c-838c5570e17e	system	2023-06-12 14:31:35.3146	DELETE	NamingSystem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3cb02e74-9f59-4766-a47d-ea37794770f1	system	2023-06-12 14:31:35.315971	CREATE	Provenance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5490bebc-6e88-4d7b-a1d3-2b8492033db2	system	2023-06-12 14:31:35.312902	UPDATE	GuidanceResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
53477488-ded5-4376-ae8e-42e6a8fbf9be	system	2023-06-12 14:31:35.3166	UPDATE	SpecimenDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
26d64b8a-b25f-4f6e-9265-bcbf5e9f2517	system	2023-06-12 14:31:35.316107	CREATE	ResearchDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
75e23dda-d4b6-4031-912a-4f9cee0a4392	system	2023-06-12 14:31:35.316966	DELETE	SubstanceSourceMaterial	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
943737ac-d8de-4f5d-97b4-173eada311ba	system	2023-06-12 14:31:35.314307	UPDATE	MedicinalProductIndication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6aaa53cc-7b8d-4e96-99a8-9ccb522dc4b0	system	2023-06-12 14:31:35.312896	READ	GuidanceResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bde2adae-8c05-435c-90e1-03caaa39993a	system	2023-06-12 14:31:35.312543	CREATE	EventDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
60f79630-7ab9-4e05-bb63-fd3c72520876	system	2023-06-12 14:31:35.317593	UPDATE	ValueSet	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c32eabe6-f139-41d1-9c74-4269009e95b4	system	2023-06-12 14:31:35.31307	CREATE	ImmunizationRecommendation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
515c7623-f133-44f3-b6d9-3eb8e0618526	system	2023-06-12 14:31:35.317459	DELETE	SupplyRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
933b3a1f-15d7-4e6c-9197-e6b3038ef654	system	2023-06-12 14:31:35.311138	DELETE	AuditEvent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9671361b-1132-4354-8d92-fec339ef7b93	system	2023-06-12 14:31:35.314445	UPDATE	MedicinalProductPharmaceutical	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e4ef653d-2ea8-4402-a71d-eeaf20fc722c	system	2023-06-12 14:31:35.31756	READ	TestScript	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5dd8c35f-e38f-4e16-8ae1-e8e1f37e71d4	system	2023-06-12 14:31:35.313062	DELETE	ImmunizationEvaluation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6b748fb2-41b6-41bf-9cba-b5d40647b6ea	system	2023-06-12 14:31:35.313606	READ	Media	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
56fafe23-4e07-418a-94de-01307d302592	system	2023-06-12 14:31:35.314419	UPDATE	MedicinalProductPackaged	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
16796afd-2bbc-4e87-9f2b-d9be1d93b190	system	2023-06-12 14:31:35.312642	CREATE	ExampleScenario	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6b710ea4-ea44-47a7-b1b8-98a1e9e48aed	system	2023-06-12 14:31:35.312922	READ	HealthcareService	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cc0035db-1c16-471a-8f92-3eafbbed8244	system	2023-06-12 14:31:35.314198	CREATE	MedicinalProduct	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e3320a31-69be-46bd-8bf5-0367dce0beb5	system	2023-06-12 14:31:35.317607	CREATE	VerificationResult	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
657b4d49-92f0-4b37-a104-fa7bc7c0eb54	system	2023-06-12 14:31:35.316056	CREATE	RelatedPerson	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9074ffdb-ea4b-4271-9efb-4e54b95109a1	system	2023-06-12 14:31:35.314504	UPDATE	MessageDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
729d8eeb-636f-45a2-a96a-1b5638759be2	system	2023-06-12 14:31:35.312622	READ	EvidenceVariable	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
81cc2801-7162-4841-9e9e-ccbda4ba37bd	system	2023-06-12 14:31:35.311663	UPDATE	Composition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
849684d2-6104-415e-895d-ee51b7f9a998	system	2023-06-12 14:31:35.311704	CREATE	Condition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
814b521d-cfc3-4a36-bf73-ef3af7d85bc6	system	2023-06-12 14:31:35.312987	CREATE	Immunization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3d27b91b-6c81-4654-acfd-60f960ca5f91	system	2023-06-12 14:31:35.312595	READ	Evidence	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f7daefcb-3162-4e51-91a6-86d8598de954	system	2023-06-12 14:31:35.312243	DELETE	DeviceRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cbb38abd-68b0-43a0-9244-0a930c7f3a42	system	2023-06-12 14:31:35.312361	UPDATE	DocumentReference	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
47ad4868-73b4-4fdb-8f16-ceb9b82e44f3	system	2023-06-12 14:31:35.312219	UPDATE	DeviceRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1814f8c0-3941-46df-a575-c39934921d37	system	2023-06-12 14:31:35.312682	UPDATE	ExplanationOfBenefit	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8fbce3ea-7015-4a7e-8722-b211b6d8bcd5	system	2023-06-12 14:31:35.317124	DELETE	SupplyDelivery	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3b77c11e-33ed-4de1-8c67-88a915be712f	system	2023-06-12 14:31:35.311266	UPDATE	Bundle	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b12e3602-7570-4be3-9f85-da6a348dfa3c	system	2023-06-12 14:31:35.311376	READ	CatalogEntry	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3472e09e-f0f5-44ba-aa46-957d41ee96c0	system	2023-06-12 14:31:35.31453	UPDATE	MessageHeader	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e86839db-c653-4d6e-b932-14299ffb8fd4	system	2023-06-12 14:31:35.314582	UPDATE	NamingSystem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0554ef79-9a8e-45f4-a87a-1a361224bf08	system	2023-06-12 14:31:35.316973	CREATE	SubstanceSpecification	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
312c6e91-2159-4079-8f15-abfe81557023	system	2023-06-12 14:31:35.315453	UPDATE	Person	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
360f778a-98df-4309-90e8-5a1d2e2fe26c	system	2023-06-12 14:31:35.314497	READ	MessageDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
774ccf89-e42e-457e-8d22-59ccff15e3de	system	2023-06-12 14:31:35.312496	READ	EnrollmentResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1c092558-519f-4f0c-acb3-f64b73bc9fee	system	2023-06-12 14:31:35.315574	CREATE	Practitioner	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
50a065f6-8a57-448d-8480-47fddac70915	system	2023-06-12 14:31:35.317568	UPDATE	TestScript	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
dd64e2af-bdc3-485b-a3be-3f035538f8fb	system	2023-06-12 14:31:35.316392	READ	Slot	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
59f84bb0-2ef0-4282-942f-52caee96b2fe	system	2023-06-12 14:31:35.314313	DELETE	MedicinalProductIndication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4592cd96-6512-42f1-a291-783eed8fd443	system	2023-06-12 14:31:35.311184	UPDATE	Binary	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7b4444e1-1283-430e-9162-f5c72e802aea	system	2023-06-12 14:31:35.314294	CREATE	MedicinalProductIndication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d85e713a-ad2c-44dd-b08c-01c0c7ca7b9e	system	2023-06-12 14:31:35.315478	UPDATE	PlanDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
43bc8169-0dc2-4aea-a59d-64fe1a0709bc	system	2023-06-12 14:31:35.312111	UPDATE	DetectedIssue	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e05e2d3d-020f-450e-afea-0a7509f67b1f	system	2023-06-12 14:31:35.31631	CREATE	SearchParameter	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5a26eba4-388d-40b0-97a5-1d0577f631e8	system	2023-06-12 14:31:35.311711	READ	Condition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cd1ed0e0-999f-4345-bcdf-51df1b2550c5	system	2023-06-12 14:31:35.311943	UPDATE	Coverage	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
17fecd96-0f92-4938-9486-000a27c0d702	system	2023-06-12 14:31:35.312536	DELETE	EpisodeOfCare	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b2b42337-f773-4cc9-8dcb-f66c38c22211	system	2023-06-12 14:31:35.316953	READ	SubstanceSourceMaterial	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d7bd4ff4-773d-473a-9628-c8644e62a286	system	2023-06-12 14:31:35.317574	DELETE	TestScript	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7bf92613-e632-43aa-838e-142937db93bc	system	2023-06-12 14:31:35.312696	CREATE	FamilyMemberHistory	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8f4ffb10-42c4-4910-9a6b-8c50009b43a1	system	2023-06-12 14:31:35.31135	READ	CareTeam	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c4e818f4-7bc1-4900-8e70-0f5e8bb69af6	system	2023-06-12 14:31:35.314216	UPDATE	MedicinalProduct	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5f4be9df-5e75-453c-902f-4426eea40dff	system	2023-06-12 14:31:35.31765	UPDATE	VisionPrescription	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e55cf8a7-c8b6-439a-8055-4cf57676ae40	system	2023-06-12 14:31:35.315433	DELETE	PaymentReconciliation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c9a7c101-c0b6-496f-9dad-c931994fcc39	system	2023-06-12 14:31:35.314082	DELETE	MedicationAdministration	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1f471d49-ba43-4423-b890-4baf9f6279b2	system	2023-06-12 14:31:35.310817	CREATE	Account	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a94c1be4-a47b-42fe-a680-818e64622464	system	2023-06-12 14:31:35.314119	CREATE	MedicationKnowledge	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9c4e1f1d-73b1-4569-ab0f-74f065800956	system	2023-06-12 14:31:35.312307	UPDATE	DiagnosticReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
04e0f667-e2b5-4c20-8b98-7651dcfd3821	system	2023-06-12 14:31:35.312334	UPDATE	DocumentManifest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
73a81a8c-f984-4fd0-b3a5-5601d31a699a	system	2023-06-12 14:31:35.31641	DELETE	Slot	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2021743f-89fb-4406-ab83-cfa97ed438be	system	2023-06-12 14:31:35.310961	CREATE	ActivityDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2e897698-3f29-4047-b434-5785dc52f627	system	2023-06-12 14:31:35.31131	DELETE	CapabilityStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bcf0d76a-9557-4d6b-9a1e-ea33c65a2622	system	2023-06-12 14:31:35.313572	CREATE	MeasureReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
38b0ed49-9f6e-41be-ac76-086ef004b855	system	2023-06-12 14:31:35.316785	CREATE	Substance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
833d5969-2f47-4f64-84cb-a323e9897002	system	2023-06-12 14:31:35.312144	DELETE	Device	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
54b8b6a5-cd0c-448e-bc9f-381639ba3dc6	system	2023-06-12 14:31:35.317625	DELETE	VerificationResult	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
48306f98-afa6-4cb7-a24d-a2b23020d5dd	system	2023-06-12 14:31:35.313275	READ	Invoice	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c36e8d43-e07b-4018-9c20-28072f47d875	system	2023-06-12 14:31:35.314339	DELETE	MedicinalProductIngredient	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3878122c-ee0d-434a-b55c-5fc4dac6b9f7	system	2023-06-12 14:31:35.311587	READ	CommunicationRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
40cb3734-faa3-400c-b4d0-348fdf403082	system	2023-06-12 14:31:35.317587	READ	ValueSet	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d36f80e7-10fd-4f7a-a008-66b1235faa71	system	2023-06-12 14:31:35.314485	CREATE	MessageDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3c5349c1-bb41-401c-9017-20ee72a71026	system	2023-06-12 14:31:35.316898	READ	SubstanceProtein	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7c8e0efe-dfd9-4692-9985-793e7b576155	system	2023-06-12 14:31:35.312117	DELETE	DetectedIssue	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2addf01a-6428-4bd9-bab2-6c34c4088913	system	2023-06-12 14:31:35.314146	CREATE	MedicationRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3bc7ba11-dde6-4b29-b1fc-c7a5a58de94a	system	2023-06-12 14:31:35.312724	CREATE	Flag	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8307cc4d-fa5f-4ed3-abb0-d87d0062ce20	system	2023-06-12 14:31:35.316386	CREATE	Slot	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8c1aaba6-a53d-4d9a-8c2b-82713b2bda55	system	2023-06-12 14:31:35.311573	DELETE	Communication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2db343dc-99a4-4ba0-bc14-7ffbcabfafc2	system	2023-06-12 14:31:35.312367	DELETE	DocumentReference	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
72741ddc-179d-4a8f-8b11-f567f06db513	system	2023-06-12 14:31:35.313134	CREATE	InsurancePlan	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3d25eaca-21a4-48a6-b148-4f3f2a572128	system	2023-06-12 14:31:35.312212	READ	DeviceRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bb8ef921-6f79-495e-abcd-bc0f671dedb6	system	2023-06-12 14:31:35.31234	DELETE	DocumentManifest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
dbff84ed-3fbb-4989-b890-4a9038fb6717	system	2023-06-12 14:31:35.315052	DELETE	Observation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6012fde5-a1cb-4f15-bbb5-d639717a41cf	system	2023-06-12 14:31:35.31586	CREATE	PractitionerRole	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9514ebfc-f8b1-4ff9-94d1-0de75d09d05b	system	2023-06-12 14:31:35.31169	UPDATE	ConceptMap	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b5be4d4a-3f32-4d47-8d8a-9f21ea4ea0ad	system	2023-06-12 14:31:35.315279	UPDATE	Patient	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
061841ba-faf3-474a-a35a-f27d3050b062	system	2023-06-12 14:31:35.316729	CREATE	Subscription	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bb8d651c-8724-4ffa-8af9-afeedafc397a	system	2023-06-12 14:31:35.317599	DELETE	ValueSet	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3ddd3ae4-ab60-4fe0-b5aa-7e8c34788968	system	2023-06-12 14:31:35.314099	READ	MedicationDispense	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1ac7e26f-b6d0-45f8-8e89-faa0acf7fc16	system	2023-06-12 14:31:35.316252	CREATE	RiskEvidenceSynthesis	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
86fc49dc-3f06-4e0b-9178-225f0f446fec	system	2023-06-12 14:31:35.31126	READ	Bundle	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b65162e9-e8e7-473f-a465-05d010f99735	system	2023-06-12 14:31:35.312125	CREATE	Device	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d9901ecf-bc1e-434f-a1d5-e9f89caa14e5	system	2023-06-12 14:31:35.315458	DELETE	Person	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2a16e3c1-03d8-41a7-ae6e-0ea31f83fdb2	system	2023-06-12 14:31:35.316139	READ	ResearchElementDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f5f74c04-eb4b-4f4b-97cf-7c66aac2e335	system	2023-06-12 14:31:35.31438	READ	MedicinalProductManufactured	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7141f04a-22cf-4104-ba8e-e876dea89d3f	system	2023-06-12 14:31:35.316921	CREATE	SubstanceReferenceInformation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
929e86cc-2612-408f-a7f8-6d654e2078da	system	2023-06-12 14:31:35.317118	UPDATE	SupplyDelivery	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1780f92a-28fc-4472-8e44-4b41e62a45c6	system	2023-06-12 14:31:35.314092	CREATE	MedicationDispense	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1812326b-3106-42a9-8503-b027e2a8f1b7	system	2023-06-12 14:31:35.311519	DELETE	ClinicalImpression	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
430135d0-27c8-43f6-9367-1bf5a42c3dda	system	2023-06-12 14:31:35.311317	CREATE	CarePlan	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0ae1260f-32c3-4367-8e73-12bc74e1fcf5	system	2023-06-12 14:31:35.312676	READ	ExplanationOfBenefit	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0a66d957-b336-40ac-9961-e9b57c721d84	system	2023-06-12 14:31:35.312104	READ	DetectedIssue	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8a0e004e-6c0a-45aa-a986-1018189601e1	system	2023-06-12 14:31:35.314386	UPDATE	MedicinalProductManufactured	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
05800322-d14a-4596-8574-102d4d67e399	system	2023-06-12 14:31:35.317486	READ	Task	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
fa3988c4-1921-48ea-83ce-677ee966bad7	system	2023-06-12 14:31:35.315019	CREATE	Observation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
39efbd04-1a82-4e9b-8b1e-052142daf8e4	system	2023-06-12 14:31:35.316023	CREATE	QuestionnaireResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
911b0fa3-a203-4b5e-a2f1-3ab90cdcf450	system	2023-06-12 14:31:35.313409	UPDATE	List	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2d61d51f-4182-4db5-aa49-3947ddabba18	system	2023-06-12 14:31:35.315394	UPDATE	PaymentNotice	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
fc7cbdf8-5085-4440-a08d-3c61464ac8e3	system	2023-06-12 14:31:35.315329	DELETE	Patient	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
fe8938cd-c141-4057-a805-47e0ec141063	system	2023-06-12 14:31:35.31521	READ	OrganizationAffiliation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9c762982-9f28-4926-b682-5348513b7175	system	2023-06-12 14:31:35.31708	DELETE	SubstanceSpecification	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
17dcbfe2-ae62-4d76-b27b-b8e21233f8a1	system	2023-06-12 14:31:35.312436	CREATE	Endpoint	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
933f42b6-024e-4adf-9f48-c0abd7b2f5e4	system	2023-06-12 14:31:35.314576	READ	NamingSystem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d9eb3dbf-be26-47ee-b10b-86198cbdab21	system	2023-06-12 14:31:35.312649	READ	ExampleScenario	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
50bdf0aa-a319-42d8-9863-8d0005d8c8cc	system	2023-06-12 14:31:35.313672	DELETE	Medication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
db16ad55-51ad-454d-b3f8-b739cb25472e	system	2023-06-12 14:31:35.316082	CREATE	RequestGroup	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
dee589dc-31d2-4d56-bb5e-36f826183a61	system	2023-06-12 14:31:35.313449	READ	Location	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5d742661-3d90-4e26-87a8-768dba4109f2	system	2023-06-12 14:31:35.315171	DELETE	OperationOutcome	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3847378a-26b9-48d3-bfa9-e04f51d14535	system	2023-06-12 14:31:35.316737	READ	Subscription	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6f08dbaa-b82b-4f3f-8e51-28508513be48	system	2023-06-12 14:31:35.314544	CREATE	MolecularSequence	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0ee1d2b7-b2f5-4d95-9305-f3607d9c26f8	system	2023-06-12 14:31:35.316075	DELETE	RelatedPerson	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9f180781-82c9-4acf-8ec6-ab1e08d84e4f	system	2023-06-12 14:31:35.312916	CREATE	HealthcareService	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ab34bdb9-96b1-454a-8079-989482f0602b	system	2023-06-12 14:31:35.315997	CREATE	Questionnaire	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
72c80652-1600-4696-8ad1-77d83aa9cca1	system	2023-06-12 14:31:35.316913	DELETE	SubstanceProtein	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bff80b03-9efc-428c-95ea-509d2a301037	system	2023-06-12 14:31:35.31764	READ	VisionPrescription	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e3aaff8a-f519-4095-bce7-1211900bb4ef	system	2023-06-12 14:31:35.311461	UPDATE	Claim	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8ad03e13-ef80-4deb-95b9-2aefab4af1fd	system	2023-06-12 14:31:35.316927	READ	SubstanceReferenceInformation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
135c1b1d-b2e0-4a4b-927e-ad6eada22e6d	system	2023-06-12 14:31:35.311487	UPDATE	ClaimResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e7994f89-00e3-42b6-b47a-b563cb0f292d	system	2023-06-12 14:31:35.316145	UPDATE	ResearchElementDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
293f2bb9-1dc4-4046-90a3-6fd0fe0f6d14	system	2023-06-12 14:31:35.311389	DELETE	CatalogEntry	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bcccab0e-a272-473e-b729-065348934a96	system	2023-06-12 14:31:35.317111	READ	SupplyDelivery	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
78a9ef51-06da-4efe-8209-5d11484c7459	system	2023-06-12 14:31:35.312601	UPDATE	Evidence	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2e6881d1-9178-41e2-8e1f-f30f7e4e431f	system	2023-06-12 14:31:35.311297	READ	CapabilityStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
773c82f5-7d53-48fc-85b9-a33d659b666b	system	2023-06-12 14:31:35.316627	CREATE	StructureDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
da187b5b-9b91-47d5-96c2-61f4d94655c2	system	2023-06-12 14:31:35.317536	READ	TestReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c6cee250-b092-44ae-9c57-0866ba9a0fd3	system	2023-06-12 14:31:35.315106	READ	ObservationDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cb34ef53-1629-45d3-b0cd-6e34b4e2abcd	system	2023-06-12 14:31:35.315044	UPDATE	Observation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1698e15b-396e-4cc3-b647-e6691490447a	system	2023-06-12 14:31:35.316581	READ	SpecimenDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
328ceb8b-eab5-4045-adc0-00775724233a	system	2023-06-12 14:31:35.311609	DELETE	CommunicationRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
40add0ee-7842-474f-9baf-2d3eb8dbcacc	system	2023-06-12 14:31:35.311039	READ	AllergyIntolerance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6827a912-956d-4286-ae26-6bc4dbc4a939	system	2023-06-12 14:31:35.311955	DELETE	Coverage	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
65b58519-b3d2-4ba6-ba17-d9d85e1217da	system	2023-06-12 14:31:35.312165	UPDATE	DeviceDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5020bc47-82a5-42b0-bea9-3775c7a5239d	system	2023-06-12 14:31:35.312876	UPDATE	Group	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4921d175-966f-4220-bd78-e5f05598f326	system	2023-06-12 14:31:35.312607	DELETE	Evidence	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7a4141ef-22e0-45a8-8af2-0554881522dd	system	2023-06-12 14:31:35.314459	CREATE	MedicinalProductUndesirableEffect	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e563deee-0dfa-4458-9e37-bcfca7f58732	system	2023-06-12 14:31:35.31622	DELETE	ResearchSubject	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ec3e6be5-3532-4463-87d9-99b40dcc1c69	system	2023-06-12 14:31:35.312152	CREATE	DeviceDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
59b02fca-3e99-47f3-b526-12bdb4df5d73	system	2023-06-12 14:31:35.31209	DELETE	CoverageEligibilityResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2bdcb2c2-602c-4d4f-bd8e-1e4943ecc24d	system	2023-06-12 14:31:35.314238	READ	MedicinalProductAuthorization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d88952aa-6de1-447f-b3bd-b706520ecd52	system	2023-06-12 14:31:35.316986	UPDATE	SubstanceSpecification	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8b1162c4-5741-4388-8f07-57388960910e	system	2023-06-12 14:31:35.311098	READ	AppointmentResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0c542493-3448-433f-8a29-fd2d9147f9af	system	2023-06-12 14:31:35.311553	CREATE	Communication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
53ec08da-84a7-4d5d-8f26-467d02dc4b63	system	2023-06-12 14:31:35.311527	CREATE	CodeSystem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4f48ce8f-733e-4f8e-addb-8daaf342f9f1	system	2023-06-12 14:31:35.311356	UPDATE	CareTeam	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5d0e4dcd-c2b8-426a-8b3d-2bb3aa32ea6a	system	2023-06-12 14:31:35.31124	UPDATE	BodyStructure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
347bf215-52b2-41d2-a764-2d880e42ddc3	system	2023-06-12 14:31:35.312482	DELETE	EnrollmentRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
726499f8-92be-43d6-bc8d-b6e0bb5c0469	system	2023-06-12 14:31:35.311507	READ	ClinicalImpression	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9555adac-564a-42e1-bc08-3a9f74540cf9	system	2023-06-12 14:31:35.311546	DELETE	CodeSystem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ce0633f4-c86b-4229-860a-21ae730e21e8	system	2023-06-12 14:31:35.314407	CREATE	MedicinalProductPackaged	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6aa467c1-2e41-41f4-bf3e-b5fe43249fe4	system	2023-06-12 14:31:35.312043	DELETE	CoverageEligibilityRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
56006685-942c-4f2b-9f04-0cdb36d33a88	system	2023-06-12 14:31:35.3167	CREATE	StructureMap	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b9c1a6ad-c435-4997-a64d-afd45695c2eb	system	2023-06-12 14:31:35.310974	UPDATE	ActivityDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
689e7b1e-3867-445b-ab93-83c73d31efc9	system	2023-06-12 14:31:35.311076	UPDATE	Appointment	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0ae9d7d1-8751-4a5c-8db1-fc89a79ddb53	system	2023-06-12 14:31:35.314477	DELETE	MedicinalProductUndesirableEffect	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1a2aa3d1-6c31-4fb5-98b2-7ef91092453f	system	2023-06-12 14:31:35.311402	READ	ChargeItem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4565cda9-62d2-4d03-bbc1-42d046f7a2d8	system	2023-06-12 14:31:35.312395	DELETE	EffectEvidenceSynthesis	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e1441d90-e92b-4d5f-aabe-aafcfbdb3b0f	system	2023-06-12 14:31:35.316845	DELETE	SubstanceNucleicAcid	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e70d0592-18a1-4036-ac26-0ac374bb42fc	system	2023-06-12 14:31:35.316003	READ	Questionnaire	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
60f279df-c7f7-4398-8888-8ebf53af9744	system	2023-06-12 14:31:35.316947	CREATE	SubstanceSourceMaterial	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f9656027-4fac-4de1-8b7f-d9c1c1c94577	system	2023-06-12 14:31:35.314536	DELETE	MessageHeader	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
97fcf72e-9f4c-4f11-b63a-cd4be4ee385a	system	2023-06-12 14:31:35.313456	UPDATE	Location	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ec3aa194-83ba-4dcd-9304-66fe546c7c54	system	2023-06-12 14:31:35.314138	DELETE	MedicationKnowledge	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
800352fa-54a7-449f-806f-8f706b258930	system	2023-06-12 14:31:35.316196	UPDATE	ResearchSubject	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2a193e2b-41bd-45b7-847d-d7105b13e5e7	system	2023-06-12 14:31:35.316609	DELETE	SpecimenDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
58276461-2327-407a-afa7-b51f615c095d	system	2023-06-12 14:31:35.313147	UPDATE	InsurancePlan	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3e8f810e-98c4-4435-a790-26e96cad36f1	system	2023-06-12 14:31:35.315267	CREATE	Patient	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a42ecdce-5533-421d-a0a4-affb4612b3b6	system	2023-06-12 14:31:35.312321	CREATE	DocumentManifest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9d95744b-ef92-402d-8143-bbde43bba81d	system	2023-06-12 14:31:35.312703	READ	FamilyMemberHistory	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
93ce850e-0bef-4539-85af-27fea3685384	system	2023-06-12 14:31:35.312469	READ	EnrollmentRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
25fd586a-6c81-41e4-bd24-3cb78dd0a38a	system	2023-06-12 14:31:35.31267	CREATE	ExplanationOfBenefit	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4b52cfa9-ae05-4c56-a642-a72c1c8961e5	system	2023-06-12 14:31:35.31175	DELETE	Consent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
691f3cf5-ad12-4142-8dac-49009f79f510	system	2023-06-12 14:31:35.314327	READ	MedicinalProductIngredient	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
74f3095a-1ce9-4b1a-aaab-e56a85fabfca	system	2023-06-12 14:31:35.312455	DELETE	Endpoint	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c2a1d159-4ceb-461a-9539-0efa9a93f7fa	system	2023-06-12 14:31:35.31501	DELETE	NutritionOrder	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
721314a2-441a-44e1-81ea-cd4cba57808e	system	2023-06-12 14:31:35.311731	CREATE	Consent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2ca5b196-4ef3-487d-98ab-d6bb2c9aa1ee	system	2023-06-12 14:31:35.311669	DELETE	Composition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b7eeaba2-504e-444a-a959-dc360c1de0d4	system	2023-06-12 14:31:35.312961	READ	ImagingStudy	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
eb2b4676-d769-40bd-abe3-9042d54bfcda	system	2023-06-12 14:31:35.311409	UPDATE	ChargeItem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
456a8685-dd63-42a3-a5a4-9f0ba53d882e	system	2023-06-12 14:31:35.313492	CREATE	Measure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
aed44509-4d9d-4552-97b4-254753646395	system	2023-06-12 14:31:35.313088	UPDATE	ImmunizationRecommendation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4db4696a-a19b-43ee-ac0e-458040512589	system	2023-06-12 14:31:35.31599	DELETE	Provenance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f039e91e-b25c-4692-ba9f-5021b5cc20a7	system	2023-06-12 14:31:35.311158	UPDATE	Basic	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4bb9dfeb-8d5b-4cfa-a8ca-e54374b01c2a	system	2023-06-12 14:31:35.311738	READ	Consent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
aae5edc5-eed9-4cf3-a725-7a1a0031b2fb	system	2023-06-12 14:31:35.311027	CREATE	AllergyIntolerance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7f1385ff-d339-48fa-a0ff-313622301644	system	2023-06-12 14:31:35.314132	UPDATE	MedicationKnowledge	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4265b933-fcf2-4ba9-bb6b-89c56230e336	system	2023-06-12 14:31:35.313281	UPDATE	Invoice	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6cba7367-7b17-47be-881d-40580b63b4f5	system	2023-06-12 14:31:35.317517	UPDATE	TerminologyCapabilities	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0f77d646-c93d-40a2-b645-adca5cb88b62	system	2023-06-12 14:31:35.316379	DELETE	ServiceRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6c5bb3cf-0119-41c5-97b8-36f196ca2c31	system	2023-06-12 14:31:35.316009	UPDATE	Questionnaire	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bd2b5b8c-ca57-4356-bf53-1199b7047c4f	system	2023-06-12 14:31:35.317542	UPDATE	TestReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a98d957f-78cf-4603-8fd7-30fe94af7056	system	2023-06-12 14:31:35.313095	DELETE	ImmunizationRecommendation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0f88696e-2970-47c2-9f15-42d752c72c94	system	2023-06-12 14:31:35.311533	READ	CodeSystem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b2b04992-f5b9-4530-9a7f-334b8f611726	system	2023-06-12 14:31:35.312942	CREATE	ImagingStudy	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4b471b87-50ad-4a44-9964-07142f48cfa9	system	2023-06-12 14:31:35.314398	DELETE	MedicinalProductManufactured	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c166e542-fa81-4a54-8555-7c283bc994d4	system	2023-06-12 14:31:35.311493	DELETE	ClaimResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
82b23b57-99db-4457-a0a1-9b1fbdaa5178	system	2023-06-12 14:31:35.311566	UPDATE	Communication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
abd4da1b-103b-4d50-a43f-82cfdcfb1884	system	2023-06-12 14:31:35.312463	CREATE	EnrollmentRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1ca20771-e3db-43d1-9d73-e44df5169c66	system	2023-06-12 14:31:35.311677	CREATE	ConceptMap	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
444fcd30-ecc9-479c-bb30-eb7dc436e911	system	2023-06-12 14:31:35.316094	UPDATE	RequestGroup	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4392d052-70a4-4601-8db3-8103787af2d5	system	2023-06-12 14:31:35.311628	READ	CompartmentDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f84e679a-0d0c-49d2-9e32-cc3c44e69139	system	2023-06-12 14:31:35.313334	READ	Linkage	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
25d65bdc-5323-4472-8c6e-724d648fdc6e	system	2023-06-12 14:31:35.3143	READ	MedicinalProductIndication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5ddee4d7-dedb-44bc-a4d6-f3907a3ca078	system	2023-06-12 14:31:35.317479	CREATE	Task	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2e4b8f8e-92d8-4877-b9f8-1c874dd552f2	system	2023-06-12 14:31:35.317505	CREATE	TerminologyCapabilities	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
39af62ba-270b-490c-912f-649005cad735	system	2023-06-12 14:31:35.312572	DELETE	EventDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
aa0b3791-2f38-4d17-b8be-6f56868c3aa6	system	2023-06-12 14:31:35.314471	UPDATE	MedicinalProductUndesirableEffect	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5695ca47-cd68-4b90-bf84-62fc6227745c	system	2023-06-12 14:31:35.315938	DELETE	PractitionerRole	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
19e34a30-f814-48b4-8ecc-b74a3fc77b2a	system	2023-06-12 14:31:35.315466	CREATE	PlanDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e20a2471-fa72-4428-ba90-186705f2d0f3	system	2023-06-12 14:31:35.312408	CREATE	Encounter	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
744daea8-7001-4b77-ade8-481549e214f6	system	2023-06-12 14:31:35.314366	DELETE	MedicinalProductInteraction	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
20df392d-d079-41ee-b49c-8839f81f9012	system	2023-06-12 14:31:35.316637	READ	StructureDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
440b3992-388a-448d-9d6d-26507edaaf9b	system	2023-06-12 14:31:35.315823	DELETE	Practitioner	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3ff0580e-cdf3-406c-bba8-912749e7a26a	system	2023-06-12 14:31:35.317619	UPDATE	VerificationResult	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bd6e4aec-bf31-475a-8120-cc6cbe465ff1	system	2023-06-12 14:31:35.311849	READ	Coverage	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
83b7c2c9-7a20-4d02-ac14-81b299f71b7c	system	2023-06-12 14:31:35.312786	DELETE	Flag	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f034abb3-085b-489b-9ee1-3fa297f6a603	system	2023-06-12 14:31:35.315964	DELETE	Procedure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
64cac4d6-8df5-42c5-bcb8-8773943d1f3b	system	2023-06-12 14:31:35.314264	READ	MedicinalProductContraindication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3f56f24d-14c9-4a31-ad0e-95bf3ea7c01f	system	2023-06-12 14:31:35.31494	READ	NutritionOrder	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0009fef9-edaf-46c3-a773-a71e10a5edfe	system	2023-06-12 14:31:35.315387	READ	PaymentNotice	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2082fc56-56ca-4653-94c2-3990017f5c94	system	2023-06-12 14:31:35.311012	UPDATE	AdverseEvent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e1f72454-2a1a-4b2e-a0e9-899cfade88bb	system	2023-06-12 14:31:35.317433	READ	SupplyRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3b061f49-2efb-407d-a5ac-e24eed2901a8	system	2023-06-12 14:31:35.316239	UPDATE	RiskAssessment	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4e4cbae6-c102-43ab-aec4-a5ffa88e6c5a	system	2023-06-12 14:31:35.312328	READ	DocumentManifest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7fa319d4-42cb-4279-bb06-357e1fd91bd3	system	2023-06-12 14:31:35.315127	CREATE	OperationDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f5c2d457-6714-459f-9c27-96f5797b2026	system	2023-06-12 14:31:35.312448	UPDATE	Endpoint	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9aebd5e0-a533-4491-92e2-b7ca247d8da9	system	2023-06-12 14:31:35.314224	DELETE	MedicinalProduct	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f6c2340f-ba85-4226-b790-51aa67d97085	system	2023-06-12 14:31:35.311441	DELETE	ChargeItemDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6a2fd348-1fc4-4fa1-a8ca-b7cd59a368a5	system	2023-06-12 14:31:35.312935	DELETE	HealthcareService	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a92075be-bbc0-4209-8603-b36060daea0b	system	2023-06-12 14:31:35.312794	CREATE	Goal	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1e6843c6-882b-4538-91ec-145994645786	system	2023-06-12 14:31:35.314172	CREATE	MedicationStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f6c5a7a3-de07-4655-9828-d1006e0aa9ac	system	2023-06-12 14:31:35.315472	READ	PlanDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7262527c-07c4-4ee0-af9f-ca543e5cbf0b	system	2023-06-12 14:31:35.312863	CREATE	Group	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
08601462-d5eb-471f-8af5-cf792961e326	system	2023-06-12 14:31:35.31634	UPDATE	SearchParameter	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b723d0a4-c7eb-40ba-819b-ef3fe9e820b6	system	2023-06-12 14:31:35.316745	UPDATE	Subscription	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
daeda3e5-bc55-402e-b23e-ea4a43811c47	system	2023-06-12 14:31:35.31273	READ	Flag	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
486c755d-7603-410f-bb2a-9afacaa9db44	system	2023-06-12 14:31:35.311191	DELETE	Binary	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2c622be9-0078-4765-808f-174d17d03fa2	system	2023-06-12 14:31:35.312348	CREATE	DocumentReference	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
809813e5-4bc8-4798-9b76-627e4f602a93	system	2023-06-12 14:31:35.311975	CREATE	CoverageEligibilityRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cdb87c59-7fcf-4a3d-99b6-c971b0b8da90	system	2023-06-12 14:31:35.317511	READ	TerminologyCapabilities	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ad1bc404-1bc3-4bac-a34a-77943eb72a2d	system	2023-06-12 14:31:35.310945	UPDATE	Account	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bad78448-837a-4c3e-a300-0b31ca46bdb0	system	2023-06-12 14:31:35.311429	READ	ChargeItemDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7ee96e41-8b68-4aac-b392-6257ac356c09	system	2023-06-12 14:31:35.31099	DELETE	ActivityDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
661edd48-757d-4156-a0e1-d04f93ed8fbc	system	2023-06-12 14:31:35.313888	READ	MedicationAdministration	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8683e174-d33d-43b6-ba93-8d3b4da5b412	system	2023-06-12 14:31:35.311053	DELETE	AllergyIntolerance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c5cf189d-6278-4edd-9eb9-770f3ef7f54e	system	2023-06-12 14:31:35.311501	CREATE	ClinicalImpression	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1ae576cb-2260-48d8-a56f-e22b613da365	system	2023-06-12 14:31:35.312842	READ	GraphDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
41809a8e-a865-4758-a43a-2b90bf5757e8	system	2023-06-12 14:31:35.312442	READ	Endpoint	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a2abc18c-e1bc-4a5c-b597-501308a4b5ad	system	2023-06-12 14:31:35.312689	DELETE	ExplanationOfBenefit	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4b3a0375-d1df-484a-968b-d6974c938aa0	system	2023-06-12 14:31:35.315242	UPDATE	Parameters	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
438f5d60-d2d5-415e-8c92-1dc6c58cb1c2	system	2023-06-12 14:31:35.316418	CREATE	Specimen	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2ee7e5cd-cdb5-4073-b296-342d77f31fde	system	2023-06-12 14:31:35.311383	UPDATE	CatalogEntry	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a13eac76-6230-4bc9-9a9d-5f9f6adb8b97	system	2023-06-12 14:31:35.314556	UPDATE	MolecularSequence	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f01da618-0289-4acc-b049-8f47b74be07b	system	2023-06-12 14:31:35.31688	DELETE	SubstancePolymer	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7e32c841-82ac-4a22-aaf4-6c0845f7927f	system	2023-06-12 14:31:35.315441	CREATE	Person	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
29bf8d68-6da8-4787-a1a3-3f5314977b0d	system	2023-06-12 14:31:35.316367	READ	ServiceRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
522c96d7-77fb-4e43-9c4d-639c1291edbb	system	2023-06-12 14:31:35.316151	DELETE	ResearchElementDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2cfe6774-89df-4fdc-83df-07a16eeb28ba	system	2023-06-12 14:31:35.313114	READ	ImplementationGuide	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
42ba5994-d12c-4a5a-ab1d-cc3e69dd3559	system	2023-06-12 14:31:35.313263	CREATE	Invoice	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
60056f1c-1d27-4341-a223-2d303a530c7b	system	2023-06-12 14:31:35.316278	CREATE	Schedule	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7ed6e529-3636-47a3-a474-c55626bd951a	system	2023-06-12 14:31:35.314232	CREATE	MedicinalProductAuthorization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
388c0da9-dcde-461e-ba55-1802a8aeaf68	system	2023-06-12 14:31:35.315379	CREATE	PaymentNotice	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
de154ae6-39dc-49c6-a6d1-96eb342b4c1a	system	2023-06-12 14:31:35.311172	CREATE	Binary	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ab7056da-2794-457e-b376-d2952fb53f27	system	2023-06-12 14:31:35.314465	READ	MedicinalProductUndesirableEffect	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
72eb6414-097b-4f7b-9007-6ac4ff68d01a	system	2023-06-12 14:31:35.313049	READ	ImmunizationEvaluation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
df236bbc-3ac5-4baa-b93f-3f06a69a363d	system	2023-06-12 14:31:35.312634	DELETE	EvidenceVariable	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
fb33a8a9-c976-45f6-8b97-43405dc2397e	system	2023-06-12 14:31:35.316245	DELETE	RiskAssessment	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
791b9ac0-de69-4add-a1eb-6bb36c0a3ee6	system	2023-06-12 14:31:35.311146	CREATE	Basic	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5995ccd2-5d2a-469f-b87a-d7e03f55a7a0	system	2023-06-12 14:31:35.313579	READ	MeasureReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
dd31ee30-b1ea-4b64-b394-d643cdfcf2af	system	2023-06-12 14:31:35.312132	READ	Device	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8105a74e-d99b-45ad-8bbd-8c3bbee1fc39	system	2023-06-12 14:31:35.31457	CREATE	NamingSystem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
97fdc08b-eedf-460f-88b1-5569b333e74e	system	2023-06-12 14:31:35.312816	DELETE	Goal	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
24968c05-2617-4ade-8387-9c5e8f09592e	system	2023-06-12 14:31:35.31451	DELETE	MessageDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
99d6c7b7-0809-47f1-a7d1-d0a7fc5f5cb9	system	2023-06-12 14:31:35.312278	DELETE	DeviceUseStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d440ecc9-9763-4c3e-97a2-e0e4390097c4	system	2023-06-12 14:31:35.315153	CREATE	OperationOutcome	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
98898682-c171-42db-9dc6-654bdfb399dd	system	2023-06-12 14:31:35.316714	UPDATE	StructureMap	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
291327d3-ecbd-4f30-b7f4-b15a074d0a58	system	2023-06-12 14:31:35.31133	UPDATE	CarePlan	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9d2cef86-062d-4f50-beaa-43d296af0b41	system	2023-06-12 14:31:35.314258	CREATE	MedicinalProductContraindication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9f6805b5-c495-475b-8c0d-6e0fa8397300	system	2023-06-12 14:31:35.311084	DELETE	Appointment	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5279841b-d668-460e-b335-b3bc9dce8df0	system	2023-06-12 14:31:35.311199	CREATE	BiologicallyDerivedProduct	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1d9e550a-9583-4796-a3fb-15d24305c1e2	system	2023-06-12 14:31:35.311019	DELETE	AdverseEvent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
312c6152-c0d4-400f-94d3-f168df44135e	system	2023-06-12 14:31:35.313287	DELETE	Invoice	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9278d051-977b-4f43-8695-a93ef3ac585c	system	2023-06-12 14:31:35.313315	DELETE	Library	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cc1b2c21-d4c1-4aab-80bf-4fe51c95279b	system	2023-06-12 14:31:35.316133	CREATE	ResearchElementDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
54a3d14b-80fd-40b8-bfce-0188b47c136e	system	2023-06-12 14:31:35.316888	CREATE	SubstanceProtein	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
43bf6b24-f2f4-4cf6-a58e-f471e9818a74	system	2023-06-12 14:31:35.31425	DELETE	MedicinalProductAuthorization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f9c0b6a4-ead3-41ac-8289-162a00a60311	system	2023-06-12 14:31:35.312824	CREATE	GraphDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
fbe6c2fb-5b3c-4a76-b4ec-d9089e742999	system	2023-06-12 14:31:35.315408	CREATE	PaymentReconciliation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
edf11e5d-9df3-4bd1-a73d-979ed399c398	system	2023-06-12 14:31:35.315946	CREATE	Procedure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
12ef8083-20cd-40ab-a078-efd687c8aeb7	system	2023-06-12 14:31:35.316227	CREATE	RiskAssessment	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
41b4d7bc-f911-4bf9-9338-93f503c5f3f8	system	2023-06-12 14:31:35.313564	DELETE	Measure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2392210d-ccb3-4f00-897e-3d1927ee83df	system	2023-06-12 14:31:35.311649	CREATE	Composition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f92f8582-0db3-4e6f-ab2a-e813dfd99367	system	2023-06-12 14:31:35.315159	READ	OperationOutcome	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b8dba8fa-ff69-4413-b86e-64fe5e83924b	system	2023-06-12 14:31:35.311104	UPDATE	AppointmentResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4d0af14f-ed15-4dd1-b48d-19d35cc2e90f	system	2023-06-12 14:31:35.31249	CREATE	EnrollmentResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d89862be-a260-42cc-8316-72ca78048b34	system	2023-06-12 14:31:35.312615	CREATE	EvidenceVariable	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5de5c755-2b42-4f6e-99c2-3bd4083adf3e	system	2023-06-12 14:31:35.312286	CREATE	DiagnosticReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a8450a43-8e28-4f91-9183-44acf93f7896	system	2023-06-12 14:31:35.312662	DELETE	ExampleScenario	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
15507065-808b-48ee-8aec-916aa6cbef0b	system	2023-06-12 14:31:35.316113	READ	ResearchDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
eb2367b8-3303-482f-ac82-ef3d1c3b031a	system	2023-06-12 14:31:35.316125	DELETE	ResearchDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
69201c3a-3d24-498e-a507-53a632379ff3	system	2023-06-12 14:31:35.313308	UPDATE	Library	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
898e5450-f988-4531-a8b6-14c6a8fc164c	system	2023-06-12 14:31:35.312355	READ	DocumentReference	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
56b284f0-8b09-45f2-a7a5-576e413586b1	system	2023-06-12 14:31:35.312709	UPDATE	FamilyMemberHistory	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b185fe01-a4a8-444f-9e52-4d1997c5e569	system	2023-06-12 14:31:35.31156	READ	Communication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2b5de9ee-1e91-4e09-9839-275ece7989ad	system	2023-06-12 14:31:35.314105	UPDATE	MedicationDispense	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
dc0f27b7-20e0-46aa-890d-e944ddfb165f	system	2023-06-12 14:31:35.311513	UPDATE	ClinicalImpression	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
fecbac3a-7e2a-4cd6-809c-265e4cc7f03c	system	2023-06-12 14:31:35.317498	DELETE	Task	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
48999795-39e4-4e16-96bc-1c8d14478800	system	2023-06-12 14:31:35.312084	UPDATE	CoverageEligibilityResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
360a81c4-a47c-4e4c-a09f-a7e733b08ccf	system	2023-06-12 14:31:35.311635	UPDATE	CompartmentDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3540c260-4d0b-4072-90d1-599956f102d3	system	2023-06-12 14:31:35.316818	DELETE	Substance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
11efe430-b686-4c85-9918-2847d6c822bf	system	2023-06-12 14:31:35.311227	CREATE	BodyStructure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f01a11a8-dde3-4034-87e9-78d2f8190a5a	system	2023-06-12 14:31:35.315931	UPDATE	PractitionerRole	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0462886c-cfdf-4a92-8fb8-337cbb011047	system	2023-06-12 14:31:35.312428	DELETE	Encounter	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
81e4dcec-68df-447c-8e64-b4d2e4ba4fd1	system	2023-06-12 14:31:35.311233	READ	BodyStructure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ffa76ceb-1015-4870-93d1-b851f0857511	system	2023-06-12 14:31:35.311344	CREATE	CareTeam	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7b04fa47-432a-4367-b40d-721b19f72f13	system	2023-06-12 14:31:35.311475	CREATE	ClaimResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
863db4b1-dca9-49fb-b14d-ffed97e4bfc8	system	2023-06-12 14:31:35.313403	READ	List	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5548217f-85cb-4d89-a249-af328419741a	system	2023-06-12 14:31:35.316164	READ	ResearchStudy	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3e3978dc-4984-417d-8420-e2fba0c1dbb7	system	2023-06-12 14:31:35.311422	CREATE	ChargeItemDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f8988f74-a0f3-43ce-9c9e-796b176b9f6e	system	2023-06-12 14:31:35.314321	CREATE	MedicinalProductIngredient	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0857a9d0-0ce3-46c6-a783-9f16328ea3a1	system	2023-06-12 14:31:35.313516	READ	Measure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1d8200ea-ba35-4a48-91be-26216fc6c698	system	2023-06-12 14:31:35.311539	UPDATE	CodeSystem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
631eda90-e70f-4e9a-b99a-f5e27d567d3b	system	2023-06-12 14:31:35.312502	UPDATE	EnrollmentResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
38f0f858-1c66-4e13-bd42-7289c8f0ef77	system	2023-06-12 14:31:35.313592	DELETE	MeasureReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f41d0450-7793-43ab-af53-576ee454743b	system	2023-06-12 14:31:35.311982	READ	CoverageEligibilityRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
88e26356-d258-4592-9260-dec1f2de41a5	system	2023-06-12 14:31:35.316826	CREATE	SubstanceNucleicAcid	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8b6be6d3-5544-4e45-89c5-7c85373fb32b	system	2023-06-12 14:31:35.315484	DELETE	PlanDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c3205db7-0599-485e-ae2a-6fdeef270790	system	2023-06-12 14:31:35.314793	CREATE	NutritionOrder	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
63b5bcf8-d8a6-400f-80a4-77f996a71477	system	2023-06-12 14:31:35.31428	UPDATE	MedicinalProductContraindication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
25f55183-f494-45d1-a84d-2a3b24dc1d24	system	2023-06-12 14:31:35.313014	DELETE	Immunization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
511edcdf-9027-4103-afb6-2e1119db04a0	system	2023-06-12 14:31:35.316859	READ	SubstancePolymer	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
666dfd93-843c-4b98-9734-533ec9a4b7e4	system	2023-06-12 14:31:35.312882	DELETE	Group	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
510cea58-ca2f-4534-a292-eb3ab0f54522	system	2023-06-12 14:31:35.312198	DELETE	DeviceMetric	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cc723eca-5054-4b21-9333-82621020f4fb	system	2023-06-12 14:31:35.317523	DELETE	TerminologyCapabilities	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
98020064-1a04-48dd-8ef3-a2b132fc338d	system	2023-06-12 14:31:35.311684	READ	ConceptMap	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
85a69cc8-84d9-4926-853d-2e42da2fad1f	system	2023-06-12 14:31:35.312716	DELETE	FamilyMemberHistory	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
744076eb-e659-4bf0-8c90-bc47bc32eef9	system	2023-06-12 14:31:35.312415	READ	Encounter	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
362ea86e-22da-46bc-9113-4ca4e2e589db	system	2023-06-12 14:31:35.312869	READ	Group	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a34ad344-648c-47d5-87a0-78ca582b2afb	system	2023-06-12 14:31:35.313723	CREATE	MedicationAdministration	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d62cb215-1966-4782-a3c3-4c55574cd5a2	system	2023-06-12 14:31:35.313341	UPDATE	Linkage	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ee01e719-6155-42ba-aa81-5498f592c8d3	system	2023-06-12 14:31:35.316832	READ	SubstanceNucleicAcid	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d9c88107-9d6e-4025-a191-055fb87a1539	system	2023-06-12 14:31:35.311219	DELETE	BiologicallyDerivedProduct	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bd4d6f05-3674-44c4-86f8-e14d026cf721	system	2023-06-12 14:31:35.3161	DELETE	RequestGroup	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
8bbfae4c-4441-4e73-9553-204ca5f2bfa7	system	2023-06-12 14:31:35.3154	DELETE	PaymentNotice	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4e878f53-b87a-477f-8698-fad908f8a6c9	system	2023-06-12 14:31:35.31362	UPDATE	Media	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c511d585-99a1-4955-8ee0-7aaebdc05868	system	2023-06-12 14:31:35.316015	DELETE	Questionnaire	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4890063e-69f9-4ab6-a821-673fddf41c35	system	2023-06-12 14:31:35.315002	UPDATE	NutritionOrder	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7de9a057-f61b-4c98-b817-108469885192	system	2023-06-12 14:31:35.311323	READ	CarePlan	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1a9a40df-9cc5-4a84-a6f4-9aa906ea7147	system	2023-06-12 14:31:35.311164	DELETE	Basic	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
99aa3e3d-e38f-49c7-b525-032128a22047	system	2023-06-12 14:31:35.312421	UPDATE	Encounter	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b5dc3a0d-5f74-4045-8717-ca7dfc8765c6	system	2023-06-12 14:31:35.312855	DELETE	GraphDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
685d4535-b304-464b-9b62-e0d280c04b81	system	2023-06-12 14:31:35.315185	READ	Organization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
db174ad0-c268-41ae-8166-d94c5572df82	system	2023-06-12 14:31:35.316041	DELETE	QuestionnaireResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
37229321-77cb-4403-b2b5-bb9b81ee1496	system	2023-06-12 14:31:35.312313	DELETE	DiagnosticReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a96dece0-4c06-4ed8-9853-024e56231f6f	system	2023-06-12 14:31:35.316346	DELETE	SearchParameter	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
dd65847a-19f3-463b-8997-b171d3456c1b	system	2023-06-12 14:31:35.313141	READ	InsurancePlan	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1d2d2a0e-9eec-46f4-9dc6-c77e3ced7c0f	system	2023-06-12 14:31:35.311178	READ	Binary	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f3d411f3-1490-43da-875e-c4642d938403	system	2023-06-12 14:31:35.315248	DELETE	Parameters	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c94f2721-5105-48af-b43d-eb00af1c0a2c	system	2023-06-12 14:31:35.315273	READ	Patient	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
389a87b8-7efc-49e5-895d-cab7f113c1cf	system	2023-06-12 14:31:35.311303	UPDATE	CapabilityStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
04f567ec-887f-496b-9464-7d57929d961b	system	2023-06-12 14:31:35.316264	UPDATE	RiskEvidenceSynthesis	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e0e55dbe-ab75-477d-9eaa-2ea38987c697	system	2023-06-12 14:31:35.312996	READ	Immunization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
704971ac-1626-4117-b4d9-53fa19aba722	system	2023-06-12 14:31:35.316436	DELETE	Specimen	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c8677238-e454-43a8-aa90-717d94f5e12c	system	2023-06-12 14:31:35.316939	DELETE	SubstanceReferenceInformation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6f998456-7b60-4a9a-860c-1253b2c037a0	system	2023-06-12 14:31:35.313008	UPDATE	Immunization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
272c00e8-6921-4fc9-9043-8cc3bfa2b76c	system	2023-06-12 14:31:35.314433	CREATE	MedicinalProductPharmaceutical	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
46bd4e71-7d61-4841-96bd-e0a90ce561c4	system	2023-06-12 14:31:35.313302	READ	Library	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b22b8503-e874-4b33-bdf8-04bf99eb9034	system	2023-06-12 14:31:35.316852	CREATE	SubstancePolymer	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
09c8c63d-e83e-4201-b41a-345c609347f7	system	2023-06-12 14:31:35.314185	UPDATE	MedicationStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d2e11f1d-3b73-4d0c-96e0-3272e714805f	system	2023-06-12 14:31:35.314244	UPDATE	MedicinalProductAuthorization	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
979d7a58-fe85-4071-a4b3-4c96f1631d3e	system	2023-06-12 14:31:35.314425	DELETE	MedicinalProductPackaged	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
68c89e92-294e-40f0-8b7a-478f6baf36f0	system	2023-06-12 14:31:35.316158	CREATE	ResearchStudy	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c5097683-9252-45e3-b63d-6440c48f51f4	system	2023-06-12 14:31:35.311362	DELETE	CareTeam	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0006173d-42fd-4929-84ac-f488fa82580b	system	2023-06-12 14:31:35.316258	READ	RiskEvidenceSynthesis	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cb95a2e3-fd95-433a-9f0d-9b7fce055192	system	2023-06-12 14:31:35.317632	CREATE	VisionPrescription	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b40cb591-764c-4fc1-802f-74093b3ebcf3	system	2023-06-12 14:31:35.311455	READ	Claim	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a228bb0b-26e2-476f-aaa0-acaf803471ff	system	2023-06-12 14:31:35.316177	DELETE	ResearchStudy	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0e5e5c7a-396e-41c2-9228-2e23fd916881	system	2023-06-12 14:31:35.315165	UPDATE	OperationOutcome	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
712dcddd-27be-440c-8403-e7a100e4a719	system	2023-06-12 14:31:35.311273	DELETE	Bundle	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
65821e94-9561-4e9c-88d5-3b8fe28b817e	system	2023-06-12 14:31:35.31289	CREATE	GuidanceResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
cad7a4e4-d9d9-47bd-8d11-0994dd49fc5a	system	2023-06-12 14:31:35.315119	DELETE	ObservationDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
976cc4d3-e304-4acc-8c7c-6817a6c28eda	system	2023-06-12 14:31:35.316029	READ	QuestionnaireResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e9567b06-d4af-4424-86aa-530fda683268	system	2023-06-12 14:31:35.317555	CREATE	TestScript	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4069f80f-50bc-4d2b-a5c6-ab8b7183d635	system	2023-06-12 14:31:35.311126	READ	AuditEvent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
df3a98df-f93a-4b59-bbf7-41644097d22e	system	2023-06-12 14:31:35.316873	UPDATE	SubstancePolymer	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ed2837ba-5201-49ed-a60f-2996f3682500	system	2023-06-12 14:31:35.310999	CREATE	AdverseEvent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
21511c10-70e1-4001-a850-33bff0dab20c	system	2023-06-12 14:31:35.311336	DELETE	CarePlan	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5d6ea554-df5e-4822-baef-9436542d8ae1	system	2023-06-12 14:31:35.313665	UPDATE	Medication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
592a6949-47e7-4331-9e8d-d2624c23fde5	system	2023-06-12 14:31:35.314562	DELETE	MolecularSequence	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
105a5094-b953-474f-9973-c5a4721e4dd8	system	2023-06-12 14:31:35.316798	READ	Substance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
3c4b2d38-71e2-4461-a195-198dd1d6df4d	system	2023-06-12 14:31:35.316839	UPDATE	SubstanceNucleicAcid	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5d574a89-acb2-499d-baf8-3eb8e26b76fe	system	2023-06-12 14:31:35.311696	DELETE	ConceptMap	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a45c7ffd-2e3a-42ff-8ab4-370273f93204	system	2023-06-12 14:31:35.312509	DELETE	EnrollmentResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
afadaf12-9636-4413-ae3d-fe689cc81452	system	2023-06-12 14:31:35.315427	UPDATE	PaymentReconciliation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7d6051ff-efa4-4e77-aea2-116da5ac3332	system	2023-06-12 14:31:35.311415	DELETE	ChargeItem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4e1a9a59-315a-4877-ab45-4a70186e2997	system	2023-06-12 14:31:35.315447	READ	Person	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a9fb159e-e1a3-45d2-8e51-638b393a8acb	system	2023-06-12 14:31:35.316373	UPDATE	ServiceRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
51844043-ce3e-4c2d-8729-0980f3a31c5b	system	2023-06-12 14:31:35.314353	READ	MedicinalProductInteraction	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
2792775e-1207-4698-9c91-a511c8317d84	system	2023-06-12 14:31:35.315984	UPDATE	Provenance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
267a446f-c6b2-4c18-930a-84144a5c8880	system	2023-06-12 14:31:35.31177	CREATE	Contract	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0163d125-edc6-4e42-a080-22461abf7f38	system	2023-06-12 14:31:35.317452	UPDATE	SupplyRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f4533566-5359-45d1-9090-8dde78bfe0f6	system	2023-06-12 14:31:35.312258	CREATE	DeviceUseStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e7ebd30e-a39b-4271-a10c-49a92c3603a6	system	2023-06-12 14:31:35.317492	UPDATE	Task	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d5e1f6ed-da4c-45e9-8d40-8f818d824571	system	2023-06-12 14:31:35.312655	UPDATE	ExampleScenario	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0820d053-b0ff-4809-95d7-b53f3588c688	system	2023-06-12 14:31:35.312206	CREATE	DeviceRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a40556ec-84b4-4468-a4f0-9821cd1bf019	system	2023-06-12 14:31:35.316933	UPDATE	SubstanceReferenceInformation	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4332b3c9-99c6-4862-98e0-a4bc5472e6b1	system	2023-06-12 14:31:35.31753	CREATE	TestReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7e633f0d-3e3f-4405-814e-a9b04d88815d	system	2023-06-12 14:31:35.316662	UPDATE	StructureDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a311f090-508d-4942-871b-cdbbefb059e8	system	2023-06-12 14:31:35.312265	READ	DeviceUseStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
4d583604-4f21-4c9d-83cc-de364481191a	system	2023-06-12 14:31:35.314286	DELETE	MedicinalProductContraindication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
46549094-ccb7-499c-b350-6a0c4e428cd4	system	2023-06-12 14:31:35.311467	DELETE	Claim	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
bc895f51-c028-4218-b08f-85c17a048cf8	system	2023-06-12 14:31:35.316979	READ	SubstanceSpecification	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
655e5435-f77a-4b3d-be8e-d3ffa674e56c	system	2023-06-12 14:31:35.314152	READ	MedicationRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
43aa4453-f512-439a-95ae-a289cbae330c	system	2023-06-12 14:31:35.312077	READ	CoverageEligibilityResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e341b712-47cd-4da4-9ffb-01f825ecb456	system	2023-06-12 14:31:35.31619	READ	ResearchSubject	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f56e528a-3c33-420e-8e51-0eb52eecf310	system	2023-06-12 14:31:35.317102	CREATE	SupplyDelivery	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
eb481803-6f1e-4588-b961-c26c776e1ceb	system	2023-06-12 14:31:35.31158	CREATE	CommunicationRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c6d28db7-699f-49d7-bae5-9d95c5429705	system	2023-06-12 14:31:35.311656	READ	Composition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7d07a6d6-3878-4f01-8fd3-e446454414fb	system	2023-06-12 14:31:35.314451	DELETE	MedicinalProductPharmaceutical	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d18d4584-549a-4fa2-bea0-f032e190986d	system	2023-06-12 14:31:35.312779	UPDATE	Flag	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
57613760-2dcd-42dc-93df-7ecc04824936	system	2023-06-12 14:31:35.311006	READ	AdverseEvent	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a940e84d-e17f-4741-8d02-3ce7483934c8	system	2023-06-12 14:31:35.313599	CREATE	Media	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
1ba6c6ee-c54f-49f4-bb88-f38f72b8ea88	system	2023-06-12 14:31:35.312172	DELETE	DeviceDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b7b128af-8d2e-47aa-b88b-8c5b00386857	system	2023-06-12 14:31:35.313415	DELETE	List	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
17874a83-f592-49b3-aee1-79a8a183c1aa	system	2023-06-12 14:31:35.311783	UPDATE	Contract	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
b87d25e8-fe89-4f3d-96c4-8388a9709965	system	2023-06-12 14:31:35.312271	UPDATE	DeviceUseStatement	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
92a4552c-1537-4632-9e3a-9de61205d02b	system	2023-06-12 14:31:35.317547	DELETE	TestReport	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e8fa4981-5e95-4909-900b-fde26c922b72	system	2023-06-12 14:31:35.31207	CREATE	CoverageEligibilityResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f4f127b3-c384-43c0-baf2-617f7d483285	system	2023-06-12 14:31:35.312388	UPDATE	EffectEvidenceSynthesis	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
9a74f544-6c55-4d61-8494-86e31234db73	system	2023-06-12 14:31:35.31523	CREATE	Parameters	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
300fda5f-2ed6-4a7e-8c56-a50f0e999704	system	2023-06-12 14:31:35.315924	READ	PractitionerRole	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
19f65e64-3823-4179-a19e-ebb832705d72	system	2023-06-12 14:31:35.314347	CREATE	MedicinalProductInteraction	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
6675bda7-344d-4375-baa1-800b8d9e843b	system	2023-06-12 14:31:35.314158	UPDATE	MedicationRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
d4f9d9c0-ac9e-4349-a8b4-31e7a8b98a5e	system	2023-06-12 14:31:35.316119	UPDATE	ResearchDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f727c08c-ba71-4b2f-a348-5abd7dbf14ea	system	2023-06-12 14:31:35.314333	UPDATE	MedicinalProductIngredient	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
92fb8eb3-2e4d-4218-820a-feb4d5e8febf	system	2023-06-12 14:31:35.3164	UPDATE	Slot	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e89cd0ba-8a79-44e3-9cdf-9880902f7c01	system	2023-06-12 14:31:35.316753	DELETE	Subscription	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
41505aa6-6fe4-489f-b465-03d6e255b057	system	2023-06-12 14:31:35.313659	READ	Medication	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
df723d5d-3d7b-42f8-bba4-442ad25494e1	system	2023-06-12 14:31:35.312973	DELETE	ImagingStudy	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
932600a6-68ab-494b-8087-c45169bcbc2d	system	2023-06-12 14:31:35.313153	DELETE	InsurancePlan	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
a93a344c-f985-4d95-9d87-97ecef9fa039	system	2023-06-12 14:31:35.312516	CREATE	EpisodeOfCare	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
70928c1e-f79e-4670-a241-90cf32d67c97	system	2023-06-12 14:31:35.314205	READ	MedicinalProduct	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
93a6bbde-188d-40ba-b265-a26cb6294dcc	system	2023-06-12 14:31:35.312186	READ	DeviceMetric	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
7350ebb6-65de-43c8-a5ea-d09dea73cda6	system	2023-06-12 14:31:35.312565	UPDATE	EventDefinition	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
97d625a3-7215-4ce4-923d-525bd36d5fa0	system	2023-06-12 14:31:35.311246	DELETE	BodyStructure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
c7dbd883-d289-4c53-aa1c-cc289abc4db7	system	2023-06-12 14:31:35.316284	READ	Schedule	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5185773c-8a8e-4e8e-832f-ac1ea1d1ccec	system	2023-06-12 14:31:35.316233	READ	RiskAssessment	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
689c22c0-507e-41e0-8c6b-4af2654c626d	system	2023-06-12 14:31:35.311396	CREATE	ChargeItem	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e0e36784-92eb-48e5-915d-1b83b43a280f	system	2023-06-12 14:31:35.312179	CREATE	DeviceMetric	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
91b5ee45-5dcc-4aa9-abae-5636af93d2fb	system	2023-06-12 14:31:35.311046	UPDATE	AllergyIntolerance	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
752ab3d4-c9ba-435b-aaef-f9e4c60e0f45	system	2023-06-12 14:31:35.313395	CREATE	List	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
44dd736a-4dcb-4294-81e2-26185bba8d67	system	2023-06-12 14:31:35.317309	CREATE	SupplyRequest	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
f93a974a-2e30-4864-ad8b-5e8625fccadf	system	2023-06-12 14:31:35.316069	UPDATE	RelatedPerson	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
5303f9a5-188a-40e1-ab9a-86de82779af1	system	2023-06-12 14:31:35.316959	UPDATE	SubstanceSourceMaterial	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
0c07b393-d841-4116-83e0-6c1dd8315ad4	system	2023-06-12 14:31:35.31111	DELETE	AppointmentResponse	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
ff325d87-6e2b-447d-9983-2ba887a4510c	system	2023-06-12 14:31:35.313543	UPDATE	Measure	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
87cd24a2-564a-445a-8f4e-29717b80f9b1	system	2023-06-12 14:31:35.314359	UPDATE	MedicinalProductInteraction	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
e83762a1-ba5c-494c-be26-c7267be94efe	system	2023-06-12 14:31:35.312523	READ	EpisodeOfCare	ALL	a6a0560e-1da6-4d0c-aa30-e37123510583
\.


--
-- Data for Name: permission_service_grant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permission_service_grant (permission_id, smart_service_id) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, created_by, created_on, name) FROM stdin;
a6a0560e-1da6-4d0c-aa30-e37123510583	system	2023-06-12 14:31:35.310433	Admin
\.


--
-- Data for Name: smart_service; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.smart_service (id, created_by, created_on, client_id, fhir_store_device_id, jwks_endpoint, name, public_key, status, patient_idp, practitioner_idp, role_id) FROM stdin;
3f01e9f4-998a-4a17-856d-19a9dbaccf82	system	2023-06-12 14:31:34.838394	980c7e60-0170-449d-8e88-19baaa020b63	\N	http://domain-admin:8080/.well-known/jwks.json	Smart Registration Service - Domain Admin	\N	APPROVED	\N	\N	a6a0560e-1da6-4d0c-aa30-e37123510583
1539cd77-c079-4ee3-be9b-f0b99a8a2d43	c516f9a4-a80e-4694-b367-56f44ef4a051	2023-06-12 14:37:55.928132	552bfe09-3ea6-4bf8-9ecc-876276934aaa	\N	\N	testrunner service	\N	APPROVED	\N	\N	a6a0560e-1da6-4d0c-aa30-e37123510583
\.


--
-- Name: smart_service client_id_index; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_service
    ADD CONSTRAINT client_id_index UNIQUE (client_id);


--
-- Name: identity_provider identity_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT identity_provider_pkey PRIMARY KEY (id);


--
-- Name: oauth2_session oauth2_session_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_session
    ADD CONSTRAINT oauth2_session_code_key UNIQUE (code);


--
-- Name: oauth2_session oauth2_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_session
    ADD CONSTRAINT oauth2_session_pkey PRIMARY KEY (id);


--
-- Name: oauth2_token oauth2_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_token
    ADD CONSTRAINT oauth2_token_pkey PRIMARY KEY (id);


--
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);


--
-- Name: permission_service_grant permission_service_grant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission_service_grant
    ADD CONSTRAINT permission_service_grant_pkey PRIMARY KEY (permission_id, smart_service_id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: smart_service smart_service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_service
    ADD CONSTRAINT smart_service_pkey PRIMARY KEY (id);


--
-- Name: smart_service unique_jwks_endpoint; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_service
    ADD CONSTRAINT unique_jwks_endpoint UNIQUE (jwks_endpoint);


--
-- Name: permission unique_permission; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT unique_permission UNIQUE (role_id, resource_type, operation);


--
-- Name: smart_service unique_public_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_service
    ADD CONSTRAINT unique_public_key UNIQUE (public_key);


--
-- Name: permission_service_grant fkcgjhhrn71uynab1031epbovrx; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission_service_grant
    ADD CONSTRAINT fkcgjhhrn71uynab1031epbovrx FOREIGN KEY (permission_id) REFERENCES public.permission(id);


--
-- Name: smart_service fkcosi5jmx6d18vmwqhv2h3gmr0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_service
    ADD CONSTRAINT fkcosi5jmx6d18vmwqhv2h3gmr0 FOREIGN KEY (role_id) REFERENCES public.role(id);


--
-- Name: permission_service_grant fkdc1aains9omcxwoulinqyvr7j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission_service_grant
    ADD CONSTRAINT fkdc1aains9omcxwoulinqyvr7j FOREIGN KEY (smart_service_id) REFERENCES public.smart_service(id);


--
-- Name: permission fkrvhjnns4bvlh4m1n97vb7vbar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT fkrvhjnns4bvlh4m1n97vb7vbar FOREIGN KEY (role_id) REFERENCES public.role(id);


--
-- Name: oauth2_session oauth2_session_identity_provider_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_session
    ADD CONSTRAINT oauth2_session_identity_provider_fkey FOREIGN KEY (identity_provider) REFERENCES public.identity_provider(id);


--
-- Name: oauth2_token oauth2_token_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oauth2_token
    ADD CONSTRAINT oauth2_token_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.oauth2_session(id);


--
-- Name: smart_service patient_idp_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_service
    ADD CONSTRAINT patient_idp_fk FOREIGN KEY (patient_idp) REFERENCES public.identity_provider(id);


--
-- Name: smart_service practitioner_idp_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.smart_service
    ADD CONSTRAINT practitioner_idp_fk FOREIGN KEY (practitioner_idp) REFERENCES public.identity_provider(id);


--
-- PostgreSQL database dump complete
--
