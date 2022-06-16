Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8D754DA86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359162AbiFPG0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359157AbiFPG0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:26:12 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62253B53;
        Wed, 15 Jun 2022 23:26:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EFAC73200B43;
        Thu, 16 Jun 2022 02:26:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 16 Jun 2022 02:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655360766; x=1655447166; bh=B6
        6Ha6BawNI5v7cRXHK0sJIXUS4GnPz6lQgVNJ1yryI=; b=IVlm4kT+eA+Eu/+rpc
        Pq8+7roAl6iskpML1mlrdCp56hkrO1E2t/S/7jFYZQw3vxvt0bC5wrt2IETkT5+i
        6U4Rli4s9hE/t2ehUm+MgyN5rTrrwKL/Cn29KvMM4uM9n638tPSeMzOj0ccfmp1y
        VIbn53tRmExR8qIQ2BRWmravSraaQTqw7wh0QwfsWPw5DXIff2cxgATsqKn9THTD
        EYBOe/4LS9X3bVn6qdHeFdBO3w6AtbiE4czasBrcEXh9CUewGkKmuyTWIQsEW/9l
        tM5DG8ViNI4flI/9VHhqSqjnjLo3VdLxKkysRBGMZAqU7o1eKD+aAH2v3QqrCAZk
        pujw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655360766; x=1655447166; bh=B66Ha6BawNI5v
        7cRXHK0sJIXUS4GnPz6lQgVNJ1yryI=; b=vvXG2UPbKQsU/5BAOEja64obwY9m9
        /yltaHtzF1nubRwdvr4i3kzJlOwydcZY3eZmuhuAyNAGSphGIFqHIxdHB71f3jdL
        gg40cEyOyry0RAHmMr3sCD645T4Fw0HzjVqQDPCZ3LB7vO+z9A5+7N04yvXoNNhB
        hYQEkdnzDVZfaRVwh92ztoqiX3X9YHgfyLclsS8KUrRCzXwUlSsRsD8v65miPeRB
        dDofx07wLQ+R5+K/jaFl2irP4kBlwmcChv+ikvdY4d44eurrjJuLmWh5K7QHwwhA
        htK2pKOEQT06Kk5bwMHWID5hx9uqmcxMrK+Oeh3WaIzuriR+5WVANHwyg==
X-ME-Sender: <xms:_cyqYs-9zC4vzVwAdmFbBS8PEO7UHAIbqQnTwR3Y-u5mkXj51k9wkw>
    <xme:_cyqYkvnfqRH4tyGxHZpZFwTe_9GrTfnAVI54lLzTYqDPHUp7SnLo1laS9n1tHqK_
    -vrq6a3HtrK4K4NPA>
X-ME-Received: <xmr:_cyqYiA1WkjhdrDKVZqi9SSZZ7dk41topdAy8cE_NbAo4vvxVvcg8bBUt1cEdRwHGmtb8xWAvNeh_whm16oMcHzym3p_0VR7XXDRsq9ANzh6m8qrgkAFYy2jcfkXiGV5lr_Vww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:_syqYsfKhthcAxyPzjKZK106WNh3xL1sidzLtxt63E7d6m-egTAErA>
    <xmx:_syqYhPlSglZP4Z2pwuSIETtq6GD1mCglkkIf_ltjAU5GPrnLv3HMg>
    <xmx:_syqYmk3HWeak4GaVts3SvYkIlLvcpSjUtlayDHmiHPSkZBfwYLGVQ>
    <xmx:_syqYonmp-6xj7X4vInCLZnDlNl-CcUaVF3ZPI2SlfmR7GvIsrtSCw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:26:05 -0400 (EDT)
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
Subject: [PATCH 3/3] arm64: dts: allwinner: pinephone: Enable internal HMIC bias
Date:   Thu, 16 Jun 2022 01:25:54 -0500
Message-Id: <20220616062554.57266-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616062554.57266-1-samuel@sholland.org>
References: <20220616062554.57266-1-samuel@sholland.org>
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

