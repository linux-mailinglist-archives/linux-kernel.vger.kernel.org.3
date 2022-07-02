Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A475642A3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiGBTxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiGBTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:52:54 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09463BF7B;
        Sat,  2 Jul 2022 12:52:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DB655C014D;
        Sat,  2 Jul 2022 15:52:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 02 Jul 2022 15:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1656791573; x=1656877973; bh=0S
        CSlNvE+hXXYvhEZe/suhpbee9w/R5RvIKP4XKG7Go=; b=W5lF417Fs3IlV9ztc8
        10SUiQDV3nutX1BiYpQ+YJjbqyGf2XW3SRxv6QuBOT89kNYRhS8L8Scd1Snb3aJn
        IH/ZBgygG0Qby+PpHYhZ38IFzrUtsMwHAJ2+HfIx7woIOD5ZmwD75EzaojaRvlQT
        t26z6H5KO3XjcV6mgMLDlXPfHImFycjs8+OvV5PmLjLFd8XoePba+MdIrkxoKaCb
        SkG/NWuLSBza4lsYlRBn3Yd3zFUMgkBNI/FYudWKuKex8w9yUTkILw5GPNMDjGB8
        wuixF2cmiPbqEBFW7ENtXKKX9cSolSNatoXRQw9s6eunv+pjWTEsptV2H3UdV+I+
        GK/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656791573; x=1656877973; bh=0SCSlNvE+hXXY
        vhEZe/suhpbee9w/R5RvIKP4XKG7Go=; b=wbHb+xYCM0LAjs/4OFpmPU/sHHzdH
        dc6iMYXKN5t5ymGABvoK30CSb0IKSPC8dzMtAuIwFKkaY+sggWqcM3f4jcBG4/Bc
        5iSTwuTd2W+l62F0QbGj45NNVNooF/KA/YRXuZkAOPtm/cWdKOt/D2AMDI3ZQPGt
        /nBldtTNKifWX4YqggaSVIBUMYLyYte0tJ9mHMZnfxFA6FiHtcOlzhfpaX6CBOTC
        kiuJsi5wifVcPwPh452y0HQsKoOM5ZuTlILTINCjUNqm65B7dcgkIImlbdd1EOhV
        3cJe+7T5t8Am3X+dVJ+X1KctscHVKktRwsQ5+Mwq6g8gnbS6fNT0MSa0A==
X-ME-Sender: <xms:FaLAYoeBtTxbB0tTvpeyabSL1Tx-qSprrVwSYxZddpLMjE9hZGFquQ>
    <xme:FaLAYqOMEa4eVMpA0pWzPHIFmppw9tQAVxwivsYM6j8lu9_tXVC-ZaFQ_mpwAwGmn
    uDVL-9mxdy36fLH3w>
X-ME-Received: <xmr:FaLAYpird9lQLm6shjt8je_hM1hW4H5GqsAx-P8D4asLdZgtSuk05GIX8b1iZunswPKSGoHSyY9CPrHSib1v9O4MgQ14vqs36VUwrU92P0K37OKoZ45Q7Bu68NAsBldQgEQpfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:FaLAYt8LImHfCFsdy3YoiHsnIthwFh5LWeKv3LXU8V6F65fDtirhkQ>
    <xmx:FaLAYkssAYJhnBOB5WclrScSTLJn_oSA87hXHbmN66pOko14bakzWQ>
    <xmx:FaLAYkHaVcgIZvXUR3Z6KxGQi_tdA-m8kxudAgfnSz_p6hOiKkcN6w>
    <xmx:FaLAYllnB8cGPXIq1cOdtfa1-RVQjfG4gmWDMEVI4ldWPQ26K7C-rg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 15:52:52 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: usb: generic-ehci: Add Allwinner D1 compatible
Date:   Sat,  2 Jul 2022 14:52:48 -0500
Message-Id: <20220702195249.54160-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220702195249.54160-1-samuel@sholland.org>
References: <20220702195249.54160-1-samuel@sholland.org>
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

The Allwinner D1 contains USB controllers which claim to be compatible
with the EHCI specification version 1.0.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 1e84e1b7ab27..25a6c14618e1 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -38,6 +38,7 @@ properties:
               - allwinner,sun8i-h3-ehci
               - allwinner,sun8i-r40-ehci
               - allwinner,sun9i-a80-ehci
+              - allwinner,sun20i-d1-ehci
               - aspeed,ast2400-ehci
               - aspeed,ast2500-ehci
               - aspeed,ast2600-ehci
-- 
2.35.1

