import cv2
import pytesseract

def detect_plate(image):
    # Pre-processing the image for plate detection
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blur = cv2.GaussianBlur(gray, (5,5), 0)
    edges = cv2.Canny(blur, 50, 150)
    
    # Detecting contours in the image
    contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    
    # Selecting the contour with the largest area
    contour = max(contours, key=cv2.contourArea)
    
    # Approximating the shape of the contour
    epsilon = 0.1 * cv2.arcLength(contour, True)
    approx = cv2.approxPolyDP(contour, epsilon, True)
    
    # Selecting the region of interest (ROI) containing the license plate
    x,y,w,h = cv2.boundingRect(approx)
    roi = gray[y:y+h, x:x+w]
    
    # Running optical character recognition (OCR) on the ROI to extract the license plate number
    text = pytesseract.image_to_string(roi)
    
    return text
