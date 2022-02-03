Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C64A4A7DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348947AbiBCCRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:17:45 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:37141 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348936AbiBCCRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:17:44 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 126642B0019D;
        Wed,  2 Feb 2022 21:17:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 02 Feb 2022 21:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=KO87UqUSigoil934L0EoAdrUFJ7VlH
        5xtIF2E/OB148=; b=MnwJmJjyn47P3vu2/r/1oSKlXJXnIUQELqN/8jnPSqBurw
        DBQm9pS3bECeAGXEbDwN61RA19s3DiF3ropO7MdR1ue/EIfV2zUOG4T/YzsESO+D
        rXP7+xGIAgDjNjX1XwkYWm1nfBRnpXFX8fCP/TUP+NBT/4lvtY9Z7nxtGt47amPk
        dmnfpxEOfPMIwu+6iMpGMNktKkLnMnA4zVHhcoWHTQ7ZUHsQfi8BnjFx5tHvrBez
        fV/5PxE0aa+pxHMj19tdeW5J8XiR003vEN/ilRx4Q8xgd7K0PF3iTW2WVc9o3Jqw
        UucXBeWCHFtNrK9lHZxpGwwVQRuf2qocrSGBrqTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KO87Uq
        USigoil934L0EoAdrUFJ7VlH5xtIF2E/OB148=; b=TbZEFaaDKs6jY+mA44vpHI
        Zy6vR4dcCdAwBI1Fg7S2yGQOR4xUrM5WZQXGCWyIwwMKs+QKezjHpjWgXZx2Y9Ie
        zcjc+auPz1uEeuanSnEmXOJbR3sksvdhnchdNBT1eX6dkN+UwQe3VILrKiJhpz00
        YkIrjNt51dORcZTSoMOpDKMTlvxdF9bCejl15AzOzMb2gv83Okpm/DiU7UHcHSNT
        YY0ll23F9D0kupAQS9FmtBXkX0KtwDZs2KQDx+zveNaPhCjrMBxjyICBmXhuJGUn
        lO7t6/yttkt9qZwbJOR0IOQmxUUSze0TEPrzu3PHGzXIUzm0KuXUEZTkVU2pCJ6A
        ==
X-ME-Sender: <xms:Rjv7YfMiKVKWIcJ2AmdWvtiv2lpi5Xc1Yj-wd0ORNmA26dqaC-7cSg>
    <xme:Rjv7YZ9P5CreDgpylmUQ34fkKajK1Ofou3qu0yonBRHi9tU8qSKO9MYdNXAdgC6b-
    3X3w58NObPWr8Pi3g>
X-ME-Received: <xmr:Rjv7YeQYs6J9Zy8t6PmHImcoZGbQ2logKoOv2n7uVnQ74q33cbeZV5YtCtPkQXrPrEPRRsk0qSB6TFdi4PEUELJ56itLKJjFKKMw9hdpgmUrMNslI_wMdVinkNR4Wu7cT0b9vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Rjv7YTvdsR3pw1zS7LjY2sq-o_LaQBBO9ZdYzhcHZ5n3Zt3AOKmK6A>
    <xmx:Rjv7YXf4Jcozm8rMGdmTdfz7oQmJBVdNfLurauvBU9WpnnSEmeXfpw>
    <xmx:Rjv7Yf1QAPAzRLxNrgndee4SRV3Z1q0BoRv_cnKdCnjKSAxESdODpA>
    <xmx:Rjv7YS39SkGSbEXrkmEqp_7ouI-clj-g36yLKy0-gwNslGtn1-6A2848CVY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 21:17:41 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/6] dt-bindings: rtc: sun6i: Clean up repetition
Date:   Wed,  2 Feb 2022 20:17:31 -0600
Message-Id: <20220203021736.13434-2-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203021736.13434-1-samuel@sholland.org>
References: <20220203021736.13434-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Use "enum" for compatibles instead of several "const" alternatives.
- Merge the H6 clock-output-names minItems/maxItems constraint into the
  identical block above.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v2)

Changes in v2:
 - Combine "const"s to "enum" in the DT binding compatible property.

 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 28 ++++++-------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
index beeb90e55727..a88d46ffb457 100644
--- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
@@ -16,16 +16,17 @@ properties:
 
   compatible:
     oneOf:
-      - const: allwinner,sun6i-a31-rtc
-      - const: allwinner,sun8i-a23-rtc
-      - const: allwinner,sun8i-h3-rtc
-      - const: allwinner,sun8i-r40-rtc
-      - const: allwinner,sun8i-v3-rtc
-      - const: allwinner,sun50i-h5-rtc
+      - enum:
+          - allwinner,sun6i-a31-rtc
+          - allwinner,sun8i-a23-rtc
+          - allwinner,sun8i-h3-rtc
+          - allwinner,sun8i-r40-rtc
+          - allwinner,sun8i-v3-rtc
+          - allwinner,sun50i-h5-rtc
+          - allwinner,sun50i-h6-rtc
       - items:
           - const: allwinner,sun50i-a64-rtc
           - const: allwinner,sun8i-h3-rtc
-      - const: allwinner,sun50i-h6-rtc
 
   reg:
     maxItems: 1
@@ -85,18 +86,7 @@ allOf:
             enum:
               - allwinner,sun8i-h3-rtc
               - allwinner,sun50i-h5-rtc
-
-    then:
-      properties:
-        clock-output-names:
-          minItems: 3
-          maxItems: 3
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: allwinner,sun50i-h6-rtc
+              - allwinner,sun50i-h6-rtc
 
     then:
       properties:
-- 
2.33.1

