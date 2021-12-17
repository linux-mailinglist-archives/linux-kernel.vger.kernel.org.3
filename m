Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4902D47925A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbhLQRFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbhLQRFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:05:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED28C061574;
        Fri, 17 Dec 2021 09:05:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t26so5305847wrb.4;
        Fri, 17 Dec 2021 09:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=um5nB/KXnHI/DITG6uZ2rZ7Qv5xgTfR6aRWla1VMiTI=;
        b=NAY3Y3CN3AEZqKnci8rVhQhUcaMdm56YmCpJoqylNFBfgIQSWEuiDpsCI7730kaLEg
         ZAHPBE/oLc8xJKZy/TxMzbgjxxN1HXDiUJwZAYYWrdefE28uYUy9pzsy7gmmDvsCaAlB
         mbh64nkrOaNyeHKk4Jm2Y5DSuNDs4P0vZ83+h1TBZwY+KkMHYmKkDwfanIJeoY/8cZfu
         aHScRuQ0uIIx4obED1tpRMiRSyc/oDDTq1gz1RN67QQnH7wM9xOR96HbyLcZ65DLfKA9
         V4emKsqv+lMQKDU4vjLsyX9y/dNPW3wHtixhu0zjap3FJhEx7OzHEiXj8ooi/emdGinm
         ZTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=um5nB/KXnHI/DITG6uZ2rZ7Qv5xgTfR6aRWla1VMiTI=;
        b=FA/d3zGLcyQsStc/ifmtF5vUenUTwqMEjt5X6BtcT5dkLw0ZZr6FevoMHPkjcJ9Gv9
         oznBmfhuClFEwBj022TNZh5Xqg7jqGFljpnqZhdA6JIjadJ3w2mE05Qi8kghfPqLzwZn
         2dO3uZRtkYoOQFj1nZSCYZTUvdq7+JMmg6/jFxUVpbSwBY0wCa1H97jY5flAmywAjmcN
         dCUmNVkEV8Sc0kX+mKAQpRN2EI+kiQbNAHRDxKyatIV+aTjPPlGcvjxCG5XK+oQF4j41
         PvGcAXxmbUupYhGAaeFmD+shutRGA8m2nulBftfG41HQokUEaFoJ6yqry/PCWd90Yoqq
         MY3A==
X-Gm-Message-State: AOAM533VcG/GoILHd1+oS8k88Y9uzDAOMFjlIz71WZY0/I2zP6yWpr32
        b3gX/DqlaP/bP5WXY8Mx1Lc=
X-Google-Smtp-Source: ABdhPJyz8a9OmnyH8ogZf25HqJdmJfkjInhBDRlIjecpab42Jjv+XXdt7LLC1BP7bWJtyNSzeu0CEg==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr3252462wrv.83.1639760712439;
        Fri, 17 Dec 2021 09:05:12 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id p12sm9563423wrr.10.2021.12.17.09.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:05:11 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: regulator: pwm: Convert to json-schema
Date:   Fri, 17 Dec 2021 18:05:03 +0100
Message-Id: <20211217170507.2843568-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217170507.2843568-1-thierry.reding@gmail.com>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the generic PWM regulator bindings from the free-form text
format to json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/regulator/pwm-regulator.txt      |  92 -------------
 .../bindings/regulator/pwm-regulator.yaml     | 121 ++++++++++++++++++
 2 files changed, 121 insertions(+), 92 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/pwm-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/pwm-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
