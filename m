Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4B57A26E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbiGSOxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiGSOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:52:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A8E26F9;
        Tue, 19 Jul 2022 07:52:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e16so13747385pfm.11;
        Tue, 19 Jul 2022 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDks3qDrWxLLtCzjVaMIFrgSz1H5Uq4a3TXwwtZzFxU=;
        b=AG+9Yaj5qw/Xi+LCS4oUQ9A5e9J4iIrePBp8of2RrRy7ITPu+Ve8vax6O51mWInq0Q
         G2GTUqXSRPbxRLocCNY7CkztPhbXwypabt6jZlS/k2qnq8HffD1GfxRjU85gMYnvcWEh
         DlP5EEoyo0CDI2WyQFxy0JxlMahxPangj+0B4uIuXTUnSXDYfYlVGHa77+tT5LZQrAxl
         raXloDKJ9tWt/xtkfKs4c5ZraLQGf4yc5IXCsvaZM1q9O2tUs7vjFsNoQhuMnlqRCrFS
         1QmJkqRQ3fgbMJaCft9kv9MLNRL98o+H/N7QAfVr53+CoCGK39HFyk6SUlqpdVDtk8c3
         T/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDks3qDrWxLLtCzjVaMIFrgSz1H5Uq4a3TXwwtZzFxU=;
        b=ry3gYW6GLvufpzezZh9sjUbt/5GXo8N5m+NmI6kb0sBx6PptJe0IdGDKEz7n+JfgWd
         G4u7z1FKLepLR0GzsCjytpqs5wAskp3kmO94GmOFgEUjMtBmVqrHbePcJnbH0OjrHwy+
         mZP/7Qou1OOJGrfs7QFn9FCC9uHLrFOMI24uSNfBODbdC+q4S5S7+RHMguf1cn1JNXhk
         2BCjvd4HSeugQcyDZEOkUHV3vpLeD7WyrvkVMIYDtzk+VM6gkT6Js/D1KSIbgfJ+csbG
         rwfvCOvUiW81b07EFZTXYicdLhyPQOXG4Yv2jY5qz5jhK94f00CZbwytLacZ5PGBqsjo
         PTbA==
X-Gm-Message-State: AJIora/4nMXcBZOAMvH/YLr7qiWoigKipmsPMfbRYZgwim2my3X38i3G
        9gTkCObSGuNuYDS/CVNlVrY=
X-Google-Smtp-Source: AGRyM1vNcGIoA6hGLVlUdWiIH54MjznBLLVh/Cl8mift+QIeF4n5WfR8dRiuM27knerLSTPfCcUTRg==
X-Received: by 2002:a05:6a00:22d5:b0:52b:af2:9056 with SMTP id f21-20020a056a0022d500b0052b0af29056mr33504236pfj.80.1658242375719;
        Tue, 19 Jul 2022 07:52:55 -0700 (PDT)
Received: from localhost.localdomain (1-171-6-142.dynamic-ip.hinet.net. [1.171.6.142])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b001615f64aaabsm11630842ple.244.2022.07.19.07.52.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:52:55 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 1/3] dt-bindings: iio: adc: Add rtq6056 adc support
Date:   Tue, 19 Jul 2022 22:52:43 +0800
Message-Id: <1658242365-27797-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658242365-27797-1-git-send-email-u0084500@gmail.com>
References: <1658242365-27797-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

