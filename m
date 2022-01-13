Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1CA48D936
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiAMNjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiAMNjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:39:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA0C06173F;
        Thu, 13 Jan 2022 05:39:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b13so23367024edn.0;
        Thu, 13 Jan 2022 05:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kTPfvO06HvCQFLO90ZikS41VItvOm898FDkrSHAhEIY=;
        b=WwtlJp50OSNkRB3hTV0fLExPfVXhTdZDP/f5fr48Z+ifzFIaXIOYvktQUZlK4Gi/f8
         Yo5uEGTC2Dmzz4M2qeydVXxqVe3Xjrjd6goWWW+oVun306tUxUWJmw8PeN3BIKjnQfCs
         Bfp1MTyCjNtcvvWMrh6wHZzgBFquZeIEhDCvqi1r9zuVew+uTfwYg1g6oyb3hrPhzveS
         3VUmoAAkOEHXu+9m1dUTB3QyHT1v4NMEjtSOR/TZzxRJc4lV97jmg7Ckf6LEIKPA+ej2
         dY2udHrvebsUyfIUIzsEmRbsPr7NG+mabGy/qECPpWp2HHThAvNNyH+3gLrHBWfbrFRq
         PSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kTPfvO06HvCQFLO90ZikS41VItvOm898FDkrSHAhEIY=;
        b=fZod+uLDg04jsJISD0ZVscpFeav96jsIEWjY4q6CGejbhkK52RzQ3COeiGAhSJBeye
         cNNQwP20IKLO+0Mqfb2nuKRX0LEgW/oWNHSJPrzmYItczzhObJi+rI80MZ65g8onPQwu
         rkPYPptPiMU1hTnZh4Fcbx+4DuLHItbs6bqlJ7+y2jvPw198XsbL07WHXDAZxexDT8S0
         VW3D8c3kL9oElO55pCu7lQS+LCBH8xuMROBAOlPDZnuSiEfcx3HEzMBD6ar27hlARJm7
         2uXaUy0EE3g32zpnJk+++zMXFdgR34c1hmR/Ks37AHIhn0mFOgYUsraA++fLashuYurf
         rN0g==
X-Gm-Message-State: AOAM530KDdXI5HXeyaB183XXpH2rrK+6SivQs+YLWAjRssgRaZugZfsi
        TfqnDdMc5lgHsdExnIcKbtnTFJJIc7g=
X-Google-Smtp-Source: ABdhPJxHxuJVjmp2xgGMx3LhKjqIbaCXtuYjlCppy2GCJDncHElUr5a1Kc0BaN6u25N8/S+jvsGJoA==
X-Received: by 2002:a05:6402:2553:: with SMTP id l19mr4208570edb.34.1642081182714;
        Thu, 13 Jan 2022 05:39:42 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id u2sm881400ejh.211.2022.01.13.05.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 05:39:42 -0800 (PST)
Date:   Thu, 13 Jan 2022 14:39:40 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: trivial-devices: fix comment indentation
Message-ID: <ea7e6b645fb1c2612f14ca62471180a38d51e9f9.1642080090.git.stano.jakubek@gmail.com>
References: <cover.1642080090.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1642080090.git.stano.jakubek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indent comments the same as the content they describe.
Fixes yamllint warnings like:
32:13     warning  comment not indented like content  (comments-indentation)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../devicetree/bindings/trivial-devices.yaml  | 314 +++++++++---------
 1 file changed, 157 insertions(+), 157 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 091792ba993e..1fb565c8f967 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -29,332 +29,332 @@ properties:
   compatible:
     items:
       - enum:
-            # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
+          # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
           - ad,ad7414
-            # ADM9240: Complete System Hardware Monitor for uProcessor-Based Systems
+          # ADM9240: Complete System Hardware Monitor for uProcessor-Based Systems
           - ad,adm9240
-            # AD5110 - Nonvolatile Digital Potentiometer
+          # AD5110 - Nonvolatile Digital Potentiometer
           - adi,ad5110
-            # Analog Devices ADP5585 Keypad Decoder and I/O Expansion
+          # Analog Devices ADP5585 Keypad Decoder and I/O Expansion
           - adi,adp5585
