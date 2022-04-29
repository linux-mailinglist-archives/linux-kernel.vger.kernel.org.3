Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C318E5157F5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381303AbiD2WMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381284AbiD2WML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:12:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9282DBD36
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:08:51 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 7so3597490pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uXNxde6+oEFnU1eADSDWDv36HR4nxvYmBMvpMLrqUE=;
        b=siAF1f2iy+4k8YPyPcz4Z/uekmGasawINuwsf6+WDe/tVeeaPnb7gTbtjgiiSmeShz
         1jcbNjdeuH10fAUnJfiqw9odOwjvCWSA29S+pHNxhMCnYfVNqZGB1rfpHSWNaqcFD402
         mtmYOoKSbY5yCPIeHafZkux720lt3KnJY+ya4osF9VmCkWUgCsUKzEHu+MQmmjhZYi3e
         /dILsxFeU3/pb9lMMOAH3TY3Gxp3UsiK0RGHAi3wsdua+0cbWIk1cJo+uvDXfkg8F+EB
         rKfACVxAkq5Z4HbXL8ZatLl3nfvZeL03P7q2RtbcDsW17liVF7P74jnRxbxZkS1MXsoQ
         N8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3uXNxde6+oEFnU1eADSDWDv36HR4nxvYmBMvpMLrqUE=;
        b=f6GJSET589AX3f0pqKXD5dcrYdrgIqQ14yFnygGBV6G94/gJw91Rj5TgK8abdMHeT/
         2mer/FM1G+77lC5NRluhsU3TBOVtkoeYA4g+4oGw0w0d8EjpFGb3mYgXgMG+0UKlmC/H
         hDrYbSy4mHuoeuSZT1IbhSloMrE+WqtWBzloE91SZIIchnwth/qJJiUZp+ZBdOKrikrH
         /CXfVklIBMKFn3cLvgb1zdCf9i/zQPosbLL7eoeHaU16QsIlcgZFyf6Qvh2P37EnDvnS
         b7SazlFcwz7pXs+8fopmMe+Az0kFgnID3MhjJbDSx1bvmuaSOCSJ8JWyfJ2u++1e1qRm
         7Ygg==
X-Gm-Message-State: AOAM530nttevdlaXm1iWRWHVIvDub19fWPWmjTpYhKxtixRhJVotDlk7
        YZWt3vPhz5Aczxj5w2lD2+YCVw==
X-Google-Smtp-Source: ABdhPJziHDsXi0fRDXzEMVE1/ugW+bUFk0pqhfd+mVF6WgZudWAhbyWUWGcKO9D2zL1MRH2KxpltnA==
X-Received: by 2002:a05:6a00:140c:b0:4e1:530c:edc0 with SMTP id l12-20020a056a00140c00b004e1530cedc0mr1310265pfu.18.1651270131396;
        Fri, 29 Apr 2022 15:08:51 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b0050dc76281c2sm170020pfa.156.2022.04.29.15.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:08:51 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, robh@kernel.org
Subject: [PATCH 1/4] dt-bindings: mmc/sdhci-msm: Convert bindings to yaml
Date:   Sat, 30 Apr 2022 03:38:30 +0530
Message-Id: <20220429220833.873672-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm sdhci-msm devicetree binding to YAML.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.txt     | 123 -----------
 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 192 ++++++++++++++++++
 2 files changed, 192 insertions(+), 123 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
