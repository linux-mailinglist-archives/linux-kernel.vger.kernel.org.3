Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1CE4A3780
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355675AbiA3QLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355531AbiA3QLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:11:32 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CC4C061714;
        Sun, 30 Jan 2022 08:11:31 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id w8so9918518qkw.8;
        Sun, 30 Jan 2022 08:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJ4snz0cur4JK5tD6GVF0n87Yz4vTpK9iTHizeDj3iE=;
        b=mChZBL5LlB+4JdK10nZJbQcYFPE+LR1IkAzqnWQFc8ZZWQGbSifXcb32wnGlU/lXL2
         DIEIGSZGV8O8rVlKnrGCye5s2G76M+VlujRl2rZ5VVJa3yKNvJBjY4QPuUmB5n9AVvrf
         fNXVBLcMMAxw4LRtA3203qrw191YWbUK7mSuZl6505xPkOq9i5BFr9RSm14Y7gtRNRYx
         0nUm4VDBs8A0HywwoyLPAt+55CeqkP0rz//ihqRC8VyGAQD2o4u9dnvpVxQ9Eun71DwP
         Cv80UxFyJl9uubBa4Y6Rj6nXKSbw6zvrxe8Jo+JUInkDMwP4iVOwUkcqK2ySw0D/neQF
         493g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJ4snz0cur4JK5tD6GVF0n87Yz4vTpK9iTHizeDj3iE=;
        b=Xjrft+UaFRruK+imgM5OXfK3ZPKdNtqBy7PG3FkFiILeGmiUwfHDAWUNKlLYj83tr9
         BIQ8a/E0+gyW2tAyKddXx/RnSWycneK4QhTRLYAHLrXObvQ5Y2I4d9H8T83PI4qj2lQR
         lA/REUn1v0zod8P5+3AupbmdYJDKWkBGLiRkjWN4RaBqKR+4R5Zcsvdbf1F/jUU9mYKC
         1MYwSW69gU8Y9e3TdS9t1NdebKcxPl+NCYNh51Ky4A0jiQ3Z6KRr+jMqQoe6p5iXFFVp
         hkGtIKSRvI8iEg6voX+LyYlXtrWgfthKvopn6Va2P/BtzceZ5Y5fCocYnNm1U6rJJejE
         SkUA==
X-Gm-Message-State: AOAM531odINqA08qtt98NfjKHSqcQkOn12CHPa1PLrpk2lf7n8onI1u3
        L4ivWJHQIqkzy0ILWjOLCR0=
X-Google-Smtp-Source: ABdhPJx9mtz97uIq2SZ2TTh2RWklutX/fwvPNBBMsalB5wrUOdIw0Mdcf7hCAIcQHu6plbKMH8kc7g==
X-Received: by 2002:ae9:e50d:: with SMTP id w13mr10743862qkf.638.1643559090930;
        Sun, 30 Jan 2022 08:11:30 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v73sm6906148qkb.51.2022.01.30.08.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:11:30 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v13 10/11] dt-bindings: iio: afe: add bindings for temperature-sense-rtd
Date:   Sun, 30 Jan 2022 11:11:00 -0500
Message-Id: <20220130161101.1067691-11-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220130161101.1067691-1-liambeguin@gmail.com>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An ADC is often used to measure other quantities indirectly. This
binding describe one case, the measurement of a temperature through the
voltage across an RTD resistor such as a PT1000.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
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
2.35.1.4.g5d01301f2b86

