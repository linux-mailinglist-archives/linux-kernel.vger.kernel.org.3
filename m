Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F7F48F37E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiAOA3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiAOA27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:28:59 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63944C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:28:58 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o12so18703819lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V1DXl2QN0Yg/QA4GazVhfXW8UeBlS4arPe8SbjwUtjM=;
        b=kwMQmuJUj/Z2gbXlYEstgwJ7aXznH8DixCQUz8n2gnpTDvhunq/b1VENv/lvgJNWs3
         b/XefIN2likIZoGzWE2X3uu1dkGo9NZCMrKtxmY0LTtG/a6qZPyr6XwyKKhP6hbeVcE3
         l3hK7krvINnn/Xw+7ZIZvpIxBjUx98aSaPJTXfr61iNN2vPzAwjBmpjgCybd1U1Ul37n
         /Qqgcexuro+ZpAUTrAxqVVmX7JAGOMI6LSm4vmfdYefubPGaLBcu1l4QbYisfqE93a/E
         p1EKVrgrJh6iqZJYqwlWV6LF/lGDfsPGsR+a9a52S1WXVE1Ni8OIy5/vclZ2RbUT0KTb
         Q9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V1DXl2QN0Yg/QA4GazVhfXW8UeBlS4arPe8SbjwUtjM=;
        b=J0YFcwAmkKs6qMVT2pRLWfu5kr+TP4TncXcU7C40cSb0Ew/KZqa0g6mqoCkR2vlQEy
         gwtWErnZz8EqY+VczxIvBiEdB3doWj6Z8oGzWbcy1gSstOtzVvZU7uuGiFSUA1cJnUuQ
         +yf+ZFGNtP0zS0ypl96mHxtCiOFgZTEcACr9iHO3vkydfhQxnefORv6G2J+S4V0qmcY9
         8EAKkaMiuN2nMrdRPWfqZQqjfESGKr0eMV8JNP2smvTMjB5uHWCEkvZAnmAaLBGbtC5E
         RTtCifpkbZksKe1rqlVjxtY7+bxQBaYWruVaIDIkUpY5mYdDsyCkemk8ZL9lQT+6g1Na
         O1UA==
X-Gm-Message-State: AOAM531+wJV6Zah/TCKF7VGopYYKhGcXVSEXMacsW1e96ijyF6c+Jllx
        AL6K/znB0JhZqBCvS12iwlLb+Q==
X-Google-Smtp-Source: ABdhPJziENN9o90bPW9y5DiZo7/zZAt7u2JespChJUO3NQd0zD3yFEA/6vF6gzCwnEb3vRd8OW7Wxg==
X-Received: by 2002:a05:6512:3fa2:: with SMTP id x34mr8442720lfa.486.1642206536514;
        Fri, 14 Jan 2022 16:28:56 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id w20sm716844lfu.274.2022.01.14.16.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:28:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] mfd: ab8500: Rewrite bindings in YAML
Date:   Sat, 15 Jan 2022 01:26:49 +0100
Message-Id: <20220115002649.1526163-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rewrites the former text based AB8500 bindings in YAML.

When the AB8500 bindings were first written (in 2012) we
were not strict on some things and node names were definitely
not standardized.

This patch uses standard node names to most of the subnodes
on the AB8500 and is accompanied by another patch fixing
all the DTS files to conform to this.

The bindings are not as perfect as newly written bindings
would be, it is a best effort to deal with the legacy.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/mfd/ab8500.txt        | 282 ----------
 .../bindings/mfd/stericsson,ab8500.yaml       | 500 ++++++++++++++++++
 .../bindings/mfd/stericsson,db8500-prcmu.yaml |   1 +
 3 files changed, 501 insertions(+), 282 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/ab8500.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
