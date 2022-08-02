Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A915876B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiHBFcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiHBFcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:32:24 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD1419B5;
        Mon,  1 Aug 2022 22:32:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3DDE6320014C;
        Tue,  2 Aug 2022 01:32:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Aug 2022 01:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659418341; x=1659504741; bh=Wt
        MXBT+59nWEb2J1x8DNZxQ7gooH85ypsgA1qbaYSaE=; b=tXm963gc+4S4p0cn16
        9zp3SYOM3N3+Qzw95uABkmcQoWsuaTjCWZqTE2HEMwKeVMQErigomgJYyS8dCbhs
        Ele0GjF2wgEVbObGKKqGRGobv4yWC0y7s6fTlNAjmf8IXC6doDSTAv6tBh08AgSq
        ZhGZBIhoYUoyNE6qyirIETObOHzTY2pvZhBy/LFaabca/xFUr5uGzmvewy74pFSU
        4/sVH5YZ8DxIwAMohzSgFbXqRpKFCWvCbgl+dB5n3pY4iQxGb9YbJnoOQVrV52tb
        odzomMQvGzqHgFeHX0A5oAd5hhhaOxwNQ3CvEiNbJf79o64gI+ZnnaKbm/8kuBZE
        8v/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659418341; x=1659504741; bh=WtMXBT+59nWEb
        2J1x8DNZxQ7gooH85ypsgA1qbaYSaE=; b=g1FdcSV+dV9CHdQ7BpcQgj1BJOBsP
        sLoIk6DdAAzfKeME0wDPttDcrRvOtmMMaRhIgTrvNymATa4TMAeh8HQucV2ORL/5
        cMLjVFadIk7tAdBAe98HdRU4MTnQcw2EnAcNr1YRYAIrkJZz5p7u2NmHS/9jhN1P
        B6pzf6JjSHA5Y4lDFFhFmw3n1P7HLH2Y65FzKZU3oabguszC7XnmpO1FeuHvqn8Y
        yu3nkoOgfNoyFxGL6SAnkdO6UOrKcACpRNDCaEKJYmlvdwrOnsH41b9TSZF4KqI2
        n4LIyryqenXxmHejo5cfCtljSHQR7Gnm6tWn/mmR2/jjIs4aMuaC3YFAg==
X-ME-Sender: <xms:5bboYihYGiW8g_qME4tTfXW1MKQEe1xPXmL24SW9dFzAZX0buSSikQ>
    <xme:5bboYjCVQbQ-k3em8bHTnDKHlaLxOO3yZYkfs05wBkGG--qolwzwQQZhuPw63-vxA
    SZfCUzaO51XdbA42Q>
X-ME-Received: <xmr:5bboYqH9lcu_IsLRh3dW9yTeIAFjgu_tyIS9qolZmCrZAd-8O3rTaUJh4xYfgU5qp8nfqQIuwnCQk9HGNGkgHC6w5zU6S-SNqIDgOYoJhpiWMzuxUzNmrLdDidYvdo6SBvdfQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:5bboYrQPCyQKn6uTzoACb5X3sqZ0S6FCDET243ydfssrD8ruqHn5CQ>
    <xmx:5bboYvwrBRfsAOUdCZlvOGfP6KK_ehZOWltCEH8zvs6v6RRXh3ucbQ>
    <xmx:5bboYp6-7gedzvpyd-YcztVUcymB6jkPRovaKSxHq3FVmnZcOcAxqg>
    <xmx:5bboYkq1PuGdl9ymO0Uz6HU6eWVdvJx51D_2dj2ExSC1u6aoMBVydg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 01:32:20 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/4] soc: sunxi: sram: Only iterate over SRAM children
Date:   Tue,  2 Aug 2022 00:32:11 -0500
Message-Id: <20220802053213.3645-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220802053213.3645-1-samuel@sholland.org>
References: <20220802053213.3645-1-samuel@sholland.org>
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

Now that a "regulators" child is accepted by the controller binding, the
debugfs show routine must be explicitly limited to "sram" children.
Otherwise, it will crash because the "regulators" node has no address.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - New patch for v2

 drivers/soc/sunxi/sunxi_sram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index a8f3876963a0..b3016b9698fb 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -120,6 +120,9 @@ static int sunxi_sram_show(struct seq_file *s, void *data)
 	seq_puts(s, "--------------------\n\n");
 
 	for_each_child_of_node(sram_dev->of_node, sram_node) {
+		if (!of_node_name_eq(sram_node, "sram"))
+			continue;
+
 		sram_addr_p = of_get_address(sram_node, 0, NULL, NULL);
 
 		seq_printf(s, "sram@%08x\n",
-- 
2.35.1

