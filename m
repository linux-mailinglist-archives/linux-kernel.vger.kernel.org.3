Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F654A60FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbiBAQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:07:37 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:50404 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240806AbiBAQHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:07:35 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211FZhqi014100;
        Tue, 1 Feb 2022 17:05:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=6PYg5Hhedg4uaQloxJmFy2l1dVuPmR6nR41VJNfEuyw=;
 b=oqT9bxTBsdPQbWEw8zRCkvHS7d0ZOGjZRvt4F1frv3tzh4HMDqo7Xjm5to0uQiRRSrlV
 lZ+vzDo4K+QpqdupZGDv7+WxhRfia63lXIPuWGtMIMWni2K8q9ZmNiodZ1L+LmPx/USz
 9Ws35zLakxRjWrKivI9k4DolcyFKYitA+/+wohyg0ym/Pfm72IxM/PUe1N47n9OPBSLX
 rurQLGg9a8e/GxSpNcHh14qCFMzgJK7Y0ytP/3rGrSw5lEAw/ZuERIJ0HW1mchvrcYFa
 hlLFCWlx+dL2URgyiBgl5XNZs+OrMCEKKYl4THKyAYZmyt9QBhctc7kPCssFo1B9W1JT /A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dy1xm1uw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 17:05:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D757410002A;
        Tue,  1 Feb 2022 17:05:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF7072248DE;
        Tue,  1 Feb 2022 17:05:16 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 1 Feb 2022 17:05:15
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: add MDMA on STM32MP13x SoC family
Date:   Tue, 1 Feb 2022 17:05:06 +0100
Message-ID: <20220201160506.348701-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201160506.348701-1-amelie.delaunay@foss.st.com>
References: <20220201160506.348701-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_08,2022-02-01_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MDMA on STM32MP13x SoCs is the same than on STM32MP15x SoCs: it offers up
to 32 channels and supports 48 requests.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index e64fa10ac245..b2377a22b511 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -165,6 +165,16 @@ syscfg: syscon@50020000 {
 			clocks = <&clk_pclk3>;
 		};
 
+		mdma: dma-controller@58000000 {
+			compatible = "st,stm32h7-mdma";
+			reg = <0x58000000 0x1000>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_pclk4>;
+			#dma-cells = <5>;
+			dma-channels = <32>;
+			dma-requests = <48>;
+		};
+
 		sdmmc1: mmc@58005000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			arm,primecell-periphid = <0x00253180>;
-- 
2.25.1

