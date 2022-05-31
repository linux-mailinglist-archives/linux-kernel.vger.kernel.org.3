Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6822D538AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbiEaFgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbiEaFgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:36:37 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F292C8;
        Mon, 30 May 2022 22:36:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B9E743200939;
        Tue, 31 May 2022 01:36:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 31 May 2022 01:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1653975394; x=1654061794; bh=lM
        0S6haiMeSAJIWm3addevlytdvDfSDjGYz4PQB/xHY=; b=P8BGvgiqIVgKsWJs3I
        s6o/hn+H4a1ioH8m0Qcc1YQYphxGET4bl0YDcVZ3qLbPQZqPFvXkHvm5UaRoyJ4Q
        gm5dbKhEAfIxbDInVJ8M3gIrkJnd3aQ0me3O7bJhP/o6xmJq47mZMKInPtbT8vN2
        CRFrxgUZ7DySC8obCtYmlqorn5i80PJ3UjHXVG+WaT3/kHZgX9SpbkUfIyY/sJtf
        l6zzD+fs0MCl7+s81KLjTBFXKefl6+p2DXnhnodomR5KHMx++aZSPcgK86RLLBCw
        oK1fIfriHfFooDx2O4DJo/JEkhUi306ENACmWtIWLUkWhHQM1VlnLzBBL09nqc0T
        xLlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653975394; x=1654061794; bh=lM0S6haiMeSAJ
        IWm3addevlytdvDfSDjGYz4PQB/xHY=; b=qNSqGItOQAOhIRwk3nMTfXomBQNSb
        kmZIIsqKMZGGvzCUc6fJlD/bqywCw4k6EUb3XBHvI5F2pWiqsqMTsSQ9as34qYv/
        c7ILMnalRyUNhhIej3FPHzKZNVaO/W5G4HgGYW0LvEt5T6R2PMAq4uzW8jjHZInT
        mLyeWRdG1VcUxvvKJvgHKNOUKQkaqoA6iZYNCh5BWHSikz6Klf3MRsiqpXhrcpSq
        WCAn+HZzEICBL7hVP9BnmqKt/xOgTxYLX8hVEhO0OafKCMz9jC7r7vqym7g2LonH
        3AmcQl3zuN7xM1ZkN/zXKAZuddt/ogiRnvcxrdimSTJA0gDyYpPVdPikA==
X-ME-Sender: <xms:YqmVYgXnfY4X9fiL9FzRVRzj3BbRJWx0rJgfWATt4hRowqOnQfRKyQ>
    <xme:YqmVYkn3u1-1_usfpzJN_hBxrUom5LtcxcMRvlomonf4S3NVtrJJs7jMAl1pb0FBC
    YReDsTx6mZ_3cnYww>
X-ME-Received: <xmr:YqmVYkY44N-xVfsSgPL4NaW1etI1q_zBLjXlDgGSA1TpzHiMJRbeJxofSBzOZ7P1nnYLlEN8wzz8yZ2bElWgu70gmVjFitxZDiDWIGskGuJPXgH_esNipdWn9rwVRtkX1C_I5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:YqmVYvVFcp5gN57wAcv75UXSjCTgO72aXLME-UNcwqaclgt__Cv_7A>
    <xmx:YqmVYqmroVEtWQo2XRLBpwOuJuWW4qxHBD86wkkLRr2xY33f6FCc6g>
    <xmx:YqmVYkeJwlAJDPjjBJtJCe63LgM_bdceiVbxcv7PkB0gvEcDdAMb8Q>
    <xmx:YqmVYl8B7fgY0lf7vwMMbS7ILIkT85cL9CURcoT-abX5LhMFKumngA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 01:36:33 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 3/3] dt-bindings: pinctrl: sunxi: Disallow the resets property
Date:   Tue, 31 May 2022 00:36:23 -0500
Message-Id: <20220531053623.43851-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531053623.43851-1-samuel@sholland.org>
References: <20220531053623.43851-1-samuel@sholland.org>
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

None of the sunxi pin controllers have a module reset line. This is
confirmed by documentation (A80) as well as experimentation (A33).

Since the property is not applicable to any variant of the hardware,
let's remove it from the binding.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml          | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index bfce850c2035..fa0c2df04675 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -80,9 +80,6 @@ properties:
       - const: hosc
       - const: losc
 
-  resets:
-    maxItems: 1
-
   gpio-controller: true
   interrupt-controller: true
   gpio-line-names: true
-- 
2.35.1

