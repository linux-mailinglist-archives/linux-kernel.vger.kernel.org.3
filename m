Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DC74D632D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349307AbiCKOLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349136AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502411B2AE1;
        Fri, 11 Mar 2022 06:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63BCC61EFF;
        Fri, 11 Mar 2022 14:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F68C340FB;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007778;
        bh=V92qRYmU07w6Uv3N4IgYj79pKA/XFgvGaHGHf6J/lik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ED4nKBeHoFLZf8E3uUomp3OGBVLywxiF/DOhiuhx5phCKCePsDcfGHkvDjh0j6xjg
         gS4ILazNWnoZy+aLHEjn6pY/du7g5EMP+53Pg6hlY1K7w15ylDv/1A4MJvqT2QGzmG
         m99tYBr3fzOIGZ5lgULf/5H06+okUNhASvVmNq5O9rweRoTZ68ofays/zHSFP2npQN
         thDSogeBRLqCUSYf+6SOO5qaGK2AmucTyNyxO/tRtYzsM5ZMqgI6w7HHq52+wIJR+i
         DQyNCywjbmMeL3sueef7WQNQrDdSPP3PsG8pNLA32V5VPHoAp3OQsjhjDSxJjqRJeJ
         QAfNXbbZ7FJmw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxY-000lIf-Ca; Fri, 11 Mar 2022 15:09:36 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 36/38] media: platform: s5p-jpeg: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:49 +0100
Message-Id: <b6258d7a7522dc421837403c0904850575cc3d2e.1647006877.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647006877.git.mchehab@kernel.org>
References: <cover.1647006877.git.mchehab@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig          | 13 +------------
 drivers/media/platform/s5p-jpeg/Kconfig | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)
 create mode 100644 drivers/media/platform/s5p-jpeg/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 447fe5681307..913b48994e15 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -69,6 +69,7 @@ source "drivers/media/platform/rockchip/rkisp1/Kconfig"
 source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
+source "drivers/media/platform/s5p-jpeg/Kconfig"
 source "drivers/media/platform/sti/hva/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
@@ -111,18 +112,6 @@ config VIDEO_MEM2MEM_DEINTERLACE
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

