import os
from sqlalchemy.orm import Session
from app.database import SessionLocal, engine, Base
from app import models

def seed_data():
    # Only create tables if they don't exist
    Base.metadata.create_all(bind=engine)
    
    db = SessionLocal()
    
    # Check if we already have data
    if db.query(models.Doctor).first():
        print("Database already seeded. Skipping.")
        db.close()
        return

    print("Seeding database...")
    
    # Add Doctors
    docs = [
        models.Doctor(id="d1", name="Dr. Ahmed Benali", specialty="Cardiologie", hospital="CHU Hassan II", rating=4.8, schedule="Lun-Ven, 09:00-16:00", is_available=True, city="Fès"),
        models.Doctor(id="d2", name="Dr. Fatima Zahra", specialty="Pédiatrie", hospital="Clinique des Oliviers", rating=4.9, schedule="Mar-Sam, 10:00-18:00", is_available=False, city="Meknès"),
        models.Doctor(id="d3", name="Dr. Omar Tazi", specialty="Neurologie", hospital="Hôpital Cheikh Zaid", rating=4.7, schedule="Lun-Jeu, 08:00-14:00", is_available=True, city="Rabat")
    ]
    db.add_all(docs)

    # Add Hospitals
    hosps = [
        models.Hospital(id="h1", name="CHU Hassan II", type="Public", rating=4.6, address="Route de Sidi Harazem, Fès", has_emergency=True, departments="Urgences,Cardiologie,Neurologie,Maternité"),
        models.Hospital(id="h2", name="Clinique Riad", type="Privé", rating=4.5, address="Avenue Hassan II, Meknès", has_emergency=False, departments="Pédiatrie,Dermatologie,Ophtalmologie")
    ]
    db.add_all(hosps)

    # Add Patient
    p1 = models.Patient(id="p1", first_name="Hamza", last_name="Alami", date_of_birth="12 Mars 1985", blood_type="O+", weight=72.5, height=1.78)
    db.add(p1)

    # Add Patient Data
    meds = [
        models.Medication(id="m1", patient_id="p1", name="Aspirin", dosage="100mg", frequency="1x/jour", duration="30 jours", icon="pill"),
        models.Medication(id="m2", patient_id="p1", name="Lisinopril", dosage="10mg", frequency="1x/jour", duration="Continue", icon="pill")
    ]
    db.add_all(meds)

    recs = [
        models.MedicalRecord(id="r1", patient_id="p1", title="Bilan Sanguin", date="10 Apr 2026", type="Analyse", doctor="Dr. Benali", status="Normal"),
        models.MedicalRecord(id="r2", patient_id="p1", title="Radio Pulmonaire", date="05 Mar 2026", type="Imagerie", doctor="Dr. Tazi", status="À revoir")
    ]
    db.add_all(recs)

    dis = [
        models.Disease(id="dis1", patient_id="p1", name="Hypertension Artérielle", diagnosed_date="2020", status="Contrôlé", is_allergy=False),
        models.Disease(id="dis2", patient_id="p1", name="Pénicilline", diagnosed_date="Enfance", status="Sévère", is_allergy=True)
    ]
    db.add_all(dis)

    db.commit()
    db.close()
    print("Database seeded completely!")

if __name__ == "__main__":
    seed_data()