-            # Analog Devices ADP5585 Keypad Decoder and I/O Expansion with support for Row5
+          # Analog Devices ADP5585 Keypad Decoder and I/O Expansion with support for Row5
           - adi,adp5585-02
-            # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
+          # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
           - adi,adp5589
-            # AMS iAQ-Core VOC Sensor
+          # AMS iAQ-Core VOC Sensor
           - ams,iaq-core
-            # i2c serial eeprom (24cxx)
+          # i2c serial eeprom (24cxx)
           - at,24c08
-            # i2c trusted platform module (TPM)
+          # i2c trusted platform module (TPM)
           - atmel,at97sc3204t
-            # i2c h/w symmetric crypto module
+          # i2c h/w symmetric crypto module
           - atmel,atsha204a
-            # i2c h/w elliptic curve crypto module
+          # i2c h/w elliptic curve crypto module
           - atmel,atecc508a
-            # BPA-RS600: Power Supply
+          # BPA-RS600: Power Supply
           - blutek,bpa-rs600
-            # Bosch Sensortec pressure, temperature, humididty and VOC sensor
+          # Bosch Sensortec pressure, temperature, humididty and VOC sensor
           - bosch,bme680
-            # CM32181: Ambient Light Sensor
+          # CM32181: Ambient Light Sensor
           - capella,cm32181
-            # CM3232: Ambient Light Sensor
+          # CM3232: Ambient Light Sensor
           - capella,cm3232
-            # CM3323: Ambient Light Sensor
+          # CM3323: Ambient Light Sensor
           - capella,cm3323
-            # High-Precision Digital Thermometer
+          # High-Precision Digital Thermometer
           - dallas,ds1631
-            # Total-Elapsed-Time Recorder with Alarm
+          # Total-Elapsed-Time Recorder with Alarm
           - dallas,ds1682
-            # Tiny Digital Thermometer and Thermostat
+          # Tiny Digital Thermometer and Thermostat
           - dallas,ds1775
-            # CPU Peripheral Monitor
+          # CPU Peripheral Monitor
           - dallas,ds1780
-            # CPU Supervisor with Nonvolatile Memory and Programmable I/O
+          # CPU Supervisor with Nonvolatile Memory and Programmable I/O
           - dallas,ds4510
-            # Digital Thermometer and Thermostat
+          # Digital Thermometer and Thermostat
           - dallas,ds75
-            # Delta AHE-50DC Open19 power shelf fan control module
+          # Delta AHE-50DC Open19 power shelf fan control module
           - delta,ahe50dc-fan
-            # Delta Electronics DPS-650-AB power supply
+          # Delta Electronics DPS-650-AB power supply
           - delta,dps650ab
           # Delta Electronics DPS920AB 920W 54V Power Supply
           - delta,dps920ab
-            # 1/4 Brick DC/DC Regulated Power Module
+          # 1/4 Brick DC/DC Regulated Power Module
           - delta,q54sj108a2
-            # Devantech SRF02 ultrasonic ranger in I2C mode
+          # Devantech SRF02 ultrasonic ranger in I2C mode
           - devantech,srf02
-            # Devantech SRF08 ultrasonic ranger
+          # Devantech SRF08 ultrasonic ranger
           - devantech,srf08
-            # Devantech SRF10 ultrasonic ranger
+          # Devantech SRF10 ultrasonic ranger
           - devantech,srf10
-            # DA9053: flexible system level PMIC with multicore support
+          # DA9053: flexible system level PMIC with multicore support
           - dlg,da9053
-            # DA9063: system PMIC for quad-core application processors
+          # DA9063: system PMIC for quad-core application processors
           - dlg,da9063
-            # DMARD05: 3-axis I2C Accelerometer
+          # DMARD05: 3-axis I2C Accelerometer
           - domintech,dmard05
-            # DMARD06: 3-axis I2C Accelerometer
+          # DMARD06: 3-axis I2C Accelerometer
           - domintech,dmard06
-            # DMARD05: 3-axis I2C Accelerometer
+          # DMARD05: 3-axis I2C Accelerometer
           - domintech,dmard07
-            # DMARD09: 3-axis Accelerometer
+          # DMARD09: 3-axis Accelerometer
           - domintech,dmard09
-            # DMARD10: 3-axis Accelerometer
+          # DMARD10: 3-axis Accelerometer
           - domintech,dmard10
