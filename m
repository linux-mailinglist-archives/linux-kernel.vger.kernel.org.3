Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A546B7C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhLGJr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbhLGJrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:47:25 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E091DC061574;
        Tue,  7 Dec 2021 01:43:54 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r25so54360862edq.7;
        Tue, 07 Dec 2021 01:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxDz7vsrStncdq89lNQiqUAc879AZdoccX4mI16/HNE=;
        b=Bu++2xo2fa48EvUi7Ic/bzmUJCfD984BsTD4NN+tRibhtIcb8ra/wytDSrxCDK/Lpu
         V2sexf1BbwsddiltgbEPePh//UjSnEJcyaIsKUbuRh9l56Ywwl6dq4yxk1m+XeN0C82e
         7GqsrdSTPB8SbmVJYKZW4sdrfYHjNyscYNVDe/c3kCm2rySs82QgnuPjEyUQTqVBkb2N
         jiPkSxxOiEbi0KNRSgExtR+teJ045HryZ541Sz0LcZGy3lRdja+NXANViTCD8l7GCW8J
         XZdasFYqeDq78VnQWPh+iXjYWYQ0C7LP0r7+MD63zTzrzA3pUrrVi+/zszne/eqnZvs5
         q4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxDz7vsrStncdq89lNQiqUAc879AZdoccX4mI16/HNE=;
        b=rlsQ2ZVqWFQGEzeMC25eyUpTFRpZAwyKaxD0hurW6nZ+6b7WD99low4VyX8IHckRLM
         ON1A9wxYuqUi7ic8uCxCoK4ZyNRhV7pGwx3dfLWAzeNJNRW/n86nUae9WK0udUM1tDLv
         M6v5gZAMOyBSUqVNynWm7odPRCS8m02VFitXEVtRBY2VE6Fq5L8kE/QQcmrJHk8XLIWO
         locCeYFkzgSd8cPchzmp1xCMRTk+b6J6gdpIIe0xHFyWCp2LHcpSTsTfU0T9S+JWsp/A
         SScEGDMpnKccghyIhqLVj4pyUQL31CpIOkWGpYlclHPK5uT5G9kQ7zgCruiBKStqZJG7
         mTkg==
X-Gm-Message-State: AOAM532PYm/O4TKwzv9lU8WIEHfSLIgNcxv+EtvgDJ6Rs+XBo46Ihr26
        B+9BUNTgFf0IVKG3+W335XI=
X-Google-Smtp-Source: ABdhPJzLmSWycBi1oEioduTzlAGeIvv51k6+K46Si7e/3a2Pad18urPRQqaaizUdkZWcDh+izUPmgA==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr52518242ejc.404.1638870233502;
        Tue, 07 Dec 2021 01:43:53 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id h7sm11336159ede.40.2021.12.07.01.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:43:52 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: accel: add ADXL367
Date:   Tue,  7 Dec 2021 11:43:36 +0200
Message-Id: <20211207094337.59300-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207094337.59300-1-cosmin.tanislav@analog.com>
References: <20211207094337.59300-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 .../bindings/iio/accel/adi,adxl367.yaml       | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
new file mode 100644
index 000000000000..b3c140dfbe2f
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
+      adxl367@53 {
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
+      adxl367@0 {
+        compatible = "adi,adxl367";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
-- 
2.34.1

