from pydantic import BaseModel
from typing import List, Optional

class MedicalRecordBase(BaseModel):
    title: str
    date: str
    type: str
    doctor: str
    status: str

class MedicalRecordCreate(MedicalRecordBase):
    pass

class MedicalRecord(MedicalRecordBase):
    id: str
    patient_id: str
    class Config:
        from_attributes = True

class MedicationBase(BaseModel):
    name: str
    dosage: str
    frequency: str
    duration: str
    icon: str

class MedicationCreate(MedicationBase):
    pass

class Medication(MedicationBase):
    id: str
    patient_id: str
    class Config:
        from_attributes = True

class DiseaseBase(BaseModel):
    name: str
    diagnosed_date: str
    status: str
    is_allergy: bool

class DiseaseCreate(DiseaseBase):
    pass

class Disease(DiseaseBase):
    id: str
    patient_id: str
    class Config:
        from_attributes = True

class PatientBase(BaseModel):
    first_name: str
    last_name: str
    date_of_birth: str
    blood_type: str
    weight: float
    height: float

class PatientCreate(PatientBase):
    pass

class Patient(PatientBase):
    id: str
    class Config:
        from_attributes = True

class PatientProfile(Patient):
    medications: List[Medication] = []
    medical_records: List[MedicalRecord] = []
    diseases: List[Disease] = []

class DoctorBase(BaseModel):
    name: str
    specialty: str
    hospital: str
    rating: float
    schedule: str
    is_available: bool
    city: str
    
class DoctorCreate(DoctorBase):
    pass

class Doctor(DoctorBase):
    id: str
    class Config:
        from_attributes = True

class HospitalBase(BaseModel):
    name: str
    type: str
    rating: float
    address: str
    has_emergency: bool
    departments: str # stored as comma separated for simple db setup

class HospitalCreate(HospitalBase):
    pass
        
class Hospital(HospitalBase):
    id: str
    departments_list: List[str] = []
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
