Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667D350289D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352597AbiDOLDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352572AbiDOLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:03:00 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0F391341;
        Fri, 15 Apr 2022 04:00:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 17so9180458lji.1;
        Fri, 15 Apr 2022 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssUQClr8jde5M1FreVdIr0gWsq0efjPJU50BRXvcIoM=;
        b=aSV/2ebh7hy3wWulSUibASpo5ISs/8d46K8dKPc/stD4xNUPmdWfz0pHdTGvBLs7JA
         KhK99n/oweSwr0s5t7+QZTASKWcJ/hgMgiFYig1ab4YrT/l78ojGjy8SxvbulSZE2IHp
         FFo8OxMit+DyEgPFp+1diokpwcrUO4WZDwwPKlNJw3ga1GF4KhMIPd6GquF2i8iyVRkO
         5iqLHcNgUp5s2j8cLJpDgVUvIYl2jW6fmHThGjrHmvmOKxYficZONo/xSBWVGpQVqGF/
         efldWB5+FhWxLdmvD4ayJQzwaS5gM4TunXbbJ29q3/bG/QImB2/2Zy9Gd29cBQvypEug
         W/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssUQClr8jde5M1FreVdIr0gWsq0efjPJU50BRXvcIoM=;
        b=2SBA2+SWcnGAMkj5CMW2gDlWnw3GS87p/G0Q/11VC/b3Ul3yfjSir/DpSNxpFAxhVm
         sopJn5ZReO4Mb+KJA6twcBRPylmKucnjOHQahHc0Tg4vY6OR5i10ecc77TJm2fJwkpE4
         zDHGRbii9iVRHTZGk2bvsdbvxB3iHFiP3C1BgO9llqpXj8UrihizZA1STE6YtDm9osIO
         6JLoIR3EHj888/XARryuXqCfBLazRbA9qDTsD2/xzfB1r+TYUJaVfdzIV9HlJ/+EbIxg
         Q8A0Chpq0FhcDYPeHhYQ44EH4JMmaPSuQMVsrq7hfVFPU/BI8ng5NvsTKhhFizQaS7Sp
         EQlw==
X-Gm-Message-State: AOAM533Zs2FTl38y51MdpoykN2LP/auyY74UpQteNdCvUnF9iQxEQ+9X
        YE033FjGfW6PKF2XDbmZVj2W/6kvFOE=
X-Google-Smtp-Source: ABdhPJwgDo2CWcrv/a/aygSelZJ9PmM0AluIqJZlwGMD4pE1QnJxY9pXDdhJa8LNAXuAEg0G1BrLlA==
X-Received: by 2002:a2e:6819:0:b0:244:c111:7444 with SMTP id c25-20020a2e6819000000b00244c1117444mr4134862lja.116.1650020427273;
        Fri, 15 Apr 2022 04:00:27 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id q14-20020a0565123a8e00b0044a7b26ae1dsm292341lfu.109.2022.04.15.04.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 04:00:26 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: mfd: Add bindings for Silicon Mitus SM5703 MFD
Date:   Fri, 15 Apr 2022 14:00:11 +0300
Message-Id: <20220415110014.7384-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415110014.7384-1-markuss.broks@gmail.com>
References: <20220415110014.7384-1-markuss.broks@gmail.com>
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

This patch adds device-tree bindings for the Silicon Mitus
SM5703 MFD.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../bindings/mfd/siliconmitus,sm5703.yaml     | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml

diff --git a/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
new file mode 100644
index 000000000000..6665409bd541
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/siliconmitus,sm5703.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Mitus SM5703 multi-function device bindings
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+description: |
+  Silicon Mitus SM5703 is a multi-function device, that consists of several
+  modules, designed for a mobile phone use. It consists of
+  LDO, Buck, USBLDO and VBUS regulators, a flash LED driver, a MUIC unit,
+  a fuel gauge and a battery charger circuit. The MUIC and Fuel-Gauge units
+  are separate from the main MFD, having their own i2c lines, while the
+  LED driver, regulators and charger are sharing the main i2c bus of the MFD.
+
+properties:
+  compatible:
+    const: siliconmitus,sm5703-mfd
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  regulators:
+    $ref: ../regulator/siliconmitus,sm5703-regulator.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+  reset-gpio:
+    description:
+      GPIO which is connected to the MRSTB pin.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      mfd@49 {
+        compatible = "siliconmitus,sm5703-mfd";
+        reg = <0x49>;
+
+        reset-gpio = <&msmgpio 24 GPIO_ACTIVE_HIGH>;
+        pinctrl-0 = <&mrstb_default>;
+
+        regulator {
+          compatible = "siliconmitus,sm5703-regulator";
+
+          regulators {
+            sm5703_ldo1: ldo1 {
+              regulator-min-microvolt = <2800000>;
+              regulator-max-microvolt = <2800000>;
+            };
+
+            sm5703_ldo2: ldo2 {
+              regulator-min-microvolt = <1500000>;
+              regulator-max-microvolt = <3300000>;
+            };
+
+            sm5703_ldo3: ldo3 {
+              regulator-min-microvolt = <3300000>;
+              regulator-max-microvolt = <3300000>;
+            };
+
+            sm5703_usbldo1: usbldo1 {
+              regulator-min-microvolt = <4800000>;
+              regulator-max-microvolt = <4800000>;
+            };
+
+            sm5703_usbldo2: usbldo2 {
+              regulator-min-microvolt = <4800000>;
+              regulator-max-microvolt = <4800000>;
+            };
+
+            sm5703_vbus: vbus {
+              regulator-min-microvolt = <5000000>;
+              regulator-max-microvolt = <5000000>;
+            };
+          };
+        };
+      };
+    };
+...
-- 
2.35.1

