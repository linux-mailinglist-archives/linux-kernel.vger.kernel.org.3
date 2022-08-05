Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297F358B2E2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbiHEXox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241811AbiHEXos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:44:48 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003786D578;
        Fri,  5 Aug 2022 16:44:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 63F425C0126;
        Fri,  5 Aug 2022 19:44:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 05 Aug 2022 19:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1659743087; x=1659829487; bh=fnd7IRtL47oZ3GEXBeTqA34XltR+qlUApMq
        Kfs2uGec=; b=Vz49L/nApOKaHAXZ3mZVCxS6X8jFu5qXcksTJpPE0qaAODEGdcy
        IUkOqIUK3BngQ4Tz3v0zLGg9Fuao7xIzcAk7mGGCWwVXsaY6YfLPSnbB50rPrWaU
        +MZAl23NTuxivCMaVCjkQ32Z0BZ8BnbG1tUyabe/5vRiTNzfVPS+2bqxG3/Sj/pg
        +GfMxq7cRn+nrkXz3HsMSPqlcnI9lmGYuNzp5gqWKYd3tppm2ZYzmKs6EcYXuqFX
        3yq25V2ZUzcyfEKDVUeYt00m1EQHtpvxoMZY7NxIXGpSER2JOLSg+QQDGK01iWh+
        xKrHogXQJ/dYv4M48Y28by6N7sNoUPP1ymQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659743087; x=1659829487; bh=fnd7IRtL47oZ3
        GEXBeTqA34XltR+qlUApMqKfs2uGec=; b=pcM5qPbEsQahc07LTRg87k6zdImSy
        1ofRAmBB0r3qaanJRS8WtpF1LpN0GEtojhi0H9aluoXIpp1CSH2BdQJ5s5Aj3k5f
        FnOxbLF1NX2mF+YmM965U82sD4eB2hIdd1IuQgkVyBYK0YHra2MD/J3A7E9jkzn+
        ifBMvk+6xSpF7sF2e+jkKaTf52QovL6NKdFkP9MJ62nJOCkOyWPiorajwE4fGIcG
        H4Macjw7bitr7Rmq41tx+CmAlmNrT0Gq4To2oppRU46sMfe/Jwak40p2swKWhy27
        84Fy8KsGcMaHxLZkcPmeN38skdLmTXod/l3p+3jcQUyoJyQncN8cQ4YlQ==
X-ME-Sender: <xms:b6vtYqLOHtBrGxLmLDfZNa9o-y9_HxGrFqDKTQ0ytEYjeST_B-jcOA>
    <xme:b6vtYiKjEYyOgEFtdKv-YX7Zbrfx4CHex_CrzIrf9SwslpE2sBhF3KczhfOduG9IJ
    EMj574UhWTbtLBDIw>
X-ME-Received: <xmr:b6vtYqtZy1KtZqqZLIMh5ldSDgrOESravIXZpTQmpGDfjsxrJoC6X51n7o-bS3b9zaHdPVO6LhROAWNMBUUKZD1JzPEpMOJw_-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefvddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvohhmucfhihhtiihhvghnrhihuceothhomhesthhomhdq
    fhhithiihhgvnhhrhidrmhgvrdhukheqnecuggftrfgrthhtvghrnhepudehfedtkefgfe
    duieelgeegleettdehteefgfeuueegffelteeiiefftddutdevnecuffhomhgrihhnpehp
    ihhnvgeigedrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:b6vtYvY7rCu61ruXFtC-rsJ02-0CtOIN9fhSU1r9BRuoKGUDq2UfAw>
    <xmx:b6vtYhZQQC3I92tCT4ShZueN7ieDc6YU0Ob6tSm-1rxPk_JTVwX7jQ>
    <xmx:b6vtYrB5hHU57hTXsnGnP8cKV5vdLVRC7jnkmUlLmLosQNWkI0Eh0A>
    <xmx:b6vtYlqGdT0fy8w3yyFbbVVnQJlM-5_7P3CTA23vZ6HEwcdVhr2Orw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 19:44:43 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     tom@tom-fitzhenry.me.uk, megi@xff.cz, martijn@brixit.nl,
        ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add PinePhone Pro bindings
Date:   Sat,  6 Aug 2022 09:44:10 +1000
Message-Id: <20220805234411.303055-3-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
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

Document board compatible names for Pine64 PinePhonePro.

https://wiki.pine64.org/wiki/PinePhone_Pro

Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7811ba64149cb..8ddedbd1ce317 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -494,6 +494,11 @@ properties:
           - const: pine64,pinenote
           - const: rockchip,rk3566
 
+      - description: Pine64 PinePhonePro
+        items:
+          - const: pine64,pinephone-pro
+          - const: rockchip,rk3399
+
       - description: Pine64 Rock64
         items:
           - const: pine64,rock64
-- 
2.37.1

