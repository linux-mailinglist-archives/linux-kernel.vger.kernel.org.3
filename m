Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A170C47CBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbhLVDrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbhLVDrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:16 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01532C061761;
        Tue, 21 Dec 2021 19:47:14 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a9so1157425qvd.12;
        Tue, 21 Dec 2021 19:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lYGAnRZm8/Ly28B67BQjOPX/ihzee1D2awrbW2Murk=;
        b=QlxjUXwazuTNo6ZNdVKrHMgBO4xSYrzTp7yIREWdBGNfHZOAolWlvXNHsqM+L4Qkzl
         pXhpwO8VEZc6bO+jmbaiQLGS0GXWQSIMUim3bxZ7JeuXR1m0m6QvIIpxRIWakczmMjqR
         3GoxqXfPyUGWR+X97X3TZp7mzO0xjm0yPVTAL5Hw5EnFwhzXwPp3rZY1b4WU8yzZ4q6b
         2/KwtYCuNkZaH8NyABOhK1yUGfcSDhLAXvMpeA648iIhlDWFbHb1E+2oIo1W0VkddvQ+
         e5VmQHl9QRaaBa4KtmX1J6e8FiJcwaj9r+MbXRxChVvIFoD+ilr5+gaCsgkWnAEWUfGh
         i3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lYGAnRZm8/Ly28B67BQjOPX/ihzee1D2awrbW2Murk=;
        b=efePV716CErjnr9N+/K43Y10fjtzHz+Bq33DtYX/LHjxu3jGpzElOfsGs6UC+dCob6
         WY++zLuXOkiaDOi/J4UITluWqd8Wqkx6DMUzWL+SOH/GEK04enWHpTcQ9ArvZOO6qygN
         ooYWiYA55pQKGOW9zkPT7/EGILN1UUb/LHPVu25PRJjPVv/D5kP0UYYKPCUB2duLovre
         rOuUoquyX5plvmMAHJ8mG3Gr/ly7hBPuxVcbbUfmGclZMRdlooYbgjFeDrLBf8iuxwdu
         Hbmtw9Ls35XrIBVBIgxXNcFWUsBToXXMj6Y2wSa8SDbMNkbL4kEhv96BruAGsuSYCjag
         E3eQ==
X-Gm-Message-State: AOAM532p/CuiF9Y8QamHtrD3ITxYtSGw93Lo1txjVLF1ndYmZfoNGwop
        MKymyA1u0Tb2GRfC8URN9onF6W9SdhDBUA==
X-Google-Smtp-Source: ABdhPJxB+sKGCjZ1ai+MRBQ4t89RhGW6HFFSstobvaxQbHJX1pRqg/VNmYqavbF7vCHmxUt8ij7LVA==
X-Received: by 2002:ad4:4ee6:: with SMTP id dv6mr1125044qvb.50.1640144833157;
        Tue, 21 Dec 2021 19:47:13 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:47:12 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 14/15] dt-bindings: iio: afe: add bindings for temperature-sense-rtd
Date:   Tue, 21 Dec 2021 22:46:45 -0500
Message-Id: <20211222034646.222189-15-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An ADC is often used to measure other quantities indirectly. This
binding describe one case, the measurement of a temperature through the
voltage across an RTD resistor such as a PT1000.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 .../iio/afe/temperature-sense-rtd.yaml        | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
new file mode 100644
index 000000000000..336ce96371db
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/afe/temperature-sense-rtd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Temperature Sense RTD
+
+maintainers:
+  - Liam Beguin <liambeguin@gmail.com>
+
+description: |
+  RTDs (Resistance Temperature Detectors) are a kind of temperature sensors
+  used to get a linear voltage to temperature reading within a give range
+  (usually 0 to 100 degrees Celsius).
+
+  When an io-channel measures the output voltage across an RTD such as a
+  PT1000, the interesting measurement is almost always the corresponding
+  temperature, not the voltage output. This binding describes such a circuit.
+
+  The general transfer function here is (using SI units)
+
+    V = R(T) * iexc
+    R(T) = r0 * (1 + alpha * T)
+    T = 1 / (alpha * r0 * iexc) * (V - r0 * iexc)
+
+  The following circuit matches what's in the examples section.
+
+           5V0
+          -----
+            |
+        +---+----+
+        |  R 5k  |
+        +---+----+
+            |
+            V 1mA
+            |
+            +---- Vout
+            |
+        +---+----+
+        | PT1000 |
+        +---+----+
+            |
+          -----
+           GND
+
+properties:
+  compatible:
+    const: temperature-sense-rtd
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of a voltage io-channel.
+
+  '#io-channel-cells':
+    const: 0
+
+  excitation-current-microamp:
+    description: The current fed through the RTD sensor.
+
+  alpha-ppm-per-celsius:
+    description: |
+      alpha can also be expressed in micro-ohms per ohm Celsius. It's a linear
+      approximation of the resistance versus temperature relationship
+      between 0 and 100 degrees Celsius.
+
+      alpha = (R_100 - R_0) / (100 * R_0)
+
+      Where, R_100 is the resistance of the sensor at 100 degrees Celsius, and
+      R_0 (or r-naught-ohms) is the resistance of the sensor at 0 degrees
+      Celsius.
+
+      Pure platinum has an alpha of 3925. Industry standards such as IEC60751
+      and ASTM E-1137 specify an alpha of 3850.
+
+  r-naught-ohms:
+    description: |
+      Resistance of the sensor at 0 degrees Celsius.
+      Common values are 100 for PT100, 500 for PT500, and 1000 for PT1000
+
+additionalProperties: false
+required:
+  - compatible
+  - io-channels
+  - excitation-current-microamp
+  - alpha-ppm-per-celsius
+  - r-naught-ohms
+
+examples:
+  - |
+    pt1000_1: temperature-sensor0 {
+        compatible = "temperature-sense-rtd";
+        #io-channel-cells = <0>;
+        io-channels = <&temp_adc1 0>;
+
+        excitation-current-microamp = <1000>; /* i = U/R = 5 / 5000 */
+        alpha-ppm-per-celsius = <3908>;
+        r-naught-ohms = <1000>;
+    };
+...
-- 
2.34.0

