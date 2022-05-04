Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CCC51A06A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348392AbiEDNLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350348AbiEDNKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:10:46 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CBD40A37;
        Wed,  4 May 2022 06:06:51 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244A6O13016063;
        Wed, 4 May 2022 15:06:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=4Jy00+YKj9FKRS8Ur8OX4MxIhckz7ncmunjwkkM24WU=;
 b=w+8C3uhPbIHWcR0v/Y5md2uXXXyc8bQ1RRqMalvJJ14vnd16xVfeikaFX7MSWvEaU0TN
 IDuKwFI7shTHM8d58gAxDPeU0zGrBPbUMRLwI5K0H9UiIZCfUur5rKdgkplvF8LQmrJ8
 JKXzzQtJ4MLn9k7EoKkMun3yBmzZWeYnSkc/pUTp4vp6dF8cMcWFkW4DExgfg2s0jZY3
 XSFiaNe4wDJXOFlkXQwafALj1XER1C0ARODv9EbAz1kcxkhw42O2wHg5EvVdFkpNHNZX
 +0XXdLF/+jtlT3jc6qrjkHb6gS4yL5Um+/9q+Yv6CzPiji/n+MUCI/04xCihVBxWCq3J vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frvf0m59p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 15:06:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F28710002A;
        Wed,  4 May 2022 15:06:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6634C21FEA9;
        Wed,  4 May 2022 15:06:37 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 4 May 2022 15:06:36
 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] dt-bindings: rtc: stm32: add alarm A out property to select output
Date:   Wed, 4 May 2022 15:06:13 +0200
Message-ID: <20220504130617.331290-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504130233.330983-1-valentin.caron@foss.st.com>
References: <20220504130233.330983-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 RTC can pulse some SOC pins when an alarm of RTC expires.

This patch adds property to activate alarm A output. The pulse can
output on three pins RTC_OUT1, RTC_OUT2, RTC_OUT2_RMP
(PC13, PB2, PI8 on stm32mp15) (PC13, PB2, PI1 on stm32mp13).

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 .../devicetree/bindings/rtc/st,stm32-rtc.yaml | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
index 56d46ea35c5d..71e02604e8de 100644
--- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
@@ -59,6 +59,13 @@ properties:
       Refer to <include/dt-bindings/rtc/rtc-stm32.h> for the supported values.
       Pinctrl state named "default" may be defined to reserve pin for RTC output.
 
+  st,alarm:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: |
+      To select and enable RTC Alarm A output.
+      Refer to <include/dt-bindings/rtc/rtc-stm32.h> for the supported values.
+      Pinctrl state named "default" may be defined to reserve pin for RTC output.
+
 allOf:
   - if:
       properties:
@@ -75,6 +82,9 @@ allOf:
         st,lsco:
           maxItems: 0
 
+        st,alarm:
+          maxItems: 0
+
         clock-names: false
 
       required:
@@ -95,6 +105,9 @@ allOf:
         st,lsco:
           maxItems: 0
 
+        st,alarm:
+          maxItems: 0
+
       required:
         - clock-names
         - st,syscfg
@@ -117,6 +130,9 @@ allOf:
         st,lsco:
           maxItems: 1
 
+        st,alarm:
+          maxItems: 1
+
       required:
         - clock-names
 
@@ -153,8 +169,9 @@ examples:
       clocks = <&rcc RTCAPB>, <&rcc RTC>;
       clock-names = "pclk", "rtc_ck";
       interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+      st,alarm = <RTC_OUT1>;
       st,lsco = <RTC_OUT2_RMP>;
-      pinctrl-0 = <&rtc_out2_rmp_pins_a>;
+      pinctrl-0 = <&rtc_out1_pins_a &rtc_out2_rmp_pins_a>;
       pinctrl-names = "default";
     };
 
-- 
2.25.1

