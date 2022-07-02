Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF382563E42
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 06:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiGBEY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 00:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGBEYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 00:24:53 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE85286CC;
        Fri,  1 Jul 2022 21:24:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AEE0D5C01C4;
        Sat,  2 Jul 2022 00:24:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 02 Jul 2022 00:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656735889; x=1656822289; bh=FUs7rY0ijqZHdaCKY9CAeZqO4
        IX8cpBDkKx0ctlACpk=; b=gRwhEwFVRGjU8ArhtMFEY/kTsiGCdYof0tv2cILq6
        46gybqs08hqWZ3MV8em1CyTAZVVN2L2u4/tc1Upifi8Sgs3ikZ0/NioGw4ZCE2Vw
        9ytHju6mBbohE2tSboBROAx/AQfPyt4kseSuaIQV4O8GAqGZ/Q8DhVekb672im1z
        Jm4YjUrdwJNqQE2gDLs5woQz2PBG3WtwZ4RlBA7uveKpp6aF3m8IFbDmSgC2pl9c
        QcKVco4B4xwMs0rMx8xcXo3XnWlvbf7Ib0n5qYgD6LwkPpsyUh58E4M6kox0SsIa
        Vsh9hwfb2D1Wdtk35EFMVGeef0oZmYLAhZauIW5hkBpLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656735889; x=1656822289; bh=FUs7rY0ijqZHdaCKY9CAeZqO4IX8cpBDkKx
        0ctlACpk=; b=Ff8OC7IQw+fgsHP/Fjh5WFf1knPf13awskdA0Jujkab7eX6S66k
        SoWq9yvwwJLQeoMp58NrUDd5qTsH0BQQs2ow0j2J4rJlXvLi6wMP92+2wwGZR/i2
        vW4QxK9ZVFT9hndtZjx5XbilcI7PJGNL2lO8fkogqWTT+EkFfVDa34zjPpmOjRhX
        xvA5QOxTzXfFionjAIbubV1mx3kqV4DLE3lrIiaBC411xIsP0pavdkvuJfWgVX7T
        UGmrnL2HWuPvct+NsIBNXz7TQhzaLLkSzfqteOJ2S/7lEZ1ZkgcacTUXZ70DQc3z
        V3R0V0I/IZjL3dq63HJePtwLNaWToPLs2Ng==
X-ME-Sender: <xms:kMi_YooMArIdI8kwrKMVhgqB6DS8LGIrkaTTZpaKUdoyydevYLOosA>
    <xme:kMi_YupuUSUJWvFoqETYuJUxTHEB1htNbyVXdNIwgQ6dsWGRcoXcR-RACcaFews4G
    fX2IW9RvO6fIseiOw>
X-ME-Received: <xmr:kMi_YtPNajAu0OBuuzE7YANhMBgMdfFsoqSEiMuGg2BdKYUaJQgrURHx4F1_FZzkA1LFvRkz45MpSUonQ27uCA57ydWkVVj6OCMIePzXOs20CbwLTrGnH_aikDAcoJ8az4G3Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:kMi_Yv6gzI-l6cV_tL33gs52YW2ecIMpwIMT8MJzgORIjEtLGTE1Iw>
    <xmx:kMi_Yn6EMP190QO1qf3m2HkWJv4FkcPSrsgl6IgQVIe-bGu3KrXVwQ>
    <xmx:kMi_Yvg5wE1pIgVQSlGVyWaiEWV4VH7g2AlWO-fYibNK6qzMEBaQzA>
    <xmx:kci_YkH9Y2xJAbsKE9MQVgCe_dPR0wng4HltgCVQdVB664IzAzySgA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 00:24:48 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: Default to the full MBUS binding
Date:   Fri,  1 Jul 2022 23:24:46 -0500
Message-Id: <20220702042447.26734-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

Some older SoCs use a deprecated MBUS binding with some clocks missing.
Currently, new SoCs must opt in to the complete binding. This should be
the default, so new SoCs do not accidentally use the deprecated version.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml        | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
index 8eee312c2e6f..2b018feb56df 100644
--- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
@@ -81,13 +81,13 @@ required:
   - dma-ranges
 
 if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - allwinner,sun8i-h3-mbus
-          - allwinner,sun50i-a64-mbus
-          - allwinner,sun50i-h5-mbus
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - allwinner,sun5i-a13-mbus
+            - allwinner,sun8i-r40-mbus
 
 then:
   properties:
-- 
2.35.1