-            # MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
+          # MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
           - fsl,mma7660
-            # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
+          # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
           - fsl,mma8450
-            # MPL3115: Absolute Digital Pressure Sensor
+          # MPL3115: Absolute Digital Pressure Sensor
           - fsl,mpl3115
-            # MPR121: Proximity Capacitive Touch Sensor Controller
+          # MPR121: Proximity Capacitive Touch Sensor Controller
           - fsl,mpr121
-            # Monolithic Power Systems Inc. multi-phase controller mp2888
+          # Monolithic Power Systems Inc. multi-phase controller mp2888
           - mps,mp2888
-            # Monolithic Power Systems Inc. multi-phase controller mp2975
+          # Monolithic Power Systems Inc. multi-phase controller mp2975
           - mps,mp2975
-            # Honeywell Humidicon HIH-6130 humidity/temperature sensor
+          # Honeywell Humidicon HIH-6130 humidity/temperature sensor
           - honeywell,hi6130
-            # IBM Common Form Factor Power Supply Versions (all versions)
+          # IBM Common Form Factor Power Supply Versions (all versions)
           - ibm,cffps
-            # IBM Common Form Factor Power Supply Versions 1
+          # IBM Common Form Factor Power Supply Versions 1
           - ibm,cffps1
-            # IBM Common Form Factor Power Supply Versions 2
+          # IBM Common Form Factor Power Supply Versions 2
           - ibm,cffps2
-            # Infineon IR36021 digital POL buck controller
+          # Infineon IR36021 digital POL buck controller
           - infineon,ir36021
           # Infineon IR38060 Voltage Regulator
           - infineon,ir38060
-            # Infineon IR38064 Voltage Regulator
+          # Infineon IR38064 Voltage Regulator
           - infineon,ir38064
           # Infineon IR38164 Voltage Regulator
           - infineon,ir38164
           # Infineon IR38263 Voltage Regulator
           - infineon,ir38263
-            # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
+          # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
           - infineon,slb9635tt
-            # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
+          # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
           - infineon,slb9645tt
-            # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
+          # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
-            # Infineon Multi-phase Digital VR Controller xdpe12254
+          # Infineon Multi-phase Digital VR Controller xdpe12254
           - infineon,xdpe12254
-            # Infineon Multi-phase Digital VR Controller xdpe12284
+          # Infineon Multi-phase Digital VR Controller xdpe12284
           - infineon,xdpe12284
-            # Inspur Power System power supply unit version 1
+          # Inspur Power System power supply unit version 1
           - inspur,ipsps1
-            # Intersil ISL29028 Ambient Light and Proximity Sensor
+          # Intersil ISL29028 Ambient Light and Proximity Sensor
           - isil,isl29028
-            # Intersil ISL29030 Ambient Light and Proximity Sensor
+          # Intersil ISL29030 Ambient Light and Proximity Sensor
           - isil,isl29030
-            # Intersil ISL68137 Digital Output Configurable PWM Controller
+          # Intersil ISL68137 Digital Output Configurable PWM Controller
           - isil,isl68137
-            # 5 Bit Programmable, Pulse-Width Modulator
+          # 5 Bit Programmable, Pulse-Width Modulator
           - maxim,ds1050
-            # 10 kOhm digital potentiometer with I2C interface
+          # 10 kOhm digital potentiometer with I2C interface
           - maxim,ds1803-010
-            # 50 kOhm digital potentiometer with I2C interface
+          # 50 kOhm digital potentiometer with I2C interface
           - maxim,ds1803-050
-            # 100 kOhm digital potentiometer with I2C interface
+          # 100 kOhm digital potentiometer with I2C interface
           - maxim,ds1803-100
-            # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
+          # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
           - maxim,max1237
-            # Temperature Sensor, I2C interface
+          # Temperature Sensor, I2C interface
           - maxim,max1619
-            # 10-bit 10 kOhm linear programable voltage divider
+          # 10-bit 10 kOhm linear programable voltage divider
           - maxim,max5481
-            # 10-bit 50 kOhm linear programable voltage divider
+          # 10-bit 50 kOhm linear programable voltage divider
           - maxim,max5482
