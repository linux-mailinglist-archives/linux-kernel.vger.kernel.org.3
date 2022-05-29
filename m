Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4467E536F36
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 05:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiE2DSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 23:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiE2DSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 23:18:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB9C5DA32;
        Sat, 28 May 2022 20:18:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 206263200805;
        Sat, 28 May 2022 23:18:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 28 May 2022 23:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1653794307; x=1653880707; bh=bYTkG4XdjS3n2q1tqYSo4fETESSr2TpAok8
        7vNcHK2s=; b=shgOIz+my/9ocJOYuq7E4juL2P7+wprpHW73Ee4bLqIZw6AGFY+
        pCa0BZNidBO7+mmVLrny2I1eB7n4zlQfEC2t0z0GSCuq9YZbc5EHT78LuKXecYJc
        FbxHdPRZqtdHblIYqS8KTG2TaGwhgJG/LqdNBDez5KheTis0GtrVMPhUXpyBAgCW
        oAuGOXQpWEempMNDGZRPLY5Sv1oCG7xXMuNubomyF2N1/GhZZEvs41rCJEQIuIGn
        p7zQkSZ9L3oAbKw29AYmHB08q1gfC627XywSZYmf0y/EBXfTxn1GJcCU9N2v3Ue9
        uMN5GraDRh+p4V4KeDufmDOXkehI6CyGbHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653794307; x=1653880707; bh=bYTkG4XdjS3n2
        q1tqYSo4fETESSr2TpAok87vNcHK2s=; b=pEJqljiDYjmjwmAY4iDOsE9L5xD3c
        fvR2V+sVdOYtireMUaJ2V5pDy2BtZ39HWmLO/oiRMicSSOn9X2jSIBzxfPuJq5jN
        oDhndcN7204QJPES8q+gcKc0F2Z65cdnenDQovdMnLnIJR6wuHV057pvf/Q/IdCP
        rIfi/oWaoPWenslMJJRBvErOk7Yey6inckUBZ9fSsHAh2LOHeCDNpVlj9+if+oNZ
        28iTpI0cmq73rBl3uOyTG4lnJSYdBW8PruMsaiotsMq19mQvxxWjNCkaPU+/S+Gn
        0vF1ddegIMH47JIK23u0gjZupVnSw+4hg5UFR+m5e0PcHW6WtjdwPFB9A==
X-ME-Sender: <xms:A-aSYp_bK5k1nChFKmjesRzOHlMzIQODpqs2rhG2ScJa1tNgkNumTA>
    <xme:A-aSYtt4hz8UmZpJQHzxGZr6jr1pTNOcZYz32RkACSS0mPPKrg4OroHcdzPt9nTIm
    xrUMMJx0DtKZ7wOOw>
X-ME-Received: <xmr:A-aSYnCPhw4HZNlUeT9DDsbx-aiYX2r3wunPMnMencmmJQdupkF_J-tnwH_5eR2_NbnfpjG-oVHdGsq2-LPRc9kNTwSFE1bRq9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhmucfh
    ihhtiihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqne
    cuggftrfgrthhtvghrnhepudehfedtkefgfeduieelgeegleettdehteefgfeuueegffel
    teeiiefftddutdevnecuffhomhgrihhnpehpihhnvgeigedrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohhmsehtohhmqdhfihht
    iihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:A-aSYtceuppHkBIagfYXqX68ag-IzIex7wIjgUPDGL7BrRFycowmSQ>
    <xmx:A-aSYuMPbDUiZn34dTANgg7s8KC_A7KEcPMMHJYI6qOmC1dB88tjgw>
    <xmx:A-aSYvlRc9WtKdXO_zHfLRb-DGv7cRHO6B0r8RRCj9eMa9HrGooFMA>
    <xmx:A-aSYov09rhmGRKooaCrwyqO-aSTmhcTySz4tk1JmPmi1K89l4YREg>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 May 2022 23:18:24 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <x@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add PinePhone Pro bindings
Date:   Sun, 29 May 2022 13:17:04 +1000
Message-Id: <20220529031705.278631-2-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220529031705.278631-1-tom@tom-fitzhenry.me.uk>
References: <20220529031705.278631-1-tom@tom-fitzhenry.me.uk>
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
index eece92f83a2d..e6a1b76f9c44 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -489,6 +489,11 @@ properties:
           - const: pine64,pinenote
           - const: rockchip,rk3566
 
+      - description: Pine64 PinePhonePro
+        items:
+          - const: pine64-pinephone-pro
+          - const: rockchip,rk3399
+
       - description: Pine64 Rock64
         items:
           - const: pine64,rock64
-- 
2.36.0

