Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82464B42FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbiBNHik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:38:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiBNHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:38:34 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF85A0AE;
        Sun, 13 Feb 2022 23:38:26 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw13so7059026ejc.9;
        Sun, 13 Feb 2022 23:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8SXCNeboPV5p4WZMz4UAaCSfT79i5ySX42XkzZvpOo=;
        b=pwvSmwB22CdJbJGvcAxNV3UWj1yoL5L4cGkij5LLzQGZLX96vcA1NviuiGOansGty+
         Q49YPUsAsiewd1FaAqZ9FRjPbZZXKm1kmiqJ4eFUb3GnkGg3cwnneKWXzXPQuLm5RRX3
         txcZ4pdS/EzrcWlVA5yGH+sursPyNtUmiS4AolHftAjDUdAzNWkm95jFTaOcEVAhhkNN
         1VdwzFmXmU7yeQnJfKVZ5FDKNXU6YE5HjNqiCKv+yqRIj6FEgnxixV3TkJmZI4KSfckC
         vR2PAx8luXNwIa/RAXOlsytOz0pbCA9HCaWmBUC2pDGcUUzyNSAqkzlglBVLbu8wIQ4b
         GzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8SXCNeboPV5p4WZMz4UAaCSfT79i5ySX42XkzZvpOo=;
        b=78okRE0lB3LLCtBI7Y/Mxp7T2hNjcQOMSf9iSLPcUojNWG4YoL4xpq0UsN1n0k5bqC
         eWpYaxEc+hxlP0jq/Hv5vprQQnlaa9Z7U/OVboC0efmzDcvv9yVyGPFCUWy6n5ZhVdMj
         t50kHs9EKaFqHeRUjm99eXCZEJ5LlR/qCwG5L6ouiSZDHYJ3uZUJJJh4DoaQ3IKRu030
         MvSI/qO/N3m4A2sqKmAGQiPVQpZGV25eegA9oV3zWAmvlg1GFxE9/Q6ra52fHt+fGLzL
         Kq20RnzwqLirpqM5J72pfiehcuc0pYZSdviOs1vwieTRR07EOAJJmEy1B1yJLtxiQ8zp
         Qg+w==
X-Gm-Message-State: AOAM531PKOqjQIiBAIeDT3x6hz6fBZBX+A6oqrWDnN8zLfi3uqlgT32S
        j4NOukSKWXpvdcfhuLBevQ5bVUcu/fc=
X-Google-Smtp-Source: ABdhPJwb5psvYWCWsRU49QrD70LolMa5euOTE61k2CJmu2I5n6y8HiRBrRK00UvDfeshWnkadhUy2Q==
X-Received: by 2002:a17:907:a409:: with SMTP id sg9mr10158763ejc.219.1644824305470;
        Sun, 13 Feb 2022 23:38:25 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.58.131])
        by smtp.gmail.com with ESMTPSA id 9sm2480065ejd.184.2022.02.13.23.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 23:38:25 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 4/5] dt-bindings: iio: accel: add ADXL367
Date:   Mon, 14 Feb 2022 09:38:09 +0200
Message-Id: <20220214073810.781016-5-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214073810.781016-1-cosmin.tanislav@analog.com>
References: <20220214073810.781016-1-cosmin.tanislav@analog.com>
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
2.35.1

