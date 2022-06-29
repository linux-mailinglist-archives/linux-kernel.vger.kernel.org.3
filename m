Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7F55F353
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiF2CU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiF2CUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:20:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB1024087;
        Tue, 28 Jun 2022 19:20:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so14559945pjj.5;
        Tue, 28 Jun 2022 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eznfU5OLKvux3gk+UgnTY7Ig8FiLSf5GcaFaWnp7GUE=;
        b=Ue6/w6+gHn+7BaHHNO/gaM7l3MTam8H2xkn++ezdQJXMY7Ao5TxSMUlN95sqB9jv4h
         Rp9H3QKbtpv214j2mUxhHF4ws40uVnUw5N+S3RQLSFKScImIa/2CWLc2GJEQAtF5V+us
         drypwf+JuQ3EiPxf2zOAe1ZdmME7i+SULxRYdRAbDZ2+R8nkN9lceot75xSDytvfRDKM
         HA6aaRLy3cl+2HZ6YaRXTp659PwalLtBBd3DOeEu4BiWio25F/FhkKMozQGvscxGauUT
         2HBsZWqqF525C85HwvtqSPCnBDTdIb2UDf0d49hikg5WrPquaROs4q/Z4CWbU0suZZXe
         6zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eznfU5OLKvux3gk+UgnTY7Ig8FiLSf5GcaFaWnp7GUE=;
        b=UK2ZlaAJgRNSTvQbUCZggEM5jFM/GxpxXUG/bPL8Xck4YJ5/Cfx/72BPgbCCAZNhTc
         j1rX7bJHgxGToZTfYJp6nGhwfnjLKyjR2vNmtuOKTTyTcfeMejQcKc1PB2qBFlvu/nYa
         6fwYiWL7WrU0Vmmc4BR2XhbuUjCP+E/Lq8Eg+roAkVvl2d9yEp2B8X04fI9Ug/sDXlxN
         E3UtyiiPnFLMU0Dqvk/w0WKKawElMiLv/GShjGC1125kYUx7qQtZ9CCVpo1CqRSDuXDc
         LkMiBb/9xs5VIR2K1nUfeFHtRIC+BfLboIlxoIl95IFJji3NFVSvzZ/Z6wtJ6ObWKolF
         65Pg==
X-Gm-Message-State: AJIora/YJ/ott/kim4GMSFZKLy9gAzPQcs3vfWG8VNajBrfQFAViiTy8
        q0OyEjhFc6efgIgUgl3mpiE=
X-Google-Smtp-Source: AGRyM1vb9ADFNmrI6jxmjc/1MicCjRqggaPMl8/Zf755QqIwNNEIkVy365hzvho133v5JhP6NF7tJA==
X-Received: by 2002:a17:902:b40a:b0:16a:bca:f591 with SMTP id x10-20020a170902b40a00b0016a0bcaf591mr8010431plr.23.1656469223155;
        Tue, 28 Jun 2022 19:20:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46a:3e21:914b:bb3e:3e56:4806])
        by smtp.gmail.com with ESMTPSA id p26-20020a056a0026da00b005251e2b53acsm10089015pfw.116.2022.06.28.19.20.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 19:20:22 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
Date:   Wed, 29 Jun 2022 10:20:11 +0800
Message-Id: <1656469212-12717-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the documentation for Richtek rtq6056.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v2
- Change the resistor property name to be generic 'shunt-resistor-micro-ohms'.

---
 .../bindings/iio/adc/richtek,rtq6056.yaml          | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
new file mode 100644
index 00000000..fe45d8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bit ADC
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
+  interface, and the device provides full information for system by reading
+  out the loading current and power.
+
+  The device monitors both of the drops across sense resistor and the BUS
+  voltage, converts into the current in amperes, and power in watts through
+  internal analog-to-digital converter ADC. The programmable calibration,
+  adjustable conversion time, and averaging function are also built in for
+  more design flexibility.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
+
+properties:
+  compatible:
+    const: richtek,rtq6056
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  shunt-resistor-micro-ohms:
+    description: Shunt IN+/IN- sensing node resistor
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      rtq6056@40 {
+        compatible = "richtek,rtq6056";
+        reg = <0x40>;
+        #io-channel-cells = <1>;
+      };
+    };
-- 
2.7.4

