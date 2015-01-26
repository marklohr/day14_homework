class MedicationsController < ApplicationController

  def index
    @medications = Medication.all
  end
  
  def show
    @doctor = Doctor.find params[:doctor_id]
    @patient = Patient.find params[:patient_id]
    @medication = Medication.find params[:id]
  end

  def new
    @doctor = Doctor.find params[:doctor_id]
    @patient = Patient.find params[:patient_id]
    @medication = @patient.medications.new
  end

  def create
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.find params[:patient_id]
    @medication = @patient.medications.create medication_params
    redirect_to doctor_patient_path(@doctor, @patient)
  end

  def edit
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.find params[:patient_id]
    @medication = @patient.medications.find params[:id]
  end

  def update
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.find params[:patient_id]
    @medication = @patient.medications.find params[:id]
    @medication.update medication_params
    redirect_to doctor_patient_path(@doctor, @patient)
  end

  def destroy
    @medication = Medication.find params[:id]
    @doctor = Doctor.find params[:doctor_id]
    @patient = Patient.find params[:patient_id]
    @medication.delete
    redirect_to doctor_patient_path(@doctor, @patient)
  end


private
  def medication_params
    params.require(:medication).permit(
        :name,
        :side_effects,
      ) 
  end

  def set_patient
    @patient = Patient.find params[:id]
  end


end