-            # 10-bit 10 kOhm linear programable variable resistor
+          # 10-bit 10 kOhm linear programable variable resistor
           - maxim,max5483
-            # 10-bit 50 kOhm linear programable variable resistor
+          # 10-bit 50 kOhm linear programable variable resistor
           - maxim,max5484
-            # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
+          # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
           - maxim,max6621
-            # 9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
+          # 9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
           - maxim,max6625
-            # 3-Channel Remote Temperature Sensor
+          # 3-Channel Remote Temperature Sensor
           - maxim,max31730
-            # mCube 3-axis 8-bit digital accelerometer
+          # mCube 3-axis 8-bit digital accelerometer
           - mcube,mc3230
-            # Measurement Specialities I2C temperature and humidity sensor
+          # Measurement Specialities I2C temperature and humidity sensor
           - meas,htu21
-            # Measurement Specialities I2C pressure and temperature sensor
+          # Measurement Specialities I2C pressure and temperature sensor
           - meas,ms5637
-            # Measurement Specialities I2C pressure and temperature sensor
+          # Measurement Specialities I2C pressure and temperature sensor
           - meas,ms5803
-            # Measurement Specialities I2C pressure and temperature sensor
+          # Measurement Specialities I2C pressure and temperature sensor
           - meas,ms5805
-            # Measurement Specialities I2C pressure and temperature sensor
+          # Measurement Specialities I2C pressure and temperature sensor
           - meas,ms5837
-            # Measurement Specialities temp and humidity part of ms8607 device
+          # Measurement Specialities temp and humidity part of ms8607 device
           - meas,ms8607-humidity
-            # Measurement Specialities temp and pressure part of ms8607 device
+          # Measurement Specialities temp and pressure part of ms8607 device
           - meas,ms8607-temppressure
-            # Measurement Specialties temperature sensor
+          # Measurement Specialties temperature sensor
           - meas,tsys01
-            # MEMSIC magnetometer
+          # MEMSIC magnetometer
           - memsic,mmc35240
-            # MEMSIC 3-axis accelerometer
+          # MEMSIC 3-axis accelerometer
           - memsic,mx4005
-            # MEMSIC 2-axis 8-bit digital accelerometer
+          # MEMSIC 2-axis 8-bit digital accelerometer
           - memsic,mxc6225
-            # MEMSIC 2-axis 8-bit digital accelerometer
+          # MEMSIC 2-axis 8-bit digital accelerometer
           - memsic,mxc6255
-            # MEMSIC 3-axis accelerometer
+          # MEMSIC 3-axis accelerometer
           - memsic,mxc6655
-            # Microchip differential I2C ADC, 1 Channel, 18 bit
+          # Microchip differential I2C ADC, 1 Channel, 18 bit
           - microchip,mcp3421
-            # Microchip differential I2C ADC, 2 Channel, 18 bit
+          # Microchip differential I2C ADC, 2 Channel, 18 bit
           - microchip,mcp3422
-            # Microchip differential I2C ADC, 2 Channel, 18 bit
+          # Microchip differential I2C ADC, 2 Channel, 18 bit
           - microchip,mcp3423
-            # Microchip differential I2C ADC, 4 Channel, 18 bit
+          # Microchip differential I2C ADC, 4 Channel, 18 bit
           - microchip,mcp3424
-            # Microchip differential I2C ADC, 1 Channel, 16 bit
+          # Microchip differential I2C ADC, 1 Channel, 16 bit
           - microchip,mcp3425
-            # Microchip differential I2C ADC, 2 Channel, 16 bit
+          # Microchip differential I2C ADC, 2 Channel, 16 bit
           - microchip,mcp3426
-            # Microchip differential I2C ADC, 2 Channel, 16 bit
+          # Microchip differential I2C ADC, 2 Channel, 16 bit
           - microchip,mcp3427
-            # Microchip differential I2C ADC, 4 Channel, 16 bit
+          # Microchip differential I2C ADC, 4 Channel, 16 bit
           - microchip,mcp3428
-            # Microchip 7-bit Single I2C Digital POT (5k)
+          # Microchip 7-bit Single I2C Digital POT (5k)
           - microchip,mcp4017-502
-            # Microchip 7-bit Single I2C Digital POT (10k)
+          # Microchip 7-bit Single I2C Digital POT (10k)
           - microchip,mcp4017-103
