Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E2F4F5F09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiDFNJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiDFNHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:07:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6655C4DF8A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:42:07 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h5so810010pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vtnVxUpqeOy+lDviWPyd0Y91LwDvZPA2Xr1Ta4Yt0XM=;
        b=wkaIlnesjO29ZSQOX6PKZU/YiZQoo/kLxIZ1Pbkhr/lOQvzqGmYEx5CzAECjsO1u0v
         doA4fHN/C8+ZQr5116S98wjABT1rLIhM19K+TKAiL3ZSn8NQZI8qgQPERqUjXStLVsAX
         FTlB9LoeIN32lt9mORzPG0YCk59nMgiuZ8rvkpxluKN2PE5ErpatQJ+qNexZTdD1TbqL
         HdrTecfcexPK1A9W3fhdTjdStdUUrD4WQAbnztE9zYeK7cnvfR3VZRM37tf2HcPFtlVJ
         DUb3XmJpNvfP8dzNqWoPanxlo/foKtX+b8tjUK3liUMah+RVEawpPeAoFKL6e8V7fft+
         VB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vtnVxUpqeOy+lDviWPyd0Y91LwDvZPA2Xr1Ta4Yt0XM=;
        b=Xq7xNGm0dDXB0Q6zgPE/raTZ3Hv0wAwwUaoaeyP4RcGkuF0JIHUZiTvSPvK/2qcU1X
         ncPkZ/XNypQDaXxdhuH2b/zfvYDxLO+BBp11dZ8rrRr8Lk2f2q1M+PBSX8NXRabs5Z4s
         05G56aTqA1Ms+29bfisobaxXJnqC5X2gUcXFphxloYWEMwJDpAim3LDcVj5pWp+2nEae
         vKauJXNZk5CObH2fOADuYzHhVkCjP+3CxnY9yjb0x17EwDX3DxQmn6IbSAcLXSVGFK9L
         YS2szqVacnZIz1pMqfjt55nNs97dXacBayMFs9M45gaF3hLdVoi9CNMhEEdI1WK7Msqw
         79tw==
X-Gm-Message-State: AOAM532kJ/VKgQg6xhirNTxoepCmdiJsj8dhAaI1g1/iNwX5n0DomBHn
        cdWOc78l9aZyhCa+6bXvzpIq9w==
X-Google-Smtp-Source: ABdhPJxectZK1HOF0zl4YAg2b2Idv6ciwvDwC6zTZEYb78ZHXR4UTIjs+SFvKYh4g6q92I03crOZBg==
X-Received: by 2002:a63:d442:0:b0:382:6f4e:d49f with SMTP id i2-20020a63d442000000b003826f4ed49fmr6390019pgj.7.1649238124002;
        Wed, 06 Apr 2022 02:42:04 -0700 (PDT)
Received: from localhost.localdomain (203-75-29-53.hinet-ip.hinet.net. [203.75.29.53])
        by smtp.gmail.com with ESMTPSA id q15-20020a056a00150f00b004fb28ea8d9fsm19720542pfu.171.2022.04.06.02.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 02:42:03 -0700 (PDT)
From:   Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
To:     agross@kernel.org
Cc:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Add sc7180-gelarshie
Date:   Wed,  6 Apr 2022 17:41:54 +0800
Message-Id: <20220406094156.3191-1-chenxiangrui@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree for Gelarshie, a trogdor variant

Signed-off-by: Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/sc7180-camera.dtsi   | 1136 +++++++++++++++++
 .../dts/qcom/sc7180-trogdor-gelarshie-r0.dts  |   15 +
 .../dts/qcom/sc7180-trogdor-gelarshie.dtsi    |  281 ++++
 .../dts/qcom/sc7180-trogdor-mipi-camera.dtsi  |  416 ++++++
 5 files changed, 1849 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-camera.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-mipi-camera.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f9e6343acd03..cf8f88b065c3 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-gelarshie-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-camera.dtsi b/arch/arm64/boot/dts/qcom/sc7180-camera.dtsi
