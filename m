Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDAE572B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiGMCwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiGMCwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:52:46 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF1AD216F;
        Tue, 12 Jul 2022 19:52:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B75E35C00CF;
        Tue, 12 Jul 2022 22:52:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 12 Jul 2022 22:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1657680757; x=1657767157; bh=ys
        LfvLvAELxN6JcUHANO7Xwphx6NIfvezWS0yoWb7IA=; b=HB6EjCOvzg6HB7IMAR
        3tfNXJT/YgSRKhRoKCVvxoU0DCL35T+w3pBhJ0zkgbxWbFdQDq/Hs0UVWGEWFTfO
        uVXpC6rHtK0TplgkG67DkS4xFYR3C70uT2WtkeIdPpLg20Tkhv+C1WkS8cEljwkc
        jzKiKTZW3fDdX2PR2MH7/kp8DcNbnCL9Fz3ekc6EYivRWDYDSQx/MHGrqkMura3q
        nUJ9pggAiVztyyhnARbkN3R6eo7zGBsc9XRfPGi2UmxEcQ2oIzLoxLcSJj8UzGCb
        pubXr5exFLptArSHxJpzlNwWJLFMDsNRzmP1OTTxo/Oqi6GG5Nk3vknljhJRaRlt
        fiKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1657680757; x=1657767157; bh=ysLfvLvAELxN6
        JcUHANO7Xwphx6NIfvezWS0yoWb7IA=; b=wW32wwSjxTEaOxh3JvyyIOHv5YV0E
        1tBLTIPJS2c0SXwadO4NqPo1NycSZWT1Wkz69ix0P53XMu2AYZ4k/e4zR+8BqfD7
        nIcrWXtFbu69xqeuE7xLsi1JAtemcUmc0LgzaMjt0vyLZpJWtv1s8BB6GoCgJ7HE
        c90YRVZkUDeyWtyQl6NBN1v1c87XrNVcIkZsD2r0I5zjs0hD1i/8dmXgx1PZEMSr
        q9ZQZd4RY4Ec/NUxHWfZ2QRvICmNRkt2kEwM+UrV5PHzLc1c0Emfm23Bw9gwLRIl
        mkfKdTdXCg3ECQML21+6LuEXkJbJ0e1eUtGmOGWpue7JIhcv/6M3vcTIw==
X-ME-Sender: <xms:dTPOYry8XNvfETFxmmiaUrtEyM1agvjG2f5hBByKhJU6fIiospISpw>
    <xme:dTPOYjRgUwUyrjpVEWvaDsoG-AR_GolSU26-pABG7RRslTkVt3PN4_CI3MuOXoM1i
    b9rAPz0u3fKeQN2bw>
X-ME-Received: <xmr:dTPOYlUGP-wY5U2Xbk-pSiX9m54WTslC0LjOKMgfDOBWy0aIEbSmsAm2bNi9TTjAaBehLEA8D7HRap6oF_Na1KtieKPw-ed83a37_dfjo7xVUZ9dRtaDS1GYmLv6dXQoVj1iSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejiedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:dTPOYlh8xQdrbTbwF8r0P6tc-3OQKsYjCaPEguiEhwx_HKmYNYiGpg>
    <xmx:dTPOYtDFMOp49n8MVaW6LXjlDXyiPT6HUVbTKkY8NY4H575jC_oCJg>
    <xmx:dTPOYuK1I8UYeSsIjffVEX7Vlr5Rtya0JVT5MOtJ1ukNuPaGKIxu9A>
    <xmx:dTPOYlxPedFg1ivR03Vv8rnf11lTJGPypnuirnUZeouQNUEjUd5S7Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 22:52:36 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 1/6] dt-bindings: pinctrl: Add compatible for Allwinner D1
Date:   Tue, 12 Jul 2022 21:52:28 -0500
Message-Id: <20220713025233.27248-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713025233.27248-1-samuel@sholland.org>
References: <20220713025233.27248-1-samuel@sholland.org>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Drop D1s compatible for now, due to ongoing discussion

 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml        | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index 6bfa46073791..d19d65c870aa 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -46,6 +46,7 @@ properties:
       - allwinner,sun8i-v3s-pinctrl
       - allwinner,sun9i-a80-pinctrl
       - allwinner,sun9i-a80-r-pinctrl
+      - allwinner,sun20i-d1-pinctrl
       - allwinner,sun50i-a64-pinctrl
       - allwinner,sun50i-a64-r-pinctrl
       - allwinner,sun50i-a100-pinctrl
@@ -178,6 +179,18 @@ allOf:
           minItems: 7
           maxItems: 7
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,sun20i-d1-pinctrl
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

