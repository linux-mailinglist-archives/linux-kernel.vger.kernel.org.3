Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F959287F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbiHOEN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbiHOENa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:13:30 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31974140AA;
        Sun, 14 Aug 2022 21:13:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5963D3200564;
        Mon, 15 Aug 2022 00:13:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 00:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536804; x=1660623204; bh=Nq
        FKEkODlx0WhlIOI2ngbEzxnvj41xzTMmfpeow5T8U=; b=KscRtCvSYKbRtCLpwr
        Sp4z5EuprCpPXar0hKXZhnlD7Cv7VJOkMSoIB5WuG3bGOK0DhT69byuadTIkv/r/
        Rbzf5ulg8+KFX7rRqRCgY5kuqcE5XFQUoyPbSwDDA7fp4SZXIinRGqdpCLqTY86p
        UJiY/gds2GX5H0WcVwqUTIDFhm7shns3pQMsYabc3aZHNWrPaPuW2MQxn4xvhMqN
        +MilaUecbEEuRgw4V6FZxHzW4knY7quIBF06i/dnD1KQDPuMdNRSwO0xBx9QHNBS
        q/m37bKstFBSMH5UTh/ylYmdzUn9VkkHQtbNcGAt7PpJTkG61bQVQH1bJNcsonnQ
        Q5GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660536804; x=1660623204; bh=NqFKEkODlx0Wh
        lIOI2ngbEzxnvj41xzTMmfpeow5T8U=; b=KUU90m5RsYrHCN2++nqvIfeeMgWRd
        ujq9Uq1RXhSQSgKWbkDxBoNWr+NvMBzdRACtylRuXar3axPIgvavTrcbjj5oUoHS
        C8qI6Xl9FPbjOWCcbXZjVJ6HhudxjjmhPRH8FGPovhYW02UET+sXvUAAau0HYZmR
        pwGFSiBIgNvifJ5BJ502tgsfyWU49qjappoZxkH6ss8UTwWnV6H+UIuNyIhL7rAN
        JekZjIxpZV+9dG4b/jXLgCWvR6gag3qZiR5X235ByZDF/83glnL6RQNFoB9KsVIe
        LsbyuUBIc/D07J2PZgcCw/2MlM0XNdOdmyB4HnnzQ5gGM9ua04784Lx2A==
X-ME-Sender: <xms:5Mf5Yv2pbZ7xn0ypLSSAf0q9jgN0LZqTER1VQ-R9-LPRUQh41r0jog>
    <xme:5Mf5YuHKnF66UcbCapOFB0QL5sr91Hcjhfc3srWzvS3nM39jaPRdJrIiaJ9htWNw8
    jRV46vbbh9fNdEoGw>
X-ME-Received: <xmr:5Mf5Yv7f1EPGStzrnlc_k8CqbIe_qN2dy8uIE_DqMMvYUfmDkY5rY5ZQ6xSHk_iB8HZxDom2WO9RGcMz4MIk4jNqz-_8hXmwySMYYWN-LWbcW_r5SM2XNjQaeeb5HXDTTkyClQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:5Mf5Yk3_7CnVsmzOH1heQjQhCyfJQhzEyaG--ROEesV8K_TTDKjilQ>
    <xmx:5Mf5YiGmhyTv-y5-xWRp2WVVI769acCFK6t8XvbY5rTD_yP-2X9KZQ>
    <xmx:5Mf5Yl_-VbLY7OH_w8qFSAMD6RmmNAgeau7t4JPM20N1vdtMmzmOww>
    <xmx:5Mf5Yt9mdBW2FVywTZu9SLe8L6kCyKylf8h4P4GhLPEm3YbG5lzSNA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:13:24 -0400 (EDT)
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
Subject: [PATCH v2 10/10] soc: sunxi: sram: Add support for the D1 system control
Date:   Sun, 14 Aug 2022 23:12:47 -0500
Message-Id: <20220815041248.53268-11-samuel@sholland.org>
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

D1 has a single EMAC and some LDOs that need to be exported.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

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

