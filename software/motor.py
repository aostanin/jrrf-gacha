import RPi.GPIO as GPIO
import time

STEP_PIN = 17
DIR_PIN = 27
EN_PIN = 22

ANGLE_DEG = 55
PAUSE_SEC = 1
STEPS_PER_REV = 1600
STEP_DELAY = 0.001

STEPS = int(STEPS_PER_REV * ANGLE_DEG / 360)

def rotate(steps, direction):
    GPIO.output(DIR_PIN, direction)
    for _ in range(steps):
        GPIO.output(STEP_PIN, GPIO.HIGH)
        time.sleep(STEP_DELAY)
        GPIO.output(STEP_PIN, GPIO.LOW)
        time.sleep(STEP_DELAY)

try:
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(STEP_PIN, GPIO.OUT)
    GPIO.setup(DIR_PIN, GPIO.OUT)
    GPIO.setup(EN_PIN, GPIO.OUT)

    GPIO.output(EN_PIN, GPIO.LOW)  # enable driver

    rotate(STEPS, GPIO.HIGH)      # forward
    time.sleep(PAUSE_SEC)
    rotate(STEPS, GPIO.LOW)       # reverse

finally:
    GPIO.cleanup()
