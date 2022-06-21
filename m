Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67F95529F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbiFUDzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345243AbiFUDzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:55:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B11D1C918;
        Mon, 20 Jun 2022 20:55:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 72A8132009A3;
        Mon, 20 Jun 2022 23:55:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 Jun 2022 23:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655783700; x=1655870100; bh=IV
        XbiXdpdoC7yhelNdR2IcucO5Ao9MT/MrT0BNZ4coY=; b=DD3jZqrlCGUciy45F2
        3LWHvr7jNU6Jafrt6YnTQMVnVHGZbkq0EsgeAs4u/7Z6byMvZ8RDj5BtJfS9uEjN
        H9222HyVP9Z6+ptqh0FbAaVGkegjpEqgp1TmBviKg+KA9/aIYFktNud8I7zSpFKB
        z800FXyNwzcPGFDNRG337ZccouDbbMW398ok8o5KENVvmUSy4IlT3N8JTSQIWiWx
        A8JkT9cPYj5a7LywTSeDMkW3AVafq6nOkZDsu3gh/oXsupnloKo5KoWyOkdg+uSF
        cA4UaqVFwAR4R/tWFanMaGkb/RTvtPVLrSPwTWgULGkEYoY72KLYJao+2V73nSEV
        gDrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655783700; x=1655870100; bh=IVXbiXdpdoC7y
        helNdR2IcucO5Ao9MT/MrT0BNZ4coY=; b=j6cr3/rM/fHch/9aHx6h+vlBZanNb
        /2/fNyCNM/fdGRkMk3M+6uavJtfqT/4GaL+WnNqfHdAS4QxBmnUjEmXf2uA3K3aI
        yHWDznXp1OU1s5R92VR2+9rfb1SczsWZ6U7iMNaWttUg/nkbHdTynX5jRwtEmFEz
        HcFMO1BEY64GnfkOCAjoof+Y1K9NYVocjPphjcMaK4B3zC5Aea3mrr6ORt5d3yy7
        SpShFSu638iiG5YWX0Lahn3/PZ5ijF0cHXnSgIkfDmbaptN6KTcSCzU5aCKOnqfx
        BS/5AGf1p3Tjq3dnfolRw3ADMVJDljMoOWxYpcQUwB0TBJLIHMnTNTibw==
X-ME-Sender: <xms:FEGxYgU-bQblQs3YSwvYJP_uw1qCj8GmkVbUTY7sME3gTJ0KtzlR7A>
    <xme:FEGxYkkCzqwClXiaicqlYklfQfrTgrusUxdyIWa4hr1oY6X9H_5C-q3BMJRpgDa8P
    OkEB5oNN0PXEh24bQ>
X-ME-Received: <xmr:FEGxYkbncAroiaJbw2YFXBdiEAwWIwoLySFGVd8tmlICWYTc2CVBqMa0bjAOMOWu1dwRBKNQAlqVKonwCruz5I57F0iJosKbh-u9UssibtROyXk9IF8LgTRE56lrg0ob35AN7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:FEGxYvXIRg8IScJBKusOtdXJJzw5GzZDU4rUXPLKKKXre97XTOOsIw>
    <xmx:FEGxYqlyzw23q6bsq2d2PsZIiqQnWtCQhsOiCuj52CbU-1EEjG44uQ>
    <xmx:FEGxYkdECgXBx_2-0B6X0i1cqj9P3QT1qN24S3Tkp95_LMOgO9Aijg>
    <xmx:FEGxYv8gZvOvqm3-ZLhNZ2foBALUqWgTjNm0IZM9eyNGydIB_YM9lg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 23:55:00 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/3] ASoC: sun50i-codec-analog: Add support for internal bias
Date:   Mon, 20 Jun 2022 22:54:51 -0500
Message-Id: <20220621035452.60272-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621035452.60272-1-samuel@sholland.org>
References: <20220621035452.60272-1-samuel@sholland.org>
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

From: Arnaud Ferraris <arnaud.ferraris@collabora.com>

In order to properly bias headset microphones, there should be a pull-up
resistor between pins HBIAS and MIC2P. This can be an external resistor,
but the codec also provides an internal 2.2K resistor which is enabled
by a register.

This patch enables or disables the internal bias resistor based on a
device tree property.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
[Samuel: split binding and implementation; move to device probe]
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Move register update from component probe to device probe

 sound/soc/sunxi/sun50i-codec-analog.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index a41e25ad0aaf..e1e5e8de0130 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -117,6 +117,7 @@
 #define SUN50I_ADDA_HS_MBIAS_CTRL_MMICBIASEN	7
 
 #define SUN50I_ADDA_JACK_MIC_CTRL	0x1d
+#define SUN50I_ADDA_JACK_MIC_CTRL_INNERRESEN	6
 #define SUN50I_ADDA_JACK_MIC_CTRL_HMICBIASEN	5
 
 /* mixer controls */
@@ -507,6 +508,7 @@ static int sun50i_codec_analog_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
 	void __iomem *base;
+	bool enable;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
@@ -520,6 +522,12 @@ static int sun50i_codec_analog_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap);
 	}
 
+	enable = device_property_read_bool(&pdev->dev,
+					   "allwinner,internal-bias-resistor");
+	regmap_update_bits(regmap, SUN50I_ADDA_JACK_MIC_CTRL,
+			   BIT(SUN50I_ADDA_JACK_MIC_CTRL_INNERRESEN),
+			   enable << SUN50I_ADDA_JACK_MIC_CTRL_INNERRESEN);
+
 	return devm_snd_soc_register_component(&pdev->dev,
 					       &sun50i_codec_analog_cmpnt_drv,
 					       NULL, 0);
-- 
2.35.1