-            # Microchip 7-bit Single I2C Digital POT (50k)
+          # Microchip 7-bit Single I2C Digital POT (50k)
           - microchip,mcp4017-503
-            # Microchip 7-bit Single I2C Digital POT (100k)
+          # Microchip 7-bit Single I2C Digital POT (100k)
           - microchip,mcp4017-104
-            # Microchip 7-bit Single I2C Digital POT (5k)
+          # Microchip 7-bit Single I2C Digital POT (5k)
           - microchip,mcp4018-502
-            # Microchip 7-bit Single I2C Digital POT (10k)
+          # Microchip 7-bit Single I2C Digital POT (10k)
           - microchip,mcp4018-103
-            # Microchip 7-bit Single I2C Digital POT (50k)
+          # Microchip 7-bit Single I2C Digital POT (50k)
           - microchip,mcp4018-503
-            # Microchip 7-bit Single I2C Digital POT (100k)
+          # Microchip 7-bit Single I2C Digital POT (100k)
           - microchip,mcp4018-104
-            # Microchip 7-bit Single I2C Digital POT (5k)
+          # Microchip 7-bit Single I2C Digital POT (5k)
           - microchip,mcp4019-502
-            # Microchip 7-bit Single I2C Digital POT (10k)
+          # Microchip 7-bit Single I2C Digital POT (10k)
           - microchip,mcp4019-103
-            # Microchip 7-bit Single I2C Digital POT (50k)
+          # Microchip 7-bit Single I2C Digital POT (50k)
           - microchip,mcp4019-503
-            # Microchip 7-bit Single I2C Digital POT (100k)
+          # Microchip 7-bit Single I2C Digital POT (100k)
           - microchip,mcp4019-104
-            # PWM Fan Speed Controller With Fan Fault Detection
+          # PWM Fan Speed Controller With Fan Fault Detection
           - microchip,tc654
-            # PWM Fan Speed Controller With Fan Fault Detection
+          # PWM Fan Speed Controller With Fan Fault Detection
           - microchip,tc655
-            # MiraMEMS DA226 2-axis 14-bit digital accelerometer
+          # MiraMEMS DA226 2-axis 14-bit digital accelerometer
           - miramems,da226
-            # MiraMEMS DA280 3-axis 14-bit digital accelerometer
+          # MiraMEMS DA280 3-axis 14-bit digital accelerometer
           - miramems,da280
-            # MiraMEMS DA311 3-axis 12-bit digital accelerometer
+          # MiraMEMS DA311 3-axis 12-bit digital accelerometer
           - miramems,da311
-            # Temperature sensor with integrated fan control
+          # Temperature sensor with integrated fan control
           - national,lm63
-            # I2C TEMP SENSOR
+          # I2C TEMP SENSOR
           - national,lm75
-            # Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
+          # Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
           - national,lm80
-            # Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
+          # Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
           - national,lm81
-            # Temperature sensor with integrated fan control
+          # Temperature sensor with integrated fan control
           - national,lm85
-            # I2C ±0.33°C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator
+          # I2C ±0.33°C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator
           - national,lm92
-            # i2c trusted platform module (TPM)
+          # i2c trusted platform module (TPM)
           - nuvoton,npct501
-            # i2c trusted platform module (TPM2)
+          # i2c trusted platform module (TPM2)
           - nuvoton,npct601
-            # Nuvoton Temperature Sensor
+          # Nuvoton Temperature Sensor
           - nuvoton,w83773g
-            # OKI ML86V7667 video decoder
+          # OKI ML86V7667 video decoder
           - oki,ml86v7667
-            # OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
+          # OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
           - ovti,ov5642
-            # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
+          # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
           - plx,pex8648
-            # Pulsedlight LIDAR range-finding sensor
+          # Pulsedlight LIDAR range-finding sensor
           - pulsedlight,lidar-lite-v2
-            # Renesas ISL29501 time-of-flight sensor
+          # Renesas ISL29501 time-of-flight sensor
           - renesas,isl29501
-            # S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
+          # S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
           - samsung,24ad0xd1
-            # Sensirion low power multi-pixel gas sensor with I2C interface
+          # Sensirion low power multi-pixel gas sensor with I2C interface
           - sensirion,sgpc3
