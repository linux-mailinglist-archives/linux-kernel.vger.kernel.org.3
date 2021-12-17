Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E70E478A54
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhLQLpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhLQLpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:45:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C2BC061574;
        Fri, 17 Dec 2021 03:45:52 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j21so2338241edt.9;
        Fri, 17 Dec 2021 03:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KK+Z9sWZd6JJuqWCEUBGA51PGCYnr1aU/EASZF9oqK4=;
        b=BuUoULfj1W91itpDwNiCgDd+HA/qRXGxapCNA+TH4y1xQOQXKkpPM0efqh/TjQ28C1
         FVrG/jMeSL018NI2Rk3fPFXZyFyJ9zVXRpiUh9X+EQ42Kp9LIrwliqSW0iz+gT8OHcV8
         va6mctvhvXwlvtRXNWCP31A7vDMlZ1ShFmaGYd6E4c7QMhVoILL4xQmqJULPJf5Sf95K
         IVgynHxdnriBjaMpo1IX4iVPJk6irzlD+PgW4LsO+VQUL0H57m3Y6d37nCATyE9t0/54
         4BSrpfaq+PARlwalNfDu1KC63iDMHoDKO0ENvRTNZrjTyq1jdhUVOLt2863gr+BRzanA
         1QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KK+Z9sWZd6JJuqWCEUBGA51PGCYnr1aU/EASZF9oqK4=;
        b=OpUACUlCvE2OE2GNEZTx/UfTwUaDqsNZ+mFrpC2r7AqKuFXjB3hLrH01qW1Toa7J6M
         5ufAWRg2Ax7CaDzqfd3xD+sBwbQRn8/nqZJtAJ44Ar1rrJ0SV4ul4fkLaVsezb2SkoXH
         MCZIFUcMsHPikZR8cAc4M0rW05q2nb+LH+6qkvT0Z6xZl5gQFUqOuhqEO4qQFdsMSSTF
         ByPHLReD8cQBxQy6VH0QUaIfUtNuuxPxDk+W9CynFZ2dLTJ/8cvAvHajGn83ihwpKWbu
         KfCrotmCnevdMSN85pA3Fkrblvb0VJqC75KlD4MyZcyq48CSacRaplzFPXLJrnI3nKrw
         mmuA==
X-Gm-Message-State: AOAM533DecfnIWJTVdm/J5DGer3lA26gn1/KFl5ZNRntsicCc7yx9ekw
        HbeSVL9sJAYOmZUSXNyHn3k=
X-Google-Smtp-Source: ABdhPJzR03EFXza4JHFeylDQbWWmmTPfcX1trTcD4FFGmB6mJltrHRHpL7OKPhICjoZ+mLYO5ylTIg==
X-Received: by 2002:a17:906:6a18:: with SMTP id qw24mr2223249ejc.118.1639741550949;
        Fri, 17 Dec 2021 03:45:50 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id 12sm2748410eja.187.2021.12.17.03.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 03:45:50 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: accel: add ADXL367
Date:   Fri, 17 Dec 2021 13:45:47 +0200
Message-Id: <20211217114548.1659721-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217114548.1659721-1-cosmin.tanislav@analog.com>
References: <20211217114548.1659721-1-cosmin.tanislav@analog.com>
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
2.34.1

