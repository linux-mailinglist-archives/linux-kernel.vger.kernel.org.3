Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACAD4B0774
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiBJHrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:47:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiBJHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:47:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2BD72;
        Wed,  9 Feb 2022 23:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644479252; x=1676015252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=p5j3Riq4rZoEYGYuDL+O+9dYmiRcXLURQv7yhYMS5TU=;
  b=GSn2Iripkeeel30kuDZaRfSXqlJV5BCTDuu6aFuiG91lpbMtN62Qfqe2
   7y4Puz0kouFXp6SdV7pcxju4iFROoWl7hRbiqe3+AZggBf+OPCi1kiWQY
   CP26I0+OvN70MilTvZm29W+r1xt+TgPYE6YZIE96eICBSrKuEWMgsnwUa
   rTWArnU0GgiXag/wxY3dAwQ6Yj8SbcRK/uEgHVG9Ig64XIKwgWWcUO1be
   qieJIeQukzCD25KNv7ikUX5UkwzcNQk4AZl3OacZJzX3Ah/kKAXqvg9WS
   pMs0Eegz8Q4It4r2NiOZadcz0veyT7LKKbgB2/cWyByT8eerfCeYC7X9w
   Q==;
IronPort-SDR: fCkB7qWlsJB1wyrTVx4IvHtQx9f+M62Ua5A8rFGAoHUNZW8m4omgDm7Z9Ho3IuJjrCVDSslfb6
 WC6UUL5YzxUIOmwLxTuIdj0rcZNbdpOvH+MoNMOKx6fb2FUU3TQAq7yxUDTOxqJtszhcXWrUcl
 8ofBh8dzksaznTRTX8w/026LR+gxwSHoTc4hwUsxJMBGqyzyuSTUemgphqw+wk5iFWp7ODOg+Q
 ERv3DkZmv5aCmdu2Iogzf4nYwqAq983usvHEsy+JZdNEz1m1eiM/heHcZ+eQGsq1NdPSH9HiA7
 YE0hREDR8y5H54bQ9TmqWCIE
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="85274949"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 00:47:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 00:47:31 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 10 Feb 2022 00:47:27 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH 1/2] mfd: dt-bindings: add bindings for lan966 flexcom shared configurations
Date:   Thu, 10 Feb 2022 13:15:45 +0530
Message-ID: <20220210074546.30669-2-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210074546.30669-1-kavyasree.kotagiri@microchip.com>
References: <20220210074546.30669-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds LAN966 SoC DT bindings documentation for Flexcom
Shared and chip-select configurations.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 .../devicetree/bindings/mfd/atmel-flexcom.txt        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
index 692300117c64..a76622082228 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
@@ -18,6 +18,15 @@ Required properties:
 			- <2> for SPI
 			- <3> for I2C
 
+Optional properties:
+- Flexcom shared configurations: Each flexcom of lan966 SoC has 2 chip selects.
+  For each chip select, there is a pin configuration register.
+  The width of the configuration register is 21 because there are 21 shared
+  pins on each of which the chip select can be mapped. Each bit of the
+  configuration register represents a different FLEXCOM_SHARED pin.
+	- lan966x-ss-pin:	Should be a flexcom shared pin.
+	- lan966x-cs:		Should be chip select 0 or 1.
+
 Required child:
 A single available child device of type matching the "atmel,flexcom-mode"
 property.
@@ -41,6 +50,9 @@ flexcom@f8034000 {
 	#size-cells = <1>;
 	ranges = <0x0 0xf8034000 0x800>;
 	atmel,flexcom-mode = <2>;
+	/* Map chip-select index 0 of the flexcom to FLEXCOM_SHARED 9 */
+	lan966x-ss-pin = <9>;
+	lan966x-cs = <0>;
 
 	spi@400 {
 		compatible = "atmel,at91rm9200-spi";
-- 
2.17.1

