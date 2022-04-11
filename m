Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3A14FB2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244646AbiDKEh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244648AbiDKEhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:37:10 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CC812759;
        Sun, 10 Apr 2022 21:34:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id DD8143201F56;
        Mon, 11 Apr 2022 00:34:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Apr 2022 00:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649651694; x=1649738094; bh=ep
        miizdCaqCMESyl/+mq43QINmA/tnOXxGAGpcNLC7w=; b=gmVspqBUmpz9x3W9kw
        +GEvMIn0ZLm3C7loA1PIwZBMSzuJz+VQuYbhknanV9Jp0yfSlcBfHOj3o9W5lTH4
        6N3DNJBSlXXhj/Vhuv1PVrPK1c8MSbgRQXsuNSY+1/cUFhNrXERTP7niqOE6BujL
        /44nZTlZrHn116zoSM7jDRZ5HyjZvJPfDahpAHnT8Ur2k5c6IAarEUetY1fFJ5RK
        x2m25B1MrxO8nsjq3/3KuM6MlGK23MR5h68MKQHkK12uIRbHxM8FZStvxLj8JqVJ
        mMxSt9LI7NyCK5l5c5ZcoWkIZ+ItrrBN4cE+YsGFWmh5AjoRwlzfz1YEJsnv+nLA
        ulCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649651694; x=1649738094; bh=epmiizdCaqCMESyl/+mq43QINmA/tnOXxGA
        GpcNLC7w=; b=TTrcHSoioTz58R97+S9XDVeaPOqpcyOrlE5BesHoYGiQKdYTbFy
        ad7rE/GRC/0Rd92M97eWTuuAocTOyH4/p6ZKXvs2PuPTp6UXNgS0yMGDTMy3+mZv
        yzfF/1irV8w1UFyExvB3jvMEJyTyVfan21eyhywlayHvjj7A4yOTf6xA5Ph+o/wv
        XbrTzVaUXEg1j2BNT5nJPYrI967Rjwu6xYpiN22Sz9cwpPo5dMK0ivJzZkbKMvYi
        K8fgXHhFif5lw2Eb2b4OgjirgcqMicd/GIiXXcjfCQTcDoG1HV5ytk4RdJfFBvz5
        UD7f8yIhDWjSp1Yl+MWT1nkZZirD94oUXrQ==
X-ME-Sender: <xms:7q9TYoNvP6ykWvK3KHIU6BwTDV0Vb0f2WupyHlldqkEXjxOB4zh4GA>
    <xme:7q9TYu9I7APjSg4465sbPreGJI4J6bHv-8hdukZnj4DlppHDE-avJh8TlSzWsNWHY
    3pXX4ucQp24GArr-A>
X-ME-Received: <xmr:7q9TYvQf1mq1FzHKrELuYT5Viq2tdKdVy3Irek1zsH_mnPPVTwD2_St4DsA4yDu8NYvu_WjZcLcs4EiJCWJgbIO3_JNGEZLu1z5hD-AjFCjArybFEKliSdMko2S_ATREOO3znQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:7q9TYgs_tC9WrFitp-yG8AT5r91ywDrCvGtXhfB2r5v3xfBH1uLQIg>
    <xmx:7q9TYgd-yiQCGJKP3yBQCCI0ClUh4avIPwcWcpvDRUj_oXWRKpusxQ>
    <xmx:7q9TYk2PzFg5nCHBRTgw7yAf8WZEhp-p_ycaetHU3Z624D6DphkTXw>
    <xmx:7q9TYk0PiTJALpFEF-QkCWb-Sp0dTbjFKGcfbT6931Ma8OdjCIkyNA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:34:53 -0400 (EDT)
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
Subject: [PATCH 09/10] drm/sun4i: Add support for D1 TCONs
Date:   Sun, 10 Apr 2022 23:34:21 -0500
Message-Id: <20220411043423.37333-10-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411043423.37333-1-samuel@sholland.org>
References: <20220411043423.37333-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has a TCON TOP, so its quirks are similar to those for the R40 TCONs.
While there are some register changes, the part of the TCON TV supported
by the driver matches the R40 quirks, so that quirks structure can be
reused. D1 has the first supported TCON LCD with a TCON TOP, so the TCON
LCD needs a new quirks structure.

D1's TCON LCD hardware supports LVDS; in fact it provides dual-link LVDS
from a single TCON. However, it comes with a brand new LVDS PHY. Since
this PHY has not been tested, leave out LVDS driver support for now.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpu/drm/sun4i/sun4i_tcon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 88db2d2a9336..2ee158aaeb9e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1542,6 +1542,12 @@ static const struct sun4i_tcon_quirks sun9i_a80_tcon_tv_quirks = {
 	.needs_edp_reset = true,
 };
 
+static const struct sun4i_tcon_quirks sun20i_d1_lcd_quirks = {
+	.has_channel_0		= true,
+	.dclk_min_div		= 1,
+	.set_mux		= sun8i_r40_tcon_tv_set_mux,
+};
+
 /* sun4i_drv uses this list to check if a device node is a TCON */
 const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun4i-a10-tcon", .data = &sun4i_a10_quirks },
@@ -1559,6 +1565,8 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ .compatible = "allwinner,sun9i-a80-tcon-lcd", .data = &sun9i_a80_tcon_lcd_quirks },
 	{ .compatible = "allwinner,sun9i-a80-tcon-tv", .data = &sun9i_a80_tcon_tv_quirks },
+	{ .compatible = "allwinner,sun20i-d1-tcon-lcd", .data = &sun20i_d1_lcd_quirks },
+	{ .compatible = "allwinner,sun20i-d1-tcon-tv", .data = &sun8i_r40_tv_quirks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_tcon_of_table);
-- 
2.35.1