new file mode 100644
index 000000000000..9f7a585d813c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-camera.dtsi
@@ -0,0 +1,1136 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <dt-bindings/clock/qcom,camcc-sc7180.h>
+
+&soc {
+	sync: qcom,sync {
+		compatible = "qcom,cam-sync";
+	};
+
+	crm: qcom,cam-req-mgr {
+		compatible = "qcom,cam-req-mgr";
+		sync_intf = <&sync>;
+		smmu_intf = <&smmu>;
+	};
+
+	smmu: cam_smmu {
+		compatible = "qcom,msm-cam-smmu";
+
+		msm_cam_smmu_ife {
+			compatible = "qcom,msm-cam-smmu-cb";
+			iommus = <&apps_smmu 0x820 0x0>,
+				<&apps_smmu 0x840 0x0>,
+				<&apps_smmu 0x860 0x0>;
+			label = "ife";
+			ife_iova_mem_map: iova-mem-map {
+				/* IO region is approximately 3.4 GB */
+				iova-mem-region-io {
+					iova-region-name = "io";
+					iova-region-start = <0x7400000>;
+					iova-region-len = <0xd8c00000>;
+					iova-region-id = <0x3>;
+				};
+			};
+		};
+
+		msm_cam_smmu_lrme {
+			compatible = "qcom,msm-cam-smmu-cb";
+			iommus = <&apps_smmu 0x0cc0 0x0>,
+				<&apps_smmu 0x0d40 0x0>;
+			label = "lrme";
+			lrme_iova_mem_map: iova-mem-map {
+				iova-mem-region-shared {
+					/* Shared region is 100MB long */
+					iova-region-name = "shared";
+					iova-region-start = <0x7400000>;
+					iova-region-len = <0x6400000>;
+					iova-region-id = <0x1>;
+				};
+				/* IO region is approximately 3.3 GB */
+				iova-mem-region-io {
+					iova-region-name = "io";
+					iova-region-start = <0xd800000>;
+					iova-region-len = <0xd2800000>;
+					iova-region-id = <0x3>;
+				};
+			};
+		};
+
+		msm_cam_smmu_jpeg {
+			compatible = "qcom,msm-cam-smmu-cb";
+			iommus = <&apps_smmu 0xd80 0x20>,
+				<&apps_smmu  0xda0 0x20>;
+			label = "jpeg";
+			jpeg_iova_mem_map: iova-mem-map {
+				/* IO region is approximately 3.4 GB */
+				iova-mem-region-io {
+					iova-region-name = "io";
+					iova-region-start = <0x7400000>;
+					iova-region-len = <0xd8c00000>;
+					iova-region-id = <0x3>;
+				};
+			};
+		};
+
+		msm_cam_icp_fw {
+			compatible = "qcom,msm-cam-smmu-fw-dev";
+			label="icp";
+		};
+
+		msm_cam_smmu_icp {
+			compatible = "qcom,msm-cam-smmu-cb";
+			iommus = <&apps_smmu 0x0ce2 0x0>,
+				<&apps_smmu 0x0c80 0x0>,
+				<&apps_smmu 0x0ca0 0x0>,
+				<&apps_smmu 0x0d00 0x0>,
+				<&apps_smmu 0x0d20 0x0>;
+			label = "icp";
+			icp_iova_mem_map: iova-mem-map {
+				iova-mem-region-firmware {
+					/* Firmware region is 5MB */
+					iova-region-name = "firmware";
+					iova-region-start = <0x0>;
+					iova-region-len = <0x500000>;
+					iova-region-id = <0x0>;
+				};
+
+				iova-mem-region-shared {
+					/* Shared region is 150MB long */
+					iova-region-name = "shared";
+					iova-region-start = <0x7400000>;
+					iova-region-len = <0x9600000>;
+					iova-region-id = <0x1>;
+					iova-granularity = <0x15>;
+				};
+
+				iova-mem-region-secondary-heap {
+					/* Secondary heap region is 1MB long */
+					iova-region-name = "secheap";
+					iova-region-start = <0x10A00000>;
+					iova-region-len = <0x100000>;
+					iova-region-id = <0x4>;
+				};
+
+				iova-mem-region-io {
+					/* IO region is approximately 3.3 GB */
+					iova-region-name = "io";
+					iova-region-start = <0x10C00000>;
+					iova-region-len = <0xCF300000>;
+					iova-region-id = <0x3>;
+				};
+
+				iova-mem-qdss-region {
+					/* qdss region is approximately 1MB */
+					iova-region-name = "qdss";
+					iova-region-start = <0x10B00000>;
+					iova-region-len = <0x100000>;
+					iova-region-id = <0x5>;
+					qdss-phy-addr = <0x16790000>;
+				};
+			};
+		};
+
+		msm_cam_smmu_cpas_cdm {
+			compatible = "qcom,msm-cam-smmu-cb";
+			iommus = <&apps_smmu 0x0d60 0x0>,
+				<&apps_smmu 0x0d61 0x0>;
+			label = "cpas-cdm0";
+			cpas_cdm_iova_mem_map: iova-mem-map {
+				iova-mem-region-io {
+					/* IO region is approximately 3.4 GB */
+					iova-region-name = "io";
+					iova-region-start = <0x7400000>;
+					iova-region-len = <0xd8c00000>;
+					iova-region-id = <0x3>;
+				};
+			};
+		};
+	};
+
+	qcom,cam-cpas@ac40000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		crm_intf = <&crm>;
+		cell-index = <0>;
+		compatible = "qcom,cam-cpas";
+		label = "cpas";
+		arch-compat = "cpas_top";
+		reg-names = "cam_cpas_top", "cam_camnoc";
+		reg = <0 0xac40000 0 0x1000>,
+			<0 0xac42000 0 0x5000>;
+		reg-cam-base = <0x40000 0x42000>;
+		interrupt-names = "cam-cpas";
+		interrupts = <GIC_SPI 459 IRQ_TYPE_EDGE_RISING>;
+		qcom,cpas-hw-ver = <0x150110>; /* Titan v150 v1.1.0 */
+		camnoc-axi-min-ib-bw = <3000000000>;
+		power-domains = <&camcc TITAN_TOP_GDSC>;
+		clock-names = "gcc_ahb_clk",
+			"gcc_axi_clk",
+			"soc_ahb_clk",
+			"slow_ahb_clk_src",
+			"cpas_ahb_clk",
+			"camnoc_axi_clk";
+		clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+			<&camcc GCC_CAMERA_HF_AXI_CLK>,
+			<&camcc CAM_CC_SOC_AHB_CLK>,
+			<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+			<&camcc CAM_CC_CPAS_AHB_CLK>,
+			<&camcc CAM_CC_CAMNOC_AXI_CLK>;
+		src-clock-name = "slow_ahb_clk_src";
+		clock-rates = <0 0 0 0 0 0>,
+			<0 0 0 80000000 0 0>,
+			<0 0 0 80000000 0 0>,
+			<0 0 0 80000000 0 0>,
+			<0 0 0 80000000 0 0>,
+			<0 0 0 80000000 0 0>;
+		clock-cntl-level = "suspend", "lowsvs", "svs",
+			"svs_l1", "nominal", "turbo";
+
+		interconnects = <&gem_noc MASTER_APPSS_PROC 0
+					&config_noc SLAVE_CAMERA_CFG 0>,
+				<&mmss_noc MASTER_CAMNOC_HF0 0
+					&mc_virt SLAVE_EBI1 0>,
+				<&camnoc_virt MASTER_CAMNOC_HF0_UNCOMP 0
+					&camnoc_virt SLAVE_CAMNOC_UNCOMP 0>,
+				<&mmss_noc MASTER_CAMNOC_HF1 0
+					&mc_virt SLAVE_EBI1 0>,
+				<&camnoc_virt MASTER_CAMNOC_HF1_UNCOMP 0
+					&camnoc_virt SLAVE_CAMNOC_UNCOMP 0>,
+				<&mmss_noc MASTER_CAMNOC_SF 0
+					&mc_virt SLAVE_EBI1 0>,
+				<&camnoc_virt MASTER_CAMNOC_SF_UNCOMP 0
+					&camnoc_virt SLAVE_CAMNOC_UNCOMP 0>;
+		interconnect-names = "cam_ahb",
+				"cam_hf_1_mnoc",
+				"cam_hf_1_camnoc",
+				"cam_hf_2_mnoc",
+				"cam_hf_2_camnoc",
+				"cam_sf_1_mnoc",
+				"cam_sf_1_camnoc";
+
+		client-id-based;
+		client-names =
+			"csiphy0", "csiphy1", "csiphy2", "csiphy3",
+			"csid0", "csid1", "csid2", "cci0", "cci1",
+			"ife0", "ife1", "ife2", "ipe0",
+			"ipe1", "cam-cdm-intf0", "cpas-cdm0", "bps0",
+			"icp0", "jpeg-dma0", "jpeg-enc0", "lrmecpas0";
+		client-axi-port-names =
+			"cam_hf_1", "cam_hf_1", "cam_hf_1", "cam_hf_1",
+			"cam_hf_1", "cam_hf_2", "cam_hf_2", "cam_sf_1",
+			"cam_sf_1", "cam_hf_1", "cam_hf_2", "cam_hf_2",
+			"cam_sf_1", "cam_sf_1", "cam_sf_1", "cam_sf_1",
+			"cam_sf_1", "cam_sf_1", "cam_sf_1", "cam_sf_1",
+			"cam_sf_1";
+		client-bus-camnoc-based;
+		qcom,axi-port-list {
+			qcom,axi-port1 {
+				qcom,axi-port-name = "cam_hf_1";
+				qcom,axi-port-mnoc {
+					qcom,msm-bus,name = "cam_hf_1_mnoc";
+					qcom,msm-bus-vector-dyn-vote;
+				};
+				qcom,axi-port-camnoc {
+					qcom,msm-bus,name = "cam_hf_1_camnoc";
+					qcom,msm-bus-vector-dyn-vote;
+				};
+			};
+			qcom,axi-port2 {
+				qcom,axi-port-name = "cam_hf_2";
+				qcom,axi-port-mnoc {
+					qcom,msm-bus,name = "cam_hf_2_mnoc";
+					qcom,msm-bus-vector-dyn-vote;
+				};
+				qcom,axi-port-camnoc {
+					qcom,msm-bus,name = "cam_hf_2_camnoc";
+					qcom,msm-bus-vector-dyn-vote;
+				};
+			};
+			qcom,axi-port3 {
+				qcom,axi-port-name = "cam_sf_1";
+					qcom,axi-port-mnoc {
+					qcom,msm-bus,name = "cam_sf_1_mnoc";
+					qcom,msm-bus-vector-dyn-vote;
+				};
+				qcom,axi-port-camnoc {
+					qcom,msm-bus,name = "cam_sf_1_camnoc";
+					qcom,msm-bus-vector-dyn-vote;
+				};
+			};
+		};
+
+		cpas: qcom,cam-cdm-intf {
+			compatible = "qcom,cam-cdm-intf";
+			cell-index = <0>;
+			label = "cam-cdm-intf";
+			num-hw-cdm = <1>;
+			cdm-client-names = "vfe",
+				"jpegdma",
+				"jpegenc",
+				"lrmecdm";
+		};
+
+		qcom,cpas-cdm0@ac48000 {
+			cell-index = <0>;
+			compatible = "qcom,cam170-cpas-cdm0";
+			label = "cpas-cdm";
+			reg = <0 0xac48000 0 0x1000>;
+			reg-names = "cpas-cdm";
+			reg-cam-base = <0x48000>;
+			interrupts = <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "cpas-cdm0";
+			clock-names = "gcc_camera_ahb",
+				"gcc_camera_axi",
+				"cam_cc_soc_ahb_clk",
+				"cam_cc_cpas_ahb_clk",
+				"cam_cc_camnoc_axi_clk";
+			clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+				<&camcc GCC_CAMERA_HF_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_CAMNOC_AXI_CLK>;
+			clock-rates = <0 0 0 0 0>;
+			clock-cntl-level = "svs";
+			cdm-client-names = "ife";
+		};
+	};
+
+	qcom,cam-isp {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		cpas_intf = <&cpas>;
+		compatible = "qcom,cam-isp";
+		arch-compat = "ife";
+
+		cam_csiphy0: qcom,csiphy@ac65000 {
+			cell-index = <0>;
+			compatible = "qcom,csiphy-v1.2.2", "qcom,csiphy";
+			cpas_intf = <&cpas>;
+			reg = <0 0x0ac65000 0 0x1000>;
+			reg-names = "csiphy";
+			reg-cam-base = <0x65000>;
+			interrupts = <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "cam-csiphy0";
+			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_CPHY_RX_CLK_SRC>,
+				<&camcc CAM_CC_CSIPHY0_CLK>,
+				<&camcc CAM_CC_CSI0PHYTIMER_CLK_SRC>,
+				<&camcc CAM_CC_CSI0PHYTIMER_CLK>;
+			clock-names = "camnoc_axi_clk",
+				"soc_ahb_clk",
+				"slow_ahb_clk_src",
+				"cpas_ahb_clk",
+				"cphy_rx_clk_src",
+				"csiphy0_clk",
+				"csi0phytimer_clk_src",
+				"csi0phytimer_clk";
+			src-clock-name = "csi0phytimer_clk_src";
+			clock-cntl-level = "svs", "svs_l1", "turbo";
+			clock-rates =
+				<0 0 0 0 270000000 0 300000000 0>,
+				<0 0 0 0 360000000 0 300000000 0>,
+				<0 0 0 0 360000000 0 300000000 0>;
+		};
+
+		cam_csiphy1: qcom,csiphy@ac66000{
+			cell-index = <1>;
+			compatible = "qcom,csiphy-v1.2.2", "qcom,csiphy";
+			cpas_intf = <&cpas>;
+			reg = <0 0xac66000 0 0x1000>;
+			reg-names = "csiphy";
+			reg-cam-base = <0x66000>;
+			interrupts = <GIC_SPI 478 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "cam-csiphy1";
+			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_CPHY_RX_CLK_SRC>,
+				<&camcc CAM_CC_CSIPHY1_CLK>,
+				<&camcc CAM_CC_CSI1PHYTIMER_CLK_SRC>,
+				<&camcc CAM_CC_CSI1PHYTIMER_CLK>;
+			clock-names = "camnoc_axi_clk",
+				"soc_ahb_clk",
+				"slow_ahb_clk_src",
+				"cpas_ahb_clk",
+				"cphy_rx_clk_src",
+				"csiphy1_clk",
+				"csi1phytimer_clk_src",
+				"csi1phytimer_clk";
+			src-clock-name = "csi1phytimer_clk_src";
+			clock-cntl-level = "svs", "svs_l1", "turbo";
+			clock-rates =
+				<0 0 0 0 270000000 0 300000000 0>,
+				<0 0 0 0 360000000 0 300000000 0>,
+				<0 0 0 0 360000000 0 300000000 0>;
+		};
+
+		cam_csiphy2: qcom,csiphy@ac67000 {
+			cell-index = <2>;
+			compatible = "qcom,csiphy-v1.2.2", "qcom,csiphy";
+			cpas_intf = <&cpas>;
+			reg = <0 0xac67000 0 0x1000>;
+			reg-names = "csiphy";
+			reg-cam-base = <0x67000>;
+			interrupts = <GIC_SPI 479 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "cam-csiphy2";
+			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_CPHY_RX_CLK_SRC>,
+				<&camcc CAM_CC_CSIPHY2_CLK>,
+				<&camcc CAM_CC_CSI2PHYTIMER_CLK_SRC>,
+				<&camcc CAM_CC_CSI2PHYTIMER_CLK>;
+			clock-names = "camnoc_axi_clk",
+				"soc_ahb_clk",
+				"slow_ahb_clk_src",
+				"cpas_ahb_clk",
+				"cphy_rx_clk_src",
+				"csiphy2_clk",
+				"csi2phytimer_clk_src",
+				"csi2phytimer_clk";
+			src-clock-name = "csi2phytimer_clk_src";
+			clock-cntl-level = "svs", "svs_l1", "turbo";
+			clock-rates =
+				<0 0 0 0 270000000 0 300000000 0>,
+				<0 0 0 0 360000000 0 300000000 0>,
+				<0 0 0 0 360000000 0 300000000 0>;
+		};
+
+		cam_csiphy3: qcom,csiphy@ac68000 {
+			cell-index = <3>;
+			cpas_intf = <&cpas>;
+			compatible = "qcom,csiphy-v1.2.2", "qcom,csiphy";
+			reg = <0 0xac68000 0 0x1000>;
+			reg-names = "csiphy";
+			reg-cam-base = <0x68000>;
+			interrupts = <GIC_SPI 461 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "cam-csiphy3";
+			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_CPHY_RX_CLK_SRC>,
+				<&camcc CAM_CC_CSIPHY3_CLK>,
+				<&camcc CAM_CC_CSI3PHYTIMER_CLK_SRC>,
+				<&camcc CAM_CC_CSI3PHYTIMER_CLK>;
+			clock-names = "camnoc_axi_clk",
+				"soc_ahb_clk",
+				"slow_ahb_clk_src",
+				"cpas_ahb_clk",
+				"cphy_rx_clk_src",
+				"csiphy3_clk",
+				"csi3phytimer_clk_src",
+				"csi3phytimer_clk";
+			src-clock-name = "csi3phytimer_clk_src";
+			clock-cntl-level = "svs", "svs_l1", "turbo";
+			clock-rates =
+				<0 0 0 0 270000000 0 300000000 0>,
+				<0 0 0 0 360000000 0 300000000 0>,
+				<0 0 0 0 360000000 0 300000000 0>;
+		};
+
+		cam_ppi0: qcom,ppi0@ace0000 {
+			cell-index = <0>;
+			compatible = "qcom,ppi170";
+			reg-names = "ppi";
+			reg = <0 0xace0000 0 0x200>;
+			reg-cam-base = <0xe0000>;
+			interrupt-names = "ppi";
+			interrupts = <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&camcc CAM_CC_CSIPHY0_CLK>;
+			clock-names = "csiphy0_clk";
+			clock-cntl-level = "svs";
+			clock-rates = <0>;
+		};
+
+		cam_ppi1: qcom,ppi0@ace0200 {
+			cell-index = <1>;
+			compatible = "qcom,ppi170";
+			reg-names = "ppi";
+			reg = <0 0xace0200 0 0x200>;
+			reg-cam-base = <0xe0200>;
+			interrupt-names = "ppi";
+			interrupts = <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&camcc CAM_CC_CSIPHY1_CLK>;
+			clock-names = "csiphy1_clk";
+			clock-cntl-level = "svs";
+			clock-rates = <0>;
+		};
+
+		cam_ppi2: qcom,ppi0@ace0400 {
+			cell-index = <2>;
+			compatible = "qcom,ppi170";
+			reg-names = "ppi";
+			reg = <0 0xace0400 0 0x200>;
+			reg-cam-base = <0xe0400>;
+			interrupt-names = "ppi";
+			interrupts = <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&camcc CAM_CC_CSIPHY2_CLK>;
+			clock-names = "csiphy2_clk";
+			clock-cntl-level = "svs";
+			clock-rates = <0>;
+		};
+
+		cam_ppi3: qcom,ppi0@ace0600 {
+			cell-index = <3>;
+			compatible = "qcom,ppi170";
+			reg-names = "ppi";
+			reg = <0 0xace0600 0 0x200>;
+			reg-cam-base = <0xe00600>;
+			interrupt-names = "ppi";
+			interrupts = <GIC_SPI 173 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&camcc CAM_CC_CSIPHY3_CLK>;
+			clock-names = "csiphy3_clk";
+			clock-cntl-level = "svs";
+			clock-rates = <0>;
+		};
+
+		cam_csid0: qcom,csid0@acb3000 {
+			cell-index = <0>;
+			compatible = "qcom,csid170";
+			reg-names = "csid";
+			reg = <0 0xacb3000 0 0x1000>;
+			reg-cam-base = <0xb3000>;
+			interrupt-names = "cam-csid0";
+			interrupts = <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc IFE_0_GDSC>;
+			clock-names = "camera_ahb",
+				"camera_axi",
+				"soc_ahb_clk",
+				"cpas_ahb_clk",
+				"slow_ahb_clk_src",
+				"ife_csid_clk",
+				"ife_csid_clk_src",
+				"ife_cphy_rx_clk",
+				"cphy_rx_clk_src",
+				"ife_clk",
+				"ife_clk_src",
+				"camnoc_axi_clk",
+				"ife_axi_clk";
+			clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+				<&camcc GCC_CAMERA_HF_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&camcc CAM_CC_IFE_0_CSID_CLK>,
+				<&camcc CAM_CC_IFE_0_CSID_CLK_SRC>,
+				<&camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
+				<&camcc CAM_CC_CPHY_RX_CLK_SRC>,
+				<&camcc CAM_CC_IFE_0_CLK>,
+				<&camcc CAM_CC_IFE_0_CLK_SRC>,
+				<&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_IFE_0_AXI_CLK>;
+			clock-rates =
+				<0 0 0 0 0 0 270000000 0 0 0 360000000 0 0>,
+				<0 0 0 0 0 0 360000000 0 0 0 432000000 0 0>,
+				<0 0 0 0 0 0 480000000 0 0 0 600000000 0 0>;
+			clock-cntl-level = "svs", "svs_l1", "turbo";
+			src-clock-name = "ife_csid_clk_src";
+			ppi-enable;
+		};
+
+		cam_csid1: qcom,csid1@acba000 {
+			cell-index = <1>;
+			compatible = "qcom,csid170";
+			reg-names = "csid";
+			reg = <0 0xacba000 0 0x1000>;
+			reg-cam-base = <0xba000>;
+			interrupt-names = "cam-csid1";
+			interrupts = <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc IFE_1_GDSC>;
+			clock-names = "camera_ahb",
+				"camera_axi",
+				"soc_ahb_clk",
+				"cpas_ahb_clk",
+				"slow_ahb_clk_src",
+				"ife_csid_clk",
+				"ife_csid_clk_src",
+				"ife_cphy_rx_clk",
+				"cphy_rx_clk_src",
+				"ife_clk",
+				"ife_clk_src",
+				"camnoc_axi_clk",
+				"ife_axi_clk";
+			clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+				<&camcc GCC_CAMERA_HF_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&camcc CAM_CC_IFE_1_CSID_CLK>,
+				<&camcc CAM_CC_IFE_1_CSID_CLK_SRC>,
+				<&camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
+				<&camcc CAM_CC_CPHY_RX_CLK_SRC>,
+				<&camcc CAM_CC_IFE_1_CLK>,
+				<&camcc CAM_CC_IFE_1_CLK_SRC>,
+				<&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_IFE_1_AXI_CLK>;
+			clock-rates =
+				<0 0 0 0 0 0 270000000 0 0 0 360000000 0 0>,
+				<0 0 0 0 0 0 360000000 0 0 0 432000000 0 0>,
+				<0 0 0 0 0 0 480000000 0 0 0 600000000 0 0>;
+			clock-cntl-level = "svs", "svs_l1", "turbo";
+			src-clock-name = "ife_csid_clk_src";
+			ppi-enable;
+		};
+
+		cam_csid_lite: qcom,csid-lite@acc8000 {
+			cell-index = <2>;
+			compatible = "qcom,csid-lite170";
+			reg-names = "csid-lite";
+			reg = <0 0xacc8000 0 0x1000>;
+			reg-cam-base = <0xc8000>;
+			interrupt-names = "cam-csid-lite";
+			interrupts = <GIC_SPI 473 IRQ_TYPE_EDGE_RISING>;
+			clock-names = "camera_ahb",
+				"camera_axi",
+				"soc_ahb_clk",
+				"cpas_ahb_clk",
+				"slow_ahb_clk_src",
+				"ife_csid_clk",
+				"ife_csid_clk_src",
+				"ife_cphy_rx_clk",
+				"cphy_rx_clk_src",
+				"ife_clk",
+				"ife_clk_src",
+				"camnoc_axi_clk";
+			clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+				<&camcc GCC_CAMERA_HF_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&camcc CAM_CC_IFE_LITE_CSID_CLK>,
+				<&camcc CAM_CC_IFE_LITE_CSID_CLK_SRC>,
+				<&camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
+				<&camcc CAM_CC_CPHY_RX_CLK_SRC>,
+				<&camcc CAM_CC_IFE_LITE_CLK>,
+				<&camcc CAM_CC_IFE_LITE_CLK_SRC>,
+				<&camcc CAM_CC_CAMNOC_AXI_CLK>;
+			clock-rates =
+				<0 0 0 0 0 0 270000000 0 0 0 360000000 0>,
+				<0 0 0 0 0 0 360000000 0 0 0 432000000 0>,
+				<0 0 0 0 0 0 480000000 0 0 0 600000000 0>;
+			clock-cntl-level = "svs", "svs_l1", "turbo";
+			src-clock-name = "ife_csid_clk_src";
+			ppi-enable;
+		};
+
+		cam_vfe0: qcom,vfe0@acaf000 {
+			cell-index = <0>;
+			compatible = "qcom,vfe170";
+			reg-names = "ife", "cam_camnoc";
+			reg = <0 0xacaf000 0 0x4000>,
+				<0 0xac42000 0 0x5000>;
+			reg-cam-base = <0xaf000 0 0x42000>;
+			interrupt-names = "cam-vfe0";
+			interrupts = <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc IFE_0_GDSC>;
+			clock-names = "camera_ahb",
+				"camera_axi",
+				"soc_ahb_clk",
+				"cpas_ahb_clk",
+				"slow_ahb_clk_src",
+				"ife_clk",
+				"ife_clk_src",
+				"camnoc_axi_clk",
+				"ife_axi_clk";
+			clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+				<&camcc GCC_CAMERA_HF_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&camcc CAM_CC_IFE_0_CLK>,
+				<&camcc CAM_CC_IFE_0_CLK_SRC>,
+				<&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_IFE_0_AXI_CLK>;
+			clock-rates =
+				<0 0 0 0 0 0 360000000 0 0>,
+				<0 0 0 0 0 0 432000000 0 0>,
+				<0 0 0 0 0 0 600000000 0 0>;
+			clock-cntl-level = "svs", "svs_l1", "turbo";
+			src-clock-name = "ife_clk_src";
+			clock-names-option =  "ife_dsp_clk";
+			clocks-option = <&camcc CAM_CC_IFE_0_DSP_CLK>;
+			clock-rates-option = <600000000>;
+		};
+
+		cam_vfe1: qcom,vfe1@acb6000 {
+			cell-index = <1>;
+			compatible = "qcom,vfe170";
+			reg-names = "ife", "cam_camnoc";
+			reg = <0 0xacb6000 0 0x4000>,
+				<0 0xac42000 0 0x5000>;
+			reg-cam-base = <0xb6000 0x42000>;
+			interrupt-names = "cam-vfe1";
+			interrupts = <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc IFE_1_GDSC>;
+			clock-names = "camera_ahb",
+				"camera_axi",
+				"soc_ahb_clk",
+				"cpas_ahb_clk",
+				"slow_ahb_clk_src",
+				"ife_clk",
+				"ife_clk_src",
+				"camnoc_axi_clk",
+				"ife_axi_clk";
+			clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+				<&camcc GCC_CAMERA_HF_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&camcc CAM_CC_IFE_1_CLK>,
+				<&camcc CAM_CC_IFE_1_CLK_SRC>,
+				<&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_IFE_1_AXI_CLK>;
+			clock-rates =
+				<0 0 0 0 0 0 360000000 0 0>,
+				<0 0 0 0 0 0 432000000 0 0>,
+				<0 0 0 0 0 0 600000000 0 0>;
+			clock-cntl-level = "svs", "svs_l1", "turbo";
+			src-clock-name = "ife_clk_src";
+			clock-names-option =  "ife_dsp_clk";
+			clocks-option = <&camcc CAM_CC_IFE_1_DSP_CLK>;
+			clock-rates-option = <600000000>;
+		};
+
+		cam_vfe_lite: qcom,vfe-lite@acc4000 {
+			cell-index = <2>;
+			compatible = "qcom,vfe-lite170";
+			reg-names = "ife-lite";
+			reg = <0 0xacc4000 0 0x4000>;
+			reg-cam-base = <0xc4000>;
+			interrupt-names = "cam-vfe-lite";
+			interrupts = <GIC_SPI 472 IRQ_TYPE_EDGE_RISING>;
+			clock-names = "camera_ahb",
+				"camera_axi",
+				"soc_ahb_clk",
+				"cpas_ahb_clk",
+				"slow_ahb_clk_src",
+				"ife_clk",
+				"ife_clk_src",
+				"camnoc_axi_clk";
+			clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+				<&camcc GCC_CAMERA_HF_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				<&camcc CAM_CC_IFE_LITE_CLK>,
+				<&camcc CAM_CC_IFE_LITE_CLK_SRC>,
+				<&camcc CAM_CC_CAMNOC_AXI_CLK>;
+			clock-rates =
+				<0 0 0 0 0 0 360000000 0>,
+				<0 0 0 0 0 0 432000000 0>,
+				<0 0 0 0 0 0 600000000 0>;
+			clock-cntl-level = "svs", "svs_l1", "turbo";
+			src-clock-name = "ife_clk_src";
+		};
+	};
+
+	qcom,cam-icp {
+		cpas_intf = <&cpas>;
+		compatible = "qcom,cam-icp";
+		compat-hw-name = "qcom,a5",
+			"qcom,ipe0",
+			"qcom,bps";
+		num-a5 = <1>;
+		num-ipe = <1>;
+		num-bps = <1>;
+		icp_pc_en;
+	};
+
+	cam_a5: qcom,a5@ac00000 {
+		cell-index = <0>;
+		cpas_intf = <&cpas>;
+		compatible = "qcom,cam-a5";
+		reg = <0 0xac00000 0 0x6000>,
+			<0 0xac10000 0 0x8000>,
+			<0 0xac18000 0 0x3000>;
+		reg-names = "a5_qgic", "a5_sierra", "a5_csr";
+		reg-cam-base = <0x00000 0x10000 0x18000>;
+		interrupts = <GIC_SPI 463 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "a5";
+		clock-names = "gcc_cam_ahb_clk",
+			"gcc_cam_axi_clk",
+			"soc_fast_ahb",
+			"soc_ahb_clk",
+			"cpas_ahb_clk",
+			"camnoc_axi_clk",
+			"icp_clk",
+			"icp_clk_src";
+		clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+			<&camcc GCC_CAMERA_HF_AXI_CLK>,
+			<&camcc CAM_CC_FAST_AHB_CLK_SRC>,
+			<&camcc CAM_CC_SOC_AHB_CLK>,
+			<&camcc CAM_CC_CPAS_AHB_CLK>,
+			<&camcc CAM_CC_CAMNOC_AXI_CLK>,
+			<&camcc CAM_CC_ICP_CLK>,
+			<&camcc CAM_CC_ICP_CLK_SRC>;
+		clock-rates =
+			<0 0 200000000 0 0 0 0 360000000>,
+			<0 0 200000000 0 0 0 0 600000000>;
+		clock-cntl-level = "svs", "turbo";
+		fw_name = "CAMERA_ICP.elf";
+		ubwc-cfg = <0x73 0x1CF>;
+	};
+
+	cam_bps: qcom,bps {
+		cell-index = <0>;
+		cpas_intf = <&cpas>;
+		compatible = "qcom,cam-bps";
+		reg = <0 0xac6f000 0 0x3000>;
+		reg-names = "bps_top";
+		reg-cam-base = <0x6f000>;
+		power-domains = <&camcc BPS_GDSC>;
+		clock-names = "bps_ahb_clk",
+			"bps_areg_clk",
+			"bps_axi_clk",
+			"bps_clk",
+			"bps_clk_src";
+		src-clock-name = "bps_clk_src";
+		clocks = <&camcc CAM_CC_BPS_AHB_CLK>,
+			<&camcc CAM_CC_BPS_AREG_CLK>,
+			<&camcc CAM_CC_BPS_AXI_CLK>,
+			<&camcc CAM_CC_BPS_CLK>,
+			<&camcc CAM_CC_BPS_CLK_SRC>;
+
+		clock-rates =
+			<0 0 0 0 360000000>,
+			<0 0 0 0 432000000>,
+			<0 0 0 0 480000000>,
+			<0 0 0 0 600000000>;
+		clock-cntl-level = "svs",
+			"svs_l1", "nominal", "turbo";
+	};
+
+	cam_ipe0: qcom,ipe0 {
+		cell-index = <0>;
+		cpas_intf = <&cpas>;
+		compatible = "qcom,cam-ipe";
+		reg = <0 0xac87000 0 0x3000>;
+		reg-names = "ipe0_top";
+		reg-cam-base = <0x87000>;
+		power-domains = <&camcc IPE_0_GDSC>;
+		clock-names = "ipe_0_ahb_clk",
+			"ipe_0_areg_clk",
+			"ipe_0_axi_clk",
+			"ipe_0_clk",
+			"ipe_0_clk_src";
+		src-clock-name = "ipe_0_clk_src";
+		clocks = <&camcc CAM_CC_IPE_0_AHB_CLK>,
+			<&camcc CAM_CC_IPE_0_AREG_CLK>,
+			<&camcc CAM_CC_IPE_0_AXI_CLK>,
+			<&camcc CAM_CC_IPE_0_CLK>,
+			<&camcc CAM_CC_IPE_0_CLK_SRC>;
+
+		clock-rates =
+			<0 0 0 0 360000000>,
+			<0 0 0 0 432000000>,
+			<0 0 0 0 540000000>,
+			<0 0 0 0 600000000>;
+		clock-cntl-level = "svs",
+			"svs_l1", "nominal", "turbo";
+	};
+
+	cam_jpeg_mgr: qcom,cam-jpeg {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		cpas_intf = <&cpas>;
+		compatible = "qcom,cam-jpeg";
+		compat-hw-name = "qcom,jpegenc",
+			"qcom,jpegdma";
+		num-jpeg-enc = <1>;
+		num-jpeg-dma = <1>;
+
+		cam_jpeg_enc: qcom,jpegenc@ac4e000 {
+			cell-index = <0>;
+			compatible = "qcom,cam_jpeg_enc";
+			reg-names = "jpege_hw";
+			reg = <0 0xac4e000 0 0x4000>;
+			reg-cam-base = <0x4e000>;
+			interrupt-names = "cam-jpeg-enc";
+			interrupts = <GIC_SPI 474 IRQ_TYPE_EDGE_RISING>;
+			clock-names = "camera_ahb",
+				"camera_axi",
+				"soc_ahb_clk",
+				"cpas_ahb_clk",
+				"camnoc_axi_clk",
+				"jpegenc_clk_src",
+				"jpegenc_clk";
+			clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+				<&camcc GCC_CAMERA_HF_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_JPEG_CLK_SRC>,
+				<&camcc CAM_CC_JPEG_CLK>;
+
+			clock-rates = <0 0 0 0 0 600000000 0>;
+			src-clock-name = "jpegenc_clk_src";
+			clock-cntl-level = "turbo";
+		};
+
+		cam_jpeg_dma: qcom,jpegdma@ac52000 {
+			cell-index = <0>;
+			compatible = "qcom,cam_jpeg_dma";
+			reg-names = "jpegdma_hw";
+			reg = <0 0xac52000 0 0x4000>;
+			reg-cam-base = <0x52000>;
+			interrupt-names = "cam-jpeg-dma";
+			interrupts = <GIC_SPI 475 IRQ_TYPE_EDGE_RISING>;
+			clock-names = "camera_ahb",
+				"camera_axi",
+				"soc_ahb_clk",
+				"cpas_ahb_clk",
+				"camnoc_axi_clk",
+				"jpegdma_clk_src",
+				"jpegdma_clk";
+			clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+				<&camcc GCC_CAMERA_HF_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_JPEG_CLK_SRC>,
+				<&camcc CAM_CC_JPEG_CLK>;
+
+			clock-rates = <0 0 0 0 0 600000000 0>;
+			src-clock-name = "jpegdma_clk_src";
+			clock-cntl-level = "turbo";
+		};
+	};
+
+	cam_lrme_mgr: qcom,cam-lrme {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		cpas_intf = <&cpas>;
+		compatible = "qcom,cam-lrme";
+		arch-compat = "lrme";
+
+		cam_lrme: qcom,lrme@ac6b000 {
+			cell-index = <0>;
+			compatible = "qcom,lrme";
+			reg-names = "lrme";
+			reg = <0 0xac6b000 0 0x1000>;
+			reg-cam-base = <0x6b000>;
+			interrupt-names = "lrme";
+			interrupts = <GIC_SPI 476 IRQ_TYPE_EDGE_RISING>;
+			clock-names = "camera_ahb",
+				"camera_axi",
+				"soc_ahb_clk",
+				"cpas_ahb_clk",
+				"camnoc_axi_clk",
+				"lrme_clk_src",
+				"lrme_clk";
+			clocks = <&camcc GCC_CAMERA_AHB_CLK>,
+				<&camcc GCC_CAMERA_HF_AXI_CLK>,
+				<&camcc CAM_CC_SOC_AHB_CLK>,
+				<&camcc CAM_CC_CPAS_AHB_CLK>,
+				<&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				<&camcc CAM_CC_LRME_CLK_SRC>,
+				<&camcc CAM_CC_LRME_CLK>;
+			clock-rates =
+				<0 0 0 0 0 200000000 200000000>,
+				<0 0 0 0 0 216000000 216000000>,
+				<0 0 0 0 0 300000000 300000000>,
+				<0 0 0 0 0 404000000 404000000>,
+				<0 0 0 0 0 404000000 404000000>,
+				<0 0 0 0 0 404000000 404000000>;
+			clock-cntl-level = "lowsvs", "svs", "svs_l1", "nominal",
+					"nominal_l1", "turbo";
+			src-clock-name = "lrme_clk_src";
+		};
+	};
+
+	cam_cci0: qcom,cci@ac4a000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		cell-index = <0>;
+		cpas_intf = <&cpas>;
+		compatible = "qcom,cci";
+		reg = <0 0xac4a000 0 0x1000>;
+		reg-names = "cci";
+		reg-cam-base = <0 0x4a000>;
+		interrupt-names = "cam-cci0";
+		interrupts = <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+			<&camcc CAM_CC_SOC_AHB_CLK>,
+			<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+			<&camcc CAM_CC_CPAS_AHB_CLK>,
+			<&camcc CAM_CC_CCI_0_CLK>,
+			<&camcc CAM_CC_CCI_0_CLK_SRC>;
+		clock-names = "camnoc_axi_clk",
+			"soc_ahb_clk",
+			"slow_ahb_src_clk",
+			"cpas_ahb_clk",
+			"cci_clk",
+			"cci_clk_src";
+		src-clock-name = "cci_clk_src";
+		clock-cntl-level = "lowsvs";
+		clock-rates = <0 0 0 0 0 37500000>;
+
+		i2c_freq_100Khz: qcom,i2c_standard_mode {
+			hw-thigh = <201>;
+			hw-tlow = <174>;
+			hw-tsu-sto = <204>;
+			hw-tsu-sta = <231>;
+			hw-thd-dat = <22>;
+			hw-thd-sta = <162>;
+			hw-tbuf = <227>;
+			hw-scl-stretch-en = <0>;
+			hw-trdhld = <6>;
+			hw-tsp = <3>;
+			cci-clk-src = <37500000>;
+		};
+
+		i2c_freq_400Khz: qcom,i2c_fast_mode {
+			hw-thigh = <38>;
+			hw-tlow = <56>;
+			hw-tsu-sto = <40>;
+			hw-tsu-sta = <40>;
+			hw-thd-dat = <22>;
+			hw-thd-sta = <35>;
+			hw-tbuf = <62>;
+			hw-scl-stretch-en = <0>;
+			hw-trdhld = <6>;
+			hw-tsp = <3>;
+			cci-clk-src = <37500000>;
+		};
+
+		i2c_freq_custom: qcom,i2c_custom_mode {
+			hw-thigh = <38>;
+			hw-tlow = <56>;
+			hw-tsu-sto = <40>;
+			hw-tsu-sta = <40>;
+			hw-thd-dat = <22>;
+			hw-thd-sta = <35>;
+			hw-tbuf = <62>;
+			hw-scl-stretch-en = <1>;
+			hw-trdhld = <6>;
+			hw-tsp = <3>;
+			cci-clk-src = <37500000>;
+		};
+
+		i2c_freq_1Mhz: qcom,i2c_fast_plus_mode {
+			hw-thigh = <16>;
+			hw-tlow = <22>;
+			hw-tsu-sto = <17>;
+			hw-tsu-sta = <18>;
+			hw-thd-dat = <16>;
+			hw-thd-sta = <15>;
+			hw-tbuf = <24>;
+			hw-scl-stretch-en = <0>;
+			hw-trdhld = <3>;
+			hw-tsp = <3>;
+			cci-clk-src = <37500000>;
+		};
+	};
+
+	cam_cci1: qcom,cci@ac4b000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		cell-index = <1>;
+		cpas_intf = <&cpas>;
+		compatible = "qcom,cci";
+		reg = <0 0xac4b000 0 0x1000>;
+		reg-names = "cci";
+		reg-cam-base = <0 0x4b000>;
+		interrupt-names = "cam-cci1";
+		interrupts = <GIC_SPI 462 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+			<&camcc CAM_CC_SOC_AHB_CLK>,
+			<&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+			<&camcc CAM_CC_CPAS_AHB_CLK>,
+			<&camcc CAM_CC_CCI_1_CLK>,
+			<&camcc CAM_CC_CCI_1_CLK_SRC>;
+		clock-names = "camnoc_axi_clk",
+			"soc_ahb_clk",
+			"slow_ahb_src_clk",
+			"cpas_ahb_clk",
+			"cci_clk",
+			"cci_clk_src";
+		src-clock-name = "cci_clk_src";
+		clock-cntl-level = "lowsvs";
+		clock-rates = <0 0 0 0 0 37500000>;
+
+		i2c_freq_100Khz_cci1: qcom,i2c_standard_mode {
+			hw-thigh = <201>;
+			hw-tlow = <174>;
+			hw-tsu-sto = <204>;
+			hw-tsu-sta = <231>;
+			hw-thd-dat = <22>;
+			hw-thd-sta = <162>;
+			hw-tbuf = <227>;
+			hw-scl-stretch-en = <0>;
+			hw-trdhld = <6>;
+			hw-tsp = <3>;
+			cci-clk-src = <37500000>;
+		};
+
+		i2c_freq_400Khz_cci1: qcom,i2c_fast_mode {
+			hw-thigh = <38>;
+			hw-tlow = <56>;
+			hw-tsu-sto = <40>;
+			hw-tsu-sta = <40>;
+			hw-thd-dat = <22>;
+			hw-thd-sta = <35>;
+			hw-tbuf = <62>;
+			hw-scl-stretch-en = <0>;
+			hw-trdhld = <6>;
+			hw-tsp = <3>;
+			cci-clk-src = <37500000>;
+		};
+
+		i2c_freq_custom_cci1: qcom,i2c_custom_mode {
+			hw-thigh = <38>;
+			hw-tlow = <56>;
+			hw-tsu-sto = <40>;
+			hw-tsu-sta = <40>;
+			hw-thd-dat = <22>;
+			hw-thd-sta = <35>;
+			hw-tbuf = <62>;
+			hw-scl-stretch-en = <1>;
+			hw-trdhld = <6>;
+			hw-tsp = <3>;
+			cci-clk-src = <37500000>;
+		};
+
+		i2c_freq_1Mhz_cci1: qcom,i2c_fast_plus_mode {
+			hw-thigh = <16>;
+			hw-tlow = <22>;
+			hw-tsu-sto = <17>;
+			hw-tsu-sta = <18>;
+			hw-thd-dat = <16>;
+			hw-thd-sta = <15>;
+			hw-tbuf = <24>;
+			hw-scl-stretch-en = <0>;
+			hw-trdhld = <3>;
+			hw-tsp = <3>;
+			cci-clk-src = <37500000>;
+		};
+	};
+
+	qcom,cam-res-mgr {
+		compatible = "qcom,cam-res-mgr";
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
new file mode 100644
index 000000000000..027d6d563a5f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Gelarshie board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7180-trogdor-gelarshie.dtsi"
+
+/ {
+	model = "Google Gelarshie (rev0+)";
+	compatible = "google,gelarshie", "qcom,sc7180";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
new file mode 100644
index 000000000000..502aa70fe1f3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Gelarshie board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7180.dtsi"
+#include "sc7180-trogdor-mipi-camera.dtsi"
+
+ap_ec_spi: &spi6 {};
+ap_h1_spi: &spi0 {};
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
+
+/* Deleted nodes from trogdor.dtsi */
+
+/delete-node/ &alc5682;
+/delete-node/ &pp3300_codec;
+
+/ {
+	/* BOARD-SPECIFIC TOP LEVEL NODES */
+
+	adau7002: audio-codec-1 {
+		compatible = "adi,adau7002";
+		IOVDD-supply = <&pp1800_l15a>;
+		wakeup-delay-ms = <80>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&backlight {
+	pwms = <&cros_ec_pwm 0>;
+};
+
+&camcc {
+	status = "okay";
+};
+
+&cros_ec {
+	cros_ec_proximity: proximity {
+		compatible = "google,cros-ec-mkbp-proximity";
+		label = "proximity-wifi";
+	};
+};
+
+ap_ts_pen_1v8: &i2c4 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@5d {
+		compatible = "goodix,gt7375p";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+
+		vdd-supply = <&pp3300_ts>;
+	};
+};
+
+&i2c7 {
+	status = "disabled";
+};
+
+&i2c9 {
+	status = "disabled";
+};
+
+&panel {
+	compatible = "edp-panel";
+};
+
+&pp1800_uf_cam {
+	status = "okay";
+};
+
+&pp1800_wf_cam {
+	status = "okay";
+};
+
+&pp2800_uf_cam {
+	status = "okay";
+};
+
+&pp2800_wf_cam {
+	status = "okay";
+};
+
+&pp3300_dx_edp {
+	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
+};
+
+&sdhc_2 {
+	status = "okay";
+};
+
+&sn65dsi86_out {
+	data-lanes = <0 1 2 3>;
+};
+
+&sound {
+	compatible = "google,sc7180-gelarshie";
+	model = "sc7180-adau7002-max98357a";
+	audio-routing = "PDM_DAT", "DMIC";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dmic_clk_en>;
+};
+
+&sound_multimedia0_codec {
+	sound-dai = <&adau7002>;
+};
+
+/* PINCTRL - modifications to sc7180-trogdor.dtsi */
+
+&en_pp3300_dx_edp {
+	pinmux  {
+		pins = "gpio67";
+	};
+
+	pinconf {
+		pins = "gpio67";
+	};
+};
+
+&ts_reset_l {
+	pinconf {
+		/*
+		 * We want reset state by default and it will be up to the
+		 * driver to disable this when it's ready.
+		 */
+		output-low;
+	};
+};
+
+/* PINCTRL - board-specific pinctrl */
+
+&tlmm {
+	gpio-line-names = "HUB_RST_L",
+			  "AP_RAM_ID0",
+			  "AP_SKU_ID2",
+			  "AP_RAM_ID1",
+			  "WF_CAM_EN2",
+			  "AP_RAM_ID2",
+			  "UF_CAM_EN",
+			  "WF_CAM_EN",
+			  "TS_RESET_L",
+			  "TS_INT_L",
+			  "",
+			  "EDP_BRIJ_IRQ",
+			  "AP_EDP_BKLTEN",
+			  "UF_CAM_MCLK",
+			  "WF_CAM_MCLK",
+			  "EDP_BRIJ_I2C_SDA",
+			  "EDP_BRIJ_I2C_SCL",
+			  "UF_CAM_SDA",
+			  "UF_CAM_SCL",
+			  "WF_CAM_SDA",
+			  "WF_CAM_SCL",
+			  "",
+			  "",
+			  "AMP_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "WF_CAM_RST_L",
+			  "UF_CAM_RST_L",
+			  "AP_BRD_ID2",
+			  "BRIJ_SUSPEND",
+			  "AP_BRD_ID0",
+			  "AP_H1_SPI_MISO",
+			  "AP_H1_SPI_MOSI",
+			  "AP_H1_SPI_CLK",
+			  "AP_H1_SPI_CS_L",
+			  "BT_UART_CTS",
+			  "BT_UART_RTS",
+			  "BT_UART_TXD",
+			  "BT_UART_RXD",
+			  "H1_AP_INT_ODL",
+			  "",
+			  "UART_AP_TX_DBG_RX",
+			  "UART_DBG_TX_AP_RX",
+			  "",
+			  "",
+			  "FORCED_USB_BOOT",
+			  "AMP_BCLK",
+			  "AMP_LRCLK",
+			  "AMP_DIN",
+			  "",
+			  "HP_BCLK",
+			  "HP_LRCLK",
+			  "HP_DOUT",
+			  "",
+			  "",
+			  "AP_SKU_ID0",
+			  "AP_EC_SPI_MISO",
+			  "AP_EC_SPI_MOSI",
+			  "AP_EC_SPI_CLK",
+			  "AP_EC_SPI_CS_L",
+			  "AP_SPI_CLK",
+			  "AP_SPI_MOSI",
+			  "AP_SPI_MISO",
+			  /*
+			   * AP_FLASH_WP_L is crossystem ABI. Schematics
+			   * call it BIOS_FLASH_WP_L.
+			   */
+			  "AP_FLASH_WP_L",
+			  "EN_PP3300_DX_EDP",
+			  "AP_SPI_CS0_L",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "WLAN_SW_CTRL",
+			  "BOOT_CONFIG_0",
+			  "REPORT_SWITCH",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "DMIC_CLK_EN",
+			  "HUB_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AP_SKU_ID1",
+			  "AP_RST_REQ",
+			  "",
+			  "AP_BRD_ID1",
+			  "AP_EC_INT_L",
+			  "BOOT_CONFIG_1",
+			  "",
+			  "",
+			  "BOOT_CONFIG_4",
+			  "BOOT_CONFIG_2",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "EDP_BRIJ_EN",
+			  "",
+			  "",
+			  "BOOT_CONFIG_3",
+			  "WCI2_LTE_COEX_TXD",
+			  "WCI2_LTE_COEX_RXD",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "FORCED_USB_BOOT_POL",
+			  "AP_TS_PEN_I2C_SDA",
+			  "AP_TS_PEN_I2C_SCL",
+			  "DP_HOT_PLUG_DET",
+			  "EC_IN_RW_ODL";
+
+	dmic_clk_en: dmic_clk_en {
+		pinmux {
+			pins = "gpio83";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio83";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mipi-camera.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mipi-camera.dtsi
new file mode 100644
index 000000000000..df8da987ecf3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mipi-camera.dtsi
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "sc7180-camera.dtsi"
+
+&tlmm {
+	cci0_active: cci0_active {
+		mux {
+			/* DATA, CLK */
+			pins = "gpio17", "gpio18";
+			function = "cci_i2c";
+		};
+		config {
+			pins = "gpio17", "gpio18";
+			bias-pull-up; /* PULL UP */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cci0_suspend: cci0_suspend {
+		mux {
+			/* DATA, CLK */
+			pins = "gpio17", "gpio18";
+			function = "cci_i2c";
+		};
+		config {
+			pins = "gpio17", "gpio18";
+			bias-pull-down; /* PULL DOWN */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cci1_active: cci1_active {
+		mux {
+			/* DATA, CLK */
+			pins = "gpio19", "gpio20";
+			function = "cci_i2c";
+		};
+		config {
+			pins = "gpio19", "gpio20";
+			bias-pull-up; /* PULL UP */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cci1_suspend: cci1_suspend {
+		mux {
+			/* DATA, CLK */
+			pins = "gpio19", "gpio20";
+			function = "cci_i2c";
+		};
+		config {
+			pins = "gpio19", "gpio20";
+			bias-pull-down; /* PULL DOWN */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cam_sensor_mclk0_active: cam_sensor_mclk0_active {
+		/* MCLK0 */
+		mux {
+			pins = "gpio13";
+			function = "cam_mclk";
+		};
+		config {
+			pins = "gpio13";
+			bias-disable; /* No PULL */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cam_sensor_mclk0_suspend: cam_sensor_mclk0_suspend {
+		/* MCLK0 */
+		mux {
+			pins = "gpio13";
+			function = "cam_mclk";
+		};
+		config {
+			pins = "gpio13";
+			bias-pull-down; /* PULL DOWN */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cam_sensor_rear_active: cam_sensor_rear_active {
+		/* RESET */
+		mux {
+			pins = "gpio29";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio29";
+			bias-disable; /* No PULL */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cam_sensor_rear_suspend: cam_sensor_rear_suspend {
+		/* RESET */
+		mux {
+			pins = "gpio29";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio29";
+			bias-pull-down; /* PULL DOWN */
+			drive-strength = <2>; /* 2 MA */
+			output-low;
+		};
+	};
+
+	cam_sensor_front_active: cam_sensor_front_active {
+		/* RESET  */
+		mux {
+			pins = "gpio30";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio30";
+			bias-disable; /* No PULL */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cam_sensor_front_suspend: cam_sensor_front_suspend {
+		/* RESET */
+		mux {
+			pins = "gpio30";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio30";
+			bias-pull-down; /* PULL DOWN */
+			drive-strength = <2>; /* 2 MA */
+			output-low;
+		};
+	};
+
+	cam_sensor_mclk1_active: cam_sensor_mclk1_active {
+		/* MCLK1 */
+		mux {
+			pins = "gpio14";
+			function = "cam_mclk";
+		};
+		config {
+			pins = "gpio14";
+			bias-disable; /* No PULL */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cam_sensor_mclk1_suspend: cam_sensor_mclk1_suspend {
+		/* MCLK1 */
+		mux {
+			pins = "gpio14";
+			function = "cam_mclk";
+		};
+		config {
+			pins = "gpio14";
+			bias-pull-down; /* PULL DOWN */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cam_sensor_standby0_active: cam_sensor_standby0_active {
+		/* STANDBY0 */
+		mux {
+			pins = "gpio6";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio6";
+			bias-disable; /* No PULL */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cam_sensor_standby0_suspend: cam_sensor_standby0_suspend {
+		/* STANDBY0 */
+		mux {
+			pins = "gpio6";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio6";
+			bias-pull-down; /* PULL DOWN */
+			drive-strength = <2>; /* 2 MA */
+			output-low;
+		};
+	};
+
+	cam_sensor_standby1_active: cam_sensor_standby1_active {
+		/* STANDBY1 */
+		mux {
+			pins = "gpio7";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio7";
+			bias-disable; /* No PULL */
+			drive-strength = <2>; /* 2 MA */
+		};
+	};
+
+	cam_sensor_standby1_suspend: cam_sensor_standby1_suspend {
+		/* STANDBY1 */
+		mux {
+			pins = "gpio7";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio7";
+			bias-pull-down; /* PULL DOWN */
+			drive-strength = <2>; /* 2 MA */
+			output-low;
+		};
+	};
+};
+
+&cam_cci0 {
+
+	pinctrl-names = "cam_default", "cam_suspend";
+	pinctrl-0 = <&cci0_active &cci1_active>;
+	pinctrl-1 = <&cci0_suspend &cci1_suspend>;
+	gpios = <&tlmm 17 0>,
+		<&tlmm 18 0>,
+		<&tlmm 19 0>,
+		<&tlmm 20 0>;
+	gpio-req-tbl-num = <0 1 2 3>;
+	gpio-req-tbl-flags = <1 1 1 1>;
+	gpio-req-tbl-label = "CCI_I2C_DATA0",
+		"CCI_I2C_CLK0",
+		"CCI_I2C_DATA1",
+		"CCI_I2C_CLK1";
+
+	actuator_rear: qcom,actuator@0 {
+		cell-index = <1>;
+		compatible = "qcom,actuator";
+		cam_vaf-supply = <&pp2800_vcm_wf_cam>;
+		regulator-names = "cam_vaf";
+		rgltr-cntrl-support;
+		rgltr-min-voltage = <2850000>;
+		rgltr-max-voltage = <2850000>;
+		rgltr-load-current = <0>;
+		cci-device = <0>;
+		cci-master = <1>;
+	};
+
+	eeprom_rear: qcom,eeprom@0 {
+		cell-index = <1>;
+		compatible = "qcom,eeprom";
+		cam_vio-supply = <&pp1800_wf_cam>;
+		regulator-names = "cam_vio";
+		rgltr-cntrl-support;
+		rgltr-min-voltage = <1800000>;
+		rgltr-max-voltage = <1800000>;
+		rgltr-load-current = <0>;
+		gpio-no-mux = <0>;
+		pinctrl-names = "cam_default", "cam_suspend";
+		pinctrl-0 = <&cam_sensor_rear_active
+			&cam_sensor_mclk1_active>;
+		pinctrl-1 = <&cam_sensor_rear_suspend
+			&cam_sensor_mclk1_suspend>;
+		gpios = <&tlmm 29 0>,
+			<&tlmm 14 0>;
+		gpio-reset = <0>;
+		gpio-req-tbl-num = <0 1>;
+		gpio-req-tbl-flags = <0 1>;
+		gpio-req-tbl-label = "CAM_RESET1",
+					"CAMIF_MCLK1";
+		sensor-mode = <0>;
+		cci-device = <0>;
+		cci-master = <1>;
+		status = "ok";
+		clocks = <&camcc CAM_CC_MCLK1_CLK>;
+		clock-names = "cam_clk";
+		clock-cntl-level = "turbo";
+		clock-rates = <24000000>;
+
+		i2c-address = <0x58>;
+		memory-bytes = <10240>;
+		address-bits = <16>;
+	};
+
+	eeprom_front: qcom,eeprom@1 {
+		cell-index = <0>;
+		compatible = "qcom,eeprom";
+		cam_vio-supply = <&pp1800_uf_cam>;
+		regulator-names = "cam_vio";
+		rgltr-cntrl-support;
+		rgltr-min-voltage = <1800000>;
+		rgltr-max-voltage = <1800000>;
+		rgltr-load-current = <0>;
+		gpio-no-mux = <0>;
+		pinctrl-names = "cam_default", "cam_suspend";
+		pinctrl-0 = <&cam_sensor_front_active
+			&cam_sensor_mclk0_active>;
+		pinctrl-1 = <&cam_sensor_front_suspend
+			&cam_sensor_mclk0_suspend>;
+		gpios = <&tlmm 30 0>,
+			<&tlmm 13 0>;
+		gpio-reset = <0>;
+		gpio-req-tbl-num = <0 1>;
+		gpio-req-tbl-flags = <0 1>;
+		gpio-req-tbl-label = "CAM_RESET0",
+					"CAMIF_MCLK0";
+		sensor-mode = <0>;
+		cci-device = <0>;
+		cci-master = <0>;
+		status = "ok";
+		clocks = <&camcc CAM_CC_MCLK0_CLK>;
+		clock-names = "cam_clk";
+		clock-cntl-level = "turbo";
+		clock-rates = <24000000>;
+
+		i2c-address = <0x50>;
+		memory-bytes = <8192>;
+		address-bits = <16>;
+	};
+
+	qcom,cam-sensor@0 {
+		cell-index = <1>;
+		compatible = "qcom,cam-sensor";
+		csiphy-sd-index = <1>;
+		sensor-position-roll = <90>;
+		sensor-position-pitch = <0>;
+		sensor-position-yaw = <180>;
+		eeprom-src = <&eeprom_rear>;
+		actuator-src = <&actuator_rear>;
+		power-domains = <&camcc TITAN_TOP_GDSC>;
+		cam_vio-supply = <&pp1800_wf_cam>;
+		regulator-names = "cam_vio";
+		rgltr-cntrl-support;
+		rgltr-min-voltage = <1800000>;
+		rgltr-max-voltage = <1800000>;
+		rgltr-load-current = <0>;
+		gpio-no-mux = <0>;
+		pinctrl-names = "cam_default", "cam_suspend";
+		pinctrl-0 = <&cam_sensor_rear_active
+			&cam_sensor_mclk1_active>;
+		pinctrl-1 = <&cam_sensor_rear_suspend
+			&cam_sensor_mclk1_suspend>;
+		gpios = <&tlmm 29 0>,
+			<&tlmm 14 0>;
+		gpio-reset = <0>;
+		gpio-req-tbl-num = <0 1>;
+		gpio-req-tbl-flags = <0 1>;
+		gpio-req-tbl-label = "CAM_RESET1",
+					"CAMIF_MCLK1";
+		sensor-mode = <0>;
+		cci-device = <0>;
+		cci-master = <1>;
+		clocks = <&camcc CAM_CC_MCLK1_CLK>;
+		clock-names = "cam_clk";
+		clock-cntl-level = "turbo";
+		clock-rates = <24000000>;
+	};
+
+	qcom,cam-sensor@1 {
+		cell-index = <0>;
+		compatible = "qcom,cam-sensor";
+		csiphy-sd-index = <0>;
+		sensor-position-roll = <90>;
+		sensor-position-pitch = <0>;
+		sensor-position-yaw = <180>;
+		eeprom-src = <&eeprom_front>;
+		power-domains = <&camcc TITAN_TOP_GDSC>;
+		cam_vio-supply = <&pp1800_uf_cam>;
+		regulator-names = "cam_vio";
+		rgltr-cntrl-support;
+		rgltr-min-voltage = <1800000>;
+		rgltr-max-voltage = <1800000>;
+		rgltr-load-current = <0>;
+		gpio-no-mux = <0>;
+		pinctrl-names = "cam_default", "cam_suspend";
+		pinctrl-0 = <&cam_sensor_front_active
+			&cam_sensor_mclk0_active>;
+		pinctrl-1 = <&cam_sensor_front_suspend
+			&cam_sensor_mclk0_suspend>;
+		gpios = <&tlmm 30 0>,
+			<&tlmm 13 0>;
+		gpio-reset = <0>;
+		gpio-req-tbl-num = <0 1>;
+		gpio-req-tbl-flags = <0 1>;
+		gpio-req-tbl-label = "CAM_RESET0",
+					"CAMIF_MCLK0";
+		sensor-mode = <0>;
+		cci-device = <0>;
+		cci-master = <0>;
+		clocks = <&camcc CAM_CC_MCLK0_CLK>;
+		clock-names = "cam_clk";
+		clock-cntl-level = "turbo";
+		clock-rates = <24000000>;
+	};
+};
+
+&cam_cci1 {
+	pinctrl-names = "cam_default", "cam_suspend";
+	gpios = <&tlmm 27 0>,
+		<&tlmm 28 0>;
+	gpio-req-tbl-num = <0 1>;
+	gpio-req-tbl-flags = <1 1>;
+	gpio-req-tbl-label = "CCI_I2C_DATA2",
+				"CCI_I2C_CLK2";
+};
-- 
2.31.0

