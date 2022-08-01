Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4155862FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbiHADGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiHADGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:06:17 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121816253;
        Sun, 31 Jul 2022 20:05:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1645232006F2;
        Sun, 31 Jul 2022 23:05:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 31 Jul 2022 23:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659323140; x=1659409540; bh=Bb
        7CzXkKhp5csuOCYANASrOGgULw142EgcfR/Ui2Xlo=; b=kFK/x3bd2y3t+4f7V/
        ipEwT1FXIogxs8d7HnfQOr/FpAPuD3Qe3D7B8tEEDdmoE3WeEbfekNgp/n0a1AzS
        63+uGQQImcyI1+ZmitHQzKZUpUSq1KlypBlU2EwBA9feQolQGr2NDpiyaIfJtl+c
        Pd1HPnhpbbdgQiSR41LrwFnwAKuc4ALYh+EjoAvybAjba+oXqPE5dhX/Byfgzj7x
        aYV9Yuw9pNrSETTeeg5WXWu1fn8B61O6KaVuFhI/eLx8UTamRHP7C/MlcE6NPv/d
        Toso931iMuHeWChIWdqwbanDyaMCWlpZWQ4B9WtbRdLFmfSzVUaq+xLllsBCrFR7
        RBkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659323140; x=1659409540; bh=Bb7CzXkKhp5cs
        uOCYANASrOGgULw142EgcfR/Ui2Xlo=; b=1Qc9nEVDcCfx6LOc5vMJdhqM0i8T5
        9lG1+COlDz/av0jnpvF98VCbhn6RFwk8puy/kvGiok14mEEW/gwaHwauynSUwkNv
        Sc4Nlx6xgpAtaOWs9M6GRoYH6WnDSnbKhjrlADMHZYZK76YR28mwlmUzJf/Otn/O
        rgQTuGEuYi9gUcNhi9/LaWEoHZ43+DzgRigm6e3g0f/hpw3UseU/s3kwg7s6Feev
        z/qRqqZxwkwRHWebVJM8BaygvSaG0fyFwgQ0P9J12B6/HM+TbMOOWAJTEB1RbgM2
        LJbUFoKy7bOZVqFKJ7qLtMTGsCZb+P66FvW9uIMylYqseMSXxki4q5jsw==
X-ME-Sender: <xms:BEPnYnrjnZOZ5WlaI_2yMq3IEeUM78ezCgkJJS_dYYEu30FiFB1wiA>
    <xme:BEPnYhqTB30w88GnppPsZU_MI2d_9qAOVh62xxkqmPkjq1CT9tkkIOekrnLT2xbQQ
    ETXI6ssdg3OBE9Pug>
X-ME-Received: <xmr:BEPnYkNWuylt5S7pnVawEqZguNIWB0MQhZEZwsQF_Hm6zr9DUgc7ttw6of13DO7DpueMi660khOc9rCHXfO4mbcshvgc4cCBSqMeBBD_4Rn78Y-blq4WmaAegNKWgV0-VKhoCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:BEPnYq5Y6_jYeeAoTQn_nH25ueU4zzfmsXnbBok7HEhOFfrv3iEDqw>
    <xmx:BEPnYm7ajE4K972pSQWD76wNpGe82ib61pZALTWDy9qZONNbxc1wIQ>
    <xmx:BEPnYihxhkBQGZZqKtn-BjMwxDNWxp31hIVh-OOFFjrYJEsEUn9LjQ>
    <xmx:BEPnYugdu_PjKS-_r9hsnjisOq9wZ-djugHkLrs6aL14qfh3ltEaYQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 23:05:39 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 9/9] soc: sunxi: sram: Add support for the D1 system control
Date:   Sun, 31 Jul 2022 22:05:09 -0500
Message-Id: <20220801030509.21966-10-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801030509.21966-1-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has a single EMAC and some LDOs that need to be exported.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/soc/sunxi/sunxi_sram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 7e8dab0f0ec4..92f9186c1c42 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -294,6 +294,11 @@ static const struct sunxi_sramc_variant sun8i_h3_sramc_variant = {
 	.num_emac_clocks = 1,
 };
 
+static const struct sunxi_sramc_variant sun20i_d1_sramc_variant = {
+	.num_emac_clocks = 1,
+	.has_ldo_ctrl = true,
+};
+
 static const struct sunxi_sramc_variant sun50i_a64_sramc_variant = {
 	.num_emac_clocks = 1,
 };
@@ -382,6 +387,10 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 		.compatible = "allwinner,sun8i-h3-system-control",
 		.data = &sun8i_h3_sramc_variant,
 	},
+	{
+		.compatible = "allwinner,sun20i-d1-system-control",
+		.data = &sun20i_d1_sramc_variant,
+	},
 	{
 		.compatible = "allwinner,sun50i-a64-sram-controller",
 		.data = &sun50i_a64_sramc_variant,
-- 
2.35.1

