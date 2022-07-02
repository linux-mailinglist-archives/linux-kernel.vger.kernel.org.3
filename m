Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36E0563E03
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 05:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiGBD31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 23:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBD30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 23:29:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A1A1FCD0;
        Fri,  1 Jul 2022 20:29:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 685FA5C050D;
        Fri,  1 Jul 2022 23:29:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Jul 2022 23:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656732565; x=1656818965; bh=6jxn8F7BMajvrURVaJ+9NyqpY
        /x+IozbjnQEFfXY0Y4=; b=NnCHze/L+KfW3lqcfUGkF8rIueEvIyeP0Rb0z5dTH
        gWc3nLXwxmUQtAAISo2TMUTJh362HO9wlNHk5XQ6XDDA2MUJRXFeowDKKbuVHTpT
        dEj3EAbtAg5tgHNDyLlWU12mC6xQ8I0uCokcM1JoHVfEi3i0hsHp2DjsJ+1atJFp
        bKOJ907w2riAlq2G0UOlYaG0NQZ6EjzGLhCuo7YZMmrenbvXTkTWRrvowQcUmu1y
        J+bqpSz9y9VF79q9Jg/Jds76CB7iqoywSmQ/xfRyX5mttcCAjJLEUNsinK78Zvms
        W4IJZ5xSyXnnGnATasITkZAaFvdoEC2qBH1iPrDRbZaYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656732565; x=1656818965; bh=6jxn8F7BMajvrURVaJ+9NyqpY/x+IozbjnQ
        EFfXY0Y4=; b=ftE4GMxrdgPqspaMnDOlGiSiYxiwE7lD8A593OzwWvLk1JLxtgx
        ebXJy3MysxNOXXcX2Wnxe2RFxvvE+ij5JgD8HM41pxaNXbabSpbmCqlGWJMMjktY
        40NR/95K13zjNVyCtiLK8nKQF5c1TOLRNNMar4N6H0l7FgdB4WFEA2K4PW3BkH7F
        d532KVO/+xbZsUwiU5inNLWY3p4TFnZcB8PHGc9T7F6iT3stdsQ0BAFqJIZVOh2x
        7ca4A22zrU9sIAacW40BmKeR/kb6+kLjloURXIiFoMDVIkhGMYkTCFPySyBCivQA
        96Tkv71DOlOP20P2qAaJMY0ObjoWZcjWlWw==
X-ME-Sender: <xms:kru_YptiNjP_c8sFMZkaUjUjuHNlds4-6MXeEqWn0eOoiy8EjRIbMw>
    <xme:kru_YidamUMIX70hhYWCTieHCsm7yX2tXxFFrJl4KebLeuTIb88dlKCBXZJNftwe6
    Vx8YCcuUxYEIcxM_g>
X-ME-Received: <xmr:kru_YszEnnQIopX7kM0t8pBqUsL3rSgnWMFhI9tOZrzE-Re8BVzsCvOnBJhxo98mcjyZiEFBUcBeHgdfMPBNosPCeMqDWXHnXNz6HCpagjT4Cs_d26NPsfdJqtFkhkC5eMck4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:k7u_YgN_XOXPsjBR0Vw0exvNO_nZm1U77hivy4gK5cFvGXCPgfHFyA>
    <xmx:k7u_Yp-Khq9LsU8AWA4mnYAP48uKT6sAIHxxhbHAU7REbNBXrLNuKA>
    <xmx:k7u_YgV8TsoFP3lqlmtC-KDoZmHckmEzmKQSv9RYMjD8j8rUWqHhhQ>
    <xmx:lbu_YgWav0sAXsewrluJXov77byloh6AjSEAVr-iy4N2c1AjQbsqNg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 23:29:22 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] dt-bindings: display: sun4i: Fix D1 pipeline count
Date:   Fri,  1 Jul 2022 22:29:21 -0500
Message-Id: <20220702032921.22433-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

When adding the bindings for the D1 display engine, I missed the
condition for the number of pipelines. D1 has two mixers, so it
will have two pipeline references.

Fixes: ae5a5d26c15c ("dt-bindings: display: Add D1 display engine compatibles")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../bindings/display/allwinner,sun4i-a10-display-engine.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-engine.yaml b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-engine.yaml
index c388ae5da1e4..c9c346e6228e 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-engine.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-display-engine.yaml
@@ -94,6 +94,7 @@ if:
           - allwinner,sun8i-a83t-display-engine
           - allwinner,sun8i-r40-display-engine
           - allwinner,sun9i-a80-display-engine
+          - allwinner,sun20i-d1-display-engine
           - allwinner,sun50i-a64-display-engine
 
 then:
-- 
2.35.1

