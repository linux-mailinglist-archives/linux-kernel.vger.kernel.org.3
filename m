Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956E257FA85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiGYHxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiGYHxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:53:36 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8512AE5;
        Mon, 25 Jul 2022 00:53:31 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P7FAfq006153;
        Mon, 25 Jul 2022 09:53:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Vb8EkYSSUZFwx6sbEAsT+sFdunEBMDnEHPfyas+LZGs=;
 b=h6ym6qS4kdym6XlOdMjSJCHKxUSFZW38xEVIKBSf+nejDRvPBtzrEDRk4vCc0MAJDzi5
 ne6UN8z2rWPMjCRrqzyuiLl0Sjw0hnKP69TQsTeu5+qxQLNyHMjXn/IxWw0OvZ9dyT0Y
 8b+vTBn6lTmNagNWTKMFn/lqsypbZ56yifbJwqC55cfXWrQWc8oNwaBiuZPebabwummA
 +/Ryt0kDB2sriruDh1VooNtLx36FsTp77JkmRtxqT2N6ooAfKxiCu4pE492xts9RWhuv
 AECrz8pIVOe/rBiSv2q+Besiv4D+FFa13K2h6M7kaekmPJlTypf00tsyOwqoxKyada3J ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hg8b0qu3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 09:53:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DB1F100038;
        Mon, 25 Jul 2022 09:53:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 17A152122FA;
        Mon, 25 Jul 2022 09:53:19 +0200 (CEST)
Received: from localhost (10.75.127.51) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 25 Jul
 2022 09:53:18 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <alexandre.torgue@foss.st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 1/2] ARM: dts: stm32: add spi nodes into stm32mp131.dtsi
Date:   Mon, 25 Jul 2022 09:52:54 +0200
Message-ID: <20220725075255.429869-2-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725075255.429869-1-alain.volmat@foss.st.com>
References: <20220725075255.429869-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-23_02,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 5 instances of spi busses supported by the stm32mp131.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index da9e8a6ca663..dd35a607073d 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -97,6 +97,34 @@ scmi_shm: scmi-sram@0 {
 			};
 		};
 
+		spi2: spi@4000b000 {
+			compatible = "st,stm32h7-spi";
+			reg = <0x4000b000 0x400>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI2_K>;
+			resets = <&rcc SPI2_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&dmamux1 39 0x400 0x01>,
+			       <&dmamux1 40 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi3: spi@4000c000 {
+			compatible = "st,stm32h7-spi";
+			reg = <0x4000c000 0x400>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI3_K>;
+			resets = <&rcc SPI3_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&dmamux1 61 0x400 0x01>,
+			       <&dmamux1 62 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		uart4: serial@40010000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40010000 0x400>;
@@ -142,6 +170,20 @@ i2c2: i2c@40013000 {
 			status = "disabled";
 		};
 
+		spi1: spi@44004000 {
+			compatible = "st,stm32h7-spi";
+			reg = <0x44004000 0x400>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI1_K>;
+			resets = <&rcc SPI1_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&dmamux1 37 0x400 0x01>,
+			       <&dmamux1 38 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		dma1: dma-controller@48000000 {
 			compatible = "st,stm32-dma";
 			reg = <0x48000000 0x400>;
@@ -189,6 +231,34 @@ dmamux1: dma-router@48002000 {
 			dma-channels = <16>;
 		};
 
+		spi4: spi@4c002000 {
+			compatible = "st,stm32h7-spi";
+			reg = <0x4c002000 0x400>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI4_K>;
+			resets = <&rcc SPI4_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&dmamux1 83 0x400 0x01>,
+			       <&dmamux1 84 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi5: spi@4c003000 {
+			compatible = "st,stm32h7-spi";
+			reg = <0x4c003000 0x400>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc SPI5_K>;
+			resets = <&rcc SPI5_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&dmamux1 85 0x400 0x01>,
+			       <&dmamux1 86 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		i2c3: i2c@4c004000 {
 			compatible = "st,stm32mp13-i2c";
 			reg = <0x4c004000 0x400>;
-- 
2.25.1

