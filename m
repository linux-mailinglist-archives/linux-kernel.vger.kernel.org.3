Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494D948C873
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355296AbiALQdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:33:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44730 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239989AbiALQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:32:49 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CBDtR3019527;
        Wed, 12 Jan 2022 17:32:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=6UwyUli8Fpb2NlNGKtX2Lx6ZCm3vXyfMrODy3uld1FU=;
 b=8TuXsiL5YKgy/JUn2JIOcqEy6XrmcNFNaLnrd5yN0Nec9KEwnKxUmN69x3EnoPrUfsUx
 7X0reLSF2IIn7/pwrRrkNJ6Cfq4yl/P8+BandSoJ0zPMxjEeG3/q4pajUkvvOnBV86Or
 ZQ63DdYU+6s0bEenLNfi/M85PwA4h74qIkl8n/MchJ+tm/JF5ol4T6r9zuG49BAj8jK6
 CTTVuBllNVRbq5dH0XkWJQv5jN/0JtfGMkbBJRUVC13DgWa/5ho3o0DIICB5i5DVs9ba
 l27twqx/zJkTSJEyyKlBFd1oZ0fGzPdQ61nIemlCCnE+4FQ5+hLacBhRUHzh6bk8UQjb LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dhtg9u811-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 17:32:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D20C1100038;
        Wed, 12 Jan 2022 17:32:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C97FC24B8B1;
        Wed, 12 Jan 2022 17:32:33 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 17:32:33
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 01/10] ARM: dts: stm32: add st,stm32-sdmmc2 compatible on stm32mp151
Date:   Wed, 12 Jan 2022 17:32:17 +0100
Message-ID: <20220112163226.25384-2-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112163226.25384-1-yann.gautier@foss.st.com>
References: <20220112163226.25384-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_04,2022-01-11_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align with bootloaders device tree files, and thanks to what was
added in yaml file [1], the compatible property for sdmmc nodes is
updated with "st,stm32-sdmmc2" string.

[1] commit 552bc46484b3 ("dt-bindings: mmc: mmci: Add st,stm32-sdmmc2
    compatible")

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 1cfc2f011e70..39e5ea16db88 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1059,7 +1059,7 @@
 		};
 
 		sdmmc3: mmc@48004000 {
-			compatible = "arm,pl18x", "arm,primecell";
+			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
 			arm,primecell-periphid = <0x00253180>;
 			reg = <0x48004000 0x400>;
 			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
@@ -1381,7 +1381,7 @@
 		};
 
 		sdmmc1: mmc@58005000 {
-			compatible = "arm,pl18x", "arm,primecell";
+			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
 			arm,primecell-periphid = <0x00253180>;
 			reg = <0x58005000 0x1000>;
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
@@ -1396,7 +1396,7 @@
 		};
 
 		sdmmc2: mmc@58007000 {
-			compatible = "arm,pl18x", "arm,primecell";
+			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
 			arm,primecell-periphid = <0x00253180>;
 			reg = <0x58007000 0x1000>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

