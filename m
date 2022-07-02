Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC3B564243
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiGBTBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiGBTBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:01:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E094AE4F;
        Sat,  2 Jul 2022 12:01:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C03585C0195;
        Sat,  2 Jul 2022 15:01:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 02 Jul 2022 15:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656788496; x=1656874896; bh=YpEelYmUvdLtWnPD4x37HhXs0
        h7SsV/ws5mffLHlEmg=; b=pjDEfEvT+op90UV/7Tj0uGeG3Xx4aJLrxlfxlvvQ/
        LCAEi24uYdfUvKbOkf1gQnMyvR0EICwJdj+td2KdkoybKGIktpmAtDmfrtcNpCvp
        YTcV2JKk/SwNYLirWr5hOomTo9N5vKWyMeZaf57u4hywX5bPLl8mByz92VwB9Ygi
        ZCnx9grwf1x0V7UqenUxWy+i8i/p8/3U7YqErNuDLhFPHnOITtvK6qNV01IvW/Q/
        OjCAYbrAFdAdiQtCw9WeSklPgan1DcbLtvq7XEl3QNxujWUtbfc/HLSPAWqWygld
        FoQdvjq0yMuM+5LaG2uc291Ls47mxmJRw/J0vhleH5BSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656788496; x=1656874896; bh=YpEelYmUvdLtWnPD4x37HhXs0h7SsV/ws5m
        ffLHlEmg=; b=S/4AdPqBg2QwigWuJn9uFT3Sz1jn23ECoS/0NlpP2wb5GJeV0dp
        8jVxpYe70jjDXJ0enTABoYIY1/kjOcCl6j2SzIvTRbpO0wcTiqqXy7dUGOUygFz7
        WH38U9D4mdMeW6Q+A5ktpHJ/y0EA0rYuQm1V73sTBlX9LfF2LpWw/Vb8pnNlqo0C
        Bj41a57PDuKa4t9kt8w2J8Ct0tarRtamukjbElJ09p3QYkKhETzomD3kyBndHju2
        lAFqYPZCK05j75I1PWwBDAMcFkcYdoFAV2TkAwUHlONR+t05NUMBxY6e0prSlbvK
        xV4NbMhEk8QkEf4kSJxjTKHLwTMRR8rM69w==
X-ME-Sender: <xms:EJbAYjAVkdLec4KbZd3gB6jmTLiUut93joFTYFh0X1L3dpaSFWXJxA>
    <xme:EJbAYphBBXFzR1lEXjcNOxTuKSvKivbU1CASJFkhz4qtdtaKQbXPCrhMAze49BlwV
    IoGw0ni-ZTc2kEcAw>
X-ME-Received: <xmr:EJbAYunVqxdqD94yW1QHCITe4bLqxmVgxzqAAv9LA7kE55xIwQ4jFur1n5AAhp2XRK_P5q7gJ4cv-8C7J1uqyh68W8IFXZmcg0uW5ImRerzQOeso7zEuY6NLWkp2LPV6HgaFsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:EJbAYlzWCPz72Gsok-obuasuvBXrdYwIQ8UFC5qBVcNVFQWUMNngBQ>
    <xmx:EJbAYoSxbeE0buFXDvQnR9AMMVndBo_i1vmCTHM96g1WaWLIbrRZMQ>
    <xmx:EJbAYobJxyeNEmP541ZsmbtmaypNAWpg7kvbbGUyJ2PhklCNMp4GlA>
    <xmx:EJbAYrEKkN_mBRS-dm15aeKkGIEKX0WTzdF_G--KkZvh5ALlI2OgBQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 15:01:35 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 1/2] clk: sunxi: Limit legacy clocks to 32-bit ARM
Date:   Sat,  2 Jul 2022 14:01:34 -0500
Message-Id: <20220702190135.51744-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sunxi legacy clocks were never compatible with any 64-bit SoC,
so there is no point in building them as part of a 64-bit ARM kernel.
They make even less sense being built in to a 64-bit RISC-V kernel.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index 3fba3d3ac9a2..a5c237610357 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig CLK_SUNXI
 	bool "Legacy clock support for Allwinner SoCs"
-	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on (ARM && ARCH_SUNXI) || COMPILE_TEST
 	default y
 
 if CLK_SUNXI
-- 
2.35.1

