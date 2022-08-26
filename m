Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0EA5A2035
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiHZFKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243720AbiHZFKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:10:00 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CBB13F55;
        Thu, 25 Aug 2022 22:09:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 876303200A8A;
        Fri, 26 Aug 2022 01:09:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 26 Aug 2022 01:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1661490597; x=1661576997; bh=z7
        lZBk+lWpWVHAS9g7ZVqLJWmlt/GE8GcSu0rIU3M0g=; b=pxwPieo2ckaht51kXM
        fcHG6LEzMy6P4hXz55IE7wsTZ0fHJ9fltwFpNYOrNuTEYAP+DnbY0u+XlgM0HcIS
        PCO8BI5M5XiQOhVME/EVcscv1wiHLeRXqhBg71WPBFLf4uY9PaWN40gG3ACASuL+
        fEjaTTM7kUa6ObWRp5rmrN7Fr1qARbsHACqiBnSarr1PFAJpK8PZO0jxDF+Pw98y
        YGt7S6G8BJVx/RXUe/5pBw3U1WaVJd+StNp7Q+Gb6aUjdmKRVtlhrcNnfdq2KIak
        Tcp9s2sOAs8aBmNG0zTOYnG0o4pp+rFT4bQGoyDOTXB9PmeKe/JoSXqo8LBkkmfW
        lEXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661490597; x=1661576997; bh=z7lZBk+lWpWVH
        AS9g7ZVqLJWmlt/GE8GcSu0rIU3M0g=; b=j83JH9rLn8jNXlpWUz2dnr7QappjN
        Xwlp3IVOivdSx3mA9MXE9N/HhjpF4Uq4bb6th9LlCN5FQ66x+28rvuU2PwDY8sLN
        kUB/bHqapclqNq/ENyOcGFoXa8euKzhsnfrkjhkn2/BB+p+kW0KJwO2dxVT0MKzj
        5zCBroLEIC98oBqXZpPPTJsMfCRKSH6jkyp05ifLiHU/QORUv2472HnKgW5CmTvl
        IBwgzhgp7WWbGzXkBj2V8Ff/QxBfqOwKtTEGVNNI4zAxHzlvb8qrpr8ZjohlCgZA
        MzZBL6E/aFaSZmLFVdVmdPk7sw+dxjwiiPUTbgyJIn+zYld5k2KvzQ1vQ==
X-ME-Sender: <xms:pFUIY7QOxhYGdbsXVrqbZhgfHY65hHFnS7_IHdWa1mLDV0vlChjLNA>
    <xme:pFUIY8wWcJF40roWWY-v-JvtvgUJFF082TCTsCBfp0W76CAHr-WGgyT5EHy-D459X
    lqemNcoLVWBCOl17g>
X-ME-Received: <xmr:pFUIYw1VpYSAY7tTlQj-8ICywX4jzaNfOwkii00qfrbvcrU3rOBdU2wN0_AZ8FMD8eUwG9OS7MO-rVqPtIlXxLZoCvyyJMHgKV2ObMXywZqtOz2L9f0-CY52FQwLnKfu0-yALQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:pFUIY7BQrvd6OT1n1hHO85lbFBPHDuM6F2jJ2Qk0-I8evQtd_ftjDA>
    <xmx:pFUIY0g_OlBSfJSONLORVuQhYkeR1h6vSEAnWUlm4_WbU9FiIJQ1mg>
    <xmx:pFUIY_o97sQcFszRr6aLEXMGCjBXKTNiZs2XKNEim3Xt93Joaknrcw>
    <xmx:pVUIY5YzTxAIf_FtRe1EvQmp6YTDOcVbdw65uZecodXT2CnPBi5HMg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 01:09:56 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 4/6] arm64: dts: allwinner: a100: Add LED controller node
Date:   Fri, 26 Aug 2022 00:09:40 -0500
Message-Id: <20220826050942.20067-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826050942.20067-1-samuel@sholland.org>
References: <20220826050942.20067-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A100 contains an LED controller. Add it to the devicetree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v5:
 - New patch for v5

 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 5453a3bb7d81..d5d13ea46c15 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -265,6 +265,20 @@ i2c3: i2c@5002c00 {
 			#size-cells = <0>;
 		};
 
+		ledc: led-controller@5018000 {
+			compatible = "allwinner,sun50i-a100-ledc";
+			reg = <0x5018000 0x400>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_LEDC>, <&ccu CLK_LEDC>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_LEDC>;
+			dmas = <&dma 42>;
+			dma-names = "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		ths: thermal-sensor@5070400 {
 			compatible = "allwinner,sun50i-a100-ths";
 			reg = <0x05070400 0x100>;
-- 
2.35.1

