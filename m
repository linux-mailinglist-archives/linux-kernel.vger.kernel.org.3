Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0C4AAE5F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 09:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiBFIU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 03:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiBFIUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 03:20:55 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFCBC0401D5;
        Sun,  6 Feb 2022 00:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UZ2JAMX8nDSsRCnVWafI2U6JO6ZmkGBfyN3BR9SHP0Y=; b=fI8nVfDG18tKT4U9QVgGHhoT4r
        trzSqJIvJgJK+WyYfGot9+K/Q1KM4RjIVLG3FDeDdctHGCiN7ne8NdZ32efXCElFe7KpQRoMvWi8A
        +6n3Twb5iYS/z9pWyKR0dGK7SvEjRaPx59aopP15nxHCHAdUj9lVq85Fk+dWzZyNZm+Q=;
Received: from p200300ccff05f6001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff05:f600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1nGcTL-0006Vm-Pi; Sun, 06 Feb 2022 09:00:36 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1nGcTL-003LEw-8P; Sun, 06 Feb 2022 09:00:35 +0100
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
Subject: [RFC PATCH 6/6] arm: dts: imx6sl: Add EPDC
Date:   Sun,  6 Feb 2022 09:00:16 +0100
Message-Id: <20220206080016.796556-7-andreas@kemnade.info>
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

Extend definition of EPDC.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/imx6sl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c7d907c5c352..919e86e4fc74 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -765,8 +765,11 @@ pxp: pxp@20f0000 {
 			};
 
 			epdc: epdc@20f4000 {
+				compatible = "fsl,imx6sl-epdc";
 				reg = <0x020f4000 0x4000>;
 				interrupts = <0 97 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_EPDC_AXI>, <&clks IMX6SL_CLK_EPDC_PIX>;
+				clock-names = "axi", "pix";
 			};
 
 			lcdif: lcdif@20f8000 {
-- 
2.30.2

