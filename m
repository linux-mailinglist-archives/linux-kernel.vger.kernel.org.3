Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AEF4A89BA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352745AbiBCRQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:16:45 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58168 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237917AbiBCRQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:16:41 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213EhamF031133;
        Thu, 3 Feb 2022 18:14:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=oJsVc/G0V4FvZjE6ehLE8WHxeNAr1eqH/qcfE5+Oq3A=;
 b=oyACJjYaOyVVCeGQn+TtxgMMN1USwMEfUUu2w6r7s6lWpStqSrXgV0Cc1uSEHgPJ3Pi+
 yx6heCSTxVm1Tp45yzT/vXnfV85xBSFDfHbCeWAMjCphrrE7lf0BPyXN0v+rw86EeQAx
 CLR+NrvIpCbx4/Ivv7fADOoAcRfCdmv9hU+XL0h4O6ClTfJljtJLQyfGM4zto9J8xTZW
 FpZRNtzTGuobNCgcuXUQjhpYcZ3GpJYRN0V46pebbRP9RrUAkWzlJdCPuQczKM8aCnoV
 DiprXZ6ZoReE608wfeGr3p32/u1BtgLKg2mx3KSA8M0xmMBEVz5d66PQk0+vXK0+/89a Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e01qkcyq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:14:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E8F8A10002A;
        Thu,  3 Feb 2022 18:14:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0F2222F7AB;
        Thu,  3 Feb 2022 18:14:31 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 3 Feb 2022 18:14:31
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
Subject: [PATCH 16/16] ARM: dts: stm32: keep uart nodes behavior on stm32mp15xx-dhcor-avenger96
Date:   Thu, 3 Feb 2022 18:11:14 +0100
Message-ID: <20220203171114.10888-17-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220203171114.10888-1-erwan.leray@foss.st.com>
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA configuration is added to uart nodes in stm32mp15x device tree.
Delete uart4 DMA property in stm32mp15xx-dhcor-avenger96 board device
tree to keep console in irq mode, as DMA support for console has been
removed from the driver by commit e359b4411c28 ("serial: stm32: fix
threaded interrupt handling").
Delete also usart2 and uart7 DMA property to keep current behavior.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
index 6885948f3024..61e17f44ce81 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
@@ -376,6 +376,8 @@
 	label = "LS-UART1";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins_b>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	status = "okay";
 };
 
@@ -385,6 +387,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart7_pins_a>;
 	uart-has-rtscts;
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	status = "okay";
 };
 
@@ -394,6 +398,8 @@
 	pinctrl-0 = <&usart2_pins_a>;
 	pinctrl-1 = <&usart2_sleep_pins_a>;
 	st,hw-flow-ctrl;
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	status = "okay";
 
 	bluetooth {
-- 
2.17.1

