Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6415247925D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbhLQRFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbhLQRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:05:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7BC061574;
        Fri, 17 Dec 2021 09:05:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so5257922wrw.10;
        Fri, 17 Dec 2021 09:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hnze5afaNK8KAxASs6tu173oJOe5Xah/nMoU4ZDZfY=;
        b=QnJrI6lrGj6zO0PXH0bUbjMgM4Hs2cnttprfNLWChbBCuTA2zTw4hzi5MpQ0exvg3J
         7SNWBqZRCYASbMhNPzxPkmW6Rhwuzle/LJlALy/HlUivuA49aNTNMeahtFMk0iwYkiFi
         o28XOwLq16fgKFq68DR9MiLADABRM8xjg5ucEsMw6ob3sYTJgWtjuO0g0dy2MyfWmGXy
         +yhhW71DGZRkvVRGWFmJ1Dq3dK7DFb79COSH46P3EzxaKrd3jucK91Hv0LQeeOFZJAo6
         XXRk++VY+Bd7gJsTqMaG/oLVhIlgCHfyPJkWCRJ/h9VAj9AJPY5dMzChk7tDnMu510cQ
         H4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hnze5afaNK8KAxASs6tu173oJOe5Xah/nMoU4ZDZfY=;
        b=trqNEEKdDIhz57iggBjnbAeZDjY4AubDNH2dYg8GcBEeybqoIb8wXI7OBrljs5Kj8l
         GOC9oi0b5w9xfbRVL3bLFgE1YWni8/WA6BK+Uqt4dZ4DtetiLOTBHFNPKXmvxRAP8jsu
         18t7Zjia08aqwETofe+YEGBmZ39YY5SRBNDMiyUDbPUC0ZuEN7sKHDiS3oYHMBiMbFut
         Yl7MN1n26clWcvgoMUN2qvCnJCWk4lK4TTlisZUeXOhMuQyp23xnV1wxCX/vinvgUOSU
         8dAbsU5zNwoiTpHOVV/kL+f3kF/1jQYSle/FsOHsYsrjfmqhXYMc0XAS6kUVirJ/nvuc
         HymA==
X-Gm-Message-State: AOAM530n3i62kRqiKP7LAIEMQXrIZgPgkumMlghkk8n6RxLmY44rqvTm
        SgW/Xuln13MemdejNE2KL41P33og7jSbQg==
X-Google-Smtp-Source: ABdhPJziSvR6Z88BVDbaXtYHMd+tyWSWSQHX/2pyHAbolhUNZrs5lSzmOmRgttgdHOpkFCx9MK/3TQ==
X-Received: by 2002:a5d:6daa:: with SMTP id u10mr3308671wrs.641.1639760715155;
        Fri, 17 Dec 2021 09:05:15 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id i9sm5598112wrb.84.2021.12.17.09.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:05:14 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: regulator: tps51632: Convert to json-schema
Date:   Fri, 17 Dec 2021 18:05:04 +0100
Message-Id: <20211217170507.2843568-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217170507.2843568-1-thierry.reding@gmail.com>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Texas Instruments TPS51632 bindings from the free-form text
format to json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/regulator/ti,tps51632.yaml       | 53 +++++++++++++++++++
 .../bindings/regulator/tps51632-regulator.txt | 27 ----------
 2 files changed, 53 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps51632.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps51632-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps51632.yaml b/Documentation/devicetree/bindings/regulator/ti,tps51632.yaml
new file mode 100644
index 000000000000..ebe4d36dc750
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps51632.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/ti,tps51632.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TPS51632 voltage regulator
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    const: ti,tps51632
+
+  reg:
+    maxItems: 1
+
+  ti,enable-pwm-dvfs:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enable the DVFS voltage control through the PWM interface.
+
+  ti,dvfs-step-20mV:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: The 20 mV step voltage when PWM DVFS enabled. Missing this will set 10 mV step
+      voltage in PWM DVFS mode. In normal mode, the voltage step is 10 mV as per datasheet.
+
+allOf:
+  - $ref: regulator.yaml
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@43 {
+        compatible = "ti,tps51632";
+        reg =  <0x43>;
+        regulator-name = "tps51632-vout";
+        regulator-min-microvolt = <500000>;
+        regulator-max-microvolt = <1500000>;
+        regulator-boot-on;
+        ti,enable-pwm-dvfs;
+        ti,dvfs-step-20mV;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/tps51632-regulator.txt b/Documentation/devicetree/bindings/regulator/tps51632-regulator.txt
deleted file mode 100644
index 2f7e44a96414..000000000000
--- a/Documentation/devicetree/bindings/regulator/tps51632-regulator.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-TPS51632 Voltage regulators
-
-Required properties:
-- compatible: Must be "ti,tps51632"
-- reg: I2C slave address
-
-Optional properties:
-- ti,enable-pwm-dvfs: Enable the DVFS voltage control through the PWM interface.
-- ti,dvfs-step-20mV: The 20mV step voltage when PWM DVFS enabled. Missing this
-	will set 10mV step voltage in PWM DVFS mode. In normal mode, the voltage
-	step is 10mV as per datasheet.
-
-Any property defined as part of the core regulator binding, defined in
-regulator.txt, can also be used.
-
-Example:
-
-	tps51632 {
-		compatible = "ti,tps51632";
-		reg =  <0x43>;
-		regulator-name = "tps51632-vout";
-		regulator-min-microvolt = <500000>;
-		regulator-max-microvolt = <1500000>;
-		regulator-boot-on;
-		ti,enable-pwm-dvfs;
-		ti,dvfs-step-20mV;
-	};
-- 
2.34.1

