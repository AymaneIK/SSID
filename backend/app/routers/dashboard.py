from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from .. import models, schemas

router = APIRouter(prefix="/api/dashboard", tags=["dashboard"])

@router.get("/{patient_id}/summary", response_model=schemas.DashboardSummaryResponse)
def get_dashboard_summary(patient_id: str, db: Session = Depends(get_db)):
    # Returns the quick stat metrics
    return {
        "heart_rate": 76,
        "oxygen": 99,
        "blood_cells": 98,
        "temperature": 36.8,
        "sleep_hours": 7.3,
        "sleep_trend": "+0.5h vs sem. der.",
        "weight_trend": "-0.5 kg ce mois"
    }

@router.get("/{patient_id}/alerts", response_model=List[schemas.DashboardAlert])
def get_alerts(patient_id: str, db: Session = Depends(get_db)):
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
