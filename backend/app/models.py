from sqlalchemy import Column, Integer, String, Float, Boolean, ForeignKey, Date
from sqlalchemy.orm import relationship
from .database import Base

class Patient(Base):
    __tablename__ = "patients"

    id = Column(String, primary_key=True, index=True)
    first_name = Column(String)
    last_name = Column(String)
    date_of_birth = Column(String)
    blood_type = Column(String)
    weight = Column(Float)
    height = Column(Float)

    medical_records = relationship("MedicalRecord", back_populates="patient")
    medications = relationship("Medication", back_populates="patient")
    diseases = relationship("Disease", back_populates="patient")

class MedicalRecord(Base):
    __tablename__ = "medical_records"

    id = Column(String, primary_key=True, index=True)
    patient_id = Column(String, ForeignKey("patients.id"))
    title = Column(String)
    date = Column(String)
    type = Column(String)
    doctor = Column(String)
    status = Column(String)

    patient = relationship("Patient", back_populates="medical_records")

class Medication(Base):
    __tablename__ = "medications"

    id = Column(String, primary_key=True, index=True)
    patient_id = Column(String, ForeignKey("patients.id"))
    name = Column(String)
    dosage = Column(String)
    frequency = Column(String)
    duration = Column(String)
    icon = Column(String)

    patient = relationship("Patient", back_populates="medications")

class Disease(Base):
    __tablename__ = "diseases"

    id = Column(String, primary_key=True, index=True)
    patient_id = Column(String, ForeignKey("patients.id"))
    name = Column(String)
    diagnosed_date = Column(String)
    status = Column(String)
    is_allergy = Column(Boolean, default=False)

    patient = relationship("Patient", back_populates="diseases")

class Doctor(Base):
    __tablename__ = "doctors"

    id = Column(String, primary_key=True, index=True)
    name = Column(String)
    specialty = Column(String)
    hospital = Column(String)
    rating = Column(Float)
    schedule = Column(String)
    is_available = Column(Boolean)
    city = Column(String)

class Hospital(Base):
    __tablename__ = "hospitals"

    id = Column(String, primary_key=True, index=True)
    name = Column(String)
    type = Column(String)
    rating = Column(Float)
    address = Column(String)
    has_emergency = Column(Boolean)
    # Store departments as comma-separated string for simplicity in SQLite 
    departments = Column(String)
