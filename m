Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD314F7720
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbiDGHS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbiDGHR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0F815609D;
        Thu,  7 Apr 2022 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649315731; x=1680851731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Bi4lSLV0zLBBZOD2CzxtM5qbY8InuCSGS8Woi7tp1Q=;
  b=QlWFiuWa4eXJ7i/HoZynivrLvU/7wI4vOMzFftCBUcM/ch+Vx1+dqi+r
   J6nOMuXjVckJjZeGR28R2xmOhRYK3SOGPFp/h7s7Q8yc6WylVW+QFZvNL
   s/JiRcMKxYVbBJxFpE04iqQujlOTm0F0xhZCyGX1Qz2fR8f9yrOazEp0n
   KbCLTPYYVZTaw2hcPIfvtbv2c0aCRGlC8D3aO25nqRptuNk678sdkQE2P
   6Fk8sMPMA4WlLaA+fnkzaE6tmAy3rXu3UekuealT4COpEt+Uwfd0/e/zG
   pF19GROqePJxJolZd/1EsaZcM9mtG+cIi+HmhQ7jda16lT9s3sFmMni6H
   w==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="151841505"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:15:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:15:28 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 00:15:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 09/10] ARM: dts: at91: sama7g5: add reset-controller node
Date:   Thu, 7 Apr 2022 10:17:07 +0300
Message-ID: <20220407071708.3848812-10-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
References: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller node.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index eddcfbf4d223..aa0e72d4d2d5 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -122,6 +122,13 @@ pmc: pmc@e0018000 {
 			clock-names = "td_slck", "md_slck", "main_xtal";
 		};
 
+		reset_controller: reset-controller@e001d000 {
+			compatible = "microchip,sama7g5-rstc";
+			reg = <0xe001d000 0xc>, <0xe001d0e4 0x4>;
+			#reset-cells = <1>;
+			clocks = <&clk32k 0>;
+		};
+
 		shdwc: shdwc@e001d010 {
 			compatible = "microchip,sama7g5-shdwc", "syscon";
 			reg = <0xe001d010 0x10>;
-- 
2.32.0

