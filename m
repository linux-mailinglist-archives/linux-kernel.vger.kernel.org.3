Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3494FCDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346358AbiDLEbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346139AbiDLEam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:30:42 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD012329A0;
        Mon, 11 Apr 2022 21:28:26 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6BAE33200E89;
        Tue, 12 Apr 2022 00:28:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Apr 2022 00:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649737705; x=1649824105; bh=rT
        me4gsdReTHZYq9dpsHcO27YtJUVs0qzpd+cDg5ggo=; b=G+N6Zs7JCoYiGdmbR3
        Rwf8otMzwqj5blzxGACkhQj2pu5MCAe7gJEJ5c/Mz8AdnskUVugJJRXL2odJeMxs
        eGVTQC9/nQn6GnDESbn7me3zAcmHLaDGjBIuvadnhnFMxuPg8U6vsInLTyvw6fUa
        EJ4MlQNg+yQR4ptrFuux6aNDk+ppL+0JyNf/t35L2lGzNpkhajokQKUJ2/sFvuUR
        jgf38ScgYwhpB6NUF2ERJe20dCLO2y02oG17z9QK9ZCogSxiYRBxWSKkoR+he4+Y
        fTt0+xAd/DWcT3jtAUhTqxnGEHadrmdZaQZbU5zRF85Yvq8vUE6jiL7Cm4+O/do4
        +e5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649737705; x=1649824105; bh=rTme4gsdReTHZYq9dpsHcO27YtJUVs0qzpd
        +cDg5ggo=; b=jyKlhTmrOMwsc2JvquM2gixmZn2SvbeJwwU8J9pVHEhDQKobzl9
        gXmAkbg7t/q0udzVrBwTUHT2Lk/JpE8WMlvnIPz1/g3F3RjQ3vhpHMdH5/NQh9d6
        gUogd4SdiXaTAFZERClBXsvMzeqsNAJlx8Mu/CvXCUFy01utDAgGfCryeACjJYtQ
        /SuShvNzI2L2Kx909Yf96J/Gz6A0y+46yX9fgPTTSEY8NDYECoflRLc0Wxx3Jeji
        qS/P4n8jBZ9Bnq+7Fr9Bk3Lk7h5ZAA5Dopjzh+LAoZnDlmpW2iJShN5Ne4Hmpg06
        JL9vmXuVDCLaE+a1uoLvpFEfmEA6zKw9y4w==
X-ME-Sender: <xms:6P9UYl-POP1U2JWe_wXqMdm2P8xbQEXj-iXWXq43yUCjE1eRL_MWqw>
    <xme:6P9UYpuBbnfzCPznh_wUzGeLNYn-EqvAW4WtCUv5bxFzjmIbuC_GFJQaByRagydxD
    IHA80tBkvk--unWNQ>
X-ME-Received: <xmr:6P9UYjDJwv6OLIPhaH653aKdqEW9kM-XXftDHMaE-ZU0OFMGcV_mUIq2Rct2BTyXz8piOiRLdNaJX_XByt7hxmSby2LVvQ1OskMP80YRoGks2j6Ewt0hY7lZp4VqqrK3uF0AzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6P9UYpc11NbbJf8bvJ42BGRU4ezdiujA533xGNdxrFUOYgEQ9OuYMw>
    <xmx:6P9UYqM_-LUIjwtpHLUijEuNf_75avUblg1z-VZ0W-7JwlB3Z-kIUg>
    <xmx:6P9UYrkmCgnmRV0ilkXxjNGJM5egzTO1pad7aBkqVaLvp0qWeWKlUQ>
    <xmx:6f9UYrlZS4prjzKImk2j9_eiYe1BOO7RmiSuRpIKNW8gZdBj6ieqhQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 00:28:24 -0400 (EDT)
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
Subject: [PATCH v2 05/14] drm/sun4i: Allow building the driver on RISC-V
Date:   Mon, 11 Apr 2022 23:27:57 -0500
Message-Id: <20220412042807.47519-6-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412042807.47519-1-samuel@sholland.org>
References: <20220412042807.47519-1-samuel@sholland.org>
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

Allwinner D1 is a RISC-V SoC which contains a DE 2.0 engine. Let's
remove the dependency on a specific CPU architecture, so the driver can
be built wherever ARCH_SUNXI is selected.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/gpu/drm/sun4i/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index befc5a80222d..3a43c436c74a 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_SUN4I
 	tristate "DRM Support for Allwinner A10 Display Engine"
-	depends on DRM && (ARM || ARM64) && COMMON_CLK
+	depends on DRM && COMMON_CLK
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_HELPER
-- 
2.35.1

