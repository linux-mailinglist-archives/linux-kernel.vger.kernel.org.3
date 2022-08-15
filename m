Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8935928DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbiHOEfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbiHOEey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:34:54 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D748815727;
        Sun, 14 Aug 2022 21:34:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 59B03320083A;
        Mon, 15 Aug 2022 00:34:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 15 Aug 2022 00:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660538088; x=1660624488; bh=Ak
        h2a1fDujqMH4YEeTbbnnaQ35ZklucjT/210qkRNQ0=; b=y08lZUOZXfu52ot0+9
        K7tGy3zkFw3TNgirtVvY5Dcp5OAXOwDKQ90qXRWIFBM2AxCOWPf+ZiIZvVfjgdRa
        NFkmH3uCHzSn8l+6Vbxm5UH90LN+JEpKGjhBhCp+DJtLvzpfaGNgBhkm0QbiTSVW
        b04eiJ0ViON9ys9OfXtfYueAqfot8SUuPisPzEtOikf34L98Gry2+uhJ86c5Mz+x
        qXfQi6YUYjaQQ/K/79DtLo10q2reQZCIQWbtt3La7XG/JX3moTTXW/MJhKoQz06X
        p+csGj2IHFK5260wQON5z5nHgl5ycN+np7Mp31UzhaUnm1h1yggdQkTrCJqiOe43
        /u0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660538088; x=1660624488; bh=Akh2a1fDujqMH
        4YEeTbbnnaQ35ZklucjT/210qkRNQ0=; b=0hCjihZFNeu/gXSOO9Ke7iNzTCZ1C
        ngo7qYhA2xyEGZr94gxOwtrkk7hvQ9nkmK+S46ifhA/3492+Z6x0gJpAXipezXI7
        GNaTLov+1hlhAG5oW3NU9puzdExdGBe1sSlVspxqtLtamp2dB7yUa4hIcbgSPfHZ
        YuQfSFUzl+9/Q6A4RA1itThXkx/pZhtORZroTeGJJsgcWt3UGVsutLihIVWIIEJP
        6vz1u3Ctc6dzOI00Oekmn50gKAq+DYYljqszJ2SKwxo4aOqGXDGmxc8P785JpV0h
        +l9LVW2yO2P/AhOZmJyFsWVBUHwzaVHMVFRjAemfLn/Y+Ik3QNCyEpdKw==
X-ME-Sender: <xms:6Mz5YiMr6rXhg7d7B09bpIyuzBKqJvIDpZCwwEMDTpfsOk45dM0fHg>
    <xme:6Mz5Yg_srz2OWV7_qWqaALuNdGJnRrhApMMxQbcwTd3OWgfufuK3ByR9Iv7160gjy
    3Qc2wc_-iZdfonbDw>
X-ME-Received: <xmr:6Mz5YpRUMekRIWr50m4JsWxCyvhMHvZNIiKUvNNT47RMou3EbbtfJKgdHxZLq2EYQeBS2oLtyTvH1YV_GMqRusJYpQZuD4njxWcoQRGTlqdkajPsmq_tEVeXJaPWcmPRxkmyzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:6Mz5YitnUTGgmoRPq9BfS9LX0BEbLUlqXjzy7KULB-2He-52XWd-Cw>
    <xmx:6Mz5YqdTQcSW2J0HaTGZTw3W-CJSD2PgokiS3MNUtDOm8bpMz3ZtVg>
    <xmx:6Mz5Ym1E07H2O8tcp4AgRFHL88nvZbVVuDp9o_KTdpz8pv3EPP_Zfw>
    <xmx:6Mz5YrUdUG9ChzqHCktpXIOm6dtW2hWXmQoVg70D_5bi2QovLkCE_g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:34:48 -0400 (EDT)
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
Subject: [PATCH v3 4/4] soc: sunxi: sram: Only iterate over SRAM children
Date:   Sun, 14 Aug 2022 23:34:35 -0500
Message-Id: <20220815043436.20170-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815043436.20170-1-samuel@sholland.org>
References: <20220815043436.20170-1-samuel@sholland.org>
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

Now that a "regulators" child is accepted by the controller binding, the
debugfs show routine must be explicitly limited to "sram" children.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 drivers/soc/sunxi/sunxi_sram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 92f9186c1c42..6acaaeb65652 100644
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

