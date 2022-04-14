Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F15E5002FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 02:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiDNA0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 20:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiDNA0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:26:16 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCAF1EC72;
        Wed, 13 Apr 2022 17:23:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3210E5C024E;
        Wed, 13 Apr 2022 20:23:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Apr 2022 20:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1649895832; x=1649982232; bh=cmioWZ70r/nopRjrVq9ahyQq5
        MHB3bUw7EtLQ9BSxDw=; b=PW7yyMSR4S2D4Pt1omShjLjhE9/jqPee13xqDl2iE
        /V8MnfIoEeK1X2tnyLEYclOZTq3xXUONCJOiaakyRZsRYsLffH9ezwIl5KNBqZRw
        ANbw5AkcuKbmVBEbKG7Vwi8q2t8aMad7d4xA46y68Rdh40BAqKTosHI1MCxWUqpJ
        TId1YSDpMqKFBzfVPdHBW5au/bzjZG5nhsbGzA28KNSbqQXqSOPXrMbH7+oafdd/
        zQANGMYXLQvRGWSFERUTVf5S8F3XsL2CjtSwiybU7yupar5/lZ/epSNSYo/vJ5F8
        pfPCINqhyHOvGoGcODB2EflFI/Ad5jnFHs3Oogsi7KGMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1649895832; x=1649982232; bh=c
        mioWZ70r/nopRjrVq9ahyQq5MHB3bUw7EtLQ9BSxDw=; b=awOiwnMwOlD5E8IPf
        11niZhS7h7vNWK7kaIuoFd6rinND0EcRIDgWZVWOeBxMuY8BiM96BKyskgijHxSW
        ePzE+Fb8IHENHvMkvX8wSuqdNJD+LofGNA013sFGM7/bMB3DVIepbrFVcPPGn3zZ
        8tSkvF3kHR8wKIobO61rYap3KPpN63XAubudWJeNzvchCyqATY3VHXI5JwADAFXH
        G6sPX3CWixhMialSbuhhmsh1NuSsGddFnldesloKedvwPAlBwYqGvLcFv0HjOnxu
        tG0A/CtrQplkCHpv0/8WM8yvX7D8Y9NShTq6HCPoeDXraZTnj9rwwiXPbQ7ac2EG
        0hvaw==
X-ME-Sender: <xms:lmlXYtr3erofv0mgV_XK_fPTXvGlxu8VJNv-uiKxC4ldYJl6twZqJg>
    <xme:lmlXYvp_97G08eSZJ3G5K0aVeC6a5vanepmViRHJEi04B3VdugQcvimRKqnJEVqfh
    xuZPG7RLdKUtyOQhg>
X-ME-Received: <xmr:lmlXYqNxNOHrpsrblxWDHtMscta73p9aykmQPgQ3cyVdy8k--tVlCHm_27qlJEXPWYsXGqm5tnQYor7W-M1PuqGJrrJluboadQVD7_MqrC4qqFtc5Xr92Dv9CZvFiQJdjdPI7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:lmlXYo5AlGJbtiuYan4eqGrINNTHDQEgyxy4JexyjM-5vYfBFZTtPw>
    <xmx:lmlXYs7USg52QltORbKsos4wpcBJtZcEORL0fpM18AXoftnibykPEw>
    <xmx:lmlXYghM3KPabbhS3vWDWe2A1CtpX7S-GtZ5TWuFnRMY2yIVsI6akA>
    <xmx:mGlXYnLyK7pK3UgFPRZlRcD11gG5vnWDSS0ZUOvFX3qDYmqxFKJI9Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 20:23:50 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/3] dt-bindings: input: sun4i-lradc-keys: Add R329 and D1 compatibles
Date:   Wed, 13 Apr 2022 19:23:46 -0500
Message-Id: <20220414002349.24332-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

The R329 and D1 SoCs each contain an LRADC with a programming interface
compatible to earlier LRADCs. However, the LRADC now has its own clock
gate and reset line, instead of being always active.

To support this, add clock/reset properties to the binding, and require
them for the variant in the new SoCs.

Acked-by: Maxime Ripard <maxime@cerno.tech>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 .../input/allwinner,sun4i-a10-lradc-keys.yaml | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
index d74f2002409e..3399fc288afb 100644
--- a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
+++ b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
@@ -18,10 +18,20 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-lradc
           - const: allwinner,sun8i-a83t-r-lradc
+      - const: allwinner,sun50i-r329-lradc
+      - items:
+          - const: allwinner,sun20i-d1-lradc
+          - const: allwinner,sun50i-r329-lradc
 
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
   interrupts:
     maxItems: 1
 
@@ -68,6 +78,18 @@ required:
   - interrupts
   - vref-supply
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - allwinner,sun50i-r329-lradc
+
+then:
+  required:
+    - clocks
+    - resets
+
 additionalProperties: false
 
 examples:
-- 
2.35.1

