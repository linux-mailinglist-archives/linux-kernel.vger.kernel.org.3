Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9EE47CBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbhLVDsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbhLVDrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:17 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70066C06179B;
        Tue, 21 Dec 2021 19:47:15 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id q14so781759qtx.10;
        Tue, 21 Dec 2021 19:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARAnJI6Kh01POg+Ick5UifmHWpptElTSf8hWc/xW4rk=;
        b=qrKQYNM01OmYGNwiEumMzJI2RKwmWGl9S7s0/lQWjTKdH5UL5x6SLz/rp8eDMS8iA+
         tv/sVFL7nyglLeL4FGH1o0fgx8FHnhWW3tJzS3lwkOGrgApZf4VqY6/uMMmuPIVLIN9+
         wJfp59I0mwbH/4vxINubgHFyp6KQ/FpR30mVALeF4WNCgoEwb8LxKjzbW28/ljTiLFpz
         2FNaUQHvmPxXKC26hbjaxcQhcqgxT89A18LyI3yBJJPbQAKBY0e8cgdVdJvo+VRQ4nHz
         fdDq6/AhL7/J43MDAldfK1tZiDhUJ3FfJ7a+FUTtmEDhksMP3g5l1hRPbgwlsiAt60ig
         YGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARAnJI6Kh01POg+Ick5UifmHWpptElTSf8hWc/xW4rk=;
        b=14n+ya3AoB+K0TMU8XH0hhuKI7SyGgdGMeggeo5A+3MiQYc4c7WU3dHC7Q7qg1ZMJq
         9m7x3XaRDxIbUkp+UdIvAL/FNPzkOak/LGuhU1wSU4f8MRSdmiRJAxx8FHXQiiA7xPio
         Wn8oI0ulbwPhJFLx5UQYGQvrlmQyw+07qZ4LmpGyX0pO4F2vHTdVh52ppYzr6Wpn7xCb
         lfpSKp0Tobp2d1R36vC4wdV29G5Il4QHCcGOmPEpTZ0g/5EjTOgZyzuZGKdcTwbUwulJ
         Wg9gTrH5dYsW+BPsnEIW2hT0PTDBfRZEX2gC6axoCO/iLl3F32ulLU20xijOOyeq9SxS
         P1Ew==
X-Gm-Message-State: AOAM531Z+NvcSC5FUytpWaYZRu8aBpCSz/jvUsCzUhhlN4n3sib7QvS+
        pctI9wMS0T5ARtzjA95agAU=
X-Google-Smtp-Source: ABdhPJxFsmX3sr4HFJa9Sw7ZNXfOdpEMfIQ/Jauo/9P56Y+mJ7W2h4yGPbeARlaej/Ut/JVBNiGK5Q==
X-Received: by 2002:a05:622a:346:: with SMTP id r6mr928005qtw.78.1640144834592;
        Tue, 21 Dec 2021 19:47:14 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:47:14 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 15/15] dt-bindings: iio: afe: add bindings for temperature transducers
Date:   Tue, 21 Dec 2021 22:46:46 -0500
Message-Id: <20211222034646.222189-16-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

An ADC is often used to measure other quantities indirectly.
This binding describe one case, the measurement of a temperature
through a temperature transducer (either voltage or current).

Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 .../iio/afe/temperature-transducer.yaml       | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml

diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
new file mode 100644
index 000000000000..cfbf5350db27
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/afe/temperature-transducer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Temperature Transducer
+
+maintainers:
+  - Liam Beguin <liambeguin@gmail.com>
+
+description: |
+  A temperature transducer is a device that converts a thermal quantity
+  into any other physical quantity. This binding applies to temperature to
+  voltage (like the LTC2997), and temperature to current (like the AD590)
+  linear transducers.
+  In both cases these are assumed to be connected to a voltage ADC.
+
+  When an io-channel measures the output voltage of a temperature analog front
+  end such as a temperature transducer, the interesting measurement is almost
+  always the corresponding temperature, not the voltage output. This binding
+  describes such a circuit.
+
+  The general transfer function here is (using SI units)
+    V(T) = Rsense * Isense(T)
+    T = (Isense(T) / alpha) + offset
+    T = 1 / (Rsense * alpha) * (V + offset * Rsense * alpha)
+
+  When using a temperature to voltage transducer, Rsense is set to 1.
+
+  The following circuits show a temperature to current and a temperature to
+  voltage transducer that can be used with this binding.
+
+           VCC
+          -----
+            |
+        +---+---+
+        | AD590 |                               VCC
+        +---+---+                              -----
+            |                                    |
+            V proportional to T             +----+----+
+            |                          D+ --+         |
+            +---- Vout                      | LTC2997 +--- Vout
+            |                          D- --+         |
+        +---+----+                          +---------+
+        | Rsense |                               |
+        +---+----+                             -----
+            |                                   GND
+          -----
+           GND
+
+properties:
+  compatible:
+    const: temperature-transducer
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of a voltage io-channel.
+
+  '#io-channel-cells':
+    const: 0
+
+  sense-offset-millicelsius:
+    description: |
+      Temperature offset.
+      This offset is commonly used to convert from Kelvins to degrees Celsius.
+      In that case, sense-offset-millicelsius would be set to <(-273150)>.
+    default: 0
+
+  sense-resistor-ohms:
+    description: |
+      The sense resistor.
+      By default sense-resistor-ohms cancels out the resistor making the
+      circuit behave like a temperature transducer.
+    default: 1
+
+  alpha-ppm-per-celsius:
+    description: |
+      Sometimes referred to as output gain, slope, or temperature coefficient.
+
+      alpha is expressed in parts per million which can be micro-amps per
+      degrees Celsius or micro-volts per degrees Celsius. The is the main
+      characteristic of a temperature transducer and should be stated in the
+      datasheet.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - io-channels
+  - alpha-ppm-per-celsius
+
+examples:
+  - |
+    ad950: temperature-sensor-0 {
+        compatible = "temperature-transducer";
+        #io-channel-cells = <0>;
+        io-channels = <&temp_adc 3>;
+
+        sense-offset-millicelsius = <(-273150)>; /* Kelvin to degrees Celsius */
+        sense-resistor-ohms = <8060>;
+        alpha-ppm-per-celsius = <1>; /* 1 uA/K */
+    };
+  - |
+    znq_tmp: temperature-sensor-1 {
+        compatible = "temperature-transducer";
+        #io-channel-cells = <0>;
+        io-channels = <&temp_adc 2>;
+
+        sense-offset-millicelsius = <(-273150)>; /* Kelvin to degrees Celsius */
+        alpha-ppm-per-celsius = <4000>; /* 4 mV/K */
+    };
+...
-- 
2.34.0

