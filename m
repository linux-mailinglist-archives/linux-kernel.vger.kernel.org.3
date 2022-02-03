Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96774A7D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348242AbiBCBgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:36:01 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39125 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230005AbiBCBgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:36:00 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 02F75580154;
        Wed,  2 Feb 2022 20:36:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 02 Feb 2022 20:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=Qg+6QTBkQeTFg6Q74FfxB2eWEkNPeUaZvFHDYsYpOA8=; b=mP52N
        t/jnmr68xzmfUO1scROUNiQH3QFkPlRgUt4G9Hi1DDLrJHTBRvWmYdVGD5Zue87N
        PCP7E/Zf1eA9hD2BF61czHJ/QeGpNHbNuSPev4XRUAkGXKdNcUIbHNK5KF0KqPRD
        vOouQzyXDpK89Y4JKgMDMxrimsaUf4RDedpMmlvk81b5+NRotm3Ci1RpJqRvKuxl
        QHAZcHj2RCfl4HxQyeIXxen6yaqxWFA9g0s4Waevk/wMacDnH/9jfToR7BqB3c9u
        nl0pTHWq1M0CMkOjluIheasrMQ4CdahuQq8VSbIQccZf2d+RQxRQ29Zgt9sqo519
        lasjDCrxcRSpjfUKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=Qg+6QTBkQeTFg6Q74FfxB2eWEkNPe
        UaZvFHDYsYpOA8=; b=NIu90/v4jVboGtH60eMoXpGmXybfEvPMjYru1LmQX6MO0
        fb4Q3lP4FEjIYt0rmq3nx+azVIIt8XGf1qHrfzyS/CBde8ukhOT2CzIyjYwQfyiV
        FC+vLZrbz/XlZFilaGLkJ40GovUmho7gQt3vah1Sfuv9vRCsdtgwdg98jbMJvs1O
        yQXxi++1yKP5RgeHclto5gzhKVk/wuGrRUyBAnxEEJwz68lZgExch0LPrVxp5Fyo
        BOOjE84dccSsjlIwCojd/e2wSbKRcSkj9PWojTsu7n/f8rmOrZGquq6fDxj3dyAp
        73wuxzC+LaNH36pzwHp9USCdHG/5zpOgZGSzzzP2A==
X-ME-Sender: <xms:fzH7YWF9NufSY-fEn5MJ3oVbqJOsdVfXnL9mtpI9VF6qW3fTSEKquA>
    <xme:fzH7YXWkOmIGnwAYFwihYaYwxPzIm32fvNbHMVhFyCxj13XoWy6dCK7vKDhVyQlD4
    FZaumVYKXsGcVIvKA>
X-ME-Received: <xmr:fzH7YQJ89YuB-uQx_Iwly8k7kG0WdpwEyKpD-am9tQsy87oPjrfA-qzFpACVXIjDPj4eFewnnQEMt262znM6bO8YerkgB5SbDl3O0TELiK91_qcVxma0LneMuxNYzUYJmnIprA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:fzH7YQEFq3d8oJKJJG15aNiFD5TlP4Bp0E0DdtNzgqur1YfjIYmi2w>
    <xmx:fzH7YcXLf1GIDECDr36G2KW07qHsZjBzdrndlTcRCYdyAEpHEDAgkQ>
    <xmx:fzH7YTNd_7TcXmR3xzlRqa8ipjGbOtAXSLBOOx8oaW7D6UwaIsDNkg>
    <xmx:fzH7YbMiQ42IvO24h935gxQkQqGNpON-2E3pXsDeuaKNl6vsVfBHPQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 20:35:58 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/4] dt-bindings: phy: Add compatible for D1 USB PHY
Date:   Wed,  2 Feb 2022 19:35:54 -0600
Message-Id: <20220203013558.11490-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 features one OTG port and one host port, like the A64 SoC, so its
USB PHY supports the same set of properties. Add the new compatible to
the existing binding.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
index 078af52b16ed..0fa4b32b097e 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
@@ -15,7 +15,9 @@ properties:
     const: 1
 
   compatible:
-    const: allwinner,sun50i-a64-usb-phy
+    enum:
+      - allwinner,sun20i-d1-usb-phy
+      - allwinner,sun50i-a64-usb-phy
 
   reg:
     items:
-- 
2.33.1

