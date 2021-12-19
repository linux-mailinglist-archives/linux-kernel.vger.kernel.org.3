Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30EC47A2DF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhLSWkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbhLSWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:15 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDEAC06173F;
        Sun, 19 Dec 2021 14:40:15 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id kc16so7820621qvb.3;
        Sun, 19 Dec 2021 14:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2qe70Unlntn4QgtFhfss5TgMBkLN99m0wOrqhV7w1NQ=;
        b=Jba5AZdWIVeUJc8KDXFcQkYsSxehZ7+bl+T66ReLMWlPymThZKZ2t/VTcpaU/yn7VS
         ex5Us3bQI23fUuBPXGwsp/c1shXoyat75kN/XoV4ZEN2+HXapGzqo9KQCp+tM+wh59d2
         yAPQLhnyUEamLYlZ7gePTnhcT77OtaXOH8EeDUT5BSxcL5qjhNgdnoRb2ULmOaBc/ubY
         ebKGs3UtO7NQITOdxFvS8B8lyJ5cmBDSgtl6CEH3/aytJX+gPDNKWPUapBA+bRLM1pq1
         983FNXCt4Peak3s8DV7dn+ddQaXce1yFHcx/fCOZVlt3udw6+a4fI1g1KEvEzERnmoG7
         iv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2qe70Unlntn4QgtFhfss5TgMBkLN99m0wOrqhV7w1NQ=;
        b=3NZ2m5J1Cr78iYAU6XwpYXel4hatpA4WLKLsDYAVwhnSb6Hx+0nv95HARiABafosGX
         KHYMjmbHsYmU7rp3nXZH6GKnMSTYjkRb2O9mxm4+jtl+sRXvtwO8H3t5m0iGp4pWusKz
         o8nbHU6MeIwi+5xzuhBAPR/m4kUOJdat+d6aBUd2dj7dSnBxhlt7N6fOGe1l/2gNprFQ
         zkVhE2Hsld8i3Dn369Gww+a686oyyZlUE5NckTV2ulPcWKP/jUAvWS4V/2P0SnDZuHtu
         MD5MsjzviOY5BFohStAX5LG8YZ75WSXdm9u01pNezua/RLaYFwsHhXvpJwbEh9M2YYz6
         paNg==
X-Gm-Message-State: AOAM530cw6mO70Ez9qdHKvtQJJJgj5zIbCZfN6dGyss1O5cSvHfENYA1
        Cjx09U4GfhFtjXIn1bBDpW8=
X-Google-Smtp-Source: ABdhPJzOJ68az9Fq8UaYANaGVQC6fRmgBJQo7THMeCyEMN1HlgOvD0UtS4jK8S6GdIddf2IRFa3NGw==
X-Received: by 2002:a05:6214:ca1:: with SMTP id s1mr9171346qvs.57.1639953614677;
        Sun, 19 Dec 2021 14:40:14 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:14 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 13/14] dt-bindings: iio: afe: add bindings for temperature-sense-rtd
Date:   Sun, 19 Dec 2021 17:39:52 -0500
Message-Id: <20211219223953.16074-14-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
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

