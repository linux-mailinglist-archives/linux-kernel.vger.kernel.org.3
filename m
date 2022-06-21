Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148E3552A05
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345244AbiFUDzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345190AbiFUDzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:55:00 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B81C13F;
        Mon, 20 Jun 2022 20:55:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 295F0320099F;
        Mon, 20 Jun 2022 23:54:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 20 Jun 2022 23:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655783697; x=1655870097; bh=86
        BF35YR8RTtkcmDKUgoRNK6UpY6pnyRSrVvGNnlz9g=; b=Jw48CXpLh3an5V8nrP
        Ltgws+4BesFtuxvoEAFHkcNLEoWdzuD5pjfH6TxdsTVnRNa7jG+iVg3mAbI2mhHs
        A2x5dJ+X5THf/eVVTyAFxIvBwWp4Zh37oXZaoDfs8PR6lMzIIDTCH1WOElxwWBA3
        J/euHa0jYgDLo3gOSQBsz6dl5xu+bCpMsmq2onvDz6uHp0aHc5RwFXY11n/GFuYC
        J9X/NiL1ZVfBYRkYpzD2XhB2MxL1NR4h/njuBoBBqV6LcHDHV9ZsqV/Z6twymJPV
        BQ8Xgv0AV7zl99vClDA6vLe3b1ZdLiYOK6qS29Y3KKWBLwwbkcgsZ9c5il4aOyCU
        I8CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655783697; x=1655870097; bh=86BF35YR8RTtk
        cmDKUgoRNK6UpY6pnyRSrVvGNnlz9g=; b=dQzQzX1Lw0EIWEw7GANiKcSDyOpuv
        Y9piGt8R4jtKXBMDkCOHVaEYWOvyG+S/ICx1s3R9F6PaX1ZXl2AuXohzB/r4D1DM
        hK6jQw+tG4RtBRKstyuveBmDAxCH3B//qA0pr1y6TwYll4mgWAJFdY3/C09LQ7ef
        uOWHtONmh+m9IPhlnWnp3TUnHelJ+j8bqKpAY/hZYGJNhQNiC4/LlBKZ1W/ud5IJ
        rzsbtH/lP/Fr+53op8sEuJJkUPetq2FHyk6G1fhtnfsAH3gC+vLZQXG669aFt9Zw
        SD+GGosCdGTFuas01d6b0pOH1xVYM82NtiUm3Z4iDAJlXR8KeGFa0QBog==
X-ME-Sender: <xms:EUGxYrkOSC6wi-LDrCVHTGJxdkz27wPaf8z0Cga4Si59goD6WeDMIw>
    <xme:EUGxYu2WarqnuAark-0AUHPNsLXJd9g_TO_dKKZQ0eFqGsV3qoVLh8La1CZ2KAuHG
    Hi71fwIxgSSTx3L1g>
X-ME-Received: <xmr:EUGxYhqJ18IBqLME0tkWVUKV09iKoSB03JOOAubRcgQFQEpTD4B2EzYsaMtjiOskRw_XqjFjX26edT6sGXB_nBaLOvAMy7s7NxQQykqXk_oNQpRpwTLsptTgOkajMMDhfvBS6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:EUGxYjkozs-on3jLGeNHpflO9qhE2gUWhulCWeML9EiSew0Yo1I00Q>
    <xmx:EUGxYp0aunE1vHp2qhblD4HCCIc1IjAU-AAEbz99LokCQ8uy52vTmg>
    <xmx:EUGxYiv_yM_VIrCbERGpnfw5ZdHKlbX8Gtl9bcEyP_SUziF4CUYl0g>
    <xmx:EUGxYjMJYo_GR8pIRNlb3tiiafYo8XMRhy7aaiWBxhwjKYgr8i9Vqw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 23:54:56 -0400 (EDT)
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
Subject: [PATCH v2 1/3] ASoC: dt-bindings: sun50i-codec: Add binding for internal bias
Date:   Mon, 20 Jun 2022 22:54:50 -0500
Message-Id: <20220621035452.60272-2-samuel@sholland.org>
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

This patch adds a device-tree property to the sun50i-codec-analog driver
to take advantage of this feature.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
[Samuel: split binding and implementation patches]
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 .../bindings/sound/allwinner,sun50i-a64-codec-analog.yaml    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun50i-a64-codec-analog.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun50i-a64-codec-analog.yaml
index 3b764415c9ab..66859eb8f79a 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun50i-a64-codec-analog.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun50i-a64-codec-analog.yaml
@@ -21,6 +21,11 @@ properties:
     description:
       Regulator for the headphone amplifier
 
+  allwinner,internal-bias-resistor:
+    description:
+      Enable the internal 2.2K bias resistor between HBIAS and MICDET pins
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.35.1

