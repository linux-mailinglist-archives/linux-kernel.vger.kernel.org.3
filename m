Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE77A4A89B7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbiBCRQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:16:10 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39680 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352787AbiBCRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:15:38 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213FKY4j012550;
        Thu, 3 Feb 2022 18:13:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=1qswNEyk+EjTNAnmqwZ/JMaBAi2XcnYYAnBEud1Qd0E=;
 b=hr0G/QsE3cqBtXHmGbWWnjzGLEr3C+P0rYIc8psHzmU1ntiuZEsq8/fpW7F9vBoKTrQs
 gVToC3IPVDXveDPA+1RnJy0eQdN6uOXXHmoZZ6PYjWrP4b11Oa+E13xKzKe5TwZvmqL8
 962UnowkdI445WvxkR2Dm09MewPbORvDR1Zc+ps/STeAgEhoPUnBIurKNnIbE2Xcw8oQ
 ttDaOG4mJAR0gHDwsZM0FLZWWGZQA1td4bnAQZHrzVuFG2Se+RD35xP6Rosi741zg7SW
 QN9G5o8FeeOBSOEkZ55yr8H/G/S1k1ZNQvtV/T3Tk7XMhOI6G4+8+59s7BecWVpye276 AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e0c4fjdm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:13:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5D36A100034;
        Thu,  3 Feb 2022 18:13:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5503F22F7AB;
        Thu,  3 Feb 2022 18:13:25 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 3 Feb 2022 18:13:24
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/16] ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcom-pdk2
Date:   Thu, 3 Feb 2022 18:11:11 +0100
Message-ID: <20220203171114.10888-14-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220203171114.10888-1-erwan.leray@foss.st.com>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA configuration is added to uart nodes in stm32mp15x device tree.
Delete usart3 and uart8 DMA property in stm32mp15xx-dhcom-pdk2 board
device tree to keep current behavior.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
index fbf3826933e4..5f586f024060 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi
@@ -287,6 +287,8 @@
 &usart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usart3_pins_a>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	status = "okay";
 };
 
@@ -294,6 +296,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart8_pins_a &uart8_rtscts_pins_a>;
 	uart-has-rtscts;
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	status = "okay";
 };
 
-- 
2.17.1