deleted file mode 100644
index 6216ed777343..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ /dev/null
@@ -1,123 +0,0 @@
-* Qualcomm SDHCI controller (sdhci-msm)
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci-msm driver.
-
-Required properties:
-- compatible: Should contain a SoC-specific string and a IP version string:
-	version strings:
-		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
-		"qcom,sdhci-msm-v5" for sdcc version 5.0
-		For SDCC version 5.0.0, MCI registers are removed from SDCC
-		interface and some registers are moved to HC. New compatible
-		string is added to support this change - "qcom,sdhci-msm-v5".
-	full compatible strings with SoC and version:
-		"qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
-		"qcom,msm8226-sdhci", "qcom,sdhci-msm-v4"
-		"qcom,msm8953-sdhci", "qcom,sdhci-msm-v4"
-		"qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
-		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
-		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
-		"qcom,msm8994-sdhci", "qcom,sdhci-msm-v4"
-		"qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
-		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
-		"qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
-		"qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
-		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
-		"qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
-		"qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
-	NOTE that some old device tree files may be floating around that only
-	have the string "qcom,sdhci-msm-v4" without the SoC compatible string
-	but doing that should be considered a deprecated practice.
-
-- reg: Base address and length of the register in the following order:
-	- Host controller register map (required)
-	- SD Core register map (required for controllers earlier than msm-v5)
-	- CQE register map (Optional, CQE support is present on SDHC instance meant
-	                    for eMMC and version v4.2 and above)
-	- Inline Crypto Engine register map (optional)
-- reg-names: When CQE register map is supplied, below reg-names are required
-	- "hc" for Host controller register map
-	- "core" for SD core register map
-	- "cqhci" for CQE register map
-	- "ice" for Inline Crypto Engine register map (optional)
-- interrupts: Should contain an interrupt-specifiers for the interrupts:
-	- Host controller interrupt (required)
-- pinctrl-names: Should contain only one value - "default".
-- pinctrl-0: Should specify pin control groups used for this controller.
-- clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
-- clock-names: Should contain the following:
-	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
-	"core"	- SDC MMC clock (MCLK) (required)
-	"bus"	- SDCC bus voter clock (optional)
-	"xo"	- TCXO clock (optional)
-	"cal"	- reference clock for RCLK delay calibration (optional)
-	"sleep"	- sleep clock for RCLK delay calibration (optional)
-	"ice" - clock for Inline Crypto Engine (optional)
-
-- qcom,ddr-config: Certain chipsets and platforms require particular settings
-	for the DDR_CONFIG register. Use this field to specify the register
-	value as per the Hardware Programming Guide.
-
-- qcom,dll-config: Chipset and Platform specific value. Use this field to
-	specify the DLL_CONFIG register value as per Hardware Programming Guide.
-
-Optional Properties:
-* Following bus parameters are required for interconnect bandwidth scaling:
-- interconnects: Pairs of phandles and interconnect provider specifier
-		 to denote the edge source and destination ports of
-		 the interconnect path.
-
-- interconnect-names: For sdhc, we have two main paths.
-		1. Data path : sdhc to ddr
-		2. Config path : cpu to sdhc
-		For Data interconnect path the name supposed to be
-		is "sdhc-ddr" and for config interconnect path it is
-		"cpu-sdhc".
-		Please refer to Documentation/devicetree/bindings/
-		interconnect/ for more details.
-
-Example:
-
-	sdhc_1: sdhci@f9824900 {
-		compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
-		reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
-		interrupts = <0 123 0>;
-		bus-width = <8>;
-		non-removable;
-
-		vmmc-supply = <&pm8941_l20>;
-		vqmmc-supply = <&pm8941_s3>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
-
-		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
-		clock-names = "core", "iface";
-		interconnects = <&qnoc MASTER_SDCC_ID &qnoc SLAVE_DDR_ID>,
-				<&qnoc MASTER_CPU_ID &qnoc SLAVE_SDCC_ID>;
-		interconnect-names = "sdhc-ddr","cpu-sdhc";
-
-		qcom,dll-config = <0x000f642c>;
-		qcom,ddr-config = <0x80040868>;
-	};
-
-	sdhc_2: sdhci@f98a4900 {
-		compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
-		reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
-		interrupts = <0 125 0>;
-		bus-width = <4>;
-		cd-gpios = <&msmgpio 62 0x1>;
-
-		vmmc-supply = <&pm8941_l21>;
-		vqmmc-supply = <&pm8941_l13>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data>;
-
-		clocks = <&gcc GCC_SDCC2_APPS_CLK>, <&gcc GCC_SDCC2_AHB_CLK>;
-		clock-names = "core", "iface";
-
-		qcom,dll-config = <0x0007642c>;
-		qcom,ddr-config = <0x80040868>;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
new file mode 100644
index 000000000000..c33f173e3b6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -0,0 +1,192 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mmc/sdhci-msm.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm SDHCI controller (sdhci-msm)
+
+maintainers:
+  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+
+description:
+  Secure Digital Host Controller Interface (SDHCI) present on
+  Qualcomm SOCs supports SD/MMC/SDIO devices.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,apq8084-sdhci
+              - qcom,msm8226-sdhci
+              - qcom,msm8953-sdhci
+              - qcom,msm8974-sdhci
+              - qcom,msm8916-sdhci
+              - qcom,msm8992-sdhci
+              - qcom,msm8994-sdhci
+              - qcom,msm8996-sdhci
+              - qcom,qcs404-sdhci
+              - qcom,sc7180-sdhci
+              - qcom,sc7280-sdhci
+              - qcom,sdm630-sdhci
+              - qcom,sdm845-sdhci
+              - qcom,sdx55-sdhci
+              - qcom,sm6125-sdhci
+              - qcom,sm6350-sdhci
+              - qcom,sm8250-sdhci
+          - enum:
+              - qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
+              - qcom,sdhci-msm-v5 # for sdcc version 5.0
+      - items:
+          - const: qcom,sdhci-msm-v4 # Deprecated (only for backward compatibility)
+                                     # for sdcc versions less than 5.0
+
+  reg:
+    minItems: 1
+    items:
+      - description: Host controller register map
+      - description: SD Core register map
+      - description: CQE register map
+      - description: Inline Crypto Engine register map
+
+  clocks:
+    minItems: 3
+    items:
+      - description: Main peripheral bus clock, PCLK/HCLK - AHB Bus clock
+      - description: SDC MMC clock, MCLK
+      - description: TCXO clock
+      - description: clock for Inline Crypto Engine
+      - description: SDCC bus voter clock
+      - description: reference clock for RCLK delay calibration
+      - description: sleep clock for RCLK delay calibration
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: iface
+      - const: core
+      - const: xo
+      - const: ice
+      - const: bus
+      - const: cal
+      - const: sleep
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: hc_irq
+      - const: pwr_irq
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+
+  pinctrl-0:
+    description:
+      Should specify pin control groups used for this controller.
+
+  qcom,ddr-config:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: platform specific settings for DDR_CONFIG reg.
+
+  qcom,dll-config:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: platform specific settings for DLL_CONFIG reg.
+
+  iommus:
+    minItems: 1
+    maxItems: 8
+    description: |
+      phandle to apps_smmu node with sid mask.
+
+  interconnects:
+    items:
+      - description: data path, sdhc to ddr
+      - description: config path, cpu to sdhc
+
+  interconnect-names:
+    items:
+      - const: sdhc-ddr
+      - const: cpu-sdhc
+
+  power-domains:
+    description: A phandle to sdhci power domain node
+    maxItems: 1
+
+patternProperties:
+  '^opp-table(-[a-z0-9]+)?$':
+    if:
+      properties:
+        compatible:
+          const: operating-points-v2
+    then:
+      patternProperties:
+        '^opp-?[0-9]+$':
+          required:
+            - required-opps
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-sm8250.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    sdhc_2: sdhci@8804000 {
+      compatible = "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5";
+      reg = <0 0x08804000 0 0x1000>;
+
+      interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "hc_irq", "pwr_irq";
+
+      clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+               <&gcc GCC_SDCC2_APPS_CLK>,
+               <&rpmhcc RPMH_CXO_CLK>;
+      clock-names = "iface", "core", "xo";
+      iommus = <&apps_smmu 0x4a0 0x0>;
+      qcom,dll-config = <0x0007642c>;
+      qcom,ddr-config = <0x80040868>;
+      power-domains = <&rpmhpd SM8250_CX>;
+
+      operating-points-v2 = <&sdhc2_opp_table>;
+
+      sdhc2_opp_table: opp-table {
+        compatible = "operating-points-v2";
+
+        opp-19200000 {
+          opp-hz = /bits/ 64 <19200000>;
+          required-opps = <&rpmhpd_opp_min_svs>;
+        };
+
+        opp-50000000 {
+          opp-hz = /bits/ 64 <50000000>;
+          required-opps = <&rpmhpd_opp_low_svs>;
+        };
+
+        opp-100000000 {
+          opp-hz = /bits/ 64 <100000000>;
+          required-opps = <&rpmhpd_opp_svs>;
+        };
+
+        opp-202000000 {
+          opp-hz = /bits/ 64 <202000000>;
+          required-opps = <&rpmhpd_opp_svs_l1>;
+        };
+      };
+    };
-- 
2.35.1

