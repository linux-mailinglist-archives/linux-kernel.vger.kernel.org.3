Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094C24EDB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiCaONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiCaONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:13:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB851A9C9E;
        Thu, 31 Mar 2022 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648735873; x=1680271873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DTlZMPyBAjhVeiotBWdlFP85K8A9aL9sjqg7w9Ombhs=;
  b=snxaDYqsGX/AJvok1qc/qb5WZ4D3yRKHa22xxJq9eT3OPiXEafBFVjux
   ZfypAtJGxJMjSuvzGWDpT3ISZA4QiKiMSKYYbJ8gOJtdxtGqimlT39Jog
   18Ce/ZASuLXzx9iXETR2cLuOfzw8GjZVG3zwc3X2cJzgkBJmqXy4bf6qY
   uktZtjQsPWGZpdTeDrnWpLDaT2Ucr1bGKSMANNutWd9EaCZfyAswESzCu
   Ltk44lQgS89e5f2C9rm6lM8Nk0eduGhF53rApGI/SN01xDao/cT48uUnx
   /XaVHv5xBgjModJ1zk2X2BDFK1p/++EJbZIvQw9H7pQNlW44dH5hYjzA7
   A==;
X-IronPort-AV: E=Sophos;i="5.90,225,1643698800"; 
   d="scan'208";a="158386498"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2022 07:11:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 31 Mar 2022 07:11:11 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 31 Mar 2022 07:11:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: sama5d4_xplained: fix pinctrl phandle name
Date:   Thu, 31 Mar 2022 17:13:22 +0300
Message-ID: <20220331141323.194355-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinctrl phandle is for spi1 so rename it to reflect this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index d241c24f0d83..accb92cfac44 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -82,7 +82,7 @@ usart4: serial@fc010000 {
 
 			spi1: spi@fc018000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_spi0_cs>;
+				pinctrl-0 = <&pinctrl_spi1_cs>;
 				cs-gpios = <&pioB 21 0>;
 				status = "okay";
 			};
@@ -140,7 +140,7 @@ pinctrl_macb0_phy_irq: macb0_phy_irq_0 {
 						atmel,pins =
 							<AT91_PIOE 1 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
 					};
-					pinctrl_spi0_cs: spi0_cs_default {
+					pinctrl_spi1_cs: spi1_cs_default {
 						atmel,pins =
 							<AT91_PIOB 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
 					};
-- 
2.32.0