-            # Sensirion multi-pixel gas sensor with I2C interface
+          # Sensirion multi-pixel gas sensor with I2C interface
           - sensirion,sgp30
-            # Sensirion gas sensor with I2C interface
+          # Sensirion gas sensor with I2C interface
           - sensirion,sgp40
-            # Sensirion temperature & humidity sensor with I2C interface
+          # Sensirion temperature & humidity sensor with I2C interface
           - sensirion,sht4x
-            # Sensortek 3 axis accelerometer
+          # Sensortek 3 axis accelerometer
           - sensortek,stk8312
-            # Sensortek 3 axis accelerometer
+          # Sensortek 3 axis accelerometer
           - sensortek,stk8ba50
-            # SGX Sensortech VZ89X Sensors
+          # SGX Sensortech VZ89X Sensors
           - sgx,vz89x
-            # Relative Humidity and Temperature Sensors
+          # Relative Humidity and Temperature Sensors
           - silabs,si7020
-            # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
+          # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
           - skyworks,sky81452
-            # Socionext SynQuacer TPM MMIO module
+          # Socionext SynQuacer TPM MMIO module
           - socionext,synquacer-tpm-mmio
-            # SparkFun Qwiic Joystick (COM-15168) with i2c interface
+          # SparkFun Qwiic Joystick (COM-15168) with i2c interface
           - sparkfun,qwiic-joystick
-            # i2c serial eeprom (24cxx)
+          # i2c serial eeprom (24cxx)
           - st,24c256
-            # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
+          # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
           - taos,tsl2550
-            # Temperature Monitoring and Fan Control
+          # Temperature Monitoring and Fan Control
           - ti,amc6821
-            # Temperature and humidity sensor with i2c interface
+          # Temperature and humidity sensor with i2c interface
           - ti,hdc1000
-            # Temperature and humidity sensor with i2c interface
+          # Temperature and humidity sensor with i2c interface
           - ti,hdc1008
-            # Temperature and humidity sensor with i2c interface
+          # Temperature and humidity sensor with i2c interface
           - ti,hdc1010
-            # Temperature and humidity sensor with i2c interface
+          # Temperature and humidity sensor with i2c interface
           - ti,hdc1050
-            # Temperature and humidity sensor with i2c interface
+          # Temperature and humidity sensor with i2c interface
           - ti,hdc1080
-            # Thermometer with SPI interface
+          # Thermometer with SPI interface
           - ti,lm70
           - ti,lm71
-            # Temperature sensor with 2-wire interface
+          # Temperature sensor with 2-wire interface
           - ti,lm73
-            # Thermometer with SPI interface
+          # Thermometer with SPI interface
           - ti,lm74
-            # Temperature sensor with integrated fan control
+          # Temperature sensor with integrated fan control
           - ti,lm96000
-            # I2C Touch-Screen Controller
+          # I2C Touch-Screen Controller
           - ti,tsc2003
-            # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
+          # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
           - ti,tmp103
-            # Thermometer with SPI interface
+          # Thermometer with SPI interface
           - ti,tmp121
           - ti,tmp122
-            # Digital Temperature Sensor
+          # Digital Temperature Sensor
           - ti,tmp275
-            # TI DC-DC converter on PMBus
+          # TI DC-DC converter on PMBus
           - ti,tps40400
-            # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus
+          # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus
           - ti,tps53676
-            # TI Dual channel DCAP+ multiphase controller TPS53679
+          # TI Dual channel DCAP+ multiphase controller TPS53679
           - ti,tps53679
-            # TI Dual channel DCAP+ multiphase controller TPS53688
+          # TI Dual channel DCAP+ multiphase controller TPS53688
           - ti,tps53688
-            # TI DC-DC converters on PMBus
+          # TI DC-DC converters on PMBus
           - ti,tps544b20
           - ti,tps544b25
           - ti,tps544c20
           - ti,tps544c25
-            # Winbond/Nuvoton H/W Monitor
+          # Winbond/Nuvoton H/W Monitor
           - winbond,w83793
-            # i2c trusted platform module (TPM)
+          # i2c trusted platform module (TPM)
           - winbond,wpct301
 
 required:
-- 
2.25.1

