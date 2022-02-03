Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8947B4A7D67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348821AbiBCBZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:25:07 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:49109 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234817AbiBCBZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:25:05 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7927932005D8;
        Wed,  2 Feb 2022 20:25:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 02 Feb 2022 20:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=3xx05KiXX+9twtJvM84t+h0e7c/xzFUESur5GJC/Ko8=; b=l8y9C
        N+TA2S2PAsQBYKn1SdcCxrHIZVYulJIjJjNsdpx7vznJailkgnCxajRj2OlDUDaV
        iwGlNiCTDFve+iNFMg1mJRjGYmEWviNBXxIqppAsDbnTLq8VhrhDAi1viDd3u6kH
        0/uaNEfI1Gbw09FZ7/LyUB8Ewt1GCNo5nmNVO117n400+5q0bHYOZs2nIwUlH5mF
        BnDr6X1lIc3KIscOyJn3/r6jgi/Q6zAsLniCyhlKXMcWSBsFoAUg+P2gnGIzTKSz
        ouJ6Heq2VfvnsmNsSY4ko0pU6rC6Z7cv0svw7PXfC5E5KlEeR7sIX9BVW2ogByil
        pZvLZ8UdRtVbnV2xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=3xx05KiXX+9twtJvM84t+h0e7c/xz
        FUESur5GJC/Ko8=; b=avOxqSJcFJQPKUXGnWyWUaOgbZHk9gVhUB3gp13J6OFwt
        NudNj9Dmu+Z+UjMQX7N7FRcqoepIhxwiYoxXovBOHD4nwRaRIgakS8SMy06OlErk
        IfAByXIJtrHn/MtbOyvN4ngfOaI0hjjXmxAskUBf/SJM9+bZFixKEjryf5q794Gn
        lfL1GX/JOSVNhPJQoUighCw/Zw4OY45Aomzm2UITut0YhSfqQuPjeQao3oBNiwWP
        ra3fTvLo0nAYMEjzyKMBhesg7/tSmsLcd3W8pvo/7WfQNtFjKEes0zQxTdjvM79y
        5ys9OP3AYHCpThtL5QnVDaqNRFw979hB1MhlXO5JA==
X-ME-Sender: <xms:7y77YXjiszeC0r9NMPT_I9dzPcK-AJNmZdHCkudzLEM6a3Ie5p4B3w>
    <xme:7y77YUBZpXPLSZttHjwWM42UxAhFPocCj5yYhrIihck465YxvoHRUwKKgKmSVES8-
    Ks7rfeCV_aoGc1bWw>
X-ME-Received: <xmr:7y77YXHY9okx-8UaeptC7tYb9xPUitpXe-AcR1VxPvWk14rbKLMZN7Ox9cluBrcB5OXg_fh70j61aZ7D_ejuMFo1Jajb_su6ZXihoPknCZGoLjfaYzgOqyRASeglEOpyav-54g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:7y77YUQan0_-bqe1GPuAlu2vJCbMh9Y0uI_Nt1LCnKXvoR4KAWD4vQ>
    <xmx:7y77YUwLS0M-vQV01IUQ9ADOc_bQsrzqdrKHNiaO-iFm_y84hkmnFQ>
    <xmx:7y77Ya6zEOaLZsuAKASxU9Ixf7VzHAU5EvvGc8-rd7VZqjyjYn03tg>
    <xmx:8C77YTm_QKBGMNNe7ftZktpaSn23q3lwhttglgUVnoqaE3fC1XiJ9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 20:25:03 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] dt-bindings: nvmem: SID: Add compatible for D1
Date:   Wed,  2 Feb 2022 19:25:00 -0600
Message-Id: <20220203012502.10661-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has a SID like other Allwinner SoCs, but with a unique eFuse layout.
Add a new compatible string for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
index 6687ab720304..e558587ff885 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
@@ -20,6 +20,7 @@ properties:
       - const: allwinner,sun7i-a20-sid
       - const: allwinner,sun8i-a83t-sid
       - const: allwinner,sun8i-h3-sid
+      - const: allwinner,sun20i-d1-sid
       - const: allwinner,sun50i-a64-sid
       - items:
           - const: allwinner,sun50i-a100-sid
-- 
2.33.1

