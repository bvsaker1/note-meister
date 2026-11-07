class NotesController < ApplicationController

  def create
    note = Note.new(note_params)

    if note.save
      render json: note, status: :created
    else
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    note = Note.find(params[:id])

    if note.nil?
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    else
      render json: note, status: :ok
    end
  end

  def index
    notes = Note.all

    if notes.nil?
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    else
      render json: notes, status: :ok
    end
  end

  def get_by_author
    author = params[:author]
    notes = Note.where("LOWER(author)=?", author)

    if notes.nil?
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    else
      render json: notes, status: :ok
    end
  end

  def get_by_category
    category = params[:category]
    notes = Note.where("LOWER(category)=?", category.downcase)

    if notes.nil?
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    else
      render json: notes, status: :ok
    end
  end

def search
  term = "%#{Note.sanitize_sql_like(params[:search_str].to_s.downcase)}%"
  notes = Note.where("LOWER(title) LIKE ?", term)
  render json: notes  
end

  def update
    note = Note.find(params[:id])

    if note.nil?
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    else
      render json: note, status: :ok
    end
  end

  def destroy
    note = Note.find(params[:id])

    if note.nil?
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    else
      render json: note, status: :ok
    end
  end

  private

  def note_params
    params.permit(:title, :author, :category, :description, :note)
  end
end
