Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40A14AAE55
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 09:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiBFIUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 03:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiBFIUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 03:20:40 -0500
X-Greylist: delayed 1186 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 00:20:37 PST
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529FC06173B;
        Sun,  6 Feb 2022 00:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UtDHnov5d0OtIQeYLlHOaaJhlsYZLUbYnfZ7b9x4A78=; b=XWN2I+sBhihf8RWlnThBNBnXZl
        zvzm4R6C/0wg7D1MD3TcN/lr2FeYKaMyO67dhqwe7dxjO/DjhpWx2yzwnX92xghn1rJ5VStRgrrKp
        RX/2XR0w4Y6JQ9z5X8MBetJIr7GjAGb4y+hCbcIzuRLYFYuNbZju1DkylM5KtWuE0M5M=;
Received: from p200300ccff05f6001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff05:f600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1nGcTL-0006Ve-BE; Sun, 06 Feb 2022 09:00:36 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1nGcTK-003LEs-QO; Sun, 06 Feb 2022 09:00:34 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, andreas@kemnade.info,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alistair@alistair23.me, samuel@sholland.org, josua.mayer@jm0.eu,
        letux-kernel@openphoenux.org
Subject: [RFC PATCH 5/6] ARM: dts: imx6sll: add EPDC
Date:   Sun,  6 Feb 2022 09:00:15 +0100
Message-Id: <20220206080016.796556-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206080016.796556-1-andreas@kemnade.info>
References: <20220206080016.796556-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commercial variant has a controller for e-Paper displays.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/imx6sll.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index d4a000c3dde7..042e8a391b2f 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -643,6 +643,15 @@ pxp: pxp@20f0000 {
 				clock-names = "axi";
 			};
 
+			epdc: epdc@20f4000 {
+				compatible = "fsl,imx6sll-epdc";
+				reg = <0x020f4000 0x4000>;
+				interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SLL_CLK_EPDC_AXI>, <&clks IMX6SLL_CLK_EPDC_PIX>;
+				clock-names = "axi", "pix";
+				status = "disabled";
+			};
+
 			lcdif: lcd-controller@20f8000 {
 				compatible = "fsl,imx6sll-lcdif", "fsl,imx28-lcdif";
 				reg = <0x020f8000 0x4000>;
-- 
2.30.2

