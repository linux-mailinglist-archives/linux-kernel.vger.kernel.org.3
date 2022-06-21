Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC8552A01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345359AbiFUDzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345294AbiFUDzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:55:07 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0E61EC76;
        Mon, 20 Jun 2022 20:55:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B37FF32009AC;
        Mon, 20 Jun 2022 23:55:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 20 Jun 2022 23:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655783704; x=1655870104; bh=VR
        hWQHBguZsw8yrrHV1JpbZv0bAlRhTVvnAV7jTHX4w=; b=ioG//c2UFTlNLdI6/f
        mw7nqozZ1TMUk2nmIHpEr+9y9Bo6Rfzf0ID3Xu+BdCnTYFWY+c9aJtXBrFUTQY/H
        S0Jhp9ZMwQ4xW8gROGew+J0wA9KWfcT9oxKv+O3EKKAOUDqxpP07T7VLdf64b+Ab
        iIxA14zIyFihRKwqSEKj73UalCRUAXABAdcBxfEz6Q7pBFdOUjNe9FkVHqNWwMiW
        dl970xPjvSTco3SWbu280o8vQSg4NrF7lZzquRECJJnjaXW/DwANGbYQSmK696BR
        GlcLyYOBm3krFTFWYGdeo7oNtkWlJ6+0jMhqiPHxdGApVRENc5vtg/bNukR9QZFO
        /QHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655783704; x=1655870104; bh=VRhWQHBguZsw8
        yrrHV1JpbZv0bAlRhTVvnAV7jTHX4w=; b=R01ZE/sKfHaJ7Q35qldycLrEjPmgt
        Qu2gjuea1qgnrSVVtuR5k8BUAqdaHBfMS0i4XUdnDL5YenSivR+UB++YCXDazeaO
        5r1VBtzLLSOLbuCHYu9q+boLgfAkIHplzAMZvMFeX96P28w8qqI37eOA449kfA8g
        ulowo6ZfTlVtJbJe5tL1g9ENP3ELadZ3WNZfP4xf3z99Vgfi+MLTL++4An/eDxP+
        78yYx090yJsxxpOFSftb3BdwODjzSJV3B/IZjKou/GyldCZFd6p9tD+N46w5Xm4Y
        PcqLa+NxFIT89EQ3QRRIya6HxVcE8q5ghNqWMf7T2y3+MEhGIozM+2q4g==
X-ME-Sender: <xms:GEGxYsiBnbERuAyHXmBtTjSMwysllg0dWLYA4Bk1cgxM53LTezhcBQ>
    <xme:GEGxYlAOAH9uqScfS04cSV00HkWjDXBCwLoedJyWznPauQ6ih310Fvz8_pbar6VSI
    hgPd2b2CxtRFDahsw>
X-ME-Received: <xmr:GEGxYkFQAqnFGK_2GFmGU9VwCyQIPMaMHOepMIilCQSQfN21s3tjqwdIrCi5nRsF4k61njE2aO0xCXf2219a6YvqnORcTtjt-gkrCGTjFeDEjFn2RzxUwTKR8Aaescq0OwrkNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:GEGxYtT95agFMh9NGGXxhwWPvTCQFVGb_X8gj6RI-Czhj1z8K6k9wg>
    <xmx:GEGxYpxPrZ8qixAG9_ue4WURFz4HlpqlQadis23HwkFUTdnHLhSTJg>
    <xmx:GEGxYr6pB9-HN4w8idgpE5IYSt8RyeqnutLXuGg_I-t8AkPH6Y46jA>
    <xmx:GEGxYuKI6EVTipbaj696Y4FEoDfqx2YwpteO_KEjEe8DrmbN2q31og>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 23:55:03 -0400 (EDT)
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
Subject: [PATCH v2 3/3] arm64: dts: allwinner: pinephone: Enable internal HMIC bias
Date:   Mon, 20 Jun 2022 22:54:52 -0500
Message-Id: <20220621035452.60272-4-samuel@sholland.org>
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

Revisions 1.0 and 1.1 of the PinePhone mainboard do not have an external
resistor connecting HBIAS to MIC2P. Enable the internal resistor to
provide the necessary headeset microphone bias.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
index fb65319a3bd3..219f720b8b7d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
@@ -10,6 +10,10 @@ / {
 	compatible = "pine64,pinephone-1.0", "pine64,pinephone", "allwinner,sun50i-a64";
 };
 
+&codec_analog {
+	allwinner,internal-bias-resistor;
+};
+
 &sgm3140 {
 	enable-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
 	flash-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
index 5e59d3752178..723af64a9cee 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
@@ -29,6 +29,10 @@ &backlight {
 	default-brightness-level = <400>;
 };
 
+&codec_analog {
+	allwinner,internal-bias-resistor;
+};
+
 &sgm3140 {
 	enable-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 	flash-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
-- 
2.35.1

