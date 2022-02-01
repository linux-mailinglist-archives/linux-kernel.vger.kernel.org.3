Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C325D4A60FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbiBAQHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:07:38 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41060 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234704AbiBAQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:07:36 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211C8U55030249;
        Tue, 1 Feb 2022 17:05:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=+MgA2PGfKilYlKlF4j5XzOprcEc+NIN/71Kfe0zvpIk=;
 b=b6Y6VzMQrNAMwkOD6o1ix8cv/W+ff5kzGDEJ4f4Ubu+DfjAViPt+KYZCRjdQmmJi7a1t
 xPiV8Dg8sCZtFdXN6B9CYHIiAyTklzYeTPhRbg3iE2dDsjFumUMRerZ4XVAYQh5pWlA4
 RvlThCizF9+lAgeDqvjkVBsHL8g55aHU8bbqWmDtc3Vxa4oKp/j5v0+E6MJP5yBZA5bv
 uQBnk+6JgjaP9CQgdaCxNz5EQ6Hsw210Nu8hAwS5AtsQPtStLjthf2zP5A3m4LxLg3s5
 hM4OSqc4XbRORGDULQiVg6CRFOMC6L7HwE5LM+Ir9p7BDSCEyb6Z5Xo/g4CrjDG6yTYG mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dxk0rx0w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 17:05:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 010A4100038;
        Tue,  1 Feb 2022 17:05:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC3CA226FA9;
        Tue,  1 Feb 2022 17:05:14 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 1 Feb 2022 17:05:14
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: add DMA1, DMA2 and DMAMUX1 on STM32MP13x SoC family
Date:   Tue, 1 Feb 2022 17:05:05 +0100
Message-ID: <20220201160506.348701-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201160506.348701-1-amelie.delaunay@foss.st.com>
References: <20220201160506.348701-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_08,2022-02-01_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA1 and DMA2 on STM32MP13x SoCs are the same than on STM32MP15x SoCs: they
offer up to 8 channels and request lines are routed through DMAMUX1.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 86126dc0d898..e64fa10ac245 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -115,6 +115,50 @@ uart4: serial@40010000 {
 			status = "disabled";
 		};
 
+		dma1: dma-controller@48000000 {
+			compatible = "st,stm32-dma";
+			reg = <0x48000000 0x400>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_pclk4>;
+			#dma-cells = <4>;
+			st,mem2mem;
+			dma-requests = <8>;
+		};
+
+		dma2: dma-controller@48001000 {
+			compatible = "st,stm32-dma";
+			reg = <0x48001000 0x400>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_pclk4>;
+			#dma-cells = <4>;
+			st,mem2mem;
+			dma-requests = <8>;
+		};
+
+		dmamux1: dma-router@48002000 {
+			compatible = "st,stm32h7-dmamux";
+			reg = <0x48002000 0x40>;
+			clocks = <&clk_pclk4>;
+			#dma-cells = <3>;
+			dma-masters = <&dma1 &dma2>;
+			dma-requests = <128>;
+			dma-channels = <16>;
+		};
+
 		syscfg: syscon@50020000 {
 			compatible = "st,stm32mp157-syscfg", "syscon";
 			reg = <0x50020000 0x400>;
-- 
2.25.1

