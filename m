Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596FE4D62FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbiCKOLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345552AbiCKOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:10:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA991B308C;
        Fri, 11 Mar 2022 06:09:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A4DFB82C0E;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2543AC340E9;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007777;
        bh=l43uig7u4QoUgCLbuOaSYDR1BPlB3/eU5ML5shDws0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Om6ucL+EIP9TOAfIH36ogRtY+727Z2w2hWmbkn0/54KXOOYned2s25FLrOnhNbb2R
         niOvUzrZjnJcWGCAHIYhZlq0Vwz2DDUI7Vm775mTdETH+O12GU3CcyyJ/5VGCKgbmC
         o8HdtllhWHr3hYkIvkk38TOlHLo6e0ki7/Z5InSaKrWRqwI+/pPjliBHbs1KIl1YIM
         wy2y9IHWLKkbgaPyNjPQlE3VeFU9AoAoVwhoRdUzrDxsDFLYL/0KFcfLkO+66j3ivr
         a3+pt04ZFTZqPWyzvoOoBzSdaaNfQX75YPZJaybIugsC/+Xl4OwBZRl6vHu7Xw7QK7
         yDJT37k3kPpDw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxW-000lH7-V7; Fri, 11 Mar 2022 15:09:34 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 12/38] media: platform: amphion: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:25 +0100
Message-Id: <3aa6e54b5f1e3c4ca8eb5a7c2284513f9b555bf5.1647006877.git.mchehab@kernel.org>
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
amphion-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 21 +--------------------
 drivers/media/platform/amphion/Kconfig | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)
 create mode 100644 drivers/media/platform/amphion/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index e795a0862841..25cfda75e625 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -47,6 +47,7 @@ source "drivers/media/platform/marvell-ccic/Kconfig"
 
 source "drivers/media/platform/via/Kconfig"
 
+source "drivers/media/platform/amphion/Kconfig"
 source "drivers/media/platform/cadence/Kconfig"
 
 source "drivers/media/platform/davinci/Kconfig"
@@ -535,26 +536,6 @@ config VIDEO_TEGRA_VDE
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

