from fastapi import APIRouter, Depends, Query, HTTPException
from sqlalchemy.orm import Session
from typing import List, Optional
import uuid
from ..database import get_db
from .. import models, schemas

router = APIRouter(prefix="/api/directory", tags=["directory"])

@router.post("/doctors", response_model=schemas.Doctor)
def create_doctor(doctor: schemas.DoctorCreate, db: Session = Depends(get_db)):
    db_doc = models.Doctor(id=str(uuid.uuid4())[:8], **doctor.dict())
    db.add(db_doc)
    db.commit()
    db.refresh(db_doc)
    return db_doc

@router.get("/doctors", response_model=List[schemas.Doctor])
def get_doctors(
    specialty: Optional[str] = None, 
    region: Optional[str] = None,
    query: Optional[str] = None,
    db: Session = Depends(get_db)
):
    doctors = db.query(models.Doctor)
    if specialty and specialty != "Tous":
        doctors = doctors.filter(models.Doctor.specialty.contains(specialty))
    if region:
        doctors = doctors.filter(models.Doctor.city.contains(region))
    if query:
        doctors = doctors.filter(models.Doctor.name.contains(query))
    
    return doctors.all()

@router.post("/hospitals", response_model=schemas.Hospital)
def create_hospital(hospital: schemas.HospitalCreate, db: Session = Depends(get_db)):
    db_hosp = models.Hospital(id=str(uuid.uuid4())[:8], **hospital.dict())
    db.add(db_hosp)
    db.commit()
    db.refresh(db_hosp)
    return db_hosp

@router.get("/hospitals", response_model=List[schemas.Hospital])
def get_hospitals(region: Optional[str] = None, db: Session = Depends(get_db)):
    hospitals = db.query(models.Hospital)
    if region:
        hospitals = hospitals.filter(models.Hospital.address.contains(region))
        
    results = hospitals.all()
    out = []
    for h in results:
        h_dict = h.__dict__
        h_dict['departments_list'] = h.departments.split(",") if h.departments else []
        out.append(schemas.Hospital(**h_dict))
    return out
