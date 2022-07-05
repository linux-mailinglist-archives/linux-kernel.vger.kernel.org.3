Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680A4567424
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiGEQYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGEQY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:24:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E8C2DD2;
        Tue,  5 Jul 2022 09:24:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o18so10625171pgu.9;
        Tue, 05 Jul 2022 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDks3qDrWxLLtCzjVaMIFrgSz1H5Uq4a3TXwwtZzFxU=;
        b=VhGkcIJhfTENwqY4ihJWEVl0SW3PSalhjJbEgWIeDWRFNiJUjCgrqPnF6nJajpdQqX
         zYNxC9UwZV3E2N8pRCwywCM05g9uab2LAsfk+3Zf2GgBtPX51xCe3Pkc3nZur2oHI18Q
         oQGbNvtU5hKH9RLezs20qBPRaDJdHuYOvJr1J7nLrRs5Sxjn1bfXrRzCpdJMwOaI3B+m
         X6Nb4SHbTf3S/ZWCt/k362tmaT9/nEK5PrIvGfJJnkSrciK6j4UeufoUZLwfofTmXGv7
         VCnI8sy385n68nE7hMHtnrdFHPYQtfCy95Om+FcN532q/RrApEafT2Qc7zAHtnZzQC0/
         GC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDks3qDrWxLLtCzjVaMIFrgSz1H5Uq4a3TXwwtZzFxU=;
        b=JWG4sjQ47gD6zdXrHj4XM1Qa1d1LpjjSXJ+x9uPPfq5WapyxMsfJsONMcIe9HRz3Ht
         7NZGlLW9kqvoBgzMVi7P/dxQrJxuaQMmn/wWKWZidQ5G4HikD8asPaZpPxUmA4NQHQUG
         mnXHI9CK6f5mx4EjMWGfj0T4Wgf3PPlS1/W2FcqvcwonzV2kbrN0odJy5BP5bS64sng4
         QLKj4tblv/mRmZPB0ZNEvuAhpiBIej+0sczTsvLzCvwu5mbmJizqHnSWu7RZWf475+/Z
         kqJjpak34aiv7UmGvU515R0zfaFLLEJ29EKg8Zs+IX6h6JY3I6bfhx8hN4HUBvnhVzBf
         IoFw==
X-Gm-Message-State: AJIora9AbSzdae5s9j2VfFzE3GK9Li4Xo77Z8e0LHhxklTylnnibhebb
        zsuhJ178J6ok3OBJdR17aWU=
X-Google-Smtp-Source: AGRyM1uLmyXpvQebteJqxEm//EQ45EuJ35tyeMer3xXU91qGNshMxT59nVc3Ymm39ErJAmYhk7YpVw==
X-Received: by 2002:a63:7c53:0:b0:40c:f729:9fe9 with SMTP id l19-20020a637c53000000b0040cf7299fe9mr30569243pgn.317.1657038265756;
        Tue, 05 Jul 2022 09:24:25 -0700 (PDT)
Received: from localhost.localdomain (1-171-10-134.dynamic-ip.hinet.net. [1.171.10.134])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090a579200b001ec932d7592sm15290896pji.9.2022.07.05.09.24.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2022 09:24:25 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
Date:   Wed,  6 Jul 2022 00:24:11 +0800
Message-Id: <1657038252-31360-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657038252-31360-1-git-send-email-u0084500@gmail.com>
References: <1657038252-31360-1-git-send-email-u0084500@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Since v3
- change the node name to be generic 'adc' in binding example.

Since v2
- Change the resistor property name to be generic 'shunt-resistor-micro-ohms'.

---
 .../bindings/iio/adc/richtek,rtq6056.yaml          | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
new file mode 100644
index 00000000..88e0086
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
+      adc@40 {
+        compatible = "richtek,rtq6056";
+        reg = <0x40>;
+        #io-channel-cells = <1>;
+      };
+    };
-- 
2.7.4

