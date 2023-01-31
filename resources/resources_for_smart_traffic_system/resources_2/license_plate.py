import cv2
import pytesseract

# Load the image
img = cv2.imread('license_plate.jpg')

# Convert the image to grayscale
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# Run OCR on the grayscale image
text = pytesseract.image_to_string(gray)

print(text)
