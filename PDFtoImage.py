import os
from pdf2image import convert_from_path
import sys

def convert_pdf_to_images(pdf_path, output_folder):
    # Convert PDF to list of images
    images = convert_from_path(pdf_path)

    # Save images as JPEG files
    for i, image in enumerate(images):
        image_filename = os.path.join(output_folder, f'{os.path.splitext(os.path.basename(pdf_path))[0]}.jpg')
        image.save(image_filename, 'JPEG')
        print(f'Saved: {image_filename}')

def main(input_folder, output_folder):
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    for filename in os.listdir(input_folder):
        if filename.endswith('.pdf'):
            pdf_path = os.path.join(input_folder, filename)
            convert_pdf_to_images(pdf_path, output_folder)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python convert_pdfs_to_images.py <input_folder> <output_folder>")
    else:
        input_folder = sys.argv[1]
        output_folder = sys.argv[2]
        main(input_folder, output_folder)
