Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB758563E6B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 06:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGBEZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 00:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiGBEYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 00:24:53 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC828E31;
        Fri,  1 Jul 2022 21:24:52 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 31CD45C020F;
        Sat,  2 Jul 2022 00:24:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 02 Jul 2022 00:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656735891; x=1656822291; bh=LG
        V0UgiQ5BsxhP6kl4zQXzxA4vF4AWjRJhvCPcjVLAA=; b=mTLu5+HMsxS/tj+kVe
        0xH5f5Upim2cayZaeXIRca25FqAEFVsqJp0UFlZJ1m5M5of7cqYL39h0GRdXF78+
        aYOYBmxk9/6ieCibKJSPIVx1a+8m8pbsryCRYlNDL5EWn8iqeoeiwGaVUhnhjlTR
        bA7rsIZKAf79eXfFsUKLKQZe8k2wumK29lmnCVMpg8PPZczzh7hWNvm7VBTtQfDj
        4s3NEpyrpiPrgRfkLxdpLGP69GC4HYShiTzkzSf0zEx5s5GgZdIhHFym5m4L9Gf1
        mY7BW1IXNC56Strlv3KhitrniALbquDbVDV6c/AheeNDtlPgM7s2BnpZ2vqhd/ve
        +Lhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656735891; x=1656822291; bh=LGV0UgiQ5Bsxh
        P6kl4zQXzxA4vF4AWjRJhvCPcjVLAA=; b=vUGCkQ0awWg4+ubo+VMfiDcVKsFHx
        Q5y1kUwg4zUVDyP2oo5trdlvTWcvSfkYMGoBBTL1F1TvBu7GquOnanSz8ImyBQuB
        Ywr72cPHB4bIf3q5Q8lePoy3l/lMYSRFpLBk5hahmZWIf8z2vuwuIrR+Re+fGFV9
        p6kjShPJua30vLSm2qlcY6q7exuLOL3+GGfCx9NHcWWEPLlHQ8Vx44ZKBngZPNbs
        EiME5lyknBDaGs+xqJFtw325qaC3aCDUS3jyywinT2xRzadXwV3w6Gs4bdcw5jhc
        lUoYtWuNkNQPjIiTYjLZX0Z+tUv4Aco5xHdW+drykQWZDeib04m0XpKFA==
X-ME-Sender: <xms:ksi_Yjy__RLTikurpstx28oPU8GnXnKbctxpf_Vh-6Zh46qA1euMGw>
    <xme:ksi_YrRwIKtuXJdGF7IOTl_a9go82GiqvKoYB5X8MMqe5tv7-xA3CyfsA2x6T2RHA
    5tCT3XbBzjohZEzpA>
X-ME-Received: <xmr:ksi_YtUMYvcNSPEzWO7dIdleiN82wxYywLI8JJLDd_cZJ6F4tWW_JFxq8NUiIczIiHX0fvA3ZPWu0TTth7cPIG-NuJcQgIP5tuun2o1EV8f6eJnsXfvlP24bCdFhhznpU0vcJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ksi_YthAhjuCC0Bhc28NHmtZilEUn1WgoZiV8ccHUQVRMtxQQE5hzA>
    <xmx:ksi_YlBwz0ksZrNN7GKcnw6bC2rZLlp2uNRThOBVzXiCxdFlliQ0rQ>
    <xmx:ksi_YmJO4TbPU3LUggFt414FYJPu4SUxmoeOS-PadJPyM30_k3admA>
    <xmx:k8i_YptHjajYOfLN6sHdWiwyDyR0oQzedWYtVXN2SNx7RhjE04snDA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 00:24:50 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 2/2] dt-bindings: arm: sunxi: Add several MBUS compatibles
Date:   Fri,  1 Jul 2022 23:24:47 -0500
Message-Id: <20220702042447.26734-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220702042447.26734-1-samuel@sholland.org>
References: <20220702042447.26734-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the sunxi SoCs since at least the A33 have a similar structure
for the MBUS and DRAM controller, but they all have minor differences in
MBUS port assignments and DRAM controller behavior. Give each SoC its
own compatible.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
index 2b018feb56df..99566688d033 100644
--- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
@@ -29,10 +29,20 @@ properties:
   compatible:
     enum:
       - allwinner,sun5i-a13-mbus
+      - allwinner,sun8i-a33-mbus
+      - allwinner,sun8i-a50-mbus
+      - allwinner,sun8i-a83t-mbus
       - allwinner,sun8i-h3-mbus
       - allwinner,sun8i-r40-mbus
+      - allwinner,sun8i-v3s-mbus
+      - allwinner,sun8i-v536-mbus
+      - allwinner,sun20i-d1-mbus
       - allwinner,sun50i-a64-mbus
+      - allwinner,sun50i-a100-mbus
       - allwinner,sun50i-h5-mbus
+      - allwinner,sun50i-h6-mbus
+      - allwinner,sun50i-h616-mbus
+      - allwinner,sun50i-r329-mbus
 
   reg:
     minItems: 1
-- 
2.35.1

