Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785025928DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbiHOEe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbiHOEes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:34:48 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E0614D2E;
        Sun, 14 Aug 2022 21:34:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 97A35320039A;
        Mon, 15 Aug 2022 00:34:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 15 Aug 2022 00:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660538086; x=1660624486; bh=XH
        2cIlWZsk/PrlJIdXb2Jov0BbOTJ4OiPzQM4O8yc7o=; b=ce4GHGTG84XpdwddCX
        gJ7V9nSj6ywVsKqnbZudmG7S2xA5EA0kfCF9/2gJ+6BrbCLqjOjMqydgCfECguWg
        wEQOaAS4vCJwoNHdILkaM5tQ9+GdxojkjNuQ42+geC1+XgA9EXIrKQW6fsFVEZrV
        U64j1DC8h9xqezfZj88ncxsjZjd82EDv1MMyKl2JuvmBuzXfiOjwPeH7KeBoSrdm
        LgUoBpixT1uqYogI/37lvt+lXZAmT5mXW62WfhfEE8/7liTvUZb3eQ1lYfeHHeZ/
        /FeiQzmGlhADMgToXvG+oTH7EckVyHgZA8WQlCsqfgqh80ZLj/3hx8dvLD+etytB
        vbJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660538086; x=1660624486; bh=XH2cIlWZsk/Pr
        lJIdXb2Jov0BbOTJ4OiPzQM4O8yc7o=; b=se4Y7TsqorqvAjfC85OfF3TvjDPWU
        jBYMgIHlll7q0VgloXRHJ2VzRUtUuIeK9AR0Ajfvy5qjzB7DsfBkatdJGxxC54Wp
        xshZXEXs2js0epyNmaghIvNGOrE3EnmlXIpoY6cBP1Kp6P1DHligCtD9kDX/X8IE
        Jq6zcNmhLWhSnfEk08Nct1MO3oKevel+wShkA8HufpgGPSlsSPoL1PMwKBLpc7mU
        2uOY6ch74NUZHK0tIT+vWH3vryCea2nQZ6UjtApGpkVNdrRnmjxxCF0LMHUZkoQh
        YbwWaY4nCjsysklVjuSbXl/tsOs6T3gO8pl6NrIidQJVv5SCtuujtA5gQ==
X-ME-Sender: <xms:5cz5YoWY9wEgdYHafKILaLgGPhvjfX78iG4JC6P3VShCVc5qfiAonQ>
    <xme:5cz5YsmKBYJQJAygeN5RaeT5PdlKcn5k2C7tK7VzeCuG179An__PsWBnhx1HIAx6Q
    RC0Q4DmqZIG8v2t2Q>
X-ME-Received: <xmr:5cz5YsYFuY36zs-fHFAUTdCYMEdt92IWag6cQD3fRrQmferqMRyDmC2NMy-oLGu4E392L7fGTn6KJv9C4JRHvmmqXt-V-IdT2xhvWiRXio2g3UOM0qEHy3OA5GRWvxnSqHA1fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:5cz5YnXFYt5tlzAP18A0nQSEMHkF-NMcuN5zsbJEtzHwNIVYBHNuhg>
    <xmx:5cz5Yin1lCc2zfw8_bdR7u4WiJn3k4PjHqgmXUvWhL_HtwqRpQkr7Q>
    <xmx:5cz5YsfUYb_c5oMZhasnsmVKpGU2AS1ZPlyFmQ4mNW11aaWbjkFaYA>
    <xmx:5sz5Yrcjtz36MPEEoG364bYRrFFJOUDp5Un70qABgdivBKlAdTbnlw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:34:45 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v3 3/4] dt-bindings: sram: sunxi-sram: Add optional regulators child
Date:   Sun, 14 Aug 2022 23:34:34 -0500
Message-Id: <20220815043436.20170-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815043436.20170-1-samuel@sholland.org>
References: <20220815043436.20170-1-samuel@sholland.org>
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

Some sunxi SoCs have in-package regulators controlled by a register in
the system control MMIO block. Allow a child node for these regulators
in addition to SRAM child nodes.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Require the regulators node to have a unit address
 - Reference the regulator schema from the SRAM controller schema
 - Move the system LDOs example to the SRAM controller schema
 - Reorder the patches so the example passes validation

Changes in v2:
 - New patch for v2

 .../allwinner,sun4i-a10-system-control.yaml   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index d64c1b28fb61..915ca85c3f10 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -56,6 +56,10 @@ properties:
   ranges: true
 
 patternProperties:
+  "^regulators@[0-9a-f]+$":
+    $ref: /schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
+    unevaluatedProperties: false
+
   "^sram@[a-z0-9]+":
     type: object
 
@@ -130,3 +134,28 @@ examples:
         };
       };
     };
+
+  - |
+    syscon@3000000 {
+      compatible = "allwinner,sun20i-d1-system-control";
+      reg = <0x3000000 0x1000>;
+      ranges;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      regulators@3000150 {
+        compatible = "allwinner,sun20i-d1-system-ldos";
+        reg = <0x3000150 0x4>;
+
+        reg_ldoa: ldoa {
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+        };
+
+        reg_ldob: ldob {
+          regulator-name = "vcc-dram";
+          regulator-min-microvolt = <1500000>;
+          regulator-max-microvolt = <1500000>;
+        };
+      };
+    };
-- 
2.35.1