deleted file mode 100644
index 3d78d507e29f..000000000000
--- a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
+++ /dev/null
@@ -1,92 +0,0 @@
-Bindings for the Generic PWM Regulator
-======================================
-
-Currently supports 2 modes of operation:
-
-Voltage Table:		When in this mode, a voltage table (See below) of
-			predefined voltage <=> duty-cycle values must be
-			provided via DT. Limitations are that the regulator can
-			only operate at the voltages supplied in the table.
-			Intermediary duty-cycle values which would normally
-			allow finer grained voltage selection are ignored and
-			rendered useless.  Although more control is given to
-			the user if the assumptions made in continuous-voltage
-			mode do not reign true.
-
-Continuous Voltage:	This mode uses the regulator's maximum and minimum
-			supplied voltages specified in the
-			regulator-{min,max}-microvolt properties to calculate
-			appropriate duty-cycle values.  This allows for a much
-			more fine grained solution when compared with
-			voltage-table mode above.  This solution does make an
-			assumption that a %50 duty-cycle value will cause the
-			regulator voltage to run at half way between the
-			supplied max_uV and min_uV values.
-
-Required properties:
---------------------
-- compatible:		Should be "pwm-regulator"
-
-- pwms:			PWM specification (See: ../pwm/pwm.txt)
-
-Only required for Voltage Table Mode:
-- voltage-table: 	Voltage and Duty-Cycle table consisting of 2 cells
-			    First cell is voltage in microvolts (uV)
-			    Second cell is duty-cycle in percent (%)
-
-Optional properties for Continuous mode:
-- pwm-dutycycle-unit:	Integer value encoding the duty cycle unit. If not
-			defined, <100> is assumed, meaning that
-			pwm-dutycycle-range contains values expressed in
-			percent.
-
-- pwm-dutycycle-range:	Should contain 2 entries. The first entry is encoding
-			the dutycycle for regulator-min-microvolt and the
-			second one the dutycycle for regulator-max-microvolt.
-			Duty cycle values are expressed in pwm-dutycycle-unit.
-			If not defined, <0 100> is assumed.
-
-NB: To be clear, if voltage-table is provided, then the device will be used
-in Voltage Table Mode.  If no voltage-table is provided, then the device will
-be used in Continuous Voltage Mode.
-
-Optional properties:
---------------------
-- enable-gpios:		GPIO to use to enable/disable the regulator
-
-Any property defined as part of the core regulator binding can also be used.
-(See: ../regulator/regulator.txt)
-
-Continuous Voltage With Enable GPIO Example:
-	pwm_regulator {
-		compatible = "pwm-regulator";
-		pwms = <&pwm1 0 8448 0>;
-		enable-gpios = <&gpio0 23 GPIO_ACTIVE_HIGH>;
-		regulator-min-microvolt = <1016000>;
-		regulator-max-microvolt = <1114000>;
-		regulator-name = "vdd_logic";
-		/* unit == per-mille */
-		pwm-dutycycle-unit = <1000>;
-		/*
-		 * Inverted PWM logic, and the duty cycle range is limited
-		 * to 30%-70%.
-		 */
-		pwm-dutycycle-range = <700 300>; /* */
-	};
-
-Voltage Table Example:
-	pwm_regulator {
-		compatible = "pwm-regulator";
-		pwms = <&pwm1 0 8448 0>;
-		regulator-min-microvolt = <1016000>;
-		regulator-max-microvolt = <1114000>;
-		regulator-name = "vdd_logic";
-
-			      /* Voltage Duty-Cycle */
-		voltage-table = <1114000 0>,
-				<1095000 10>,
-				<1076000 20>,
-				<1056000 30>,
-				<1036000 40>,
-				<1016000 50>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
new file mode 100644
index 000000000000..d87e8110989d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/pwm-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic PWM Regulator
+
+maintainers:
+  - Rob Herring <robh+dt@kernel.org>
+  - Mark Brown <broonie@kernel.org>
+
+description: |
+  Currently supports 2 modes of operation:
+
+    - Voltage Table: When in this mode, a voltage table (See below) of predefined voltage <=>
+      duty-cycle values must be provided via DT. Limitations are that the regulator can only
+      operate at the voltages supplied in the table. Intermediary duty-cycle values which would
+      normally allow finer grained voltage selection are ignored and rendered useless. Although
+      more control is given to the user if the assumptions made in continuous-voltage mode do not
+      reign true.
+
+    - Continuous Voltage: This mode uses the regulator's maximum and minimum supplied voltages
+      specified in the regulator-{min,max}-microvolt properties to calculate appropriate duty-cycle
+      values. This allows for a much more fine grained solution when compared with voltage-table
+      mode above. This solution does make an assumption that a %50 duty-cycle value will cause the
+      regulator voltage to run at half way between the supplied max_uV and min_uV values.
+
+  NB: To be clear, if voltage-table is provided, then the device will be used
+  in Voltage Table Mode.  If no voltage-table is provided, then the device will
+  be used in Continuous Voltage Mode.
+
+  Any property defined as part of the core regulator binding can also be used. (See:
+  ../regulator/regulator.txt)
+
+properties:
+  compatible:
+    const: pwm-regulator
+
+  pwms:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description: phandle and PWM specifier (see ../pwm/pwm.txt)
+
+  # Only required for Voltage Table Mode:
+  voltage-table:
+    description: Voltage and Duty-Cycle table consisting of 2 cells. The first cell is the voltage
+      in microvolts (uV) and the second cell is duty-cycle in percent (%).
+    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
+
+  # Optional properties for Continuous mode:
+  pwm-dutycycle-unit:
+    description: Integer value encoding the duty cycle unit. If not defined, <100> is assumed,
+      meaning that pwm-dutycycle-range contains values expressed in percent.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  pwm-dutycycle-range:
+    description: Should contain 2 entries. The first entry is encoding the dutycycle for
+      regulator-min-microvolt and the second one the dutycycle for regulator-max-microvolt. Duty
+      cycle values are expressed in pwm-dutycycle-unit. If not defined, <0 100> is assumed.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+
+  # Optional properties:
+  enable-gpios:
+    description: GPIO to use to enable/disable the regulator
+
+  # from regulator.yaml
+  regulator-enable-ramp-delay: true
+  regulator-max-microvolt: true
+  regulator-min-microvolt: true
+  regulator-name: true
+  regulator-ramp-delay: true
+  regulator-settling-time-us: true
+  vin-supply: true
+
+allOf:
+  - $ref: "regulator.yaml"
+
+additionalProperties: false
+
+required:
+  - compatible
+  - pwms
+
+examples:
+  # Continuous Voltage With Enable GPIO:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    pwm_regulator {
+        compatible = "pwm-regulator";
+        pwms = <&pwm1 0 8448 0>;
+        enable-gpios = <&gpio0 23 GPIO_ACTIVE_HIGH>;
+        regulator-min-microvolt = <1016000>;
+        regulator-max-microvolt = <1114000>;
+        regulator-name = "vdd_logic";
+        /* unit == per-mille */
+        pwm-dutycycle-unit = <1000>;
+        /*
+         * Inverted PWM logic, and the duty cycle range is limited
+         * to 30%-70%.
+         */
+        pwm-dutycycle-range = <700 300>; /* */
+    };
+
+  # Voltage Table:
+  - |
+    regulator {
+        compatible = "pwm-regulator";
+        pwms = <&pwm1 0 8448 0>;
+        regulator-min-microvolt = <1016000>;
+        regulator-max-microvolt = <1114000>;
+        regulator-name = "vdd_logic";
+
+        /* Voltage Duty-Cycle */
+        voltage-table = <1114000 0>,
+                        <1095000 10>,
+                        <1076000 20>,
+                        <1056000 30>,
+                        <1036000 40>,
+                        <1016000 50>;
+    };
-- 
2.34.1

