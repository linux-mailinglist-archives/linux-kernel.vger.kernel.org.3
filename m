Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DFA4E8099
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiCZLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiCZLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:41:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A494ECC4;
        Sat, 26 Mar 2022 04:39:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so10984909pjm.0;
        Sat, 26 Mar 2022 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=euxupepULOUqptjQmHefym8ok3QpesS+ejLb/40hyY4=;
        b=PfmCJvpCBnFGlkiiA8yHofZidAvrzY0zeaWFvaGlYF+MSYJCiG66FQSoqiK/vME2cj
         HqS2cBGk2CGRTZ9rr4D5FeDorb/l0CxthPSlklK4G+A2qm0gAMC3TiW56CvC/QAWbs7u
         U5uSs15hiza+M1qBq8a2T9Fx6Z1Gn+haM0mzvoZ6kcjj7AhrtdUr/kBXcXiOY8hq2856
         aY8Xb4Ux/bS7YEZAEyUFSuu0QoD5mKxJDZZgnlfgBY6mVvleKA1RFwJTVySlRIzIEgrF
         NlwQsxDDeip90z1bKB22hFOROo0sU3FuL3/ZZdcQgXneSfXvpuBGFBYmKiUaJSH7g7Zd
         CeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=euxupepULOUqptjQmHefym8ok3QpesS+ejLb/40hyY4=;
        b=Ye8+gKRwvbx/uxYgLHI5c+G14S74HsANWpQ7p2v2Uc1hglx/3ComfLFucX0zsy07L5
         2Aeu32xB0fNb9ZbhOqw7EayLFfNsxDwbz8OCHznmVLo+dxbvEye/pryyBWikyRzzuQam
         cypBBlxkiYpNWmZIdEptYqFgGzAgB/Gbce+TsOwxGee1K7QHd5GqdjDByyvye6T6hyYt
         HsGyPb3zKVKZENb8Vm1ncVPQ7S5rqknfQznA2UQqNtROmySVbM0cL7yHk2HQUeqOBNHX
         /9QdwkB10yD3gSf6TlaCrxxKf9tgbYgyrQNaZOG4LMqi8Sxyi9OJ0e8z8elSq5++WAAK
         XMgw==
X-Gm-Message-State: AOAM530qw/glJ0iR1G3A1+/Vp/6abqsfooQVXeAuiFRG4b52584gtr8S
        AyXhS3trsEsBL/LO2NxbF3Q=
X-Google-Smtp-Source: ABdhPJzA4OoXYS+72pYlwEMhGCdtQALCl5/h/x38MB47LaqYCTgzN95KCaHU1K9GpMB8bOqZPlkPaA==
X-Received: by 2002:a17:902:8601:b0:153:95da:fcdd with SMTP id f1-20020a170902860100b0015395dafcddmr16356038plo.104.1648294798802;
        Sat, 26 Mar 2022 04:39:58 -0700 (PDT)
Received: from RD-1129-20047.dynamic.kbronet.com.tw (180-176-43-246.dynamic.kbronet.com.tw. [180.176.43.246])
        by smtp.gmail.com with ESMTPSA id s1-20020a056a00178100b004f731a1a952sm9884926pfg.168.2022.03.26.04.39.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Mar 2022 04:39:57 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: regulator: Add binding for Richtek RT5759 DCDC converter
Date:   Sat, 26 Mar 2022 19:39:47 +0800
Message-Id: <1648294788-11758-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648294788-11758-1-git-send-email-u0084500@gmail.com>
References: <1648294788-11758-1-git-send-email-u0084500@gmail.com>
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

Add bindings for Richtek RT5759 high-performance DCDC converter.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rt5759-regulator.yaml        | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
new file mode 100644
index 00000000..0a4c957
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt5759-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5759 High Performance DCDC Converter
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT5759 is a high-performance, synchronous step-down DC-DC converter that
+  can deliver up to 9A output current from 3V to 6.5V input supply, The output
+  voltage can be programmable with I2C controlled 7-Bit VID.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT5759/DS5759-00.pdf
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt5759
+      - richtek,rt5759a
+
+  reg:
+    maxItems: 1
+
+  regulator-allowed-modes:
+    description: |
+      buck allowed operating mode
+        0: auto mode (PSKIP: pulse skipping)
+        1: force pwm mode
+    items:
+      enum: [0, 1]
+
+  richtek,watchdog-enable:
+    description: enable the external watchdog reset pin listening
+    type: boolean
+
+allOf:
+  - $ref: regulator.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: richtek,rt5759
+    then:
+      properties:
+        richtek,watchdog-enable: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  # example 1 for RT5759
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@62 {
+        compatible = "richtek,rt5759";
+        reg = <0x62>;
+        regulator-name = "rt5759-buck";
+        regulator-min-microvolt = <600000>;
+        regulator-max-microvolt = <1500000>;
+        regulator-boot-on;
+      };
+    };
+  # example 2 for RT5759A
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@62 {
+        compatible = "richtek,rt5759a";
+        reg = <0x62>;
+        regulator-name = "rt5759a-buck";
+        regulator-min-microvolt = <600000>;
+        regulator-max-microvolt = <1725000>;
+        regulator-boot-on;
+        richtek,watchdog-enable;
+      };
+    };
-- 
2.7.4

