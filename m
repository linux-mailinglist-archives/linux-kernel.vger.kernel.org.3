Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C275559286F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiHOENC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiHOEM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:12:57 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDEA13E3A;
        Sun, 14 Aug 2022 21:12:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AD0C03200124;
        Mon, 15 Aug 2022 00:12:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 00:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660536774; x=1660623174; bh=ya
        VqJui3bYeLRgRCIoQLia/sNzVVTMrxQMcj8Y31TN4=; b=lvSnByki87LxSF/liV
        ZUpi0T9/GeoQE+48s6UWVWpgFK6HNFbdtxt5I1/R3r6LlFiV6bih25qA9l6Ido+6
        j/35XGxSIquHzbbAf27f0j8lhWX/hPWzhGTr9NLoS/FrU8mAnPzFvBHMbnprtWrE
        gYp43gf7s0qMIapWKBLBr5v/PeeIjAGgb9OorLKvNGFz7yRKG675bH+s1OZM3Cep
        TRX2mMXiU+ucUpoEKG/R2pWTKvusjPhiyHXGQxkeLx+FfBDywejjd3Mz98isUI/j
        DoAtX/8NLpTAjHvWCfq6GjKdRbnBnX78HdFmEav1ZHMHcHbS94IQTJ+9GI1Aq7UK
        rqbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660536774; x=1660623174; bh=yaVqJui3bYeLR
        gRCIoQLia/sNzVVTMrxQMcj8Y31TN4=; b=Qk4yQrQmw2tJPb9TkWoOfocxpmi4n
        MVt7TLTnl9iCYRD9DKGKYLyRa9yQYnQb8bGghQQk+FD2awNOhUkx3WFCS15mmnfh
        /X/I9brApLp6skOY0+kJg/19hr2j1FOKa4F169VJXMBSLdczMWOAGVHJbodHSS5r
        07Z3TIsUANKNn78CwyJ5n7hUm8LE8dO6CkCPfavClio6XYUGC7NHQK/odpSF3SMZ
        FcuCLwi+sS5ej1T+ffrgv4wrvacBl+P+QULTheH94jWqZztoRzL+Ix8Iwz7ysDVa
        5X8dskipYCGzSZywlglBUINuSS3pnWAHP5zDh6kr/tgzdkl3CD7lKiGZw==
X-ME-Sender: <xms:xsf5YodNbwgDKOEE86mitGAbQrpG9L9XgeH02anCEIdd2X9_Bke7og>
    <xme:xsf5YqNodWnO3dXqi5LBZxbtyjoIpWGD7Ve5IaL_DJAphp_ockrDh1N5BD_5Y98HU
    1A4v8ycH0-dofHUhQ>
X-ME-Received: <xmr:xsf5YphXpCoCpZQ-LvnY5In0jmhDOyFXEZJiK7idwP1ezBeZ_prUZ9VYShpWHzPAvZvQQOfTm9LM0P9Rq5hUC1DmVNb179RPFA66YXAxCApqaXvpaSiq811ayvMH5_iNYD2sXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:xsf5Yt9Hr6M5b_tcIWBa44J3HXA4Zt5wp6XStqAtissxoE9O-DF3eQ>
    <xmx:xsf5Yku4Cwx3F58N2PnLYKGL_03y71f_VVzjYJo8cff8aJlcRchkTA>
    <xmx:xsf5YkF2mxj32gK2lSiQXSdX_AAyVQuEZL_5FgDzEXJDe9THg7ffkg>
    <xmx:xsf5YlEEuD3fh_eJk7TVPiw5WLRE6GHWJDD-eQaYucETpMicNlSZYg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:12:53 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 01/10] dt-bindings: sram: sunxi-sram: Clean up the compatible lists
Date:   Sun, 14 Aug 2022 23:12:38 -0500
Message-Id: <20220815041248.53268-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041248.53268-1-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org>
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

Use enumerations where appropriate to combine "const" choices and
deduplicate fallback compatible strings.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - New patch to first clean up the binding

 .../allwinner,sun4i-a10-system-control.yaml   | 81 +++++++------------
 1 file changed, 31 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index 1c426c211e36..5055c9081059 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -24,32 +24,30 @@ properties:
 
   compatible:
     oneOf:
-      - const: allwinner,sun4i-a10-sram-controller
+      - enum:
+          - allwinner,sun4i-a10-sram-controller
+          - allwinner,sun50i-a64-sram-controller
         deprecated: true
