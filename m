Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70FB50D36B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiDXQaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiDXQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:30:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66088789;
        Sun, 24 Apr 2022 09:26:58 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E9935C00D0;
        Sun, 24 Apr 2022 12:26:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 24 Apr 2022 12:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650817618; x=1650904018; bh=2F
        Fi/xkoVj6iwlrA1EObaufgO0Y0jToiRKkjZNAOp+c=; b=jTc4qXG4yQKZ1WF9Gn
        R07utbzOJAZatX33Gy9kFgYYzY5yIzdMyYLjm1ayPTVHp99zdlbevmBsEjJU4rlC
        Yp2LFUPTYykjhLNW/nFI29UPG/7eZRM0enUazQoz0QIgVL0ONbhbppzclMRhzAIQ
        g0Dv5c5JcMI4CsqzWxrZ43yRSy0A7ChrNNolyE6JFq1+KTd4i/KChgEqjb2gHnl/
        Y/cDqKvscJIISqsNaUWRHFbdNTFauxPiq4ly7HAvHDsAzaiHJ48flpZvjhLiTDuT
        Kdl08m4i5rACmERSnQJxCP3xm5zE4FsKJsz9fkYUoDcvhCSyjKJWRCkfx/kPKUix
        b2ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650817618; x=1650904018; bh=2FFi/xkoVj6iwlrA1EObaufgO0Y0jToiRKk
        jZNAOp+c=; b=UGga3K3DMlIU2u+sHQmZOGr7vY3No+13DlhU5cZdZGyOEXNp3Pp
        K25VsMFLwM2AD+OihomHY9U1OPdiyRiUdQzFClui4psPK3zGbFs16JjsR/945sHe
        AR6ZU0+qqyyE1b+O4UiCQp6dSJ4kzcJBBSViXtVMcj+qwmUGHfHC6yHj+cENw8/E
        9ZtIMCEw8TWXzT3Y4VTGxyLHdtdOw0HnXvEXvs1+SADuGvP2GhoxeallT9vNlLvF
        uMPE5GStkzaGLu1Fg5cstjBeYOVF1YfAz4RZQQ/wlAsBF7Iytm0tiHf7UBc8KIf+
        Gj+/UBmrigNl8pioG004aF0ixbod9iOC7JA==
X-ME-Sender: <xms:UnplYr6wEC-ZlHM9g09oqtdMUuo9Zute0X9hrMBbrGG-igyu2c4k9g>
    <xme:UnplYg4RBARiMRvsJAiHk8jNjjwA41oEB4L5qyQN8MbMqJuBivS5lkK8JDSzxmG95
    UNm-RtKpvDzApMzUg>
X-ME-Received: <xmr:UnplYicvVjFHTVPGihGVAAG_-Zhu2vf33b2pEJV0FNMz8D_xGvSxba86g7g96yxZdG3BU3MWysh7dp2TvHM2zdWXDC8FNyegVvl649CWSK1lSBTGBACbN1AFZmcqzsHlU8MqiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:UnplYsKJ5v6WEg6XvYLu_mMj2cAzXbj8Bc9QP4FvvxFiykESG8WrMg>
    <xmx:UnplYvK3CB9yU0YyAR3BqoARtaZekLQzTckkbs0CuXkCXKkGwjyAcQ>
    <xmx:UnplYlxa-Puuo9yqqeVGEOPgMcd4jQVJSC1uZ3ZyeoizGaUKEAOMkA>
    <xmx:UnplYhy8CZuS8sx4AGOrvt3GQ56kGXQ5qGuc727c-KJAQ6bnanYbPg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 12:26:57 -0400 (EDT)
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
Subject: [PATCH v3 12/14] drm/sun4i: Add support for D1 TCON TOP
Date:   Sun, 24 Apr 2022 11:26:30 -0500
Message-Id: <20220424162633.12369-13-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424162633.12369-1-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has a TCON TOP with TCON TV0 and DSI, but no TCON TV1. This puts the
DSI clock name at index 1 in clock-output-names. Support this by only
incrementing the index for clocks that are actually supported.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 1b9b8b48f4a7..da97682b6835 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -189,22 +189,23 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 	 * if TVE is active on each TCON TV. If it is, mux should be switched
 	 * to TVE clock parent.
 	 */
+	i = 0;
 	clk_data->hws[CLK_TCON_TOP_TV0] =
 		sun8i_tcon_top_register_gate(dev, "tcon-tv0", regs,
 					     &tcon_top->reg_lock,
-					     TCON_TOP_TCON_TV0_GATE, 0);
+					     TCON_TOP_TCON_TV0_GATE, i++);
 
 	if (quirks->has_tcon_tv1)
 		clk_data->hws[CLK_TCON_TOP_TV1] =
 			sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
 						     &tcon_top->reg_lock,
-						     TCON_TOP_TCON_TV1_GATE, 1);
+						     TCON_TOP_TCON_TV1_GATE, i++);
 
 	if (quirks->has_dsi)
 		clk_data->hws[CLK_TCON_TOP_DSI] =
 			sun8i_tcon_top_register_gate(dev, "dsi", regs,
 						     &tcon_top->reg_lock,
-						     TCON_TOP_TCON_DSI_GATE, 2);
+						     TCON_TOP_TCON_DSI_GATE, i++);
 
 	for (i = 0; i < CLK_NUM; i++)
 		if (IS_ERR(clk_data->hws[i])) {
@@ -272,6 +273,10 @@ static const struct sun8i_tcon_top_quirks sun8i_r40_tcon_top_quirks = {
 	.has_dsi	= true,
 };
 
+static const struct sun8i_tcon_top_quirks sun20i_d1_tcon_top_quirks = {
+	.has_dsi	= true,
+};
+
 static const struct sun8i_tcon_top_quirks sun50i_h6_tcon_top_quirks = {
 	/* Nothing special */
 };
@@ -282,6 +287,10 @@ const struct of_device_id sun8i_tcon_top_of_table[] = {
 		.compatible = "allwinner,sun8i-r40-tcon-top",
 		.data = &sun8i_r40_tcon_top_quirks
 	},
+	{
+		.compatible = "allwinner,sun20i-d1-tcon-top",
+		.data = &sun20i_d1_tcon_top_quirks
+	},
 	{
 		.compatible = "allwinner,sun50i-h6-tcon-top",
 		.data = &sun50i_h6_tcon_top_quirks
-- 
2.35.1

