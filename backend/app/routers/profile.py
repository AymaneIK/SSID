from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from .. import models, schemas

router = APIRouter(prefix="/api/profile", tags=["profile"])

@router.get("/{patient_id}", response_model=schemas.PatientProfile)
def get_patient_profile(patient_id: str, db: Session = Depends(get_db)):
    # In a real app we'd fetch this from the db
    # For now, if the database is empty, return mock data matching flutter models
    patient = db.query(models.Patient).filter(models.Patient.id == patient_id).first()
    if not patient:
        return {
            "id": patient_id,
            "first_name": "Hamza",
            "last_name": "Alami",
            "date_of_birth": "12 Mars 1985",
            "blood_type": "O+",
            "weight": 72.5,
            "height": 1.78,
            "medications": [
                {"id": "m1", "name": "Aspirin", "dosage": "100mg", "frequency": "1x/jour", "duration": "30 jours", "icon": "pill"},
                {"id": "m2", "name": "Lisinopril", "dosage": "10mg", "frequency": "1x/jour", "duration": "Continue", "icon": "pill"}
            ],
            "medical_records": [
                {"id": "r1", "title": "Bilan Sanguin", "date": "10 Apr 2026", "type": "Analyse", "doctor": "Dr. Benali", "status": "Normal"},
                {"id": "r2", "title": "Radio Pulmonaire", "date": "05 Mar 2026", "type": "Imagerie", "doctor": "Dr. Tazi", "status": "À revoir"}
            ],
            "diseases": [
                {"id": "d1", "name": "Hypertension Artérielle", "diagnosed_date": "2020", "status": "Contrôlé", "is_allergy": False},
                {"id": "a1", "name": "Pénicilline", "diagnosed_date": "Enfance", "status": "Sévère", "is_allergy": True}
            ]
        }
    return patient
