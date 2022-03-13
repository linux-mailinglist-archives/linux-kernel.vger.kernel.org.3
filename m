Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05554D7397
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiCMH0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiCMHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E871119457D;
        Sat, 12 Mar 2022 23:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D82C360F70;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FECC36AF8;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=ra4b3xu0CtMY3nrNaoXdedfEwl6h4CmfmRm9yvylQn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyuHBsld4VdGEp5vzoZs27jylw/xi8Rwmkz4bX8ofNA0SNBUONXeBMAdh/Tctncb5
         CiPhw7v2Ppf7jezZGVcqd2XaeN3ZSTMN5Rvo2qDc6LTgaPVVbqfbVB5mXsXsPIelMP
         TxWzldYtwiAojPuDbuuMnk2CXmkzCnANLP4AWQhatDh7GdPlWL0Rg4CwBGKgPIRwjJ
         zEQB4fxrfXrOlH+ITyLz7S+bwjqnHMw3kneff8CjGGZp1Szes+9XSUZ3oZQsvdMZiO
         Zqw5ituqZz1DwigJbjGHQoBKps1XbWrXBlLTO40ceO/M+Rw/btFIlG54THV9n00JIv
         dLMqRtYlsEc8g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY4-0012xs-Ii; Sun, 13 Mar 2022 08:21:52 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v3 37/39] media: platform: Kconfig: sort entries
Date:   Sun, 13 Mar 2022 08:21:46 +0100
Message-Id: <f8cba33b5ddaa49aec905dbda9192236a157f12e.1647155572.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647155572.git.mchehab@kernel.org>
References: <cover.1647155572.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that each non-generic driver has their own directory,
sort the entries.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig | 98 +++++++++++++++-------------------
 1 file changed, 43 insertions(+), 55 deletions(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index d5aedc6b5ca3..b7c60969c974 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -29,84 +29,72 @@ config V4L_MEM2MEM_DRIVERS
 	  to capture and output drivers, which use memory buffers for just
 	  one of those.
 
+# Ancillary drivers
+
+config VIDEO_MEM2MEM_DEINTERLACE
+	tristate "Deinterlace support"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on HAS_DMA
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	    Generic deinterlacing V4L2 driver.
+
+config VIDEO_MUX
+	tristate "Video Multiplexer"
+	depends on V4L_PLATFORM_DRIVERS
+	select MULTIPLEXER
+	depends on VIDEO_V4L2 && OF
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select REGMAP
+	select V4L2_FWNODE
+	help
+	  This driver provides support for N:1 video bus multiplexers.
+
+# Platform drivers - Please keep it alphabetically sorted
+
+# TODO: create per-manufacturer directories
+
 source "drivers/media/platform/allegro-dvt/Kconfig"
-source "drivers/media/platform/nxp/Kconfig"
-
-source "drivers/media/platform/renesas/Kconfig"
-
-# V4L platform drivers
-
-source "drivers/media/platform/marvell-ccic/Kconfig"
-
-source "drivers/media/platform/via/Kconfig"
-
+source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/amphion/Kconfig"
+source "drivers/media/platform/aspeed/Kconfig"
+source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/cadence/Kconfig"
-
 source "drivers/media/platform/coda/Kconfig"
 source "drivers/media/platform/davinci/Kconfig"
-
 source "drivers/media/platform/exynos-gsc/Kconfig"
+source "drivers/media/platform/exynos4-is/Kconfig"
+source "drivers/media/platform/intel/Kconfig"
+source "drivers/media/platform/marvell-ccic/Kconfig"
 source "drivers/media/platform/meson/ge2d/Kconfig"
 source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
 source "drivers/media/platform/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mtk-vpu/Kconfig"
-source "drivers/media/platform/omap3isp/Kconfig"
+source "drivers/media/platform/nxp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
+source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/qcom/camss/Kconfig"
 source "drivers/media/platform/qcom/venus/Kconfig"
-
-source "drivers/media/platform/aspeed/Kconfig"
+source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/rockchip/rkisp1/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
 source "drivers/media/platform/s5p-jpeg/Kconfig"
+source "drivers/media/platform/s5p-mfc/Kconfig"
+source "drivers/media/platform/sti/bdisp/Kconfig"
+source "drivers/media/platform/sti/c8sectpfe/Kconfig"
+source "drivers/media/platform/sti/delta/Kconfig"
 source "drivers/media/platform/sti/hva/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
+source "drivers/media/platform/sunxi/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-rotate/Kconfig"
 source "drivers/media/platform/tegra/vde/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
-
-config VIDEO_MUX
-	tristate "Video Multiplexer"
-	depends on V4L_PLATFORM_DRIVERS
-	select MULTIPLEXER
-	depends on VIDEO_V4L2 && OF
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select REGMAP
-	select V4L2_FWNODE
-	help
-	  This driver provides support for N:1 video bus multiplexers.
-
-source "drivers/media/platform/intel/Kconfig"
-
-source "drivers/media/platform/exynos4-is/Kconfig"
-source "drivers/media/platform/am437x/Kconfig"
+source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
-source "drivers/media/platform/atmel/Kconfig"
-source "drivers/media/platform/sunxi/Kconfig"
-
-# Mem2mem drivers
-
-config VIDEO_MEM2MEM_DEINTERLACE
-	tristate "Deinterlace support"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on HAS_DMA
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	    Generic deinterlacing V4L2 driver.
-
-source "drivers/media/platform/s5p-mfc/Kconfig"
-
-source "drivers/media/platform/sti/bdisp/Kconfig"
-
-source "drivers/media/platform/sti/delta/Kconfig"
-
-# DVB platform drivers
-source "drivers/media/platform/sti/c8sectpfe/Kconfig"
-- 
2.35.1

