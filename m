Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC03488630
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiAHUyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiAHUx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:57 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F1FC06175D;
        Sat,  8 Jan 2022 12:53:51 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id o10so9475378qvc.5;
        Sat, 08 Jan 2022 12:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EoVz/z4Kv5flD6bBPkUi3ywu6/Ph5Pi55G9NAdUbUhI=;
        b=JB/GGwTvKXgIXawkydGQfQNe8QeBW4/7mg95LnrEOmNGY1FLmz2zvuWdELEyvGnmtO
         CWFv0w+dJi8RPeQbJ58aOxGuXx21EywvqD1i31qikp182z3Hj7LeKAWttii+y7VsVjjY
         UwVDIg0NWkDBj4M/hxNZBMgfp50V5/oUZmj+f9f7tRspkkdqcgeP4AwjBAAzYupcIKOw
         RYfX9FqZiWjaqcPxKYsCXXci4uQtqtjBCgZoPB31NIJLhm4KHtzTt/+fpMsypKv3pFJ0
         MnLapqlSUJ4cnyYdG+zu66pgDggKqqvmTThrh4DTTTdlrlnw/znbtPxzz5ssvO63tyj0
         rudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoVz/z4Kv5flD6bBPkUi3ywu6/Ph5Pi55G9NAdUbUhI=;
        b=CuVJuZD2GpbBXJETNEuu2qupKqAga3RXMLIAP75TDK2gyfKMWFVni0sq5eQlJ2DLF9
         knrnkmt+s2QPr+z6yD0Ich/fyzs0MbvL8/VhAUvuhwZrZQSKmMRVBO9x42nmqrQ3dgy3
         SofCKQZTGbEtCD61hjosV9AHfa3jW22fd5VFTMhLPflKRsp7iu3b1be8RjtaquVhwb9r
         bY9X9pD5cLFaLlPgrL2CqYWoMutSN0Rm+fzTe13SvyoQ9mWOHg7IVDwEBWPlxlT/qces
         1crRYOnOJlT/dJJfwwj6nv6V06bUmx30u9FfbXVL0xc5bT7WqNr6rBIpv3W1CxIQqQPW
         DX2g==
X-Gm-Message-State: AOAM530cX5jCiTQuVDkpvreOxKJMpmSHCZmFD+UjiLYmnFqhexy5DBk/
        XQK71b5T57XHz4YfdpnsWm8=
X-Google-Smtp-Source: ABdhPJzLPlQ8CBQvgk9O6QmzPTsggxfUU7F1JEjXhTmn6djftHEiMjlGAPFdZTb5AaOl0W/4bM2+aQ==
X-Received: by 2002:a05:6214:27cc:: with SMTP id ge12mr62552008qvb.122.1641675230675;
        Sat, 08 Jan 2022 12:53:50 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:50 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 15/16] dt-bindings: iio: afe: add bindings for temperature-sense-rtd
Date:   Sat,  8 Jan 2022 15:53:18 -0500
Message-Id: <20220108205319.2046348-16-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
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
2.34.0

