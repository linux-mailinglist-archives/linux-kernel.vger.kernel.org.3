Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F361948C886
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355289AbiALQex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:34:53 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:59188 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349908AbiALQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:34:31 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CBMfp9006161;
        Wed, 12 Jan 2022 17:34:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=/LVZgAZ4KaMt6HeUK373T2nn7MiSHorKjvrFcPNUFCU=;
 b=U3vPtfIVd4aP/lgZljy0g/ZVEl/5KDNXj2nUWhGZbD+SBpOxmdZh2R93N5EhomMR3J2F
 XwlrpAAKNBQS89RLTLxqH6w0NGdFEaMGIs4irW3iYjEOynAhzyAlYjT6y/3slzP8G2Jx
 cCJ9W7JnEzpFs71unmhGnZfI2yc3A9AOju6mleQ0qrwjNWabv9z3rzctQu/GTE1eX5/9
 tXYlvKEwYXCS/Lk+j7+dWI9yYfWk4qZh5w+SEBadKpoHCdhL9HEqm72J4mOAKD1ZPakW
 b+GTifmjfOtUKTXYWhKhBp7cjKgD+/vTHEmsynp/rrfxmrQ8rf+4JPIFI5z8qOlFikH+ yQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dhtft32ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 17:34:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BBC6310002A;
        Wed, 12 Jan 2022 17:34:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B530C24B8BA;
        Wed, 12 Jan 2022 17:34:20 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 17:34:20
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Yann Gautier <yann.gautier@st.com>
Subject: [PATCH 08/10] ARM: dts: stm32: update SDMMC version for STM32MP13
Date:   Wed, 12 Jan 2022 17:33:54 +0100
Message-ID: <20220112163356.25634-9-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_04,2022-01-11_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yann Gautier <yann.gautier@st.com>

On STM32MP13, the embedded SDMMC peripheral version is v2.2.
Update arm,primecell-periphid for SDMMC in the SoC DT file.

Signed-off-by: Yann Gautier <yann.gautier@st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 672ac9360619..7189cba6b256 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -123,7 +123,7 @@
 
 		sdmmc1: mmc@58005000 {
 			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
-			arm,primecell-periphid = <0x00253180>;
+			arm,primecell-periphid = <0x20253180>;
 			reg = <0x58005000 0x1000>, <0x58006000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "cmd_irq";
-- 
2.17.1

