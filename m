Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C4592EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiHOMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbiHOMal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:30:41 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A026863EE;
        Mon, 15 Aug 2022 05:30:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 21C9C3200947;
        Mon, 15 Aug 2022 08:30:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 08:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1660566638; x=1660653038; bh=fnd7IRtL47oZ3GEXBeTqA34XltR+qlUApMq
        Kfs2uGec=; b=oWNiRhjZ3jF76mANDWLqGxuvN+2Na6BQ/exB3v+jhP9nMjb6Ot+
        HA45SHhepaE2bp86bOGKhWqExJSVYo0xH6ztMmDRp2fQULPDqvIlOOKVlEWFGiXR
        gfawMKFi6RVZfMDLF7a5FhIZMLwH4K6sBjPNgvDsJTBC2Z+BH2XhTSIjbsga/IN4
        xgy4ZTOtEN1/mNRlwMqdbksQijaDgrpLKQJqfaxLuJKcHYXRMN641g62NrbERKk/
        Ht3v/wtovrXh3ASFgyt4dH4hEqt+Yh/jMeGXRsfYjGjbHdOONYraK3AYFSqrv/ZF
        M506JZlGQsnl5L9BZ5j+MLqPcZKjVMTjyEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660566638; x=1660653038; bh=fnd7IRtL47oZ3
        GEXBeTqA34XltR+qlUApMqKfs2uGec=; b=tuv49HflFNRBFlr+KNPeLJrt4UyJj
        iXsztMJutTgG7QFQbAMFK+JDQBGAT5MA9r3bqpUmOsIDFnzE4AwDUVZaX0hg2JJT
        sXkH9kSVQaLa9IwiAeiQSnJbXDgc17C1RuPZKdPlhLkURmt9z1WjtkQcqdyeZ3b6
        1crlSA03yo17v04E2MM3xvr/9ugpvpP2BrsnbNmGdevsc2HmwKoF0VY5CYJoB7LH
        s9zd8BRTkEiTSHftv+yyJhfmJBJ4Vn9ziiXJR2R98Ra1SWCcrncWnRbm3CYBm+UA
        XyIda4Gqh1bEsR2Wl7AMV9igJDy/JgZkqFuCz4JeYg3/PODnYI+q3Utew==
X-ME-Sender: <xms:bjz6Yl_AoWqXeprWOguqZn1RmUmcC5_V5QWl-BTmpljFDQsNK-FDGA>
    <xme:bjz6YptePruN6zkcOGYTB_MndJAPZeMMSx-ZtMoGVHMwug-a5wJ1doh3RmQi4-RKY
    zdDDngshLgtPLzDbg>
X-ME-Received: <xmr:bjz6YjDi0Vq-lM-N4w2l2Xo2CJly3eP5N25XU2RAav9qzKi0qctBRS_93v3XZ-nKkugeeeGXgAhhjg-mVkT82fUbhuHZ7N7jh0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvohhmucfhihhtiihhvghnrhihuceothhomhesthhomhdq
    fhhithiihhgvnhhrhidrmhgvrdhukheqnecuggftrfgrthhtvghrnhepudehfedtkefgfe
    duieelgeegleettdehteefgfeuueegffelteeiiefftddutdevnecuffhomhgrihhnpehp
    ihhnvgeigedrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:bjz6Ypfat6WJd7B5UNZ2vyUlZqgZGsnde-v3vom5n1CKlpffqIqe0Q>
    <xmx:bjz6YqOAI29ZIvoNqRbXwkcOUHM2pwlFBehbuDSW8JLOOi_1n66mgQ>
    <xmx:bjz6YrnT2qj7E5LY2RasVNJllyr-6ayZ5RJ3Dbv2-GZQyyCoA3enUg>
    <xmx:bjz6YhnvfgL2Daj_vy4gPBULFnSDk9H98HSlgJhQHokqApwq5T1lqg>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 08:30:34 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        tom@tom-fitzhenry.me.uk, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add PinePhone Pro bindings
Date:   Mon, 15 Aug 2022 22:30:03 +1000
Message-Id: <20220815123004.252014-2-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
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

