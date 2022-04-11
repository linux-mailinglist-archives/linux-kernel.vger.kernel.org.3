Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D838A4FB2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244670AbiDKEhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244598AbiDKEg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:36:56 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A81BC02;
        Sun, 10 Apr 2022 21:34:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 789ED3201F01;
        Mon, 11 Apr 2022 00:34:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Apr 2022 00:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649651682; x=1649738082; bh=br
        FmjsixLA13LMlSAce+x7kOCOj+NB4rSeQln6A+Zlw=; b=irzmLzAkmAfGk0q7xO
        fL7vIY0BQ1p/OMVyB6jGxFUcyj27rOMraep+mrKWrJzbGwIb7DNQAsvzfLHeGKwf
        tBzCsMq8Y+fmtRbsw+mfmX6qP7WOFu2cJFgxzKIe7AdsdQpe1dOlzzdaa2d0jrGN
        sRf+pCnXUTHLJMSM2Weilevc/LfNPSXrldM3ZWkSEphelh+AToLjV0G0Mx9wB4FJ
        Fj/IOGqrz8jK70T3dq45zb6KJYHj/Gl5uqTky4Rai1WOTC9L50WBW36+Zi14jofy
        ShvDEgkt2nGRG1DaQUbvyOgHiI2XPxFvpdIcWSW8ZVHQySf7LcdhWckJ9G+6XDyt
        OLpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649651682; x=1649738082; bh=brFmjsixLA13LMlSAce+x7kOCOj+NB4rSeQ
        ln6A+Zlw=; b=XVwD9S0keBDxHNm5sJs3ZvXB5rgH9RtVItcIwOhhWalb5GOYH8F
        Dvkzilhe/0+hJeGaTB2J5a/iBcwUrGUxPWcY+t2m/83m7izaLYESl13G0SUonoZg
        7/Bz5WURBl9ZKOP1nSWTBEVAluGsvUpA1zxxTtwzBWwRYk8QzDZIwnhELol+24Db
        Y4fp7MbiTUe1Q64J4aIzBHC98TeAPmDNfV7Zglp+lkvNGZObRw6l0C2Ns31nfQQX
        ybWk2vmonRiVcYjButFPSr7C+fpze2sBRvywgQR2BT6OxDxtUtFFSbsiHRNFeNef
        aWH7KdJ2fMXxSP+7rBRIly8fSHb7PkGIF3w==
X-ME-Sender: <xms:4q9TYho1p7scK6RD1n7xh0CH7CnH1cJMG-GTQiiR3C1OpqFNLhoalQ>
    <xme:4q9TYjoU1efhUuSimh3VTswahhcEWcP5VB0VHWs4nro-v1glwiH-rXGfjKw1s2A56
    PKgP2kW0SPM3eL9Vg>
X-ME-Received: <xmr:4q9TYuMQvg6FWdYhy9RsNOyVGXSYc4DgBwOcTMErAGRwAcFAbBOzJd75LKZWvlcASnvlzooIBJ3EtO0_fpoNbgODBLwgFBG_vM4ImXbfm57obJtXWdTF_Ws7_XtCUr3To8UpqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:4q9TYs6OQLrdq9K6fXYVjMnZsZPGDALL2urChdUyOUNe9Yyvq65x3g>
    <xmx:4q9TYg6m9dMQ4KEChK3PnzIs5pRNqCgWEjSRC8MKmefsQpi4ciZi5A>
    <xmx:4q9TYkjklqya6oVSQD55rjYP9cJZrVkn5S1pvUM1hWz1hUbhOdUEng>
    <xmx:4q9TYgiZTq92_Ya75vOEgE1dcE0KRIo_4rhfHxKcPKGkbMDpvFEIBA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:34:41 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 05/10] drm/sun4i: csc: Add support for the new MMIO layout
Date:   Sun, 10 Apr 2022 23:34:17 -0500
Message-Id: <20220411043423.37333-6-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411043423.37333-1-samuel@sholland.org>
References: <20220411043423.37333-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 changes the MMIO address offset for the CSC blocks in the first
mixer. The ccsc field value is used as an index into the ccsc_base
array; allocate the next available value to represent the new variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpu/drm/sun4i/sun8i_csc.c   | 3 ++-
 drivers/gpu/drm/sun4i/sun8i_csc.h   | 1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 6 ++++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/sun8i_csc.c
index 9bd62de0c288..1ed10c6447a3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -8,9 +8,10 @@
 #include "sun8i_csc.h"
 #include "sun8i_mixer.h"
 
-static const u32 ccsc_base[2][2] = {
+static const u32 ccsc_base[][2] = {
 	{CCSC00_OFFSET, CCSC01_OFFSET},
 	{CCSC10_OFFSET, CCSC11_OFFSET},
+	{CCSC00_OFFSET, CCSC01_OFFSET_D1},
 };
 
 /*
diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/sun8i_csc.h
index 022cafa6c06c..bd54166b2bcc 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.h
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
@@ -13,6 +13,7 @@ struct sun8i_mixer;
 /* VI channel CSC units offsets */
 #define CCSC00_OFFSET 0xAA050
 #define CCSC01_OFFSET 0xFA050
+#define CCSC01_OFFSET_D1 0xFA000
 #define CCSC10_OFFSET 0xA0000
 #define CCSC11_OFFSET 0xF0000
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 5b3fbee18671..22f1b7ef9225 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -151,8 +151,10 @@
  *	scaler and 2 UI channels with scaler, bitmask would be 0xC.
  * @ccsc: select set of CCSC base addresses
  *	Set value to 0 if this is first mixer or second mixer with VEP support.
- *	Set value to 1 if this is second mixer without VEP support. Other values
- *	are invalid.
+ *	Set value to 1 if this is second mixer without VEP support.
+ *	Set value to 2 if this is first mixer or second mixer with VEP support,
+ *	and the SoC uses the MMIO layout found in the D1 SoC.
+ *	Other values are invalid.
  * @mod_rate: module clock rate that needs to be set in order to have
  *	a functional block.
  * @is_de3: true, if this is next gen display engine 3.0, false otherwise.
-- 
2.35.1

