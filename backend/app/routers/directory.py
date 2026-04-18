from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from typing import List, Optional
from ..database import get_db
from .. import models, schemas

router = APIRouter(prefix="/api/directory", tags=["directory"])

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
    
    docs_list = doctors.all()
    # Mock fallback if db is empty
    if not docs_list:
        return [
            {
                "id": "1", "name": "Dr. Ahmed Benali", "specialty": "Cardiologie",
                "hospital": "CHU Hassan II", "rating": 4.8, "schedule": "Lun-Ven, 09:00-16:00",
                "is_available": True, "city": "Fès"
            },
            {
                "id": "2", "name": "Dr. Fatima Zahra", "specialty": "Pédiatrie",
                "hospital": "Clinique des Oliviers", "rating": 4.9, "schedule": "Mar-Sam, 10:00-18:00",
                "is_available": False, "city": "Meknès"
            }
        ]
    return docs_list

@router.get("/hospitals", response_model=List[schemas.Hospital])
def get_hospitals(region: Optional[str] = None, db: Session = Depends(get_db)):
    hospitals = db.query(models.Hospital)
    if region:
        hospitals = hospitals.filter(models.Hospital.address.contains(region))
        
    hosp_list = hospitals.all()
    if not hosp_list:
        return [
            {
                "id": "1", "name": "CHU Hassan II", "type": "Public", "rating": 4.6,
                "address": "Route de Sidi Harazem, Fès", "has_emergency": True,
                "departments": ["Urgences", "Cardiologie", "Neurologie", "Maternité"]
            },
            {
                "id": "2", "name": "Clinique Riad", "type": "Privé", "rating": 4.5,
                "address": "Avenue Hassan II, Meknès", "has_emergency": False,
                "departments": ["Pédiatrie", "Dermatologie", "Ophtalmologie"]
            }
        ]
    return hosp_list
