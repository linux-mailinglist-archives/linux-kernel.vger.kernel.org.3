Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546894B3920
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 03:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiBMC6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 21:58:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiBMC6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:58:03 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4660A96;
        Sat, 12 Feb 2022 18:57:56 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 200so11649228qki.2;
        Sat, 12 Feb 2022 18:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4lFaVXaOEQ0S/iYKidAfI8kJNzQK67M6VoIAHTd3OhI=;
        b=OQlcvwD0OmoTfRHRCWxDs/O9XI8QsUuXGUFQNBjHvP6njMBLGHK+QIbxJiNzNvnHLw
         kIi9VrQy2fasZt+Jnux35DYgvbTCaHXYFp9oZkZmcntm/EQrexRP8MGzpTb0m9KAJKzL
         PZGdhrvdUcWKzpT5wg9hUBExB/mIFOYxJ4/y2raImLFyQgTfAICniboS86DftsIKI0TF
         3L8BHNC024IjxQ/Jzgf1jh7L5w1WgUuNfJy7gLUEuMhIzjt9to+ISolrxMYJY8yqHdhW
         WLRpsQDkXI7irXyHarsKUc/8bW1WApLPfAJ9BR99/01baYc9O/c82W0/6s+Xm1XtEgs7
         5Xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4lFaVXaOEQ0S/iYKidAfI8kJNzQK67M6VoIAHTd3OhI=;
        b=tdLlDsyvcQvMI7lJMyNsOYjd76qv2dogMOh6kGk85Zn+z20bNOnHDXWjuwODS+GUIR
         71ZsDBo5VsxAk75j13nglQw+9Wxr8/KemxnjHb2D98M1TqBwUihczqdSW7ucj2K31yZO
         vGT3IPyy37L2Ki8iEUoJrU5+Gsp4Am9ELfNSVoRnJSpXAzH/cRNgzm3bORju2vHvS37+
         q8+v5Kdopw+MX8HbJPgBI/zqpw6e2tkZZgPQb7iQBt0Dc9PyQsVHhrS+ax3cyGu7RIlL
         7RnEzJCOBbxUT7m5xVEatjKTRZzcT+uPtKY4EN/Vd3EZm9l6n/cYY/P4/luOE7ues+7B
         OKYg==
X-Gm-Message-State: AOAM533kRIBdZq1U3gXMwneiUiyGOqO3CtMtqApP1XovjZTDzqeVTsw+
        wWgSwhc9HTjQgIfVf6gywh4=
X-Google-Smtp-Source: ABdhPJz6DrPO0/WwNjNvsviRwGT8Tc3/96W6GlwjSkSho5oMcgYnjI3eP/nd03VGHUwosc80Q4s0sQ==
X-Received: by 2002:a05:620a:458e:: with SMTP id bp14mr4074746qkb.210.1644721075197;
        Sat, 12 Feb 2022 18:57:55 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id y15sm14551106qkp.22.2022.02.12.18.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 18:57:54 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v15 10/10] dt-bindings: iio: afe: add bindings for temperature transducers
Date:   Sat, 12 Feb 2022 21:57:39 -0500
Message-Id: <20220213025739.2561834-11-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220213025739.2561834-1-liambeguin@gmail.com>
References: <20220213025739.2561834-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An ADC is often used to measure other quantities indirectly.
This binding describe one case, the measurement of a temperature
through a temperature transducer (either voltage or current).

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
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
2.35.1.4.g5d01301f2b86

