Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEFA4A7D82
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348851AbiBCBvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:51:16 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:56569 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbiBCBvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:51:15 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 961E42B000B2;
        Wed,  2 Feb 2022 20:51:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Feb 2022 20:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=/7Tz0hzsxmkP1TdALkiiPI8pdw56MShYLYbDn/MtWbM=; b=XzBwH
        +ZDuLMwhI5NSXa4dlVfvX05vYIrZRRinl63gscPncdSc4TtAULkWtNN2/Tz5jQBk
        u/EvLHCQJbphoIhjTtvKMAuo0gm+GuSdMqjdp5TAX1AtmNI8Y7u2I3lK2hA/KnjD
        6eiR+Zx7Mb1659DYM22K7ix/lkFK9Q1I+gKPzzIwR+3JP7syqOY0sH4o0WQHgbPx
        4v8wXcg24OrYuOYk9XggGHAWlfYE4I/4gyaN+s93MIJ3AifKatyaHOx1UtJq0j5V
        q0VHJ51S/vP9FwimNH8fFka7G4jm9SNI+9rTzM7EaBp6bSI8MlQbBlmd+slCLtND
        dPM3gMWxajE6EuqHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=/7Tz0hzsxmkP1TdALkiiPI8pdw56M
        ShYLYbDn/MtWbM=; b=MXGiOOHaxpc5Vr3YJE3nnxX3xoqXZCIz+dqwVw5Jm0plT
        tFu1cRGglAaoXptjoY6tAzRS/qy//3a9LnG//S51XwO+qP0699AMaRfhTGWs6e8n
        TkWwfOkjm8ruWPKObQ+tiTUZ9T6t9qYdWodrTWNMjrv6Uodt7+cMzmdzZqxhYjSw
        2VAplSAKKwA58YnqExVV4xZAydIBoZfcPX1L2WwCFgqCrDxqKVdZ1530jPEm3r+G
        KWIT6arFvHT/aUFNPNfp5ufeU/Iuxty0wmKOqA3R5EmTfEVXu3afQFAxc0eQ2oym
        XITlG/ipNnS3YhlVdpfp43FLS/jKgGC3LNPblq+Mw==
X-ME-Sender: <xms:ETX7YfxU8rakxLKbUQu2yXMuZvJBZ0DMEqQGyAf2DH8B49Ef_uuZgQ>
    <xme:ETX7YXSzzsXLt9ExghRhVFfrYQL5HYXsfsfhK2dVeYJW9rYl5J2GQw-MRocQcJUjE
    46Zt5tC3mbEt56XCQ>
X-ME-Received: <xmr:ETX7YZX4jOzZN8XOBT8lhXh3gJbmKYwieUDSCLE8JdvJtKEHTWdJ5inKK7VhMfNEls4GJ1ESPTahLKyu3db4nF4s_COMC5zEdTMZWyisPNUG4hWji5Q1a5J7FFTSNoCOOi1cHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ETX7YZghmwOOdWLTccIONMNE5eGDq55aXLlBdJqCFHZxhYZ18u2lQg>
    <xmx:ETX7YRCin-060C3hMpckjTvkf3OqUHRpGLq4qkDYLrwz0Ig8wG24wQ>
    <xmx:ETX7YSL9OGDtC_7mv4L30UX8naySd2K9Xyl7JQReTHSj6n-XeQri2A>
    <xmx:EjX7YVvYm3brRpXZDHBwll5kOaX8Z90hXwI2DiUxTgpNp5aXFYplu-a2dSY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 20:51:13 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] dt-bindings: mmc: sunxi: Add D1 MMC and eMMC compatibles
Date:   Wed,  2 Feb 2022 19:51:10 -0600
Message-Id: <20220203015112.12008-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 contains variants of the usual sunxi MMC controller. The eMMC
controller has the same parameters as the A100 eMMC controller. The
other controllers have a DMA address shift like on A100, but they have
a smaller 13-bit size field, making them a new incompatible variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index 4f62ad6ce50c..94e2c6c4e4b7 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -24,6 +24,7 @@ properties:
       - const: allwinner,sun7i-a20-mmc
       - const: allwinner,sun8i-a83t-emmc
       - const: allwinner,sun9i-a80-mmc
+      - const: allwinner,sun20i-d1-mmc
       - const: allwinner,sun50i-a64-emmc
       - const: allwinner,sun50i-a64-mmc
       - const: allwinner,sun50i-a100-emmc
@@ -49,6 +50,9 @@ properties:
       - items:
           - const: allwinner,sun50i-h6-mmc
           - const: allwinner,sun50i-a64-mmc
+      - items:
+          - const: allwinner,sun20i-d1-emmc
+          - const: allwinner,sun50i-a100-emmc
       - items:
           - const: allwinner,sun50i-h616-emmc
           - const: allwinner,sun50i-a100-emmc
-- 
2.33.1

