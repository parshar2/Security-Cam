 import numpy as np
 import cv2
 
 face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
 eye_cascade = cv2.CascadeClassifier('haarcascade_eye.xml')
 
 img = cv2.imread('sachin.jpg')
 gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

faces = face_cascade.detectMultiScale(gray, 1.3, 5)
 for (x,y,w,h) in faces:
     cv2.rectangle(img,(x,y),(x+w,y+h),(255,0,0),2)
     
 cv2.imshow('img',img)
 cv2.waitKey(0)
 cv2.destroyAllWindows()



tup = detectMotion(img, oldjpg)
                if(tup):
                    # Explode the result
                    diff, jpg = tup
                    if(calib):
                        print(diff)
                    elif(diff):
                        # if above a threshold, store it to file
                        #######################################################################
                        # TODO2 : Check the RMS difference and store the image to the proper
                        # location, for our webserver to read these files they should go
                        # under the location /srv/www/motionlog/* 
                        if(diff > thresh):
                            print("** Motion! %.3f" % diff)
                            fileName = "%s%d.jpg" % (m_save, time.time())
                            jpg.save(fileName)
                    else:
                        print('-- No diff yet')
                    oldjpg = jpg


run apt-get update && apt-get install -y -q wget curl
run apt-get update && apt-get install -y -q build-essential
run apt-get update && apt-get install -y -q cmake
run apt-get update && apt-get install -y -q python2.7 python2.7-dev
