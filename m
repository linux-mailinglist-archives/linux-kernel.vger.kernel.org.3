Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5457CEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiGUPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiGUPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:30:17 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39220D9D;
        Thu, 21 Jul 2022 08:30:11 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LFIMDr006815;
        Thu, 21 Jul 2022 17:29:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=6G9UfE0wFCTuuFaKCQKQnT0MV0TreW/ELTGxWMqwGZg=;
 b=lNZevbAfDC71CHhZ+rScxpbk81xn9P2iYTQkoHq6bmxTuFuuKoXtW/zGzexp7PGQ1ZVV
 6rkzoXVilm+EEEiCBd5pdjtxtQrd7veFiAG7Uey/rto71F0reJS3ItzYWAmdNMTeMX+e
 8jj6dvxdXHEyGmkEPO1cJsBGX+mc1bPwbDxjycnPoYMSYRyjsVToQxbkoK75ixXAMELB
 lNgxjEEFlTRloDzrnVAm2oupV2PEip19V1vrPHO4U3kiYqulJzp9Yjanp58AvZYEtIPo
 GAYMvhUimGyvTlkD36lG6gA4EU8Vk3VjflaTpzQz5cUe8EEaxRu5UrcU/O95ZC5g02ra Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hbnp6du3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 17:29:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7B328100034;
        Thu, 21 Jul 2022 17:29:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7673C226FCB;
        Thu, 21 Jul 2022 17:29:52 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 21 Jul
 2022 17:29:52 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <alexandre.torgue@foss.st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: add i2c nodes into stm32mp131.dtsi
Date:   Thu, 21 Jul 2022 17:29:32 +0200
Message-ID: <20220721152933.3805272-2-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721152933.3805272-1-alain.volmat@foss.st.com>
References: <20220721152933.3805272-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 5 instances of i2c busses supported by the stm32mp131.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 90 +++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 3a921db23e9f..da9e8a6ca663 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -106,6 +106,42 @@ uart4: serial@40010000 {
 			status = "disabled";
 		};
 
+		i2c1: i2c@40012000 {
+			compatible = "st,stm32mp13-i2c";
+			reg = <0x40012000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C1_K>;
+			resets = <&rcc I2C1_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&dmamux1 33 0x400 0x1>,
+			       <&dmamux1 34 0x400 0x1>;
+			dma-names = "rx", "tx";
+			st,syscfg-fmp = <&syscfg 0x4 0x1>;
+			i2c-analog-filter;
+			status = "disabled";
+		};
+
+		i2c2: i2c@40013000 {
+			compatible = "st,stm32mp13-i2c";
+			reg = <0x40013000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C2_K>;
+			resets = <&rcc I2C2_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&dmamux1 35 0x400 0x1>,
+			       <&dmamux1 36 0x400 0x1>;
+			dma-names = "rx", "tx";
+			st,syscfg-fmp = <&syscfg 0x4 0x2>;
+			i2c-analog-filter;
+			status = "disabled";
+		};
+
 		dma1: dma-controller@48000000 {
 			compatible = "st,stm32-dma";
 			reg = <0x48000000 0x400>;
@@ -153,6 +189,60 @@ dmamux1: dma-router@48002000 {
 			dma-channels = <16>;
 		};
 
+		i2c3: i2c@4c004000 {
+			compatible = "st,stm32mp13-i2c";
+			reg = <0x4c004000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C3_K>;
+			resets = <&rcc I2C3_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&dmamux1 73 0x400 0x1>,
+			       <&dmamux1 74 0x400 0x1>;
+			dma-names = "rx", "tx";
+			st,syscfg-fmp = <&syscfg 0x4 0x4>;
+			i2c-analog-filter;
+			status = "disabled";
+		};
+
+		i2c4: i2c@4c005000 {
+			compatible = "st,stm32mp13-i2c";
+			reg = <0x4c005000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C4_K>;
+			resets = <&rcc I2C4_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&dmamux1 75 0x400 0x1>,
+			       <&dmamux1 76 0x400 0x1>;
+			dma-names = "rx", "tx";
+			st,syscfg-fmp = <&syscfg 0x4 0x8>;
+			i2c-analog-filter;
+			status = "disabled";
+		};
+
+		i2c5: i2c@4c006000 {
+			compatible = "st,stm32mp13-i2c";
+			reg = <0x4c006000 0x400>;
+			interrupt-names = "event", "error";
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc I2C5_K>;
+			resets = <&rcc I2C5_R>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dmas = <&dmamux1 115 0x400 0x1>,
+			       <&dmamux1 116 0x400 0x1>;
+			dma-names = "rx", "tx";
+			st,syscfg-fmp = <&syscfg 0x4 0x10>;
+			i2c-analog-filter;
+			status = "disabled";
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp13-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
2.25.1