-      - const: allwinner,sun4i-a10-system-control
-      - const: allwinner,sun5i-a13-system-control
+      - enum:
+          - allwinner,sun4i-a10-system-control
+          - allwinner,sun5i-a13-system-control
+          - allwinner,sun8i-a23-system-control
+          - allwinner,sun8i-h3-system-control
+          - allwinner,sun50i-a64-system-control
+          - allwinner,sun50i-h5-system-control
+          - allwinner,sun50i-h616-system-control
       - items:
-          - const: allwinner,sun7i-a20-system-control
+          - enum:
+              - allwinner,suniv-f1c100s-system-control
+              - allwinner,sun7i-a20-system-control
+              - allwinner,sun8i-r40-system-control
           - const: allwinner,sun4i-a10-system-control
-      - const: allwinner,sun8i-a23-system-control
-      - const: allwinner,sun8i-h3-system-control
       - items:
           - const: allwinner,sun8i-v3s-system-control
           - const: allwinner,sun8i-h3-system-control
-      - items:
-          - const: allwinner,sun8i-r40-system-control
-          - const: allwinner,sun4i-a10-system-control
-      - const: allwinner,sun50i-a64-sram-controller
-        deprecated: true
-      - const: allwinner,sun50i-a64-system-control
-      - const: allwinner,sun50i-h5-system-control
       - items:
           - const: allwinner,sun50i-h6-system-control
           - const: allwinner,sun50i-a64-system-control
-      - items:
-          - const: allwinner,suniv-f1c100s-system-control
-          - const: allwinner,sun4i-a10-system-control
-      - const: allwinner,sun50i-h616-system-control
 
   reg:
     maxItems: 1
@@ -76,43 +74,26 @@ patternProperties:
               - const: allwinner,sun4i-a10-sram-d
               - const: allwinner,sun50i-a64-sram-c
               - items:
-                  - const: allwinner,sun5i-a13-sram-a3-a4
-                  - const: allwinner,sun4i-a10-sram-a3-a4
-              - items:
-                  - const: allwinner,sun7i-a20-sram-a3-a4
+                  - enum:
+                      - allwinner,sun5i-a13-sram-a3-a4
+                      - allwinner,sun7i-a20-sram-a3-a4
                   - const: allwinner,sun4i-a10-sram-a3-a4
               - items:
-                  - const: allwinner,sun5i-a13-sram-c1
-                  - const: allwinner,sun4i-a10-sram-c1
-              - items:
-                  - const: allwinner,sun7i-a20-sram-c1
-                  - const: allwinner,sun4i-a10-sram-c1
-              - items:
-                  - const: allwinner,sun8i-a23-sram-c1
-                  - const: allwinner,sun4i-a10-sram-c1
-              - items:
-                  - const: allwinner,sun8i-h3-sram-c1
+                  - enum:
+                      - allwinner,sun5i-a13-sram-c1
+                      - allwinner,sun7i-a20-sram-c1
+                      - allwinner,sun8i-a23-sram-c1
+                      - allwinner,sun8i-h3-sram-c1
+                      - allwinner,sun8i-r40-sram-c1
+                      - allwinner,sun50i-a64-sram-c1
+                      - allwinner,sun50i-h5-sram-c1
+                      - allwinner,sun50i-h6-sram-c1
                   - const: allwinner,sun4i-a10-sram-c1
               - items:
-                  - const: allwinner,sun8i-r40-sram-c1
-                  - const: allwinner,sun4i-a10-sram-c1
-              - items:
-                  - const: allwinner,sun50i-a64-sram-c1
-                  - const: allwinner,sun4i-a10-sram-c1
-              - items:
-                  - const: allwinner,sun50i-h5-sram-c1
-                  - const: allwinner,sun4i-a10-sram-c1
-              - items:
-                  - const: allwinner,sun50i-h6-sram-c1
-                  - const: allwinner,sun4i-a10-sram-c1
-              - items:
-                  - const: allwinner,sun5i-a13-sram-d
-                  - const: allwinner,sun4i-a10-sram-d
-              - items:
-                  - const: allwinner,sun7i-a20-sram-d
-                  - const: allwinner,sun4i-a10-sram-d
-              - items:
-                  - const: allwinner,suniv-f1c100s-sram-d
+                  - enum:
+                      - allwinner,suniv-f1c100s-sram-d
+                      - allwinner,sun5i-a13-sram-d
+                      - allwinner,sun7i-a20-sram-d
                   - const: allwinner,sun4i-a10-sram-d
               - items:
                   - const: allwinner,sun50i-h6-sram-c
-- 
2.35.1

