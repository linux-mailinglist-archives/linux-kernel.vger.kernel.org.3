Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F318C52E5D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346461AbiETHFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346519AbiETHEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:04:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C41D163F5F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:04:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id n23so9692648edy.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xIJXQrfU4eKH+FA+SzQBGD/O2Dz+Amb0pD+ua4CPDL0=;
        b=5OLSg+iyUKN6BqERHa2E3+TtUbwfBw+hjmnoSZrovnhIfM+ecAmXw/R0IXVHAuAthT
         OiBgGbPw1lKdhJFjsIfT8sr/1RM/kyWj5OpwglS44ilhRy2ZZquBelC8KSE2Wgew31+f
         Pu9Glt0207Mj5qTMVKk7BXOuoSjftmKRAEi0tIOhYgKD+fQr6s5PDtXBrBZVl1QMSYUr
         QYfJYlBHYQ4WzNDuhDgUBEgQ+1LJR2WQ3+RLmNgKMlGio8axUfWV2kw6/RII+knQQi/x
         9GNS8a75wGgqC5aB0ct34E/oq1FuXPZXDhPCcKaWPT0aNRjsNpwaNZAMT9EIiLbbsRLQ
         f50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xIJXQrfU4eKH+FA+SzQBGD/O2Dz+Amb0pD+ua4CPDL0=;
        b=lMmFd9vSU2h83yMAbAaSo/ktQzQSLX+JiklUeBBVcYwpWHdETKndN4Q8i32pcnvIGY
         bp4BGexyYMmzlkcx993KE2eUmN5o4qbFEKlfT2PapE7Yd3nY+Y9wPFBsGzP9aUefXurj
         UqY77YGA2IZtBRwEP+ry7MHgQYryM1wD05yOiLdpjLVoz2cTc7d9ZuQjKFT6fz/dCzvN
         bABxj2qpyTf6fRS5gRPPrisu5J0qcVN6I0r2Q7cZgFOFWtn4HZqqErGVWkToOGnZcizT
         uSDCvh44wsQh/+MLFKQpJcAp+WOiWXs/fL9gBMRrTaKxBOlppT/pov3AYL287EAch504
         dQQA==
X-Gm-Message-State: AOAM533Hxdcwf+SazmuGAbHo8lWEm92Rua8ezOk5WbT5TBooMzMHMAc5
        C5ZIpSN1BwnVIWjLx+fgrQ5Jvg==
X-Google-Smtp-Source: ABdhPJyjbT1uLAeCmAIX2YRg0kqyW0SC0P2O6zQjv5mMY4UprKV5moruQy15ghS0B2Ad+gBCJMGquQ==
X-Received: by 2002:a05:6402:3496:b0:42b:dc8:5d87 with SMTP id v22-20020a056402349600b0042b0dc85d87mr4157834edc.23.1653030264897;
        Fri, 20 May 2022 00:04:24 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id md17-20020a170906ae9100b006feaf472637sm336092ejb.53.2022.05.20.00.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:04:24 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: dts: qcom: sm6350: Add interconnect support
Date:   Fri, 20 May 2022 09:03:17 +0200
Message-Id: <20220520070318.48521-6-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520070318.48521-1-luca.weiss@fairphone.com>
References: <20220520070318.48521-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the different NoC providers that are found in SM6350 and
populate different nodes that use the interconnect properties.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes since v1:
* Use #interconnect-cells = <2>, adjust everything accordingly

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index fb1a0f662575..119073f19285 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
  * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2022, Luca Weiss <luca.weiss@fairphone.com>
  */
 
 #include <dt-bindings/clock/qcom,gcc-sm6350.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,sm6350.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -539,6 +541,10 @@ i2c0: i2c@880000 {
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -552,6 +558,10 @@ i2c2: i2c@888000 {
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 		};
@@ -578,6 +588,10 @@ i2c6: i2c@980000 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -591,6 +605,10 @@ i2c7: i2c@984000 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -604,6 +622,10 @@ i2c8: i2c@988000 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -615,6 +637,9 @@ uart9: serial@98c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -628,11 +653,62 @@ i2c10: i2c@990000 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
 		};
 
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sm6350-config-noc";
+			reg = <0 0x01500000 0 0x28000>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1620000 {
+			compatible = "qcom,sm6350-system-noc";
+			reg = <0 0x01620000 0 0x17080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+
+			clk_virt: interconnect-clk-virt {
+				compatible = "qcom,sm6350-clk-virt";
+				#interconnect-cells = <2>;
+				qcom,bcm-voters = <&apps_bcm_voter>;
+			};
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sm6350-aggre1-noc";
+			reg = <0 0x016e0000 0 0x15080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sm6350-aggre2-noc";
+			reg = <0 0x01700000 0 0x1f880>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+
+			compute_noc: interconnect-compute-noc {
+				compatible = "qcom,sm6350-compute-noc";
+				#interconnect-cells = <2>;
+				qcom,bcm-voters = <&apps_bcm_voter>;
+			};
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sm6350-mmss-noc";
+			reg = <0 0x01740000 0 0x1c100>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufs@1d84000 {
 			compatible = "qcom,sm6350-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -933,6 +1009,10 @@ sdhc_2: sdhci@8804000 {
 				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "iface", "core", "xo";
+			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_SDCC_2 0>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
 			power-domains = <&rpmhpd 0>;
@@ -947,11 +1027,15 @@ sdhc2_opp_table: sdhc2-opp-table {
 				opp-100000000 {
 					opp-hz = /bits/ 64 <100000000>;
 					required-opps = <&rpmhpd_opp_svs_l1>;
+					opp-peak-kBps = <790000 131000>;
+					opp-avg-kBps = <50000 50000>;
 				};
 
 				opp-202000000 {
 					opp-hz = /bits/ 64 <202000000>;
 					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <3190000 294000>;
+					opp-avg-kBps = <261438 300000>;
 				};
 			};
 		};
@@ -1017,12 +1101,33 @@ dp_phy: dp-phy@88ea200 {
 			};
 		};
 
+		dc_noc: interconnect@9160000 {
+			compatible = "qcom,sm6350-dc-noc";
+			reg = <0 0x09160000 0 0x3200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm6350-llcc";
 			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
 			reg-names = "llcc_base", "llcc_broadcast_base";
 		};
 
+		gem_noc: interconnect@9680000 {
+			compatible = "qcom,sm6350-gem-noc";
+			reg = <0 0x09680000 0 0x3e200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		npu_noc: interconnect@9990000 {
+			compatible = "qcom,sm6350-npu-noc";
+			reg = <0 0x09990000 0 0x1600>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sm6350-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -1051,6 +1156,10 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
+			interconnects = <&aggre2_noc MASTER_USB3 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
 			usb_1_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a600000 0 0xcd00>;
-- 
2.36.1

