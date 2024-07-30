


List<Map<String,dynamic>> Immnunization = [{
"fullUrl": "urn:uuid:c69729ac-33f7-b2b4-324a-8d631bbb389a",
"resource": {
    "resourceType": "DiagnosticReport",
    "id": "c69729ac-33f7-b2b4-324a-8d631bbb389a",
    "meta": {
        "profile": [
            "http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab"
        ]
    },
    "status": "final",
    "category": [
        {
            "coding": [
                {
                    "system": "http://terminology.hl7.org/CodeSystem/v2-0074",
                    "code": "LAB",
                    "display": "Laboratory"
                }
            ]
        }
    ],
    "code": {
        "coding": [
            {
                "system": "http://loinc.org",
                "code": "51990-0",
                "display": "Basic Metabolic Panel"
            }
        ],
        "text": "Basic Metabolic Panel"
    },
    "subject": {
        "reference": "urn:uuid:1293efbb-72dc-8b15-3bd6-916f96ed54f4"
    },
    "encounter": {
        "reference": "urn:uuid:2645c638-3a70-9a36-3267-9cb3f279a8a6"
    },
    "effectiveDateTime": "2013-12-29T03:04:03-05:00",
    "issued": "2013-12-29T03:04:03.715-05:00",
    "performer": [
        {
            "reference": "Organization?identifier=https://github.com/synthetichealth/synthea|bf24f5a7-6c7e-3e72-b31d-aca37d5fca33",
            "display": "PCP141874"
        }
    ],
    "result": [
        {
            "reference": "urn:uuid:26b90173-100a-5547-dbba-4c909ecfef9c",
            "display": "Glucose"
        },
        {
            "reference": "urn:uuid:06e5daf5-716b-65bf-6f33-b29d96dc6547",
            "display": "Urea Nitrogen"
        },
        {
            "reference": "urn:uuid:01bee0ae-0587-f355-940f-4e0ea4c0eb38",
            "display": "Creatinine"
        },
        {
            "reference": "urn:uuid:9abc6005-abd2-3ef5-ad52-7ef6b034da64",
            "display": "Calcium"
        },
        {
            "reference": "urn:uuid:6f871aec-2b64-ddc6-2367-a4962bdc72f7",
            "display": "Sodium"
        },
        {
            "reference": "urn:uuid:8de402e8-60e5-58b1-0e9c-a08262f77178",
            "display": "Potassium"
        },
        {
            "reference": "urn:uuid:16381171-2a72-c024-3529-d922c981522a",
            "display": "Chloride"
        },
        {
            "reference": "urn:uuid:2e00d17b-1d03-3812-db82-6f645887e6b5",
            "display": "Carbon Dioxide"
        }
    ]
}}];

