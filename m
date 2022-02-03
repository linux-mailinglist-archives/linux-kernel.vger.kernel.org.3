Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65014A7D73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348870AbiBCBgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:36:11 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35097 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348834AbiBCBgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:36:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 67D845801D8;
        Wed,  2 Feb 2022 20:36:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 02 Feb 2022 20:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=Qv9J1cRGGPx4g8yfYeZF9v08xNYwi0
        aJAWkB6MIlnNo=; b=PsTXpCgOT5MWmZJun82tGr+XVHga3TcF2KbdsfcUSlRJwr
        CM5n946W0YwpTidnusclb3EZmpdo7Yt+tJ8BCrm5gcCY0D6huNxovmFGHZDPzdqg
        OHuiUlQQxAc8zBKUq49HLu1y56QS+ecPM2YUyg+sRlX2ISvNVVl1QmEX1/TX5myG
        LmGOURKncuQsGkDAsKF8siYsqWtCEfCOUGQlOaI3Y6lBGUrF90K5m0glil/Fis4W
        ju+okkFbHMnVSJfS/8lFlD9R1LeOOLk2qQlprws0P9S4R/Fl2QftdF2CfTpCxAqN
        2SAxURcag3FPTdMG/hEA05rhgPkfpstmAJGkNaLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Qv9J1c
        RGGPx4g8yfYeZF9v08xNYwi0aJAWkB6MIlnNo=; b=oG6ujevragac52soTNNY5a
        v5PPCIYKTrEX8enK7AMQMfTMVQXQVDXeyHT6ZBzUvhaCFo6YprXNlWrMy/hoOexe
        GZfCD3fQlV04xemT3AqxESAZoVkSFoJ/9gqRrwSJAY8y1W6xE6wx0eRYCTzs67VM
        IVkaBloXm7GPvjtXW1RrzzwYlc6OcpsMUtlTPz/YCEeEpucs2ZMTc+VeU9FgtATC
        c1msKONWRvTHXIB7tx7IJduuLGoH7sijUmbEEeIMGJxqTGmCDll298HIDaBSYcKk
        elM2GWLQ+1I3yNHo7EKlOJ3uuPrUy0cGDfTnrkQfyTpuVNVgiqxcDaTAIjRrdWdA
        ==
X-ME-Sender: <xms:hTH7YbXjzgxgQrunYqBCvZI7PixE2Mj6UVm4_d6_7fyh3kcoCMqAWg>
    <xme:hTH7YTmufX3_X0glz-mbmqiez5WuEtzvNpc1WXpA0UhcLD6nACYl5lbc8-M_gwQG8
    _kxFOZ-gTU-Ng2Cbw>
X-ME-Received: <xmr:hTH7YXa89loeAW2Pss-OmISxfpSJG5iKjFG5svuxPro-WtYVR00JnEfFx93iC-WRxyEIwOvZSnlIeI1Ky19cNz6_uOa76g385e0ESF3Ob9XepucftpuCE1Li8drsh3GPCbSRcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:hTH7YWWuC75YL797VAW9eKKrlFMgzGPU1u1VDiggIaDVDkX02CwadQ>
    <xmx:hTH7YVnDBwGm1k7z_yc7EHTTeiG88FK2yeK5bY5yeI2qVPFGHj5HJQ>
    <xmx:hTH7YTe_wi5LNZao5QsXYdTCQGl6OJbw5J1ielHG-_IDaLSs0lDEzw>
    <xmx:hTH7YbcNc-gvENjmmJ9vgqbNwXZ1cnAiNirRm98gB8vCWxpI58HY4Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 20:36:04 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 4/4] phy: sun4i-usb: Add D1 variant
Date:   Wed,  2 Feb 2022 19:35:57 -0600
Message-Id: <20220203013558.11490-4-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203013558.11490-1-samuel@sholland.org>
References: <20220203013558.11490-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has a register layout like A100 and H616, with the moved SIDDQ bit.
Unlike H616 it does not have any dependencies between PHY instances.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/allwinner/phy-sun4i-usb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 6675dad17415..d5f3b42eb8ce 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -945,6 +945,15 @@ static const struct sun4i_usb_phy_cfg sun8i_v3s_cfg = {
 	.phy0_dual_route = true,
 };
 
+static const struct sun4i_usb_phy_cfg sun20i_d1_cfg = {
+	.num_phys = 2,
+	.type = sun50i_h6_phy,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+	.hci_phy_ctl_clear = PHY_CTL_SIDDQ,
+	.phy0_dual_route = true,
+};
+
 static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
 	.num_phys = 2,
 	.type = sun50i_a64_phy,
@@ -975,6 +984,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-usb-phy", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun8i-r40-usb-phy", .data = &sun8i_r40_cfg },
 	{ .compatible = "allwinner,sun8i-v3s-usb-phy", .data = &sun8i_v3s_cfg },
+	{ .compatible = "allwinner,sun20i-d1-usb-phy", .data = &sun20i_d1_cfg },
 	{ .compatible = "allwinner,sun50i-a64-usb-phy",
 	  .data = &sun50i_a64_cfg},
 	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
-- 
2.33.1

