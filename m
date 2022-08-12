Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7F5914C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiHLRXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiHLRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:23:51 -0400
X-Greylist: delayed 159 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Aug 2022 10:23:51 PDT
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB8BB248F;
        Fri, 12 Aug 2022 10:23:51 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1oMYNk-00FqJz-8Q; Fri, 12 Aug 2022 17:23:36 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mm-venice-gw7903: add digital I/O ctl gpios
Date:   Fri, 12 Aug 2022 10:23:34 -0700
Message-Id: <20220812172334.14171-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GW7903-C revision introduced two additional GPIO's for controlling
the digital I/O direction. Add them.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
index a7dae9bd4c11..1b69ac0e12b0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
@@ -250,7 +250,7 @@ &gpio1 {
 };
 
 &gpio2 {
-	gpio-line-names = "dig2_in", "dig2_out#", "", "", "", "", "", "",
+	gpio-line-names = "dig2_in", "dig2_out#", "dig2_ctl", "", "", "", "dig1_ctl", "",
 		"dig1_out#", "dig1_in", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "";
@@ -630,6 +630,8 @@ MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11	0x40000041 /* RS485# */
 			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x40000041 /* RS232# */
 			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9	0x40000041 /* DIG1_IN */
 			MX8MM_IOMUXC_SD1_DATA6_GPIO2_IO8	0x40000041 /* DIG1_OUT */
+			MX8MM_IOMUXC_SD1_DATA4_GPIO2_IO6	0x40000041 /* DIG1_CTL */
+			MX8MM_IOMUXC_SD1_DATA0_GPIO2_IO2	0x40000041 /* DIG2_CTL */
 			MX8MM_IOMUXC_SD1_CLK_GPIO2_IO0		0x40000041 /* DIG2_IN */
 			MX8MM_IOMUXC_SD1_CMD_GPIO2_IO1		0x40000041 /* DIG2_OUT */
 			MX8MM_IOMUXC_ECSPI1_MOSI_GPIO5_IO7	0x40000041 /* SIM1DET# */
-- 
2.25.1

