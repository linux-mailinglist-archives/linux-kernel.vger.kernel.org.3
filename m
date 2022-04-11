Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC44FB2E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244603AbiDKEg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbiDKEgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:36:45 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AA463A1;
        Sun, 10 Apr 2022 21:34:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E7D4D3200D78;
        Mon, 11 Apr 2022 00:34:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Apr 2022 00:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1649651666; x=1649738066; bh=UADj43RFHZwY34uGNWFBbRbPs
        ti5GL31jj1csV2jv00=; b=d9sIXm3fZjepfsUk1yqvaRFb2lrDthNzo/KLQoROC
        6o5jt28hQBuvSMy76jkX+CMUOj0iLNAaSZhC4eL5jarzZ2/xaAe+QcN1l1dnY2Z+
        ZygA/KEdHYZ9Y/lGrFxud+aQAxGYjiEXtmVvu4/p+YykyOi9MZfodx9HX/vSvldg
        ttPuQ+mNOIO0xCzncr5NcUuiksAvs1SNceQpFsuTZ1DbotOAbQ+Mml4ko0RjEb6j
        JCYnix5fJIiKmUwDG4T2gQdQuve4RKUQ6N74jfL6OnGeGlQ+gP4Dtpt9/BPxFTa8
        BxHSENmfaWg7qZK6bxiI5VYFQi9foUogDAofopK1PCwQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1649651666; x=1649738066; bh=U
        ADj43RFHZwY34uGNWFBbRbPsti5GL31jj1csV2jv00=; b=YYz7e9VAgM1dCGVTV
        /uK6eUgwClFPFYcNmNkwRyn7gKopKOYIAcZTFtS/tGm7uI4Nh+1Fy3Y+0RoD1qDq
        dRhTs3ja8m8jutojKg+GLZPUtfdhIsv35IVcWn8vSbjDGmw119+gSe7SOqexonQn
        zLcAsE8vSBNXfj4nQV1uZlIXB1TnnidSKcCzSNnSh4+IpSaf5vGmJNRBH7xoc53I
        5R5/b2p5xvRnEWJsteszHCj1B0LeuaUVLNmuCvu9WWaUcA+1tX8P8XuCcbpSdzH2
        26KSkkYKGigk9UTcbBe0uXV5rHmEcK15LnUzeXoetgmk/4SaBiFk8MVvqkw8wH6I
        8rUMQ==
X-ME-Sender: <xms:0a9TYv-p6Q5nuleDPFcP87OHhxG2kU9zyfAs8LPWhEjD4OZS8FUXTQ>
    <xme:0a9TYruXQmmlRW4rKYGRqO-hFy-mWInFpsWpp_hK6aw58jwQtR94jaMTYW3AFQ7Is
    SzL8LBqMZ9wQGIYPw>
X-ME-Received: <xmr:0a9TYtD0cKdslGAxW1FwNE8Bv-SZsr7aaEmKUaJl4_IHp1-bB1JYbibt0G4HHqFuS2snWPgbtQR36bP2L8KZdNuahAgflwXvnnHzl-rDAeYGnkzkFzfpf074dOW4wwIg5atnmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:0a9TYreIrhsxN46nReyzw4kSGGcCxNwQ7RKO5eK8fzGiDXg6r4z7_w>
    <xmx:0a9TYkNkHI9965TaJKmaUG9kmGG7VwOfxO3ijqEkhusPmAtaKN33NA>
    <xmx:0a9TYtl-1XkY6jNrt8ECdRTW2Tv2FpLcshbeNEJKMHUj4U6529nPtQ>
    <xmx:0q9TYtn5HLMATeVFiRfwfR27Ml3yplO4ZtHnYUk8p9Ojiw_5enLb1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:34:24 -0400 (EDT)
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
Subject: [PATCH 00/10] drm/sun4i: Allwinner D1 Display Engine 2.0 Support
Date:   Sun, 10 Apr 2022 23:34:12 -0500
Message-Id: <20220411043423.37333-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

This series adds binding and driver support for Display Engine 2.0
variant found in the Allwinner D1.

So far it has only been tested with HDMI. I will be sending the HDMI
support series separately, because the hardware comes with a brand new
custom HDMI PHY, which requires some refactoring to support cleanly.


Samuel Holland (10):
  dt-bindings: display: Separate clock item lists by compatible
  dt-bindings: display: Add D1 display engine compatibles
  drm/sun4i: Remove obsolete references to PHYS_OFFSET
  drm/sun4i: Allow building the driver on RISC-V
  drm/sun4i: csc: Add support for the new MMIO layout
  drm/sun4i: Allow VI layers to be primary planes
  drm/sun4i: Add support for D1 mixers
  drm/sun4i: Add support for D1 TCON TOP
  drm/sun4i: Add support for D1 TCONs
  drm/sun4i: Add compatible for D1 display engine

 .../allwinner,sun4i-a10-display-engine.yaml   |   1 +
 .../display/allwinner,sun4i-a10-tcon.yaml     |   2 +
 .../allwinner,sun8i-a83t-de2-mixer.yaml       |   2 +
 .../display/allwinner,sun8i-r40-tcon-top.yaml | 145 ++++++++++++------
 drivers/gpu/drm/sun4i/Kconfig                 |   2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
 drivers/gpu/drm/sun4i/sun4i_frontend.c        |   3 -
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   8 +
 drivers/gpu/drm/sun4i/sun8i_csc.c             |   3 +-
 drivers/gpu/drm/sun4i/sun8i_csc.h             |   1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |  26 ++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h           |   6 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        |  15 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  36 ++++-
 14 files changed, 196 insertions(+), 55 deletions(-)

-- 
2.35.1

