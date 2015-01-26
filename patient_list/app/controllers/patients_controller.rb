class PatientsController < ApplicationController

  def index
    @patients = Patient.all
  end
  
  def show
    @doctor = Doctor.find params[:doctor_id]
    @patient = Patient.find params[:id]
  end

  def new
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.new
  end

  def create
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.create patient_params
    redirect_to doctor_path(@doctor)
  end

  def edit
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.find params[:id]
  end

  def update
    @doctor = Doctor.find params[:doctor_id]
    @patient = @doctor.patients.find params[:id]
    redirect_to doctor_path(@doctor)
  end

  def destroy
    @patient = Patient.find params[:id]
    @doctor = Doctor.find params[:doctor_id]
    if @patient.delete
      flash[:notice] = 'Patient data was deleted successfully.'
      redirect_to doctor_path(@doctor)
    else
      flash[:notice] = 'Patient data was NOT deleted successfully.'
    end
  end

private
  def patient_params
    params.require(:patient).permit(
        :first_name,
        :last_name,
        :date_of_birth,
        :description,
        :gender,
        :blood_type
      ) 
  end

  def set_doctor
    @doctor = Doctor.find params[:id]
  end

end
