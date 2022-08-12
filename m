Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C3C590D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiHLH41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiHLH4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:56:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8CB98D35;
        Fri, 12 Aug 2022 00:56:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 70CEF5C017C;
        Fri, 12 Aug 2022 03:56:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 12 Aug 2022 03:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660290970; x=1660377370; bh=hq
        hnld67pDLmyX1tJBCi+H9QPo25a/aBfduzgY06UlA=; b=g6f4x6qYl0ol4Uo73U
        oQ1EA7uAAc7lhfWNtUgZ8vP25tu//0EmbOqBthrKnL3fPVXALOOB4VnQqc0H4KTy
        YOfX1tNQ0hqaIMy1GJh/6GC4YV8Evv0/mWVq4rJoJCOGCcTmKheMf1kQMa48ZA+H
        1KNeESjvf7RerQ/q8b/vpzoYCl/DGATIvPqkdmCUvNqzIan+Mx58+5fn2vyuAaiD
        TwjqHx5EIZGooFnnmc2F0eODIOmo7rtOqV5HnoxfmlpRxWACmnMerXz7holWDFhP
        REUrKrKU4w7MsGuIeIxuljyCtHmhKtd9C3x4AVmHFjTSpIDaCjPoPa1OKWM0e5GE
        8STQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660290970; x=1660377370; bh=hqhnld67pDLmy
        X1tJBCi+H9QPo25a/aBfduzgY06UlA=; b=QHiN/6EXtWLDEwii71eNzW6SySZx3
        g87zxAntgceKO3w8dV3R60kdyJhLyIKjWwbpUWZwt10u4bjy0RnnvN/9cuqgsBVN
        MLI8HgCZHrWcUgfsADKwgR4x0jCE9EiR1epOWLJ/vemiQP4bQMMylSX7DI2hWE+w
        eAkQMC+qLXYo6wiMu9dh3zYFE3G/FZAV20tE+WlzExaBn7TQReD15QqhngcNLmqK
        WOe8RhPaTiYstWwQKTLmUSzakmsQiI+4GW2sBj3p3uvu5/ud2Ic4kSH2FRP7RZUv
        Q5vRxke/M+JYf4KLsATwNFdjfYRhDN7AviNM02fPG4y9D1yvH+kN7ZKLA==
X-ME-Sender: <xms:mgf2YqhyOBA59n4vBPOaCS-sfdcYMzaBxrowDnaOvqRks_zZZQrEyA>
    <xme:mgf2YrDd4UmDUdcM9hTaJpAS0GEB2dwln36vgicW_MIAT5_aIMic4MQECBufjsiSN
    iHa72_WqgGmzVJ4pw>
X-ME-Received: <xmr:mgf2YiHc91d9SIamysnrvMf3hi2Jn1C0jFGoCRikHI9QXzWOBqKEp6DdpPn6a6OtVPL8re-Ko_3qHCPsC1gVaTrc_bPcBiyF9wNKeEQm8A6yDmA77q2NWMeW-yefKzN82vxmvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:mgf2YjTMnfU6aoJn9dR1UB_MjUc02F9KGSbRNo22L0ZH01w9ZTyFQg>
    <xmx:mgf2Ynxu2u3DmbgEvwtNsU5vVpJKa1VzYpUUYSWszPDe2wgBDEFdXQ>
    <xmx:mgf2Yh4Pe2jqzYjYsDvvL-9UIWjxhpqb4-9r_eu5kUTwTN9p1R297g>
    <xmx:mgf2YsKtwV7aCenttmbiIlvWt5hIfm-4YH8NmmaqtJ_TOgyajOekBw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 03:56:09 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 4/8] dt-bindings: sun6i-a31-mipi-dphy: Add the A100 DPHY variant
Date:   Fri, 12 Aug 2022 02:55:59 -0500
Message-Id: <20220812075603.59375-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812075603.59375-1-samuel@sholland.org>
References: <20220812075603.59375-1-samuel@sholland.org>
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

A100 features an updated DPHY, which moves PLL control inside the DPHY
register space. (Previously PLL-MIPI was controlled from the CCU. This
does not affect the "clocks" property because the link between PLL-MIPI
and the DPHY was never represented in the devicetree.) It also requires
a modified analog power-on sequence. Finally, the new DPHY adds support
for operating as an LVDS PHY. D1 uses this same variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml           | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
index cf49bd99b3e2..b88c4b52af7d 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
@@ -17,9 +17,13 @@ properties:
   compatible:
     oneOf:
       - const: allwinner,sun6i-a31-mipi-dphy
+      - const: allwinner,sun50i-a100-mipi-dphy
       - items:
           - const: allwinner,sun50i-a64-mipi-dphy
           - const: allwinner,sun6i-a31-mipi-dphy
+      - items:
+          - const: allwinner,sun20i-d1-mipi-dphy
+          - const: allwinner,sun50i-a100-mipi-dphy
 
   reg:
     maxItems: 1
-- 
2.35.1

