Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186104AF0EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiBIMIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiBIMG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:29 -0500
X-Greylist: delayed 240 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 03:17:34 PST
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8D6C094C8C;
        Wed,  9 Feb 2022 03:17:33 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2199Dkbu017886;
        Wed, 9 Feb 2022 11:49:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=UGC+VEwgikjaZ7ZKIhZPlx6lbEE0SrNgxVh2SUobLaA=;
 b=YSBxDmNYSw4iT83zEgAaNdLqYIDc0xre2EtHPQBlFUplhescIYo4VdJfIL3gQjNrQ3Dq
 2DQmXu79s6U8UOKX/zH6hO4ruYRUMO3rjy6XUPKBGR1accYh75GsyT9HL3+JxPEvn5n3
 PJHmq9ZnOGiV/nAOmIwPoihgBuJwh2wNwS5irt5NBKCCEtgOpwLl2MQb5MOcHBXeUK7z
 xxVS33PRzQrGvKmI9mkv+B0ZL/I0dMCf1qs7yIpQAKGeg85QksywFdCQqaBsR3KFIghs
 mXaV6KeULmnSTyv3BVbTTcgaYvUyMhv39GXU+dfbRX3Sie2cE4PmKJISiGOOLR7f/5BB sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4asygkyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 11:49:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 438AD10002A;
        Wed,  9 Feb 2022 11:49:01 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B4F2215126;
        Wed,  9 Feb 2022 11:49:01 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 9 Feb 2022 11:49:00
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>
CC:     <olivier.moysan@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: remove some timer duplicate unit-address on stm32f7 series
Date:   Wed, 9 Feb 2022 11:48:48 +0100
Message-ID: <1644403729-22665-2-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644403729-22665-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1644403729-22665-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
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

Several unused "timer" are duplicate nodes of "timers" nodes.
There are two dt-schemas:
- timer/st,stm32-timer.yaml: A timer is needed on STM32F7 series, on all
  boards, to act as clockevent.
- mfd/st,stm32-timers.yaml: Timers can be used for other purpose.

By default, timer5 is left enabled to be used as clockevent. Remove all
other timer clockevent nodes that are currently unused and duplicated.

This removes several messages: Warning (unique_unit_address): /soc/timer@..
duplicate unit-address (also used in node /soc/timers@...)

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 014b416..a4f5c6a 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -75,14 +75,6 @@
 	};
 
 	soc {
-		timer2: timer@40000000 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000000 0x400>;
-			interrupts = <28>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM2)>;
-			status = "disabled";
-		};
-
 		timers2: timers@40000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -105,14 +97,6 @@
 			};
 		};
 
-		timer3: timer@40000400 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000400 0x400>;
-			interrupts = <29>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM3)>;
-			status = "disabled";
-		};
-
 		timers3: timers@40000400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -135,14 +119,6 @@
 			};
 		};
 
-		timer4: timer@40000800 {
-			compatible = "st,stm32-timer";
-			reg = <0x40000800 0x400>;
-			interrupts = <30>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM4)>;
-			status = "disabled";
-		};
-
 		timers4: timers@40000800 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -194,14 +170,6 @@
 			};
 		};
 
-		timer6: timer@40001000 {
-			compatible = "st,stm32-timer";
-			reg = <0x40001000 0x400>;
-			interrupts = <54>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM6)>;
-			status = "disabled";
-		};
-
 		timers6: timers@40001000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -218,14 +186,6 @@
 			};
 		};
 
-		timer7: timer@40001400 {
-			compatible = "st,stm32-timer";
-			reg = <0x40001400 0x400>;
-			interrupts = <55>;
-			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM7)>;
-			status = "disabled";
-		};
-
 		timers7: timers@40001400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4

