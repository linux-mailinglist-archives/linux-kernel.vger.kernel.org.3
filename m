Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0062C4D6338
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbiCKOMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349213AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495031B1DF7;
        Fri, 11 Mar 2022 06:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D73061EF8;
        Fri, 11 Mar 2022 14:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9118C3410A;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007777;
        bh=Fe0ryIwx0a4/s0R6N6D3aXkyaHLa/qrZCaWjXq0v/fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4M/MsJU070+d1a3NYrSFfWh9TDWst3x88yR7D4hVy401WREaJh8bkmT9EC2gVziq
         WUmEcp3vkHC00IxFquUmgVGdr545N/8zZUDOuo+3F9v/HPbeG7m921jmZ+FC3zrYMK
         dJb2wHBWSC8xmh8wslu4SBvpjFSYV4/lUvXgY36FdPL8qn56VKvYbv9NRHfvEHKodT
         KxBZ/TrAIpcCejuWZBsW0Fay5b4yLbIplYnPT32UBujUIEEvjbQ3pqvxP3FTee+kyt
         Ph7KyDz6mcuZjxtumFdovAeaNqw4+pkX1I7J1KKxUXw/7pbXubwx+3SxXAiFRBDwh3
         OXhylFlvlC4mw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxX-000lHx-O5; Fri, 11 Mar 2022 15:09:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 25/38] media: platform: s5p-g2d: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:38 +0100
Message-Id: <c801234d44c13878854d1348b2297826b78d178e.1647006877.git.mchehab@kernel.org>
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
s5p-g2d-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 11 +----------
 drivers/media/platform/s5p-g2d/Kconfig | 11 +++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)
 create mode 100644 drivers/media/platform/s5p-g2d/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 633fbc408b8c..95f66255b635 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -67,6 +67,7 @@ source "drivers/media/platform/qcom/venus/Kconfig"
 source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
+source "drivers/media/platform/s5p-g2d/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -164,16 +165,6 @@ config VIDEO_MEM2MEM_DEINTERLACE
 	help
 	    Generic deinterlacing V4L2 driver.
 
-config VIDEO_SAMSUNG_S5P_G2D
-	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This is a v4l2 driver for Samsung S5P and EXYNOS4 G2D
-	  2d graphics accelerator.
 
 config VIDEO_SAMSUNG_S5P_JPEG
 	tristate "Samsung S5P/Exynos3250/Exynos4 JPEG codec driver"
diff --git a/drivers/media/platform/s5p-g2d/Kconfig b/drivers/media/platform/s5p-g2d/Kconfig
new file mode 100644
index 000000000000..9bc9d90a666a
--- /dev/null
+++ b/drivers/media/platform/s5p-g2d/Kconfig
@@ -0,0 +1,11 @@
+config VIDEO_SAMSUNG_S5P_G2D
+	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This is a v4l2 driver for Samsung S5P and EXYNOS4 G2D
+	  2d graphics accelerator.
+
-- 
2.35.1

