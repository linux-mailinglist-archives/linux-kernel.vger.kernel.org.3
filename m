Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14FE4CB0BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbiCBVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245057AbiCBVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:11:56 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CD0B2E02;
        Wed,  2 Mar 2022 13:11:11 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3E6E21C0002;
        Wed,  2 Mar 2022 21:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646255470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9E9ElsT8ujr2+MBXOLESCuF1hdN+tBFsEX48iQO/NGk=;
        b=mmRTwo1Sn9gFJDUUx+33czdTbJJrjCVYCYaBnSEzKpb7dx6ELqfRzIH0RPXPaPzwj+TbXs
        SiQtkw3LTwaW6pFruyRQSkIqFXDH85/0Oh3hCDwi8pCdu13BtZntpLCqmExamkwvvPKu/d
        VigJRIUBTPj3UgACMjXh6Qm9AYvCxmxvp1hrhOjBfkf3z3RnzTEEh/F6PAS5RTW14U2hJ9
        PF3deDxdv8X+KGEx5mBixw8L0DQT7l4wIFEijms2+gWnY9aMlEaRAaONMTYDMT8kO/GBeP
        W6xwPMXybgOeg3VmDKUA9EZBlhWL42TF8UnBr9avwQDcaovcDh8weq2RtIXybw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 3/8] clk: sunxi-ng: v3s: Export MBUS and DRAM clocks to the public header
Date:   Wed,  2 Mar 2022 22:10:55 +0100
Message-Id: <20220302211100.65264-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
References: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to declare a mbus node for the v3s, expose its associated
clocks to the public header.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h      | 4 ----
 include/dt-bindings/clock/sun8i-v3s-ccu.h | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
index 108eeeedcbf7..8ed4eff86ca1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
@@ -39,14 +39,10 @@
 
 /* The first bunch of module clocks are exported */
 
-#define CLK_DRAM		58
-
 /* All the DRAM gates are exported */
 
 /* Some more module clocks are exported */
 
-#define CLK_MBUS		72
-
 /* And the GPU module clock is exported */
 
 #define CLK_PLL_DDR1		74
diff --git a/include/dt-bindings/clock/sun8i-v3s-ccu.h b/include/dt-bindings/clock/sun8i-v3s-ccu.h
index 014ac6123d17..4231f23bc53b 100644
--- a/include/dt-bindings/clock/sun8i-v3s-ccu.h
+++ b/include/dt-bindings/clock/sun8i-v3s-ccu.h
@@ -87,7 +87,7 @@
 #define CLK_SPI0		55
 #define CLK_USB_PHY0		56
 #define CLK_USB_OHCI0		57
-
+#define CLK_DRAM		58
 #define CLK_DRAM_VE		59
 #define CLK_DRAM_CSI		60
 #define CLK_DRAM_EHCI		61
@@ -101,7 +101,7 @@
 #define CLK_VE			69
 #define CLK_AC_DIG		70
 #define CLK_AVS			71
-
+#define CLK_MBUS		72
 #define CLK_MIPI_CSI		73
 
 /* Clocks not available on V3s */
-- 
2.35.1

