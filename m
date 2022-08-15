Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE7D592875
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbiHOENP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiHOENI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:13:08 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9914027;
        Sun, 14 Aug 2022 21:13:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 18634320039A;
        Mon, 15 Aug 2022 00:13:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Aug 2022 00:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536784; x=1660623184; bh=6t
        +E/GzmpMJm/V9XelMviA0bo6ILpcPhq8GPa08Xnhg=; b=EjvkZeVAQKv1yhm0JW
        Wp9zDLMd5ZTzs+VktdeFb7T2SV7KUKv78JiIky7719C2mr3FJDHTLPd5wTFCGu5M
        s1zTKCUCtFQgkR1ObBWFjxCL3vGowJmA/pgQt2xzNtxbv/ccep20siuE7ea+cCBy
        3CnKavQhEI9E7433gsAjjo3X7yXfYpWg/Gr5jQk4Q4fOAzZjg/ukEJ0HtADmZYfj
        2/iR4b6CwGprRdGRPGyUoUReG/THGXfOXx65ONQBHXKTLt6mOt4l+Ejo0H6P7IEh
        FIOBhYEifdmpQlR53YIQSgauEzCQ/b2W9vLeo689OjrQF/X+9LXNZziqpbgZ0DLN
        OFog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660536784; x=1660623184; bh=6t+E/GzmpMJm/
        V9XelMviA0bo6ILpcPhq8GPa08Xnhg=; b=MJ70y6S9jjaVAuY2GY5h0/KySpe+Y
        /Y0k8N5/m+F21uJ61AdDQrHSviVI4T8rKrmt5ylikQpAkj/f+fN70q3sY861UL25
        jgCBXFyj97LDjY4yXIUt8acMvj8ITNMeFwjsr/Yhvfa8YmKJ6/2JZm1r7UcwgI+F
        KWhTmaSbGKHSixGw9e6PeTCkVBUl3YGbxEYcCg/fLu9O84+IJXulO1YkZ5DP/3Zl
        b+P9q/8GI2M77Wx5GTFVfdgrO2NmZmll847KYZTyM/jK77DyfFvseY+i6bFHfV/u
        W8BWAM46/AoO1/qbX1DNtyrasG134ZhhQV1vY39W04tEFwUIoCcSycYeQ==
X-ME-Sender: <xms:0Mf5YnnEzMuhgql3fQ5b0N4kHaDEDxx_7BIRKl19GYsa57bvdWCcPw>
    <xme:0Mf5Yq15NhR-0yAD_gpCZvbX1bHncQlWIvIxl2_o28b1FMM6IY-xLtH2UoR5EJxrv
    0c9d2N8p8JoVo-CTA>
X-ME-Received: <xmr:0Mf5YtqUX7Up2r7ffCSIkN7S17YBfPI5Vnu-k62rNebiH7OF85T4rjdotBhDokJeGuXrB4kJ0BYQKUgz-nlBtSE2iRc1rQc6lRpB54iQD18tsPkltq6fR7N0NAcpPsw7l9bSMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:0Mf5YvmoSaMppiOgbW_dRNxcDlRzo2j749irt3JpGegEA1ad_OIS-g>
    <xmx:0Mf5Yl1s_KNDdzdk6Sy6g0gZYoOsb5dgg49nqhpDl_f081C70QZQbA>
    <xmx:0Mf5YutNeKgnHkdLaeilbagXwcD3g6Pk8A_zxKCdU_HNKU-KZJIhMQ>
    <xmx:0Mf5YmuxOWRXnrtwPzo76e-VdPL6lPhN974Cly8v-JqJzPyWUf0Y4w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:13:03 -0400 (EDT)
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
Subject: [PATCH v2 04/10] soc: sunxi: sram: Prevent the driver from being unbound
Date:   Sun, 14 Aug 2022 23:12:41 -0500
Message-Id: <20220815041248.53268-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041248.53268-1-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org>
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

This driver exports a regmap tied to the platform device (as opposed to
a syscon, which exports a regmap tied to the OF node). Because of this,
the driver can never be unbound, as that would destroy the regmap. Use
builtin_platform_driver_probe() to enforce this limitation.

Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/soc/sunxi/sunxi_sram.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index f3d3f9259df9..a858a37fcdd4 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -330,7 +330,7 @@ static struct regmap_config sunxi_sram_emac_clock_regmap = {
 	.writeable_reg	= sunxi_sram_regmap_accessible_reg,
 };
 
-static int sunxi_sram_probe(struct platform_device *pdev)
+static int __init sunxi_sram_probe(struct platform_device *pdev)
 {
 	struct dentry *d;
 	struct regmap *emac_clock;
@@ -410,9 +410,8 @@ static struct platform_driver sunxi_sram_driver = {
 		.name		= "sunxi-sram",
 		.of_match_table	= sunxi_sram_dt_match,
 	},
-	.probe	= sunxi_sram_probe,
 };
-module_platform_driver(sunxi_sram_driver);
+builtin_platform_driver_probe(sunxi_sram_driver, sunxi_sram_probe);
 
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_DESCRIPTION("Allwinner sunXi SRAM Controller Driver");
-- 
2.35.1

