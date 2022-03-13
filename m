Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F684D7385
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiCMHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiCMHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8816A194576;
        Sat, 12 Mar 2022 23:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D70C960F6F;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1104C36AEB;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=BOiGB4sNHzTN94Svjzn5HIDTxNSi9vo6g7hrj1wHpfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnIfz/LW3lailNCIWIXjUt23a5jfRFjoYMetc6iPD63HhZy8ZUDEccpwDS0/H+GGC
         EQep/bgpm2AIt0SMjSYJ+idfNfPFhSszHuaV7leg0guDV8tNkrIPpm149kRNJZpBCS
         nfruwPsuVGfXenkWh6PjwMbiQsCmZSqwde/SrgRPx7eyv7OInHHvd6ULDqYZ5SlNmW
         BnBaTqezQJNMlLZ21OXD63psdAep9ranZXA2ApZaaaNH+Pr8agKSkBlCvjwSA0KgrT
         NIgNKBz3CvwoXGduPf4AL1pOqcVi/+TDdxhNof3S0oUxISA5cGlXRq6B8BcgI5fg1q
         B9ljmyFo2ifcA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY4-0012xo-HY; Sun, 13 Mar 2022 08:21:52 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v3 36/39] media: platform: s5p-jpeg: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:45 +0100
Message-Id: <822d8d6a7fa225bf756fc023f9c5287808f10ef0.1647155572.git.mchehab@kernel.org>
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

In order to better organize the platform/Kconfig, place
s5p-jpeg-specific config stuff on a separate Kconfig file.

Acked-by: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig          | 13 +------------
 drivers/media/platform/s5p-jpeg/Kconfig | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)
 create mode 100644 drivers/media/platform/s5p-jpeg/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index fd6b18ac0c7c..d5aedc6b5ca3 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -62,6 +62,7 @@ source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/rockchip/rkisp1/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
+source "drivers/media/platform/s5p-jpeg/Kconfig"
 source "drivers/media/platform/sti/hva/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
@@ -101,18 +102,6 @@ config VIDEO_MEM2MEM_DEINTERLACE
 	help
 	    Generic deinterlacing V4L2 driver.
 
-
-config VIDEO_SAMSUNG_S5P_JPEG
-	tristate "Samsung S5P/Exynos3250/Exynos4 JPEG codec driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This is a v4l2 driver for Samsung S5P, EXYNOS3250
-	  and EXYNOS4 JPEG codec
-
 source "drivers/media/platform/s5p-mfc/Kconfig"
 
 source "drivers/media/platform/sti/bdisp/Kconfig"
diff --git a/drivers/media/platform/s5p-jpeg/Kconfig b/drivers/media/platform/s5p-jpeg/Kconfig
new file mode 100644
index 000000000000..e522860d2b15
--- /dev/null
+++ b/drivers/media/platform/s5p-jpeg/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config VIDEO_SAMSUNG_S5P_JPEG
+	tristate "Samsung S5P/Exynos3250/Exynos4 JPEG codec driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This is a v4l2 driver for Samsung S5P, EXYNOS3250
+	  and EXYNOS4 JPEG codec
-- 
2.35.1

