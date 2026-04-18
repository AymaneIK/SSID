from pydantic import BaseModel
from typing import List, Optional

class MedicalRecordBase(BaseModel):
    id: str
    title: str
    date: str
    type: str
    doctor: str
    status: str

class MedicalRecord(MedicalRecordBase):
    class Config:
        from_attributes = True

class MedicationBase(BaseModel):
    id: str
    name: str
    dosage: str
    frequency: str
    duration: str
    icon: str

class Medication(MedicationBase):
    class Config:
        from_attributes = True

class DiseaseBase(BaseModel):
    id: str
    name: str
    diagnosed_date: str
    status: str
    is_allergy: bool

class Disease(DiseaseBase):
    class Config:
        from_attributes = True

class PatientBase(BaseModel):
    id: str
    first_name: str
    last_name: str
    date_of_birth: str
    blood_type: str
    weight: float
    height: float

class Patient(PatientBase):
    class Config:
        from_attributes = True

class PatientProfile(Patient):
    medications: List[Medication] = []
    medical_records: List[MedicalRecord] = []
    diseases: List[Disease] = []

class DoctorBase(BaseModel):
    id: str
    name: str
    specialty: str
    hospital: str
    rating: float
    schedule: str
    is_available: bool
    city: str
    
class Doctor(DoctorBase):
    class Config:
        from_attributes = True

class HospitalBase(BaseModel):
    id: str
    name: str
    type: str
    rating: float
    address: str
    has_emergency: bool
    departments: List[str]

    # Convert comma separated string to list
    @classmethod
    def from_orm(cls, obj: any):
        setattr(obj, "departments", obj.departments.split(',') if obj.departments else [])
        return super().from_orm(obj)
        
class Hospital(HospitalBase):
    class Config:
        from_attributes = True

class DashboardSummaryResponse(BaseModel):
    heart_rate: int
    oxygen: int
    blood_cells: int
    temperature: float
    sleep_hours: float
    sleep_trend: str
    weight_trend: str

class DashboardAlert(BaseModel):
    id: str
    icon: str
    title: str
    description: str
    priority: str
    color: str
