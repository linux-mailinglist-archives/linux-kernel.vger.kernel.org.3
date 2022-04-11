Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3004FB2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244203AbiDKEhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbiDKEgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:36:53 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB75065F7;
        Sun, 10 Apr 2022 21:34:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8AE303201E78;
        Mon, 11 Apr 2022 00:34:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Apr 2022 00:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649651679; x=1649738079; bh=lm
        1CYL2crA76mqn8yhmfIaPwd9txmmkjx2Gv/gchVwA=; b=np6Nt/5VsPzzijoTdC
        55o1rTmMueDS5rokTb7//Z9moldP49kJK32dEUghyQ6Z4yfJU9Jk7Gscbcbn+gYA
        MiZtN6NGDYiMun6BBjIcsvwKQ/RKAGjmCQmdaflHZd24wB+Iu+f2vwyUa/7AKYZp
        q9fMofyp4l8XK6PV/MxbiwMtwHythlqlvrl+vXyxcVLZ8fc0kBjg5OM+KmEUcTJu
        oR+7nvocqXkWL/d+JKOCHoCp77uWT5bPUze4KS3pELN9anTgR28eFeP+aTEis6ES
        XhFgIrEMjmlN0pbznJxxoOkdHZorccFZwrszDoxr2ifIuAvigTOyE/DsL6aSQxPY
        6qDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1649651679; x=1649738079; bh=lm1CYL2crA76mqn8yhmfIaPwd9txmmkjx2G
        v/gchVwA=; b=NCFOaAIyhaLKstsTz4SH0wej+qlv1QngXha/KNRK2ScNcDEGtHN
        NXygq3jzFO+b8cLUSJhZz+umDI1mnZ9pnZgqA6KATiWXJXXOqW+D3ECxLiXEuEZd
        biLpCatdZBps5Br7tvrpqDXWWp+rny+nBRMxRW3yQJmPZUGOtxWQjl5Ippot0oBr
        LBwml0UyOH+rcH3h87hcR6yhiJEP2VRpO6F2BFtpQbRLOwA3LXJbfH4FBs1fM+25
        TR9EkqhHIgCACuVw3k3x7YSpnmnti/F3UaVkZPaImEGmxVZdGcVnzXQmDO1KhOtl
        4MJa+X5EOJEeuVc+1xOxYYD8ZjjLjbse+jA==
X-ME-Sender: <xms:369TYjcrlcVa4hGauUCawWuGJu9_65WIX3uxLH4k2ktiHNj3SyTNpg>
    <xme:369TYpPsAPYAUarpZ2yE5-JcKVo5WipLLn-bm0nm_gMCI9hmHVJSj9GyxuOGZILuW
    lmTEw7G-auSHz1B6w>
X-ME-Received: <xmr:369TYsgk1Rt2MYZQIrBmWxVaCWgP7TAw3yS7DmEgRQ6n02ePgfM07HqUnnWaQpMv4bYuk1-qX6XIMK_LdGPaUdHKDdRpebZEG20pjZqlPfQL2dDqpGL-44DACP8ecqG94zn0wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekhedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:369TYk_FD_am8tVwX9UvLsIygh_DZe7uQChMcdNu1phpRElu0WNxKA>
    <xmx:369TYvvAE5NCl1Aa3AUG_hH3OEPDt7xyu4D7mNPlSy61dmu4oUBzkg>
    <xmx:369TYjFJFXGI_LUoHo16HTlHDwJTBXAnRgZlZ2QM3rhkrL3d9PEBPw>
    <xmx:369TYjEKxKk-NEHV53uFP8X0cjlGj2_Kt1aOSbCX-peXU8LqQDERdA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Apr 2022 00:34:38 -0400 (EDT)
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
Subject: [PATCH 04/10] drm/sun4i: Allow building the driver on RISC-V
Date:   Sun, 10 Apr 2022 23:34:16 -0500
Message-Id: <20220411043423.37333-5-samuel@sholland.org>
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

Allwinner D1 is a RISC-V SoC which contains a DE 2.0 engine. Let's
remove the dependency on a specific CPU architecture, so the driver can
be built wherever ARCH_SUNXI is selected.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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

