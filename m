Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA835862F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiHADFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239547AbiHADFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:05:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEF55FF8;
        Sun, 31 Jul 2022 20:05:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5F1EE320070D;
        Sun, 31 Jul 2022 23:05:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 31 Jul 2022 23:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659323127; x=1659409527; bh=s9
        WFLVwZEMuAM0cTEBVsRJsr2wnA2LCJYYugauiDLN4=; b=IzLg2OYLjawKDfEsAG
        po40vB5+VtI7Z5Gmo0l+wXh2XvSwxARZqxPwviB3quisgaq3IDm+3uadU4ytz8fz
        crG8ajyNkvlS/mTkxnH4aJPH74Idi0toCD6qXMELnoaY9iwJGJPGJq4DDupTPGiJ
        Rd8AXDBTJRrBLwPPfi7bkMU8uxdMtQPAYhuLOlnzlFA7qcqZtanZOoKBD/Nnu21C
        CYlpIFJ3NzW8NPuzH7vbd/+lwcb+9lM0Tt/qhOhOyzfE8Q1LnpgcZr235noCBl6b
        76MID1mzjP5evlNYX4YwuCyME2ZzZet3kvjXcoRZhfXqfKnL2aPVe+GCOTv3rHd+
        1tGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659323127; x=1659409527; bh=s9WFLVwZEMuAM
        0cTEBVsRJsr2wnA2LCJYYugauiDLN4=; b=x57uUAk+TGU/KCeioNTbqrjy8IZYV
        BZtzneyPVOOxP9XhYk5RIaraxq7/0PaLq3njiA2+SV2X8V1h01BAMkGp1eMp4Kbr
        7NC1pZhLy8NcxFNrx7oe0WEB2Q02VeG3sInqLA8D2ftZlL3FM0lxPCDsMb0WTaCE
        cecnyKC6QgYCHJ0fs/Jq6awkBz3GU9uhijdyLQFrYPetjgIjy62fuavNSXj55hSS
        qhAP0hGD8VYhjyW/3ufYa1eFG8PgKRH1BGNigmDJLwOFDAEnrbMZgvzFaf5zZvKS
        kf1GugTkE2g62PPFpDHTTssP4b2G2hBbqXg8hV+7E946U0nxQn7kk2vjA==
X-ME-Sender: <xms:90LnYkhYoESI_OBcVmTSfsGFUCDh52r7LEv98pOMFdPHYd1mXiGHvg>
    <xme:90LnYtBi7GEwg3waQmk--Yuo8WLUil2o0xMMXG8xnnP_VjAFpUN0aKVRE83r_Zzer
    IOPasrro6MJfY9kTg>
X-ME-Received: <xmr:90LnYsFKjYFxZ14naB67EorePcJmla2BqynHNZejxxJBgUraqRguDtwf05IbCoU8XB8hFcekqMWqHZrn3v1oWyMamhH-lvTGcrDLVRGU0WsLFHDzS1JrrTImYG9F1cMOMw0ZUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:90LnYlSmIac1BXXicO04QSpC9U9u6HwwC0UN2r-YH6rui_FOGWGcmg>
    <xmx:90LnYhwOd845sjT54nO-4o-pW5e1l3ciblpOHAxtbM74_Gruzw_rRA>
    <xmx:90LnYj7GFKptQieG3Rh38AClOSIEy3h6QKVW_l81n5eURlzHxUmDeQ>
    <xmx:90LnYn7kgKsRMgggAkTMXy4SEb3he3saajRcKUJgVmz7O_TIlCI5vw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 23:05:27 -0400 (EDT)
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
Subject: [PATCH 5/9] soc: sunxi: sram: Fix debugfs info for A64 SRAM C
Date:   Sun, 31 Jul 2022 22:05:05 -0500
Message-Id: <20220801030509.21966-6-samuel@sholland.org>
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

The labels were backward with respect to the register values. The SRAM
is mapped to the CPU when the register value is 1.

Fixes: 5e4fb6429761 ("drivers: soc: sunxi: add support for A64 and its SRAM C")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/soc/sunxi/sunxi_sram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 52d07bed7664..09754cd1d57d 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -78,8 +78,8 @@ static struct sunxi_sram_desc sun4i_a10_sram_d = {
 
 static struct sunxi_sram_desc sun50i_a64_sram_c = {
 	.data	= SUNXI_SRAM_DATA("C", 0x4, 24, 1,
-				  SUNXI_SRAM_MAP(0, 1, "cpu"),
-				  SUNXI_SRAM_MAP(1, 0, "de2")),
+				  SUNXI_SRAM_MAP(1, 0, "cpu"),
+				  SUNXI_SRAM_MAP(0, 1, "de2")),
 };
 
 static const struct of_device_id sunxi_sram_dt_ids[] = {
-- 
2.35.1

