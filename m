Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F065592879
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbiHOENa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiHOENV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:13:21 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95031408E;
        Sun, 14 Aug 2022 21:13:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E758832004AE;
        Mon, 15 Aug 2022 00:13:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 00:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536791; x=1660623191; bh=qt
        OroOKPyiVLPusAb844jwRTjcP+oe0WxCpZbVu2Sb4=; b=mDOkrWDevbnKQAQnNb
        7FCIj33VQ8OtnacsGpCo3Fs5NMXWZMKlabCkmCnSBg/SKp2tzQvlzghhWj8EREnT
        d6e6L71sKgqFa1BRi4FrLJnve3Njbuf65jMd+zh2VaLS9B1ly5QKthX8gefPlkh5
        WWROdMrra++7ebDGD/ijXcotLk+wPGtuHE7BH5LPxM9VmMfsdiw0dEE4EdPATUB1
        ratBzIPgi5LIc54YJaJjXe/Rcl+y/e45kirpSJ3v5TpaRLo7wX/ckTy2uJ+BAGGO
        kxbHRID1du3rD/ilwwnVkePpi1yUDHoCY++58lchPR12gorYFY3NDjTaact9mIin
        9csg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660536791; x=1660623191; bh=qtOroOKPyiVLP
        usAb844jwRTjcP+oe0WxCpZbVu2Sb4=; b=RQTbTen2IJMqnvVjqRFoUhyGN+pV6
        DMxjKnbO1qtW5eUWgI64Or21/x7etVFqB1j8tOvshujEILuiUh76RsB4QGLRpYyN
        B4In1mCEMs4u1GpZxPASR7ae7bG0aIu6QyWauz5BuAFxOU9UpLJNzmeYTcvQu3n+
        8BtYjcGYDsQr3ftvcUf7SsBWGPwm3j9HrsFNObwtYPDdcm2gvkcKwbOxa4rs2IKL
        9DpgIyfJjGmrAOepdLr9d3eztgcGRGzT4N5SDR8lIrV44bu91TaK3PKCnzCBKE4G
        be7inzrgY+4L/Lpmb6juOOEC3Hvk9JAJyAvp9T4Y3JfWXaZFIQ6MrcaTQ==
X-ME-Sender: <xms:18f5YsCLmdLHpdg0DsR3fgaSLmk4aYx_cJWxl7lGyw9-4BGKiXEsXQ>
    <xme:18f5Yugc5TtJFQfcVytuSr1EQZl4rMD4IbvOfAmThtXClPo4wEhLfdIxluEAfI8xz
    PHl1Ng1AGROkNSmbQ>
X-ME-Received: <xmr:18f5YvkWxiWLOlxusNOOnsFrf1buJ-uD7Pfve4fP0sDkFPt-F6NBzTKlwlEcJ_0AriNKmvedztimooLCYT-ThqVVXYnicjqqAUQoKkDucz4fDIbRHcB3qBIj9-BELpF45GGFWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:18f5Yizqam7pJ2BJq2hPmmW4jpn3FF9QXnbJxfM1DxsuNZTzSDnCbA>
    <xmx:18f5YhQBvVY9uh5Q_4_S2Uby0weRT9lB64mbhSgj-yFJsslJ-Zqr2w>
    <xmx:18f5YtYJyJQ4gqKqKKWAISLefrjYYDtXf-YKnsKzRjP3fChjM7bm9g>
    <xmx:18f5YhY-bEovkuhcCp2hscLwe9K6BS5rQCeAwmFQmWWqrANgCZlyXw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:13:10 -0400 (EDT)
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
Subject: [PATCH v2 06/10] soc: sunxi: sram: Fix debugfs info for A64 SRAM C
Date:   Sun, 14 Aug 2022 23:12:43 -0500
Message-Id: <20220815041248.53268-7-samuel@sholland.org>
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

The labels were backward with respect to the register values. The SRAM
is mapped to the CPU when the register value is 1.

Fixes: 5e4fb6429761 ("drivers: soc: sunxi: add support for A64 and its SRAM C")
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

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

