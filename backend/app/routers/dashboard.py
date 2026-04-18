from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from .. import models, schemas

router = APIRouter(prefix="/api/dashboard", tags=["dashboard"])

@router.get("/{patient_id}/summary", response_model=schemas.DashboardSummaryResponse)
def get_dashboard_summary(patient_id: str, db: Session = Depends(get_db)):
    patient = db.query(models.Patient).filter(models.Patient.id == patient_id).first()
    if not patient:
        raise HTTPException(status_code=404, detail="Patient not found")
        
    return {
        "heart_rate": 76,
        "oxygen": 99,
        "blood_cells": 98,
        "temperature": 36.8,
        "sleep_hours": 7.3,
        "sleep_trend": "+0.5h vs sem. der.",
        "weight_trend": f"{-0.5} kg ce mois (actuel: {patient.weight}kg)"
    }

@router.get("/{patient_id}/alerts", response_model=List[schemas.DashboardAlert])
def get_alerts(patient_id: str, db: Session = Depends(get_db)):
    # Standard static AI alerts for now, in V3 this would query an Alert table 
    return [
        {
            "id": "1", "icon": "directions_walk_rounded", "title": "Activité physique", 
            "description": "Augmentez votre activité de 15min/jour", "priority": "Recommandé", 
            "color": "primary"
        },
        {
            "id": "2", "icon": "restaurant_rounded", "title": "Nutrition", 
            "description": "Réduisez la consommation de sel", "priority": "Important", 
            "color": "warning"
        }
    ]
