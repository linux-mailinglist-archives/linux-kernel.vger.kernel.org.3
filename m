Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91A94AF104
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiBIMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiBIMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:05 -0500
X-Greylist: delayed 2225 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 03:26:24 PST
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FBC03BFF6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:26:24 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2199mRen022696;
        Wed, 9 Feb 2022 11:49:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=24MjF0dFTU7NbfTaD8f88stD/b7vEPeeuJ/9sopfTKw=;
 b=ho7KLtbzFvjNTNHuzuHUBCDHyHvgBdQNEfBvO0W4/op+4E5ecNZagUJ4F4Tkqvq3VCNM
 q73NrhkO3Z1DJobVnqIS059V5nnRBHMF4zv8axlR+UmBi0QjmYZGFQbK0cOr+PYJrGle
 sqViNvr4sh40J38qTdVs4eAcZ8Np1SkELXQiooFZZRvX2dSB7tELGM5ov8D+jB5EDUdc
 O1Dlj2zRuhyNGkjsTbdc0r+BxOb/6s/uO7tlHw2TOdkPALQl2o9LY+Hi+dkMO0mNPZSR
 HjawSgm9ivRy+n6TZ9CyzOUxrYOP6NnLtVY0SsDretJDEQ9iQqVVUG9FQszjZWRM3OXF DQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4ba9gc9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 11:49:03 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3199F10002A;
        Wed,  9 Feb 2022 11:49:03 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 24FAE217B60;
        Wed,  9 Feb 2022 11:49:03 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 9 Feb 2022 11:49:02
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>
CC:     <olivier.moysan@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: remove timer5 duplicate unit-address on stm32f7 series
Date:   Wed, 9 Feb 2022 11:48:49 +0100
Message-ID: <1644403729-22665-3-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644403729-22665-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1644403729-22665-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_05,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the following warnings seen when building with W=1.
Warning (unique_unit_address): /soc/timer@40000c00: duplicate unit-address
(also used in node /soc/timers@40000c00)
This approach is based on some discussions[1], to restructure the dtsi
and dts files.

Timer5 is enabled by default on stm32f7 series, to act as clockevent. In
order to get rid of the W=1 warning, and be compliant with dt-schemas
(e.g. dtbs_check):
- In stm32f746.dtsi:
  . Keep the more complete timers5 description
  . Remove the most simple timer5 node that is duplicate
- In each board:
  . adopt "st,stm32-timer" compatible for timers5, also add the interrupt
  . use /delete-property/ and /delete-node/ so the it matches the
    clockevent bindings

Note: all this is done in one shot (e.g. not split) to keep clockevent
functionality.

[1] https://lore.kernel.org/linux-arm-kernel/Yaf4jiZIp8+ndaXs@robh.at.kernel.org/

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts  | 12 ++++++++++++
 arch/arm/boot/dts/stm32f746-disco.dts | 12 ++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi      |  7 -------
 arch/arm/boot/dts/stm32f769-disco.dts | 12 ++++++++++++
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 327613f..a293e651 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -194,6 +194,18 @@
 	bus-width = <4>;
 };
 
+&timers5 {
+	/* Override timer5 to act as clockevent */
+	compatible = "st,stm32-timer";
+	interrupts = <50>;
+	status = "okay";
+	/delete-property/#address-cells;
+	/delete-property/#size-cells;
+	/delete-property/clock-names;
+	/delete-node/pwm;
+	/delete-node/timer@4;
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
index 569d23c..c11616e 100644
--- a/arch/arm/boot/dts/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -109,6 +109,18 @@
 	bus-width = <4>;
 };
 
+&timers5 {
+	/* Override timer5 to act as clockevent */
+	compatible = "st,stm32-timer";
+	interrupts = <50>;
+	status = "okay";
+	/delete-property/#address-cells;
+	/delete-property/#size-cells;
+	/delete-property/clock-names;
+	/delete-node/pwm;
+	/delete-node/timer@4;
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_b>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index a4f5c6a..dc868e6 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -141,13 +141,6 @@
 			};
 		};
 
-		timer5: timer@40000c00 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000c00 0x400>;
-			interrupts = <50>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM5)>;
-		};
-
 		timers5: timers@40000c00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
index be943b7..b038d0e 100644
--- a/arch/arm/boot/dts/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/stm32f769-disco.dts
@@ -137,6 +137,18 @@
 	bus-width = <4>;
 };
 
+&timers5 {
+	/* Override timer5 to act as clockevent */
+	compatible = "st,stm32-timer";
+	interrupts = <50>;
+	status = "okay";
+	/delete-property/#address-cells;
+	/delete-property/#size-cells;
+	/delete-property/clock-names;
+	/delete-node/pwm;
+	/delete-node/timer@4;
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
-- 
2.7.4

