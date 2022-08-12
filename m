Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB520590A88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiHLDQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLDQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:16:32 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF19AFE3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 20:16:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8579B320083A;
        Thu, 11 Aug 2022 23:16:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Aug 2022 23:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660274186; x=1660360586; bh=eEN4SPCABGXPkuUYKnXW9SWU+
        dCnKerEicjfCo3KjfE=; b=Y6hbFDwFKkmF6RVegZVeNnfXwVr54p5hH9JtP8ywB
        xpJCi0oQ1Me2H2DOOdklWUV2jSKelWgvxXxdrhsgc6xEY4wz9hKfAtQRjX++gdZN
        ziRtfnNTCWNEu528c22syXvY/PinVpzhxiWwGz6ZG2Y6pdsml38QGuzZ4F/KoAY9
        RYlPwJXnRg5J1eI6jO5xcyk6TTmgEdW1ztkQGpKtKDbYjF2TR0k5auh+kbg7CIy0
        qqbLwDspbAhIO0cuyGkMdY2kThmJWhXglh9s6c6g74tcp2iaLswtr0WP+XEzYRFs
        qJ9MKa16KntqJXjnMq1ZPAZkynxMmqXeGX7RdC/ESGGqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660274186; x=1660360586; bh=eEN4SPCABGXPkuUYKnXW9SWU+dCnKerEicj
        fCo3KjfE=; b=UamtFwWoSpRzmtdXyf3hGbX9ehx7fps2l2mBxBTs5B0gx9YYqKc
        tJnr8lTBAsSW8dgyhl7YaqZjg/yCxXErX6HTXIf5RrRN6MOXIFEXBnUnNQOFQZvO
        YKB/aoTsn5AS3JHwDpTQy7nr48ez40lLEK7/NJIjmTaV0TVS2Z1vAbnp4d8A6Aps
        xEh7/oz5g08YsDs5IK8sTXPJLsRVFg7EuNbNQ/bPihzVeN0vDv7kZqXrxTH+cTHz
        yE9Q0smTf+imeGjRYH+ZJDv6rpttO6bDaJNcIPUgX/luXqskSFydUxi/77/dmJNd
        mPqTMfwfAJtsGL/hTRp0pfSVuAAlqLXD2yA==
X-ME-Sender: <xms:Ccb1Ykn1cX-qUVm71lU5MqnUfue_XKPqqRvCdc_fPygkKObNDRtpXw>
    <xme:Ccb1Yj0iJ1sT7cX2P6X0MC9PAeEewnQX5LjmzJWuyWb_-ldltrj9S8trvHzltyewd
    U1S_dOWtMa7HpNd0w>
X-ME-Received: <xmr:Ccb1Yiq6CGbED7hZuS30TkciVi0L2rFzkNpy2B18pq3yp9en5rap5cnsvRGl3bi0qdaadsXp7xmcm-uLB_Hje0HkaqvYDyW68QhRvs0YokaL1XyyQrJ9Ku-eZv6okWwNqCYD_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Ccb1YglslJidpdEpPwYNfT21xqzAk-U7GrejXzdoLxV8ysOxwNZajg>
    <xmx:Ccb1Yi3a0fLmaiYzWWG5TxsYiz3lQUBs5kM8PRujdCvwq62g8tGVWQ>
    <xmx:Ccb1YnvvwJW8Cbu5fjhKJ39Tu4LzbVxBiLDfvgqfJsArftCeppgbpg>
    <xmx:Csb1YjKBYkz5EFboar812m0mAc8khyj3jW7eXxhtqEVZDfm6m_qVRg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 23:16:24 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] drm/sun4i: dsi: Prevent underflow when computing packet sizes
Date:   Thu, 11 Aug 2022 22:16:23 -0500
Message-Id: <20220812031623.34057-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the packet overhead is subtracted using unsigned arithmetic.
With a short sync pulse, this could underflow and wrap around to near
the maximal u16 value. Fix this by using signed subtraction. The call to
max() will correctly handle any negative numbers that are produced.

Apply the same fix to the other timings, even though those subtractions
are less likely to underflow.

Fixes: 133add5b5ad4 ("drm/sun4i: Add Allwinner A31 MIPI-DSI controller support")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index b4dfa166eccd..34234a144e87 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -522,77 +522,77 @@ static void sun6i_dsi_setup_format(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_PIXEL_PF1_CRC_INIT_LINE0(0xffff) |
 		     SUN6I_DSI_PIXEL_PF1_CRC_INIT_LINEN(0xffff));
 
 	regmap_write(dsi->regs, SUN6I_DSI_PIXEL_CTL0_REG,
 		     SUN6I_DSI_PIXEL_CTL0_PD_PLUG_DISABLE |
 		     SUN6I_DSI_PIXEL_CTL0_FORMAT(fmt));
 }
 
 static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 				    struct drm_display_mode *mode)
 {
 	struct mipi_dsi_device *device = dsi->device;
-	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
+	int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
 	u16 hbp = 0, hfp = 0, hsa = 0, hblk = 0, vblk = 0;
 	u32 basic_ctl = 0;
 	size_t bytes;
 	u8 *buffer;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
 	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
 		hblk = mode->hdisplay * Bpp;
 		basic_ctl = SUN6I_DSI_BASIC_CTL_VIDEO_BURST |
 			    SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS |
 			    SUN6I_DSI_BASIC_CTL_HBP_DIS;
 
 		if (device->lanes == 4)
 			basic_ctl |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL |
 				     SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
 	} else {
 		/*
 		 * A sync period is composed of a blanking packet (4
 		 * bytes + payload + 2 bytes) and a sync event packet
 		 * (4 bytes). Its minimal size is therefore 10 bytes
 		 */
 #define HSA_PACKET_OVERHEAD	10
-		hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
+		hsa = max(HSA_PACKET_OVERHEAD,
 			  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
 
 		/*
 		 * The backporch is set using a blanking packet (4
 		 * bytes + payload + 2 bytes). Its minimal size is
 		 * therefore 6 bytes
 		 */
 #define HBP_PACKET_OVERHEAD	6
-		hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
+		hbp = max(HBP_PACKET_OVERHEAD,
 			  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
 
 		/*
 		 * The frontporch is set using a sync event (4 bytes)
 		 * and two blanking packets (each one is 4 bytes +
 		 * payload + 2 bytes). Its minimal size is therefore
 		 * 16 bytes
 		 */
 #define HFP_PACKET_OVERHEAD	16
-		hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
+		hfp = max(HFP_PACKET_OVERHEAD,
 			  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
 
 		/*
 		 * The blanking is set using a sync event (4 bytes)
 		 * and a blanking packet (4 bytes + payload + 2
 		 * bytes). Its minimal size is therefore 10 bytes.
 		 */
 #define HBLK_PACKET_OVERHEAD	10
-		hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
+		hblk = max(HBLK_PACKET_OVERHEAD,
 			   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
 			   HBLK_PACKET_OVERHEAD);
 
 		/*
 		 * And I'm not entirely sure what vblk is about. The driver in
 		 * Allwinner BSP is using a rather convoluted calculation
 		 * there only for 4 lanes. However, using 0 (the !4 lanes
 		 * case) even with a 4 lanes screen seems to work...
 		 */
 		vblk = 0;
 	}
 
-- 
2.35.1

