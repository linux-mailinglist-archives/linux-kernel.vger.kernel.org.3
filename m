Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7E4CD66C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbiCDOaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239889AbiCDOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:30:10 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0321BBF41;
        Fri,  4 Mar 2022 06:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646404161; x=1677940161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WwJlGF2U4JLMsEwUtCwxY/YCgq4lqd75LmiAV/2FZ24=;
  b=16iZFnekYme/CkJdPi4YEgzV9pCC0n+zzv/bx8HWeofigZK4lEjKiuyo
   JHVxkP7wad+aC+NF5LSJLGDexyn/AZiVr4gof+H/WeK3YsHUKur5HnA0H
   fg2Zz7G1JkTFduXxsna7rJxC71hdFT6YTIhKMVJ0gtDPnWw/j0eunSVHq
   uG5FH0QQaDteX/nu9IfSkDucci/DT4w/qNNMkUjjqlkrhCHQjC5KJqpVx
   IRHyFfDNSPl5rIXHtKyMRjEQQuIMk7zrNXNPB1fgjLfn5ziQl1JxoBo7f
   LOw8K00RcV4Z5SiWi+vdvUD8/eFOUzuW4kkAduTGaw8iXyWInM6aQ2cqn
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="164546135"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 07:29:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 07:29:19 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 07:29:16 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v3 4/5] dt-bindings: rtc: at91: Use macros for the IRQ type
Date:   Fri, 4 Mar 2022 16:27:45 +0200
Message-ID: <20220304142746.121947-5-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304142746.121947-1-sergiu.moga@microchip.com>
References: <20220304142746.121947-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer using macros for the IRQ type of the example node's
interrupt property.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
index af25cc275356..d2452067bfe4 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
@@ -54,10 +54,12 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     rtc@fffffd20 {
         compatible = "atmel,at91sam9260-rtt";
         reg = <0xfffffd20 0x10>;
-        interrupts = <1 4 7>;
+        interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
         clocks = <&clk32k>;
         atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
     };
-- 
2.25.1

