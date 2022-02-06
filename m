Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C854AB247
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbiBFVN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbiBFVNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:13:30 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A3C06173B;
        Sun,  6 Feb 2022 13:13:29 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cz16so7553632edb.8;
        Sun, 06 Feb 2022 13:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F1jiObY9AX7zYZGsvn4/79pWPB3gpHKb3YMbVYWWLxk=;
        b=SfU1Zbk5rIiC4ntznX9BfRKfccnau24SZ1mlpN1msNP/HLIT6unYfvkcV7x51YtoMX
         bj2vvZNwE4jp230llHV5V4sM/rgo5KknumU2AGyVmewohthcv1KBDn93nTyr4Xxo3/gz
         tv6QqfFl1082T/ST3hCjJMLK6FL7K/IimtGkiMRUwsMT1/fZTmved9n/6ektkRCEBbdB
         e5xKmBmmb4Rb/6QiL4qxagAECtJMJlHGFUPr+ZvZ+FyCHIcZMI8/mHf6Eep+wWs2RXaD
         dTOYLHcKacrNjuScb1N6wN6uNWTl0EBzFtYXS1KMoDaql6h1fmghITzEkz7ceebIu8SN
         SUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1jiObY9AX7zYZGsvn4/79pWPB3gpHKb3YMbVYWWLxk=;
        b=4S0nSmNI9El4NIx3KaVz4BxBvPIzugmLzpOYE4yqDpX9xyiq/CjqQUwd6Iznt+4LQK
         kb0isEsoGQheRC39JZYNq7ME0p0PAt/QPEMcAZUrSHosMtdg0Rssl+WErIEjXKdvahkK
         +LhKh+JL4dU4tuCGDNsHtlWq73aGgWHzEaCv21pxdAXY1lg6KylL4S3sdbVb4iZwHOF1
         3U5H1PcrzNg9WKPs266cfVDNTX07dv286WcC2p4w2RXkaawsMQFbm6XTFgBd9vDhLFmZ
         3mA/ghy1CapoTtCiYLxTBPWfGnH7eMywcLzitU2MYb7r7JgBxLJyOuG5F7kSndahc5Wa
         M5Dw==
X-Gm-Message-State: AOAM533LYW40ZNTg00rA8uMmRJKx3BqfAPh4zwZR7MhGJXvn5euMlW8D
        FigZJEgB1kZWezVJuCtkyVA=
X-Google-Smtp-Source: ABdhPJzyXl+vsHy59BL+U2RffUhWd7LuAPilJ6sShOlZEgAQ2YPDH6rpBVySRvliNXoJr8Sy7fP3aA==
X-Received: by 2002:a05:6402:d0d:: with SMTP id eb13mr10514246edb.83.1644182007720;
        Sun, 06 Feb 2022 13:13:27 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id a4sm1248598edr.33.2022.02.06.13.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:13:27 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 4/5] dt-bindings: iio: accel: add ADXL367
Date:   Sun,  6 Feb 2022 23:13:06 +0200
Message-Id: <20220206211307.1564647-5-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220206211307.1564647-1-cosmin.tanislav@analog.com>
References: <20220206211307.1564647-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.

The ADXL367 does not alias input signals to achieve ultralow power
consumption, it samples the full bandwidth of the sensor at all
data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
with a resolution of 0.25mg/LSB on the +-2 g range.

In addition to its ultralow power consumption, the ADXL367
has many features to enable true system level power reduction.
It includes a deep multimode output FIFO, a built-in micropower
temperature sensor, and an internal ADC for synchronous conversion
of an additional analog input.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/accel/adi,adxl367.yaml       | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
new file mode 100644
index 000000000000..d259e796c1d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adxl367.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXL367 3-Axis Digital Accelerometer
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
+
+  The ADXL367 does not alias input signals by to achieve ultralow power
+  consumption, it samples the full bandwidth of the sensor at all
+  data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
+  with a resolution of 0.25mg/LSB on the +-2 g range.
+
+  In addition to its ultralow power consumption, the ADXL367
+  has many features to enable true system level power reduction.
+  It includes a deep multimode output FIFO, a built-in micropower
+  temperature sensor, and an internal ADC for synchronous conversion
+  of an additional analog input.
+    https://www.analog.com/en/products/adxl367.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adxl367
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vdd-supply: true
+  vddio-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      accelerometer@53 {
+        compatible = "adi,adxl367";
+        reg = <0x53>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      accelerometer@0 {
+        compatible = "adi,adxl367";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
-- 
2.35.0

