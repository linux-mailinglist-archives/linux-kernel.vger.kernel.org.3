Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666E44FCDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346810AbiDLEbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346380AbiDLEa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:30:59 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54C32EDF;
        Mon, 11 Apr 2022 21:28:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CC18A3200E89;
        Tue, 12 Apr 2022 00:28:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Apr 2022 00:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649737720; x=1649824120; bh=MQ
        4FTXr1na6Tt4xS2pUA3joEglBoItsM9c3A/HBjrsc=; b=NxhZ8uyXfao5bBw3Qp
        pZdIVCRsjJyUjvWqFbXoSCnGTW3mr0h3KBTsXshgOk9pZAc0wMiCp7dH/v2DpmDu
        sLRpuc5pMivcjnt4FsNzt7lnsE09N547cCMVk9VfqLVhUdRVGKBApB0HTW3x8xSZ
        asgNclqT9hCT8mLViSBU3PMLM0vHMFlGaolpp6eUQ9wmLxlrLts7/tq/unET2oWF
        uhBjO7ggrY6pym4fmI9mMzP5f0ioKHomNW5FDJeV2vbV9/gjQjM+BVwKZCpxp+HO
        XtcUw2UaboNpOgyEPI0wYXHWsKhfR8h5opmtSe2TgelV6qdjXs6z7utePWVHO+8K
        DOag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649737720; x=1649824120; bh=MQ4FTXr1na6Tt4xS2pUA3joEglBoItsM9c3
        A/HBjrsc=; b=NU4zgyx2qk9BRKZUe6nesj0I0jKSHJ9skI6czoBeuy7Dy4WuwIE
        PO3TxiiVgfTCNBv7eDqgmebbLUFygAqAfNkUHsJGpp8FzDdz+16OFQuo3RPn6Z1N
        FTou9ftNcggwVQY2YDs5f6WnVYTMvBM0x/ZB1NlgRrt/BlY9TxlIi5rzmXEx+lIt
        HbZdxTxhKWe8KKs/pDDScX9S11JEzA9IpnhZJb21nvNgYOg+/Wiwz9w9fB/m8GeT
        hunhOFn6xGQvby9Us0tnkWrzztcsmM0OT0/m+s34cj2J1XkeCd6b1y1XO4DiTSLn
        iG5NAlbpR0TrEyGdEtWElu+qYrWhxHO8UMA==
X-ME-Sender: <xms:-P9UYoLwX920y6aHE7VTP9EjJkJX_rKbf591HIgm6GCLRG8HUWtiPQ>
    <xme:-P9UYoJPvC-zotI-_GHEjWJyBl6XHXF1AUbVqQBDvHW1EmmQ8EbP4lLvPLSO3meqe
    8M1cVzWzSkp6jTYLw>
X-ME-Received: <xmr:-P9UYov-1IFIFh84fHk1FRkW88zffvWrFJEmmMtYwO6CNBI0585qy4Jfcaa0tigkKBT2Z3QLWHTPthamE2Eda-URolHbsw9V2LYA_hY-pJozdBzODgFQSaRhOkzlITwE1xHD2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:-P9UYlavaBu83iDndq53Zi4S4hvPNyEnratSEQUdBZLOfhuX1SRL7w>
    <xmx:-P9UYvavpSyG2vhCVi04v0Yt_KTo_6P3YHDmxkJbU83yCGgnwCtZ4Q>
    <xmx:-P9UYhCMUepvAz6ojzMnuVXytSK6ToaUcR0pdoKPldHROufESaeb1w>
    <xmx:-P9UYtDCotcVCdTJUtBxaNnpxRDDdhll-IUVRo_1-nC1IVpU5MTXKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 00:28:39 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 10/14] drm/sun4i: csc: Add support for the new MMIO layout
Date:   Mon, 11 Apr 2022 23:28:02 -0500
Message-Id: <20220412042807.47519-11-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412042807.47519-1-samuel@sholland.org>
References: <20220412042807.47519-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 changes the MMIO offsets for the CSC blocks in the first mixer. The
mixers' ccsc property is used as an index into the ccsc_base array. Use
an enumeration to describe this index, and add the new set of offsets.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Use an enumeration for the ccsc value.

 drivers/gpu/drm/sun4i/sun8i_csc.c   |  7 ++++---
 drivers/gpu/drm/sun4i/sun8i_csc.h   |  1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 18 +++++++++---------
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 14 ++++++++++----
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/sun8i_csc.c
index 9bd62de0c288..58480d8e4f70 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -8,9 +8,10 @@
 #include "sun8i_csc.h"
 #include "sun8i_mixer.h"
 
