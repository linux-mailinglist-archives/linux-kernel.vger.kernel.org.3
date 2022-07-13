Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C677572B82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiGMCw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiGMCwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:52:50 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E608AD4BE6;
        Tue, 12 Jul 2022 19:52:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2345E5C0167;
        Tue, 12 Jul 2022 22:52:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 12 Jul 2022 22:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1657680759; x=1657767159; bh=TH
        eS8xy4Zm5mdWzYbARJ4M+iZXKF70sJR2l6+NqN65g=; b=ioldxu42vU48K401aB
        B9epgJXtYbyEcPUMHhMS6S/fX2xo/PX5NVuie8OC4SSzeSaZxytQfZvlN1uqOXZ6
        SlXPUkosNfcmlsqwb8FW8EJZ+yguO9MYJ00prZFFu8g9vOcGbNzZ4nrQwdWv0pCw
        jka30OTLl3rW1nNaTR8G42t79Cxg8GkG6efCvv4rxBhUuOAk9NEwgxd117ScpEtq
        WVg1m8Ad5Dk0skxISWD2A16eJFwD7crwuDZD7lOirOJXMbbvnIP0Quk5Lyp7M6JC
        mdhNOxqDU9Z6PbfSsgWbcmz354rrqMIE3V3PBr7cLdhwi60GA+clPa7O5/CxYb4N
        8EVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1657680759; x=1657767159; bh=THeS8xy4Zm5md
        WzYbARJ4M+iZXKF70sJR2l6+NqN65g=; b=LA9TK9aW5CrKSvbrXeJaUKmXDuxdg
        9s+3rEBM92WXzdl+mNgGtBTLtabVopfY0Ny1rWVtboV15RRHvaTjcqsr/CuApQ4O
        LikRZUsOJ38T3uRJY62NIx3WJD6Ipk4mpFJGdfrTKzDPMiVrNYbsvBjdTww6DfzO
        TeAfO/v4FuUkw7zvbyUEG0aw1EiLJeBSzlgybi+aj0LX5xol0B9vPqCwHM+5dpAt
        PiC/gVv/+HqSsGBSnWpmcqLKM8bDkyluy19iK5P7l0S9D1LQeYHPzM/LLJLbZdoj
        8mWPct5UXlT/nwC59yg2AdYsy8JXLv/CaLYtQWJiwk3KUDW2AVHvpNKpQ==
X-ME-Sender: <xms:djPOYja6xPA_BNPtEhhOdn2Y_vJn43GJ852PxqmSz855SneLI0T3iQ>
    <xme:djPOYibpzQgObIiS8_CfQ-KtK_y3mNvWSyi8hjaMdxEHkarWJDl5yBRM-lOXuLzxD
    J3_3Wqh1TolK2onlA>
X-ME-Received: <xmr:djPOYl_BjJlckJNkBkxLA2Lo1X6D5x7nFvrsQmLJvsRSG8UrlLoWejByp7jAH1KlDF8EOSFVm_QnS9QogclvC26FJb6e4M-Paf0nAOznZh1vth3iRlwWJXZP5bab2A26QBALWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejiedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:djPOYpobIcHpAB93lsN-4Y3zbUn3lezAoTYqGisFw4vijG0K0_rBmA>
    <xmx:djPOYurgIDTaTH9CkRtWMFGh_-xzvEVjyrFT8cxAt2lC3NTqGgogmg>
    <xmx:djPOYvSbsIBHz5OyjR9SkvRLKPo2yqPBqBqz6xqV2n3D6wRu5_27CA>
    <xmx:dzPOYkgfPg-v8FFJ8fn-XQT2ZiC4E53qS7WGBXswUB2OhL7APTdv5g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 22:52:38 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 2/6] pinctrl: sunxi: Add I/O bias setting for H6 R-PIO
Date:   Tue, 12 Jul 2022 21:52:29 -0500
Message-Id: <20220713025233.27248-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713025233.27248-1-samuel@sholland.org>
References: <20220713025233.27248-1-samuel@sholland.org>
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

H6 requires I/O bias configuration on both of its PIO devices.
Previously it was only done for the main PIO.

The setting for Port L is at bit 0, so the bank calculation needs to
account for the pin base. Otherwise the wrong bit is used.

Fixes: cc62383fcebe ("pinctrl: sunxi: Support I/O bias voltage setting on H6")
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c | 1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c       | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
index 487a76c45f7e..3aba0aec3d78 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
@@ -106,6 +106,7 @@ static const struct sunxi_pinctrl_desc sun50i_h6_r_pinctrl_data = {
 	.npins = ARRAY_SIZE(sun50i_h6_r_pins),
 	.pin_base = PL_BASE,
 	.irq_banks = 2,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
 };
 
 static int sun50i_h6_r_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index d9327d7d56ee..3c5e71359ca8 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -622,7 +622,7 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct sunxi_pinctrl *pctl,
 					 unsigned pin,
 					 struct regulator *supply)
 {
-	unsigned short bank = pin / PINS_PER_BANK;
+	unsigned short bank;
 	unsigned long flags;
 	u32 val, reg;
 	int uV;
@@ -638,6 +638,9 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct sunxi_pinctrl *pctl,
 	if (uV == 0)
 		return 0;
 
+	pin -= pctl->desc->pin_base;
+	bank = pin / PINS_PER_BANK;
+
 	switch (pctl->desc->io_bias_cfg_variant) {
 	case BIAS_VOLTAGE_GRP_CONFIG:
 		/*
@@ -655,8 +658,6 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct sunxi_pinctrl *pctl,
 		else
 			val = 0xD; /* 3.3V */
 
-		pin -= pctl->desc->pin_base;
-
 		reg = readl(pctl->membase + sunxi_grp_config_reg(pin));
 		reg &= ~IO_BIAS_MASK;
 		writel(reg | val, pctl->membase + sunxi_grp_config_reg(pin));
-- 
2.35.1

