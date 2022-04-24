Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08C50D360
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiDXQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiDXQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:29:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE6B8566D;
        Sun, 24 Apr 2022 09:26:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 49F305C0112;
        Sun, 24 Apr 2022 12:26:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 24 Apr 2022 12:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650817597; x=1650903997; bh=iZ
        8UlWzjvuD9578rf5+qyEth9oXMoy4abZ8+2x1E9TI=; b=LU+CgGYWItGih3EZoW
        2BA2xbYs6LRQaS2/4drtlMuO47F0oSD1SMjch+h/dsJM+48sV5MdVCE5oRwkq5Ei
        +3Nm8889pnsNNNEDSkaNIKum7de+aogyuFHzhHCeZTGj+8pcxhfBA5APggj5UNhL
        aXjcbCnHe18RKvlyn7kAoRAZghl1dmp0tQ6OFT++tbk9ykOFo/RoGj+Ub3RDs6Qf
        ka10ttlIm3K3UNqG7kekdnsS3Pl/YdcpKKgWOjBUQ2BGvEeaRamFOAAUE3V43tPj
        K2vJ6ONJCtEp1/Ox7s12yy0oSs9WpF+axg7vJpyjgFJP9z1E05BS129pxDb/bj4M
        qoGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650817597; x=1650903997; bh=iZ8UlWzjvuD9578rf5+qyEth9oXMoy4abZ8
        +2x1E9TI=; b=dKvZ9lq93DVs9J+rT5WMTSvg0j9W1BVyo3dNGkMlLF4uREL2eHO
        sI1VaTnyT8vXrZEwPpCw+SrezHcptZ4cfGLZ5L7514SxNhZIZG1/LsnhK+aP7Adc
        AsM000xnf14LgErHp1N3oTKm+3e/Q7YfcAOZSf1kWQSGyNI7RPC6duK7i9WS4XZg
        F2JR11/DNjY1p+u43ie8RGoF8YeKGFByjtr/XnyN9vaqM3fpW+HzG9OafF7juLVI
        84zYgMNkzpa2PUaoWLqqOEXHymO/XTUMg4kJyJyPOY3JsVnzZVkWNG1Gjm0SNj3K
        PSOmdSF0ggtWRWCocmjSzBcwbDHfUgrm2tg==
X-ME-Sender: <xms:PXplYsWZhgAKqMyHOR_DnqgPVUWZe3tuDEC0Uxs_-jES4NzPCO4ucg>
    <xme:PXplYgmTCAdCbUXC5SDiGu85KSsNBefECxI9UH7ue_aysW9tEwRybQO6d1EtvrQHm
    SXUjOzP9SPQjuzq7Q>
X-ME-Received: <xmr:PXplYgYJbQSrKrTmjnVXUC7UgNyQv9b8Z84-Zk07mbOHXg3u1fyUWWNWHXc3VSTVNOeJvdkEXW_qqv80bu6A3jWCDe7DokID4-sRiLExCPKITfeZ-pCJIoLA5YK48SQRPWBEVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:PXplYrWn86KOgknX24vf--Zuh13nlC_aVwUeZHu6tdFYe2VhOamEyQ>
    <xmx:PXplYmnKihdq0rWh5O46RgZ9SwDePWooMQwMgOO8eT3h-Wo6ZBY2_A>
    <xmx:PXplYgchpd_f6w9s_Tqhwh54oAdEq6k0CJ1EUYaw7a7r6KWi7zDXIA>
    <xmx:PXplYh_OPmYS69UDq-tyMKVbnN55bEXBaMIQGK7betR7PenICTVg5A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 12:26:36 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 01/14] dt-bindings: display: Separate clock item lists by compatible
Date:   Sun, 24 Apr 2022 11:26:19 -0500
Message-Id: <20220424162633.12369-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424162633.12369-1-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, the binding and driver have relied on the fact that the H6
clocks are both a prefix and a subset of the R40 clocks. This allows
them to share the clocks/clock-names items and the clock-output-names
order between the hardware variants.

However, the D1 hardware has TCON TV0 and DSI, but no TCON TV1. This
cannot be supported by the existing scheme because it puts a gap in the
middle of the item lists. To prepare for adding D1 support, use separate
lists for variants with different combinations of clocks.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Drop redundant minItems and maxItems

 .../display/allwinner,sun8i-r40-tcon-top.yaml | 105 ++++++++++--------
 1 file changed, 61 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-top.yaml b/Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-top.yaml
index 61ef7b337218..449fa99aa51b 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-top.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun8i-r40-tcon-top.yaml
@@ -48,31 +48,15 @@ properties:
 
   clocks:
     minItems: 2
-    items:
-      - description: The TCON TOP interface clock
-      - description: The TCON TOP TV0 clock
-      - description: The TCON TOP TVE0 clock
-      - description: The TCON TOP TV1 clock
-      - description: The TCON TOP TVE1 clock
-      - description: The TCON TOP MIPI DSI clock
+    maxItems: 6
 
   clock-names:
     minItems: 2
-    items:
-      - const: bus
-      - const: tcon-tv0
-      - const: tve0
-      - const: tcon-tv1
-      - const: tve1
-      - const: dsi
+    maxItems: 6
 
   clock-output-names:
     minItems: 1
     maxItems: 3
-    description: >
-      The first item is the name of the clock created for the TV0
-      channel, the second item is the name of the TCON TV1 channel
-      clock and the third one is the name of the DSI channel clock.
 
   resets:
     maxItems: 1
@@ -129,32 +113,65 @@ required:
 
 additionalProperties: false
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: allwinner,sun50i-h6-tcon-top
-
-then:
-  properties:
-    clocks:
-      maxItems: 2
-
-    clock-output-names:
-      maxItems: 1
-
-else:
-  properties:
-    clocks:
-      minItems: 6
-
-    clock-output-names:
-      minItems: 3
-
-    ports:
-      required:
-        - port@2
-        - port@3
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun8i-r40-tcon-top
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: The TCON TOP interface clock
+            - description: The TCON TOP TV0 clock
+            - description: The TCON TOP TVE0 clock
+            - description: The TCON TOP TV1 clock
+            - description: The TCON TOP TVE1 clock
+            - description: The TCON TOP MIPI DSI clock
+
+        clock-names:
+          items:
+            - const: bus
+            - const: tcon-tv0
+            - const: tve0
+            - const: tcon-tv1
+            - const: tve1
+            - const: dsi
+
+        clock-output-names:
+          items:
+            - description: TCON TV0 output clock name
+            - description: TCON TV1 output clock name
+            - description: DSI output clock name
+
+        ports:
+          required:
+            - port@2
+            - port@3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h6-tcon-top
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: The TCON TOP interface clock
+            - description: The TCON TOP TV0 clock
+
+        clock-names:
+          items:
+            - const: bus
+            - const: tcon-tv0
+
+        clock-output-names:
+          items:
+            - description: TCON TV0 output clock name
 
 examples:
   - |
-- 
2.35.1

