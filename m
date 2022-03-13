Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0AF4D7382
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiCMHYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiCMHXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E968119455D;
        Sat, 12 Mar 2022 23:21:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83BA4B80BE8;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05DCC34102;
        Sun, 13 Mar 2022 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156113;
        bh=xAYblfv3hUy292GLEYd0Eivlz95IA651ocBdwEtnsAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFVJh1IQWsvNXzS+WHOXKFFunUAowqui6BUw9TuNr7Vbv42KTXg98/QZ0gjLN188D
         aaxhcmeolYnLFqkAuvsqthHULrNIprWTBXB5Chp5M9mu6Z3cfLzEEL8dt3a6IkBnTj
         0b7ZOBIPUTk8d0nkY9YRnlX7mAtKiJGkPR9Cwb00vnGrc+LuP2ZK3kTXoTvN7bTZ0X
         P7MSo3kWysy1WLWMJ+PUPW51UQi2c4R9l8D32wsFEeAWSx0aj01+Y4PN8EW2Sp1Jgg
         7BMbgixw6LvLNEFfnsjY7k+GTCJ5hnrozWBO0eT16W4vBepvNHtRT7RunUOaJu3HLf
         jSirPRL3sV7NQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY3-0012wG-HM; Sun, 13 Mar 2022 08:21:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v3 12/39] media: platform: amphion: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:21 +0100
Message-Id: <2ac89ce86e6ace3edbca21abeafb77901c9ff447.1647155572.git.mchehab@kernel.org>
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
amphion-specific config stuff on a separate Kconfig file.

Reviewed-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 21 +--------------------
 drivers/media/platform/amphion/Kconfig | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)
 create mode 100644 drivers/media/platform/amphion/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 25e5ae27210d..060d6264dea4 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -40,6 +40,7 @@ source "drivers/media/platform/marvell-ccic/Kconfig"
 
 source "drivers/media/platform/via/Kconfig"
 
+source "drivers/media/platform/amphion/Kconfig"
 source "drivers/media/platform/cadence/Kconfig"
 
 source "drivers/media/platform/davinci/Kconfig"
@@ -524,26 +525,6 @@ config VIDEO_TEGRA_VDE
 	   Support for the NVIDIA Tegra video decoder unit.
 	   To compile this driver as a module choose m here.
 
-config VIDEO_AMPHION_VPU
-	tristate "Amphion VPU (Video Processing Unit) Codec IP"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on ARCH_MXC || COMPILE_TEST
-	depends on MEDIA_SUPPORT
-	depends on VIDEO_DEV
-	depends on VIDEO_V4L2
-	select MEDIA_CONTROLLER
-	select V4L2_MEM2MEM_DEV
-	select VIDEOBUF2_DMA_CONTIG
-	select VIDEOBUF2_VMALLOC
-	help
-	  Amphion VPU Codec IP contains two parts: Windsor and Malone.
-	  Windsor is encoder that supports H.264, and Malone is decoder
-	  that supports H.264, HEVC, and other video formats.
-	  This is a V4L2 driver for NXP MXC 8Q video accelerator hardware.
-	  It accelerates encoding and decoding operations on
-	  various NXP SoCs.
-	  To compile this driver as a module choose m here.
-
 # TI VIDEO PORT Helper Modules
 # These will be selected by VPE and VIP
 config VIDEO_TI_VPDMA
diff --git a/drivers/media/platform/amphion/Kconfig b/drivers/media/platform/amphion/Kconfig
new file mode 100644
index 000000000000..13899649f766
--- /dev/null
+++ b/drivers/media/platform/amphion/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_AMPHION_VPU
+	tristate "Amphion VPU (Video Processing Unit) Codec IP"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on MEDIA_SUPPORT
+	depends on VIDEO_DEV
+	depends on VIDEO_V4L2
+	select MEDIA_CONTROLLER
+	select V4L2_MEM2MEM_DEV
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	help
+	  Amphion VPU Codec IP contains two parts: Windsor and Malone.
+	  Windsor is encoder that supports H.264, and Malone is decoder
+	  that supports H.264, HEVC, and other video formats.
+	  This is a V4L2 driver for NXP MXC 8Q video accelerator hardware.
+	  It accelerates encoding and decoding operations on
+	  various NXP SoCs.
+	  To compile this driver as a module choose m here.
-- 
2.35.1

