Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9C55AE2C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiFZCL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiFZCL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:11:56 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B1313E85;
        Sat, 25 Jun 2022 19:11:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 90DC432008FD;
        Sat, 25 Jun 2022 22:11:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 25 Jun 2022 22:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656209514; x=1656295914; bh=wy
        eR3lxXOmCAQeS8Gi1vPaFAP1UPTolRFL1liomH1uY=; b=UMRYy2VZTfJXilwIFX
        yXRA+QsmMl+TpKJZvAL/jt6lF6b2R96RXr4NW21RZT7dJCRPxiXmUuSUrbea8mMc
        qJfGRl7brmjm2IJ2oQNpCYqG5wu+kLzpY5GCCR0GX9P5YwIy3mHe3tsjky1gGvTM
        MS7Y9kQ57fH6LyikbdPWZC01AWovdwtIJsPAqhpy9fqEZ+a+nEe9YTFMLDB6MnMi
        jo76U63erM+QPAUr4kEGXqYFY9wRnncTQD73j5OmZfNcHBcdfcywibVHB7XwEk7x
        D6bTGjY5HGUVahcPit/BH8SmQ6F+GgNyibsACVEg/Yx3CpMrmuYBCJp3lXNBcHVk
        3y0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656209514; x=1656295914; bh=wyeR3lxXOmCAQ
        eS8Gi1vPaFAP1UPTolRFL1liomH1uY=; b=tZr2yA54Oo+Gvr0yxaoyy9Re09KuI
        06XV/Z6CCc8+VGRfg48y21eGZzZcpDxNiNK4swBTeiA+smgxgZoZdrG81JscVu4t
        hR5+gJgkUW5u3auoiEqt7yp/Z/4SOTziUYPX3xH4buiSn0TqrQuhJrFOQcM5nkzP
        BVL+goApqpRho5WVvzsLeeS4he6GYx3QCEXlHvLfg3IYbMxmYYIsM82N2HgZJW4K
        RGNAAzevFowaN4apvqlmK84YCg0sRnYnJq1gesMZ2+k6ykHulA05p3NhZjCmPNdm
        g/WUb5JOO6CYfNyu9cauG5LIaLyiAxd/LsbeW4NRjN0nmj9PVYNArtxiw==
X-ME-Sender: <xms:acC3Ypp8mmu0aS8kgDdSBDzew5WDlhCvpWKSV1vZFNmxgDpKtziP3g>
    <xme:acC3YrqFp073nP6tekECKZijxDHoSuIK6JCoV1eRI-IrAYa6YqbBYHmz44l7-DLcO
    9ROXFP89Z3osf2LGg>
X-ME-Received: <xmr:acC3YmNkUYoX864X-HB9MqKeZOGI_aF2_gBHGpGIzM1UTlNH73swzbsHbAw0YeMgVZf581uh4zrM5TXVudJBnjOdN33vMSIYCgerw65xyEeovJATEFIm8DYmeIcTsEqflW_uAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegvddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:acC3Yk4cAK8jy9e_SOr40EDGv7wY77pob-Zov-ZmWNo2tGl_WYWx0A>
    <xmx:acC3Yo7lpZS5bvkSA-BsQk2891RnQ78sVN_hhCZ3R1fgMhEFrQkt7A>
    <xmx:acC3YsjtrppmHdFd2LRs4SW3oldE2JaGtphdaWX7Hxo3erCrEvvaeQ>
    <xmx:asC3YogCfKGZ2GO6kuv9iDLeRnhEr2E7mpy3wFVL1uandePGq4n5Yg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jun 2022 22:11:52 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 1/6] dt-bindings: pinctrl: Add compatibles for Allwinner D1/D1s
Date:   Sat, 25 Jun 2022 21:11:42 -0500
Message-Id: <20220626021148.56740-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220626021148.56740-1-samuel@sholland.org>
References: <20220626021148.56740-1-samuel@sholland.org>
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

D1 contains a pin controller similar to previous SoCs, but with some
register layout changes. It includes 6 interrupt-capable pin banks.

D1s is a low pin count version of the D1 SoC, with some pins omitted.
The remaining pins have the same function assignments as D1.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index bfce850c2035..3da52814f151 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -46,6 +46,8 @@ properties:
       - allwinner,sun8i-v3s-pinctrl
       - allwinner,sun9i-a80-pinctrl
       - allwinner,sun9i-a80-r-pinctrl
+      - allwinner,sun20i-d1-pinctrl
+      - allwinner,sun20i-d1s-pinctrl
       - allwinner,sun50i-a64-pinctrl
       - allwinner,sun50i-a64-r-pinctrl
       - allwinner,sun50i-a100-pinctrl
@@ -171,6 +173,19 @@ allOf:
           minItems: 7
           maxItems: 7
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,sun20i-d1-pinctrl
+            - allwinner,sun20i-d1s-pinctrl
+
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+          maxItems: 6
+
   - if:
       properties:
         compatible:
-- 
2.35.1