-static const u32 ccsc_base[2][2] = {
-	{CCSC00_OFFSET, CCSC01_OFFSET},
-	{CCSC10_OFFSET, CCSC11_OFFSET},
+static const u32 ccsc_base[][2] = {
+	[CCSC_MIXER0_LAYOUT]	= {CCSC00_OFFSET, CCSC01_OFFSET},
+	[CCSC_MIXER1_LAYOUT]	= {CCSC10_OFFSET, CCSC11_OFFSET},
+	[CCSC_D1_MIXER0_LAYOUT]	= {CCSC00_OFFSET, CCSC01_D1_OFFSET},
 };
 
 /*
diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/sun8i_csc.h
index 022cafa6c06c..828b86fd0cab 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.h
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
@@ -13,6 +13,7 @@ struct sun8i_mixer;
 /* VI channel CSC units offsets */
 #define CCSC00_OFFSET 0xAA050
 #define CCSC01_OFFSET 0xFA050
+#define CCSC01_D1_OFFSET 0xFA000
 #define CCSC10_OFFSET 0xA0000
 #define CCSC11_OFFSET 0xF0000
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 6b1711a9a71f..4ce593c99807 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -564,7 +564,7 @@ static int sun8i_mixer_remove(struct platform_device *pdev)
 }
 
 static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
-	.ccsc		= 0,
+	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
 	.ui_num		= 3,
@@ -572,7 +572,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg = {
-	.ccsc		= 1,
+	.ccsc		= CCSC_MIXER1_LAYOUT,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
 	.ui_num		= 1,
@@ -580,7 +580,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
-	.ccsc		= 0,
+	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.mod_rate	= 432000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
@@ -589,7 +589,7 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
-	.ccsc		= 0,
+	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
@@ -598,7 +598,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg = {
-	.ccsc		= 1,
+	.ccsc		= CCSC_MIXER1_LAYOUT,
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
@@ -611,12 +611,12 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.ui_num = 1,
 	.scaler_mask = 0x3,
 	.scanline_yuv = 2048,
-	.ccsc = 0,
+	.ccsc = CCSC_MIXER0_LAYOUT,
 	.mod_rate = 150000000,
 };
 
 static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
-	.ccsc		= 0,
+	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 4096,
@@ -625,7 +625,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
-	.ccsc		= 1,
+	.ccsc		= CCSC_MIXER1_LAYOUT,
 	.mod_rate	= 297000000,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
@@ -634,7 +634,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
 };
 
 static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
-	.ccsc		= 0,
+	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.is_de3		= true,
 	.mod_rate	= 600000000,
 	.scaler_mask	= 0xf,
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 5b3fbee18671..85c94884fb9a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -141,6 +141,15 @@
 #define SUN50I_MIXER_CDC0_EN			0xd0000
 #define SUN50I_MIXER_CDC1_EN			0xd8000
 
+enum {
+	/* First mixer or second mixer with VEP support. */
+	CCSC_MIXER0_LAYOUT,
+	/* Second mixer without VEP support. */
+	CCSC_MIXER1_LAYOUT,
+	/* First mixer with the MMIO layout found in the D1 SoC. */
+	CCSC_D1_MIXER0_LAYOUT,
+};
+
 /**
  * struct sun8i_mixer_cfg - mixer HW configuration
  * @vi_num: number of VI channels
@@ -149,10 +158,7 @@
  *	First, scaler supports for VI channels is defined and after that, scaler
  *	support for UI channels. For example, if mixer has 2 VI channels without
  *	scaler and 2 UI channels with scaler, bitmask would be 0xC.
- * @ccsc: select set of CCSC base addresses
- *	Set value to 0 if this is first mixer or second mixer with VEP support.
- *	Set value to 1 if this is second mixer without VEP support. Other values
- *	are invalid.
+ * @ccsc: select set of CCSC base addresses from the enumeration above.
  * @mod_rate: module clock rate that needs to be set in order to have
  *	a functional block.
  * @is_de3: true, if this is next gen display engine 3.0, false otherwise.
-- 
2.35.1

