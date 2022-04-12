Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246384FCDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345936AbiDLEab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiDLEa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:30:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7453298F;
        Mon, 11 Apr 2022 21:28:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B9F023201F24;
        Tue, 12 Apr 2022 00:28:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Apr 2022 00:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1649737689; x=1649824089; bh=mTmKnvQTGsBoRsAAqdQBjpSXL
        YdyxkIborYacXcxMFs=; b=LHFutkbugEbkHURUMOmuhONbA29IkXpRXBTHFcpiX
        xUFoAQx3/FaLOqUrWM5QEKh9fI6azDbrIctgcbCFu/X1GQc7vTZT9EYRYPzvwk9T
        cV5v+sUqb5yQS5ahNlpcyN6dV76AzfctKQeZFH11bKkMCVFx+GuRnFBZ50yV/5ct
        VQudJ95Jnv0Ie73rwUbs4H8Gnnt/5O70ROGh/EI1ksGUPfYPoT6eGGRZT0pJwRp5
        wz6q3GShN/KtH1VMLY4Woq0/JXmpBiWpnzUg5peOst9ZpPX0tGzJqdEOp7MHiika
        DgVcusH2JOfojpZ60DcYOog616DhZcRChdxEwcj5kDceA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1649737689; x=1649824089; bh=m
        TmKnvQTGsBoRsAAqdQBjpSXLYdyxkIborYacXcxMFs=; b=Snn3V0pHT7h6YxgYV
        LRwrPvhPs0ihNYeg4MQ/o9dsL216zkxvQsxLow+cdoDF5GqDG9FItyHbjO7alnlt
        QDJ6pn4iZb8m2oDPCOz4WnXtZ0WUyTm7iQERZI2aOUQqQ8dPsPZsNC2fUdTiaATb
        69FgmLT3DEchwX49Ki3n7HzbjYvCY5owq5SS7KXq6XcSLFLYNF38spv7C6F3xZ/o
        eVJUp23mMgor22G6Tvj6Z7jDiln4VxV7tQfO5oQYZ8xPwZsxRg3YmCcxY1HieaiV
        G4H67qKsS3W7OtJZmM++yydmBsDR5/RtU34bdahfxXnYPBEFS4X8CSj1uL3Qm33H
        0XySA==
X-ME-Sender: <xms:2P9UYpWOEW3LNea-znOyAiR84mF8UHEPlOP2_XHArO7m_2eVlKqoog>
    <xme:2P9UYpmv5SW-OvELVMXj0VMl3zfoBXIwD-RZGSmc4vRECdCqeZK53lDnxF7GtlNPI
    skMHbXTk4K6AcmPAw>
X-ME-Received: <xmr:2P9UYlaS-wTB8B3ck42cTNEnTH3--wnYxCWRe_v_oTx9m3L0RmS02dgIHOXX16hufAmaBnmL4neH8kZGwMydLMVwPWaIQZ3lGzS-kM_m8nsimOAJ6NAue5k_l07OLboT7UV0tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:2P9UYsX-weSqasTUk-8knNQlixibOm2BYp3zVTDW0dD07-5q2wIL_Q>
    <xmx:2P9UYjk8XqFcgnNoG2S8UcuncNjEuM0_zEc6ECVVQgz6D5a13QKmPw>
    <xmx:2P9UYpd2rdJsFd60pzUA3MaVHWQ5-mseoh0Mfs-DNhq_Yg11m-M8Vg>
    <xmx:2f9UYhdd-nPBrA2s0X8KDjWYzy9H8IB0U4IcC06Dias0Y6ACWWN-Lg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 00:28:08 -0400 (EDT)
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
Subject: [PATCH v2 00/14] drm/sun4i: Allwinner D1 Display Engine 2.0 Support
Date:   Mon, 11 Apr 2022 23:27:52 -0500
Message-Id: <20220412042807.47519-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

This series was tested on A33, D1 and H3.

Changes in v2:
 - New patch: I/O helper portability
 - Use Jernej's patches for mixer mode setting.
 - Use an enumeration for the ccsc value.

Jernej Skrabec (3):
  sun4i/drm: engine: Add mode_set callback
  sun4i/drm: backend: use mode_set engine callback
  sun4i/drm: sun8i: use mode_set engine callback

Samuel Holland (11):
  dt-bindings: display: Separate clock item lists by compatible
  dt-bindings: display: Add D1 display engine compatibles
  drm/sun4i: Remove obsolete references to PHYS_OFFSET
  drm/sun4i: hdmi: Use more portable I/O helpers
  drm/sun4i: Allow building the driver on RISC-V
  drm/sun4i: Allow VI layers to be primary planes
  drm/sun4i: csc: Add support for the new MMIO layout
  drm/sun4i: Add support for D1 mixers
  drm/sun4i: Add support for D1 TCON TOP
  drm/sun4i: Add support for D1 TCONs
  drm/sun4i: Add compatible for D1 display engine

 .../allwinner,sun4i-a10-display-engine.yaml   |   1 +
 .../display/allwinner,sun4i-a10-tcon.yaml     |   2 +
 .../allwinner,sun8i-a83t-de2-mixer.yaml       |   2 +
 .../display/allwinner,sun8i-r40-tcon-top.yaml | 145 ++++++++++++------
 drivers/gpu/drm/sun4i/Kconfig                 |   2 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c         |  40 ++---
 drivers/gpu/drm/sun4i/sun4i_crtc.c            |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
 drivers/gpu/drm/sun4i/sun4i_frontend.c        |   3 -
 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c        |   4 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   8 +
 drivers/gpu/drm/sun4i/sun8i_csc.c             |   7 +-
 drivers/gpu/drm/sun4i/sun8i_csc.h             |   1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |  74 +++++++--
 drivers/gpu/drm/sun4i/sun8i_mixer.h           |  14 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        |  15 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  30 ----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |   6 +-
 drivers/gpu/drm/sun4i/sunxi_engine.h          |  27 ++++
 19 files changed, 263 insertions(+), 120 deletions(-)

-- 
2.35.1

