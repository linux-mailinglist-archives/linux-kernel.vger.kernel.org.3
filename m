Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03D54B2933
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbiBKPit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:38:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiBKPis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:38:48 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA1C13A;
        Fri, 11 Feb 2022 07:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=XaO2U/DxJmSHTkTEoZb8gTY8X7cg1YHSNA/LJ+mK5R8=; b=E
        kcb1iOuz+34AeINzNrVbucvS4iZsk+cwGrWUjmudw8tYMIPfB1XWUKPYLc8rC3cKXuRh9aT+NR26z
        9ic8EToRDEeniNwwadqL6jC2OxfqA4OAFMQQjJujpQiN757oEfKQoIxVnt66EIagSCI0siXa6gCcs
        G4h45FHqz/4v3RJ8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55256 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIY0J-0003yU-Tl; Fri, 11 Feb 2022 10:38:36 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Feb 2022 10:38:17 -0500
Message-Id: <20220211153818.3721541-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] arm64: dts: imx8mp-evk: add PCA6416 gpio line names
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add gpio-line-names for the various GPIO's connected to the PCA6416
I/O expander on the imx8mp EVK.

This helps when using the new gpiod interface to find the GPIOs by name.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 9055ce32aecc..a82c31dbdbf3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -300,6 +300,22 @@ pca6416: gpio@20 {
 		pinctrl-0 = <&pinctrl_pca6416_int>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names = "EXT_PWREN1",
+			"EXT_PWREN2",
+			"CAN1/I2C5_SEL",
+			"PDM/CAN2_SEL",
+			"FAN_EN",
+			"PWR_MEAS_IO1",
+			"PWR_MEAS_IO2",
+			"EXP_P0_7",
+			"EXP_P1_0",
+			"EXP_P1_1",
+			"EXP_P1_2",
+			"EXP_P1_3",
+			"EXP_P1_4",
+			"EXP_P1_5",
+			"EXP_P1_6",
+			"EXP_P1_7";
 	};
 };
 
-- 
2.30.2