deleted file mode 100644
index 937b3e5505e0..000000000000
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ /dev/null
@@ -1,282 +0,0 @@
-* AB8500 Multi-Functional Device (MFD)
-
-Required parent device properties:
-- compatible             : contains "stericsson,ab8500" or "stericsson,ab8505";
-- interrupts             : contains the IRQ line for the AB8500
-- interrupt-controller   : describes the AB8500 as an Interrupt Controller (has its own domain)
-- #interrupt-cells       : should be 2, for 2-cell format
-                            - The first cell is the AB8500 local IRQ number
-                            - The second cell is used to specify optional parameters
-                              - bits[3:0] trigger type and level flags:
-                                  1 = low-to-high edge triggered
-                                  2 = high-to-low edge triggered
-                                  4 = active high level-sensitive
-                                  8 = active low level-sensitive
-
-The AB8500 consists of a large and varied group of sub-devices:
-
-Device                     IRQ Names              Supply Names   Description
-------                     ---------              ------------   -----------
-ab8500-bm                :                      :              : Battery Manager
-ab8500-btemp             :                      :              : Battery Temperature
-ab8500-charger           :                      :              : Battery Charger
-ab8500-codec             :                      :              : Audio Codec
-ab8500-fg                : 			: vddadc       : Fuel Gauge
-			 : NCONV_ACCU           :	       : Accumulate N Sample Conversion
-			 : BATT_OVV		:	       : Battery Over Voltage
-			 : LOW_BAT_F		:	       : LOW threshold battery voltage
-			 : CC_INT_CALIB		:	       : Coulomb Counter Internal Calibration
-			 : CCEOC		:	       : Coulomb Counter End of Conversion
-ab8500-btemp		 :			: vtvout       : Battery Temperature
-			 : BAT_CTRL_INDB        :              : Battery Removal Indicator
-			 : BTEMP_LOW            :              : Btemp < BtempLow, if battery temperature is lower than -10°C
-			 : BTEMP_LOW_MEDIUM     :              : BtempLow < Btemp < BtempMedium,if battery temperature is between -10 and 0°C
-			 : BTEMP_MEDIUM_HIGH    :	       : BtempMedium < Btemp < BtempHigh,if battery temperature is between 0°C and MaxTemp
-			 : BTEMP_HIGH           :              : Btemp > BtempHigh, if battery temperature is higher than MaxTemp
-ab8500-charger		 :			: vddadc       : Charger interface
-			 : MAIN_CH_UNPLUG_DET	:	       : main charger unplug detection management (not in 8505)
-			 : MAIN_CHARGE_PLUG_DET	:	       : main charger plug detection management (not in 8505)
-			 : MAIN_EXT_CH_NOT_OK	:	       : main charger not OK
-			 : MAIN_CH_TH_PROT_R	:	       : Die temp is above main charger
-			 : MAIN_CH_TH_PROT_F	:	       : Die temp is below main charger
-			 : VBUS_DET_F		:	       : VBUS falling detected
-			 : VBUS_DET_R		:	       : VBUS rising detected
-			 : USB_LINK_STATUS	:	       : USB link status has changed
-			 : USB_CH_TH_PROT_R	:	       : Die temp is above usb charger
-			 : USB_CH_TH_PROT_F	:	       : Die temp is below usb charger
-			 : USB_CHARGER_NOT_OKR	:	       : allowed USB charger not ok detection
-			 : VBUS_OVV		:	       : Overvoltage on Vbus ball detected (USB charge is stopped)
-			 : CH_WD_EXP		:	       : Charger watchdog detected
-ab8500-gpadc             : HW_CONV_END          : vddadc       : Analogue to Digital Converter
-                           SW_CONV_END          :              :
-ab8500-gpio              :                      :              : GPIO Controller (AB8500)
-ab8505-gpio              :                      :              : GPIO Controller (AB8505)
-ab8500-ponkey            : ONKEY_DBF            :              : Power-on Key
-                           ONKEY_DBR            :              :
-ab8500-pwm               :                      :              : Pulse Width Modulator
-ab8500-regulator         :                      :              : Regulators (AB8500)
-ab8505-regulator         :                      :              : Regulators (AB8505)
-ab8500-rtc               : 60S                  :              : Real Time Clock
-                         : ALARM                :              :
-ab8500-sysctrl           :                      :              : System Control
-ab8500-usb               : ID_WAKEUP_R          : vddulpivio18 : Universal Serial Bus
-                         : ID_WAKEUP_F          : v-ape        :
-                         : VBUS_DET_F           : musb_1v8     :
-                         : VBUS_DET_R           :              :
-                         : USB_LINK_STATUS      :              :
-                         : USB_ADP_PROBE_PLUG   :              :
-                         : USB_ADP_PROBE_UNPLUG :              :
-
-Required child device properties:
-- compatible             : "stericsson,ab8500-[bm|btemp|charger|fg|gpadc|gpio|ponkey|
-                                               pwm|regulator|rtc|sysctrl|usb]";
-
-  A few child devices require ADC channels from the GPADC node. Those follow the
-  standard bindings from
-  https://github.com/devicetree-org/dt-schema/blob/master/schemas/iio/iio-consumer.yaml
-  and Documentation/devicetree/bindings/iio/adc/adc.yaml
-
-  abx500-temp		 : io-channels "aux1" and "aux2" for measuring external
-			   temperatures.
-  ab8500-fg		 : io-channel "main_bat_v" for measuring main battery voltage,
-  ab8500-btemp		 : io-channels "btemp_ball" and "bat_ctrl" for measuring the
-			   battery voltage.
-  ab8500-charger	 : io-channels "main_charger_v", "main_charger_c", "vbus_v",
-			   "usb_charger_c" for measuring voltage and current of the
-			   different charging supplies.
-
-Optional child device properties:
-- interrupts             : contains the device IRQ(s) using the 2-cell format (see above)
-- interrupt-names        : contains names of IRQ resource in the order in which they were
-                           supplied in the interrupts property
-- <supply_name>-supply   : contains a phandle to the regulator supply node in Device Tree
-
-Non-standard child device properties:
- - Audio CODEC:
-   - stericsson,amic[1|2]-type-single-ended : Single-ended Analoge Mic (default: differential)
-   - stericsson,amic1a-bias-vamic2          : Analoge Mic wishes to use a non-standard Vamic
-   - stericsson,amic1b-bias-vamic2          : Analoge Mic wishes to use a non-standard Vamic
-   - stericsson,amic2-bias-vamic1           : Analoge Mic wishes to use a non-standard Vamic
-   - stericsson,earpeice-cmv                : Earpeice voltage (only: 950 | 1100 | 1270 | 1580)
-
-ab8500 {
-         compatible = "stericsson,ab8500";
-         interrupts = <0 40 0x4>;
-         interrupt-controller;
-         #interrupt-cells = <2>;
-
-         ab8500-rtc {
-                 compatible = "stericsson,ab8500-rtc";
-                 interrupts = <17 0x4
-                               18 0x4>;
-                 interrupt-names = "60S", "ALARM";
-         };
-
-        ab8500-gpadc {
-                compatible = "stericsson,ab8500-gpadc";
-                interrupts = <32 0x4
-                              39 0x4>;
-                interrupt-names = "HW_CONV_END", "SW_CONV_END";
-                vddadc-supply = <&ab8500_ldo_tvout_reg>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		#io-channel-cells = <1>;
-
-		/* GPADC channels */
-		bat_ctrl: channel@1 {
-			reg = <0x01>;
-		};
-		btemp_ball: channel@2 {
-			reg = <0x02>;
-		};
-		main_charger_v: channel@3 {
-			reg = <0x03>;
-		};
-		acc_detect1: channel@4 {
-			reg = <0x04>;
-		};
-		acc_detect2: channel@5 {
-			reg = <0x05>;
-		};
-		adc_aux1: channel@6 {
-			reg = <0x06>;
-		};
-		adc_aux2: channel@7 {
-			reg = <0x07>;
-		};
-		main_batt_v: channel@8 {
-			reg = <0x08>;
-		};
-		vbus_v: channel@9 {
-			reg = <0x09>;
-		};
-		main_charger_c: channel@a {
-			reg = <0x0a>;
-		};
-		usb_charger_c: channel@b {
-			reg = <0x0b>;
-		};
-		bk_bat_v: channel@c {
-			reg = <0x0c>;
-		};
-		die_temp: channel@d {
-			reg = <0x0d>;
-		};
-		usb_id: channel@e {
-			reg = <0x0e>;
-		};
-		xtal_temp: channel@12 {
-			reg = <0x12>;
-		};
-		vbat_true_meas: channel@13 {
-			reg = <0x13>;
-		};
-		bat_ctrl_and_ibat: channel@1c {
-			reg = <0x1c>;
-		};
-		vbat_meas_and_ibat: channel@1d {
-			reg = <0x1d>;
-		};
-		vbat_true_meas_and_ibat: channel@1e {
-			reg = <0x1e>;
-		};
-		bat_temp_and_ibat: channel@1f {
-			reg = <0x1f>;
-		};
-        };
-
-	ab8500_temp {
-		compatible = "stericsson,abx500-temp";
-		io-channels = <&gpadc 0x06>,
-			      <&gpadc 0x07>;
-		io-channel-name = "aux1", "aux2";
-	};
-
-	ab8500_battery: ab8500_battery {
-		stericsson,battery-type = "LIPO";
-		thermistor-on-batctrl;
-	};
-
-	ab8500_fg {
-		compatible = "stericsson,ab8500-fg";
-		battery	   = <&ab8500_battery>;
-		io-channels = <&gpadc 0x08>;
-		io-channel-name = "main_bat_v";
-	};
-
-	ab8500_btemp {
-		compatible = "stericsson,ab8500-btemp";
-		battery	   = <&ab8500_battery>;
-		io-channels = <&gpadc 0x02>,
-			      <&gpadc 0x01>;
-		io-channel-name = "btemp_ball",
-				"bat_ctrl";
-	};
-
-	ab8500_charger {
-		compatible	= "stericsson,ab8500-charger";
-		battery		= <&ab8500_battery>;
-		vddadc-supply	= <&ab8500_ldo_tvout_reg>;
-		io-channels = <&gpadc 0x03>,
-			      <&gpadc 0x0a>,
-			      <&gpadc 0x09>,
-			      <&gpadc 0x0b>;
-		io-channel-name = "main_charger_v",
-				"main_charger_c",
-				"vbus_v",
-				"usb_charger_c";
-	};
-
-        ab8500-usb {
-                compatible = "stericsson,ab8500-usb";
-                interrupts = < 90 0x4
-                               96 0x4
-                               14 0x4
-                               15 0x4
-                               79 0x4
-                               74 0x4
-                               75 0x4>;
-                interrupt-names = "ID_WAKEUP_R",
-                                  "ID_WAKEUP_F",
-                                  "VBUS_DET_F",
-                                  "VBUS_DET_R",
-                                  "USB_LINK_STATUS",
-                                  "USB_ADP_PROBE_PLUG",
-                                  "USB_ADP_PROBE_UNPLUG";
-                vddulpivio18-supply = <&ab8500_ldo_intcore_reg>;
-                v-ape-supply = <&db8500_vape_reg>;
-                musb_1v8-supply = <&db8500_vsmps2_reg>;
-        };
-
-        ab8500-ponkey {
-                compatible = "stericsson,ab8500-ponkey";
-                interrupts = <6 0x4
-                              7 0x4>;
-                interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
-        };
-
-        ab8500-sysctrl {
-                compatible = "stericsson,ab8500-sysctrl";
-        };
-
-        ab8500-pwm {
-                compatible = "stericsson,ab8500-pwm";
-        };
-
-	codec: ab8500-codec {
-		compatible = "stericsson,ab8500-codec";
-
-		stericsson,earpeice-cmv = <950>; /* Units in mV. */
-	};
-
-        ab8500-regulators {
-                compatible = "stericsson,ab8500-regulator";
-
-                ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
-                        /*
-                         * See: Documentation/devicetree/bindings/regulator/regulator.txt
-                         * for more information on regulators
-                         */
-                };
-        };
-};
diff --git a/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml b/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
new file mode 100644
index 000000000000..623a4b5cd27a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
@@ -0,0 +1,500 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/stericsson,ab8500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST-Ericsson Analog Baseband AB8500 and AB8505
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  the AB8500 "Analog Baseband" is the mixed-signals integrated circuit
+  handling power management (regulators), analog-to-digital conversion
+  (ADC), battery charging, fuel gauging of the battery, battery-backed
+  RTC, PWM, USB PHY and some GPIO lines in the ST-Ericsson U8500 platforms
+  in connection with the DB8500 digital baseband. The DB8500 PRCMU
+  communicates directly and autonomously with the AB8500 and thus it
+  appears as a subnode of the DB8500 PRCMU. An altered version called
+  AB8505 also exist, the difference in AB8505 is that some of the USB and
+  USB charging handling has changed, and it has an embedded USB-to-serial
+  converter. Most subblocks takes their interrupts directly from the
+  AB8500 embedded interrupt controller.
+
+properties:
+  $nodename:
+    pattern: '^ab850[05]$'
+
+  compatible:
+    enum:
+      - stericsson,ab8500
+      - stericsson,ab8505
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  # Some subnodes use a reg, some don't. Those that do use a single cell.
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  clock-controller:
+    description: Node describing the AB8500 clock controller. This
+      provides the reference clock for the entire U8500 system and
+      the DB8500 counterpart.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,ab8500-clk
+
+      '#clock-cells':
+        const: 1
+
+  gpio:
+    description: Node describing the AB8500 GPIO controller. A few
+      GPIO pins available for misc usage.
+    type: object
+
+    properties:
+      compatible:
+        enum:
+          - stericsson,ab8500-gpio
+          - stericsson,ab8505-gpio
+
+      gpio-controller: true
+
+      '#gpio-cells':
+        const: 2
+
+  rtc:
+    description: Node describing the AB8500 battery-backed RTC.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,ab8500-rtc
+
+      interrupts:
+        items:
+          - description: 60 second interval alarm interrupt
+          - description: RTC alarm
+
+      interrupt-names:
+        items:
+          - const: 60S
+          - const: ALARM
+
+  adc:
+    description: Node describing the AB8500 general purpose analog to digital
+      converter, GPADC.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,ab8500-gpadc
+
+      # AB8505 only supports one (software) EOC interrupt
+      interrupts:
+        minItems: 1
+        maxItems: 2
+
+      interrupt-names: true
+
+      vddadc-supply: true
+
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+      '#io-channel-cells':
+        const: 1
+
+    patternProperties:
+      "^channel@[0-9a-f]+$":
+        type: object
+        $ref: ../iio/adc/adc.yaml#
+        description: Represents each of the external channels which are
+          connected to the ADC.
+
+        properties:
+          reg:
+            items:
+              minimum: 1
+              maximum: 31
+
+        required:
+          - reg
+
+        additionalProperties: false
+
+    required:
+      - compatible
+      - interrupts
+      - interrupt-names
+      - vddadc-supply
+      - '#address-cells'
+      - '#size-cells'
+      - '#io-channel-cells'
+
+    additionalProperties: false
+
+  thermal:
+    description: Node describing the AB8500 thermal control block. All this block
+      really does is to fire an interrupt when the die becomes 130 degrees Celsius
+      in temperature.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,abx500-temp
+
+      interrupts:
+        items:
+          - description: Thermal warm warning interrupt
+
+      interrupt-names:
+        items:
+          - const: ABX500_TEMP_WARM
+
+    required:
+      - compatible
+      - interrupts
+      - interrupt-names
+
+    additionalProperties: false
+
+  ab8500_fg:
+    description: Node describing the AB8500 fuel gauge control block.
+    type: object
+    $ref: ../power/supply/stericsson,ab8500-fg.yaml
+
+  ab8500_btemp:
+    description: Node describing the AB8500 battery temperature control block.
+    type: object
+    $ref: ../power/supply/stericsson,ab8500-btemp.yaml
+
+  ab8500_charger:
+    description: Node describing the AB8500 battery charger control block.
+    type: object
+    $ref: ../power/supply/stericsson,ab8500-charger.yaml
+
+  ab8500_chargalg:
+    description: Node describing the AB8500 battery charger algorithm.
+    type: object
+    $ref: ../power/supply/stericsson,ab8500-chargalg.yaml
+
+  phy:
+    description: Node describing the AB8500 USB PHY control block.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,ab8500-usb
+
+      interrupts:
+        items:
+          - description: ID wakeup rising IRQ
+          - description: ID wakeup falling IRQ
+          - description: VBUS detection falling IRQ
+          - description: VBUS detection rising IRQ
+          - description: USB link status change IRQ
+          - description: ADP probe plug IRQ
+          - description: ADP probe unplug IRQ
+
+      interrupt-names:
+        items:
+          - const: ID_WAKEUP_R
+          - const: ID_WAKEUP_F
+          - const: VBUS_DET_F
+          - const: VBUS_DET_R
+          - const: USB_LINK_STATUS
+          - const: USB_ADP_PROBE_PLUG
+          - const: USB_ADP_PROBE_UNPLUG
+
+      vddulpivio18-supply: true
+      v-ape-supply: true
+      musb_1v8-supply: true
+
+      clocks:
+        items:
+          - description: PRCMY system clock
+
+      clock-names:
+        items:
+          - const: sysclk
+
+      '#phy-cells':
+        const: 0
+
+    required:
+      - compatible
+      - interrupts
+      - interrupt-names
+      - vddulpivio18-supply
+      - v-ape-supply
+      - musb_1v8-supply
+      - clocks
+      - clock-names
+      - '#phy-cells'
+
+    additionalProperties: false
+
+  key:
+    description: Node describing the AB8500 power-on key control block.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,ab8500-poweron-key
+
+      interrupts:
+        items:
+          - description: ON key falling IRQ
+          - description: ON key rising IRQ
+
+      interrupt-names:
+        items:
+          - const: ONKEY_DBF
+          - const: ONKEY_DBR
+
+    required:
+      - compatible
+      - interrupts
+      - interrupt-names
+
+    additionalProperties: false
+
+  ab8500-sysctrl:
+    description: Node describing the AB8500 system control block.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,ab8500-sysctrl
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+  codec:
+    description: Node describing the AB8500 audio codec block.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,ab8500-codec
+
+      V-AUD-supply: true
+      V-AMIC1-supply: true
+      V-AMIC2-supply: true
+      V-DMIC-supply: true
+
+      clocks:
+        items:
+          - description: Audio system clock
+
+      clock-names:
+        items:
+          - const: audioclk
+
+      stericsson,earpeice-cmv:
+        description: Earpeice voltage
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 950, 1100, 1270, 1580 ]
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+  regulator:
+    description: Node describing the AB8500 internal regulators.
+    type: object
+
+    properties:
+      compatible:
+        enum:
+          - stericsson,ab8500-regulator
+          - stericsson,ab8505-regulator
+
+      vin-supply:
+        description: The regulator supplying all of the internal regulators
+          with power.
+
+      ab8500_ldo_aux1:
+        description: The voltage for the auxilary LDO regulator 1
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_aux2:
+        description: The voltage for the auxilary LDO regulator 2
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_aux3:
+        description: The voltage for the auxilary LDO regulator 3
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_aux4:
+        description: The voltage for the auxilary LDO regulator 4
+          only present on AB8505
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_aux5:
+        description: The voltage for the auxilary LDO regulator 5
+          only present on AB8505
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_aux6:
+        description: The voltage for the auxilary LDO regulator 6
+          only present on AB8505
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      # There is never any AUX7 regulator which is confusing
+
+      ab8500_ldo_aux8:
+        description: The voltage for the auxilary LDO regulator 8
+          only present on AB8505
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_intcore:
+        description: The LDO regulator for the internal core voltage
+          of the AB8500
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_adc:
+        description: Analog power regulator for the analog to digital converter
+          ADC, only present on AB8505
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_tvout:
+        description: The voltage for the TV output regulator, incidentally
+          this voltage is also used for other purposes such as measuring
+          the temperature of the NTC thermistor on the battery.
+          Only present on AB8500.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_audio:
+        description: The LDO regulator for the audio codec output
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_anamic1:
+        description: The LDO regulator for the analog microphone 1
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_anamic2:
+        description: The LDO regulator for the analog microphone 2
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_dmic:
+        description: The LDO regulator for the digital microphone
+          only present on AB8500
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ldo_ana:
+        description: Analog power regulator for CSI and DSI interfaces,
+          Camera Serial Interface CSI and Display Serial Interface DSI.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+
+  regulator-external:
+    description: Node describing the AB8500 external regulators. This
+      concerns the autonomous regulators VSMPS1, VSMPS2 and VSMPS3
+      that are normally controlled by external electronics but also
+      sometimes need to be explicitly controlled by software.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,ab8500-ext-regulator
+
+      ab8500_ext1:
+        description: The voltage for the VSMPS1 external regulator
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ext2:
+        description: The voltage for the VSMPS2 external regulator
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      ab8500_ext3:
+        description: The voltage for the VSMPS3 external regulator
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+patternProperties:
+  "^pwm@[1-9]+?$":
+    type: object
+    $ref: ../pwm/pwm.yaml#
+    description: Represents each of the PWM blocks in the AB8500
+
+    properties:
+      compatible:
+        const: stericsson,ab8500-pwm
+
+      reg: true
+
+      clocks:
+        items:
+          - description: internal clock
+
+      clock-names:
+        items:
+          - const: intclk
+
+    required:
+      - compatible
+      - reg
+
+required:
+  - compatible
+  - clock-controller
+  - gpio
+  - rtc
+  - adc
+  - thermal
+  - ab8500_fg
+  - ab8500_btemp
+  - ab8500_charger
+  - ab8500_chargalg
+  - phy
+  - key
+  - regulator
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
index a0d4bad5dc81..1d4d88f7e82d 100644
--- a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
+++ b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
@@ -263,6 +263,7 @@ patternProperties:
       set of devicetree bindings. The AB8505 is a newer version of the
       same ASIC.
     type: object
+    $ref: stericsson,ab8500.yaml#
 
 required:
   - compatible
-- 
2.31.1

