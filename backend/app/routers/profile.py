from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
import uuid
from ..database import get_db
from .. import models, schemas

router = APIRouter(prefix="/api/profile", tags=["profile"])

@router.post("/", response_model=schemas.Patient)
def create_patient(patient: schemas.PatientCreate, db: Session = Depends(get_db)):
    db_patient = models.Patient(id=str(uuid.uuid4())[:8], **patient.dict())
    db.add(db_patient)
    db.commit()
    db.refresh(db_patient)
    return db_patient

@router.get("/{patient_id}", response_model=schemas.PatientProfile)
def get_patient_profile(patient_id: str, db: Session = Depends(get_db)):
    patient = db.query(models.Patient).filter(models.Patient.id == patient_id).first()
    if not patient:
        raise HTTPException(status_code=404, detail="Patient not found")
    return patient

@router.put("/{patient_id}", response_model=schemas.Patient)
def update_patient(patient_id: str, patient_update: schemas.PatientCreate, db: Session = Depends(get_db)):
    patient = db.query(models.Patient).filter(models.Patient.id == patient_id).first()
    if not patient:
        raise HTTPException(status_code=404, detail="Patient not found")
    for key, value in patient_update.dict().items():
        setattr(patient, key, value)
    db.commit()
    db.refresh(patient)
    return patient

@router.post("/{patient_id}/medical-records", response_model=schemas.MedicalRecord)
def add_medical_record(patient_id: str, record: schemas.MedicalRecordCreate, db: Session = Depends(get_db)):
    db_record = models.MedicalRecord(id=str(uuid.uuid4())[:12], patient_id=patient_id, **record.dict())
    db.add(db_record)
    db.commit()
    db.refresh(db_record)
    return db_record

@router.post("/{patient_id}/medications", response_model=schemas.Medication)
def add_medication(patient_id: str, medication: schemas.MedicationCreate, db: Session = Depends(get_db)):
    db_med = models.Medication(id=str(uuid.uuid4())[:12], patient_id=patient_id, **medication.dict())
    db.add(db_med)
    db.commit()
    db.refresh(db_med)
    return db_med

@router.delete("/{patient_id}/medical-records/{record_id}")
def delete_medical_record(patient_id: str, record_id: str, db: Session = Depends(get_db)):
    record = db.query(models.MedicalRecord).filter(models.MedicalRecord.id == record_id, models.MedicalRecord.patient_id == patient_id).first()
    if not record:
        raise HTTPException(status_code=404, detail="Record not found")
    db.delete(record)
    db.commit()
    return {"message": "Record deleted successfully"}
