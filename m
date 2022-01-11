Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762CE48AB76
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349206AbiAKKeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348876AbiAKKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:34:00 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD323C061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:33:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q8so31963816wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqNBsRcjQjHmu9oXUqgctJ3evIfScLc2vJGzdrITO90=;
        b=Xu8gUB/wyAxcPFd6dw8gkm2TKTIJlGJBTor9EjQDZnIuguIPM2TaeFArBB2r+gxca+
         zMCKxJZvUTn4+YK8p0ixF2gEoy/sIAzBD2lO1jVfjjbw8/xJfrsqgYnRQirrKS9Yeyic
         QOwMGKCdlPW5mxRoDCvn6uJ5ksFdSZk9Mz/qfDDWJRRVGv89RVQgG6HNS2GZT8gs6kzg
         T0VgYZSWSudlsymwnqAl46t6EsWlHsXE34MXoMobGFQwXvkA6tqNsRqPPGwgjW+BAK92
         1Xu3QHBYfhSCmk1DxWNU5WhbJZwu+IXwvZTkt/Q1vfvJRc5KZ9dTrg3f3YfpLJOg+8vl
         Gegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqNBsRcjQjHmu9oXUqgctJ3evIfScLc2vJGzdrITO90=;
        b=0L/FPtsHE7NeOpspgK4bAPDDgqrRLxoZ739HrPLH6oXPiFC4JRwyVXacARIoeeIUgd
         yyS06Jx4ZfOvStEz11JWC70QLPToCG1Su+4NOQDSWWvWY2q28AkIDQYh3Vgjpzhj7jbS
         T+fOUb2L4P3OdJLgkfUyMpt1Zx4pTSisWW3lFzT3MXMq8uaNB1OsykQ0B3gBGc01zMqQ
         QQw1kCgmAbVZ9KgiohzSdF2n75G97eEUQdi7wBbqaReX0ZanKH9boVPbTkzJK2Aj/+ZC
         UOHLyXif1Qn12k/SLRy4wNmCyqpCYH+Bst5oJWeTf/32zSN4IKkRqTJys8gmb1VfBX8f
         fKNQ==
X-Gm-Message-State: AOAM530jXTjwHx36ysAD8/WblEmFWFtRUqMXYLBW9iKNtO5veQjgWBZl
        3WQD0aaObBrDiaDyIKqo7wX81Q==
X-Google-Smtp-Source: ABdhPJzUrxsR8cHYm600a8hZckJc96n5dY9Z+dWP6MFmc9bq6QlUWlmZs8hKVhm7nGrhrAImvvIVwQ==
X-Received: by 2002:adf:da45:: with SMTP id r5mr3364866wrl.695.1641897238277;
        Tue, 11 Jan 2022 02:33:58 -0800 (PST)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u16sm8803470wrn.24.2022.01.11.02.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 02:33:57 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 RESEND 1/2] dt-bindings: Add DT bindings for the DT-based virtual sensor driver
Date:   Tue, 11 Jan 2022 11:33:45 +0100
Message-Id: <20220111103346.2660639-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111103346.2660639-1-abailon@baylibre.com>
References: <20220111103346.2660639-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT bindings for the DT-based virtual sensor driver.
This driver provides a way, using DT, to aggregate the temperature
of multiple thermal zones and get some useful data from it.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../thermal/virtual,thermal-sensor.yaml       | 86 +++++++++++++++++++
 include/dt-bindings/thermal/virtual-sensor.h  | 15 ++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
 create mode 100644 include/dt-bindings/thermal/virtual-sensor.h

diff --git a/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
new file mode 100644
index 000000000000..b404fd4b2b38
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2021 BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/virtual,thermal-sensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual thermal sensor binding
+
+maintainers:
+  - Alexandre Bailon <abailon@baylibre.com>
+
+description: |
+  The virtual thermal sensor device provides a way to aggregate the temperature
+  from multiple thermal zones. Basically, this could be used to get the
+  maximum, minimum or average temperature.
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: virtual,thermal-sensor
+
+  aggregation-function:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Used to select the operations to perform on the sensors to get the virtual
+      sensor temperature.
+    enum:
+      - VIRTUAL_THERMAL_SENSOR_MIN_VAL
+      - VIRTUAL_THERMAL_SENSOR_MAX_VAL
+      - VIRTUAL_THERMAL_SENSOR_AVG_VAL
+
+  thermal-sensors:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      The names of the thermal zone to aggregate.
+
+required:
+  - aggregation-function
+  - thermal-sensors
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/thermal/thermal.h>
+    #include <dt-bindings/thermal/virtual-sensor.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8192-clk.h>
+
+    lvts: lvts@1100b000 {
+        compatible = "mediatek,mt6873-lvts";
+        reg = <0x1100b000 0x1000>;
+        clocks = <&infracfg CLK_INFRA_THERM>;
+        clock-names = "lvts_clk";
+        #thermal-sensor-cells = <1>;
+        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+    cpu_max_sensor: cpu_max_sensor {
+      compatible = "virtual,thermal-sensor";
+      #thermal-sensor-cells = <1>;
+      aggregation-function = <VIRTUAL_THERMAL_SENSOR_MAX_VAL>;
+      thermal-sensors = "cpu1", "cpu2";
+    };
+
+    thermal_zones: thermal-zones {
+      cpu1 {
+        polling-delay = <0>; /* milliseconds */
+        polling-delay-passive = <0>; /* milliseconds */
+        thermal-sensors = <&lvts 0>;
+      };
+      cpu2 {
+        polling-delay = <0>; /* milliseconds */
+        polling-delay-passive = <0>; /* milliseconds */
+        thermal-sensors = <&lvts 1>;
+      };
+      cpu_max {
+        polling-delay = <0>; /* milliseconds */
+        polling-delay-passive = <0>; /* milliseconds */
+        thermal-sensors = <&cpu_max_sensor 0>;
+      };
+    };
+...
diff --git a/include/dt-bindings/thermal/virtual-sensor.h b/include/dt-bindings/thermal/virtual-sensor.h
new file mode 100644
index 000000000000..6254b2aa8f5c
--- /dev/null
+++ b/include/dt-bindings/thermal/virtual-sensor.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides constants for virtual thermal sensor bindings.
+ *
+ * Copyright (C) 2021 BayLibre
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H
+#define _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H
+
+#define VIRTUAL_THERMAL_SENSOR_MIN_VAL 0
+#define VIRTUAL_THERMAL_SENSOR_MAX_VAL 1
+#define VIRTUAL_THERMAL_SENSOR_AVG_VAL 2
+
+#endif /* _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H */
-- 
2.25.1

