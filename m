Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2504D74B3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiCMKzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiCMKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:54:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210A11EC46;
        Sun, 13 Mar 2022 03:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8AB661021;
        Sun, 13 Mar 2022 10:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3278C34117;
        Sun, 13 Mar 2022 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647168730;
        bh=+Y3G+nuTtdIJf00pXppXleGBXkybw5av3IQASzDnjwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGVjv+Nu4wXdbfJhiI3NAf8DPSyetPIS4wignQzOIrlPO4+/97RNC/8s4bUXMZn1C
         MfKUuMFoI+tGZRxo1n8EdZOqe5w97J4NAO7lWUnTWPKebx/AIP/bGY7Jy83XhHqcsS
         xxnqY6klAF3YDKyC61xsG9mNBFufuvxF6t07Qd4yjgedefzp4AMq0icK458WtV5i5d
         z60SrbivLJDnLNQ6eAEJGArKiOBsIdxQA7oBLXFH5/H35HQwpt5JlGCbYkeIt/4vAD
         FkyQAp5sPEBBNvH5SbRJ1jfqyQrIHjj7I6KiQBM/MyutATUH6CUvb6XkARVHTOBgSJ
         MoSfD7TnDYJOg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTLpX-001I2S-LK; Sun, 13 Mar 2022 11:52:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Herman <yanshuaijun@yulong.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 19/24] media: platform: rename davinci/ to ti/davinci/
Date:   Sun, 13 Mar 2022 11:52:00 +0100
Message-Id: <a042a3d3e1b5281866245d61bd71caa0e61eab94.1647167750.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647167750.git.mchehab@kernel.org>
References: <cover.1647167750.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the end goal is to have platform drivers split by vendor,
rename davinci/ to ti/davinci/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/

 .../media/drivers/davinci-vpbe-devel.rst      | 20 +++++++++----------
 MAINTAINERS                                   |  2 +-
 drivers/media/platform/Kconfig                |  2 +-
 drivers/media/platform/Makefile               |  2 +-
 .../media/platform/{ => ti}/davinci/Kconfig   |  0
 .../media/platform/{ => ti}/davinci/Makefile  |  0
 .../{ => ti}/davinci/ccdc_hw_device.h         |  0
 .../platform/{ => ti}/davinci/dm355_ccdc.c    |  0
 .../{ => ti}/davinci/dm355_ccdc_regs.h        |  0
 .../platform/{ => ti}/davinci/dm644x_ccdc.c   |  0
 .../{ => ti}/davinci/dm644x_ccdc_regs.h       |  0
 .../media/platform/{ => ti}/davinci/isif.c    |  0
 .../platform/{ => ti}/davinci/isif_regs.h     |  0
 .../media/platform/{ => ti}/davinci/vpbe.c    |  0
 .../platform/{ => ti}/davinci/vpbe_display.c  |  0
 .../platform/{ => ti}/davinci/vpbe_osd.c      |  0
 .../platform/{ => ti}/davinci/vpbe_osd_regs.h |  0
 .../platform/{ => ti}/davinci/vpbe_venc.c     |  0
 .../{ => ti}/davinci/vpbe_venc_regs.h         |  0
 .../platform/{ => ti}/davinci/vpfe_capture.c  |  0
 .../media/platform/{ => ti}/davinci/vpif.c    |  0
 .../media/platform/{ => ti}/davinci/vpif.h    |  0
 .../platform/{ => ti}/davinci/vpif_capture.c  |  0
 .../platform/{ => ti}/davinci/vpif_capture.h  |  0
 .../platform/{ => ti}/davinci/vpif_display.c  |  0
 .../platform/{ => ti}/davinci/vpif_display.h  |  0
 .../media/platform/{ => ti}/davinci/vpss.c    |  0
 27 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/media/platform/{ => ti}/davinci/Kconfig (100%)
 rename drivers/media/platform/{ => ti}/davinci/Makefile (100%)
 rename drivers/media/platform/{ => ti}/davinci/ccdc_hw_device.h (100%)
 rename drivers/media/platform/{ => ti}/davinci/dm355_ccdc.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/dm355_ccdc_regs.h (100%)
 rename drivers/media/platform/{ => ti}/davinci/dm644x_ccdc.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/dm644x_ccdc_regs.h (100%)
 rename drivers/media/platform/{ => ti}/davinci/isif.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/isif_regs.h (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpbe.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpbe_display.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpbe_osd.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpbe_osd_regs.h (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpbe_venc.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpbe_venc_regs.h (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpfe_capture.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpif.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpif.h (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpif_capture.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpif_capture.h (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpif_display.c (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpif_display.h (100%)
 rename drivers/media/platform/{ => ti}/davinci/vpss.c (100%)

diff --git a/Documentation/driver-api/media/drivers/davinci-vpbe-devel.rst b/Documentation/driver-api/media/drivers/davinci-vpbe-devel.rst
index f0961672e6a3..4e87bdbc7ae4 100644
--- a/Documentation/driver-api/media/drivers/davinci-vpbe-devel.rst
+++ b/Documentation/driver-api/media/drivers/davinci-vpbe-devel.rst
@@ -7,22 +7,22 @@ File partitioning
 -----------------
 
  V4L2 display device driver
-         drivers/media/platform/davinci/vpbe_display.c
-         drivers/media/platform/davinci/vpbe_display.h
+         drivers/media/platform/ti/davinci/vpbe_display.c
+         drivers/media/platform/ti/davinci/vpbe_display.h
 
  VPBE display controller
-         drivers/media/platform/davinci/vpbe.c
-         drivers/media/platform/davinci/vpbe.h
+         drivers/media/platform/ti/davinci/vpbe.c
+         drivers/media/platform/ti/davinci/vpbe.h
 
  VPBE venc sub device driver
-         drivers/media/platform/davinci/vpbe_venc.c
-         drivers/media/platform/davinci/vpbe_venc.h
-         drivers/media/platform/davinci/vpbe_venc_regs.h
+         drivers/media/platform/ti/davinci/vpbe_venc.c
+         drivers/media/platform/ti/davinci/vpbe_venc.h
+         drivers/media/platform/ti/davinci/vpbe_venc_regs.h
 
  VPBE osd driver
-         drivers/media/platform/davinci/vpbe_osd.c
-         drivers/media/platform/davinci/vpbe_osd.h
-         drivers/media/platform/davinci/vpbe_osd_regs.h
+         drivers/media/platform/ti/davinci/vpbe_osd.c
+         drivers/media/platform/ti/davinci/vpbe_osd.h
+         drivers/media/platform/ti/davinci/vpbe_osd_regs.h
 
 To be done
 ----------
diff --git a/MAINTAINERS b/MAINTAINERS
index a8599cb4091e..801391246c87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19321,7 +19321,7 @@ S:	Maintained
 W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
-F:	drivers/media/platform/davinci/
+F:	drivers/media/platform/ti/davinci/
 F:	include/media/davinci/
 
 TI ENHANCED QUADRATURE ENCODER PULSE (eQEP) DRIVER
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index b3dde9c3cfc4..4d4d8e120731 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -72,7 +72,6 @@ source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/cadence/Kconfig"
 source "drivers/media/platform/chips-media/Kconfig"
-source "drivers/media/platform/davinci/Kconfig"
 source "drivers/media/platform/intel/Kconfig"
 source "drivers/media/platform/marvell/Kconfig"
 source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
@@ -97,6 +96,7 @@ source "drivers/media/platform/sti/Kconfig"
 source "drivers/media/platform/sti/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/ti/am437x/Kconfig"
+source "drivers/media/platform/ti/davinci/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index a34278911145..4e063935f061 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -12,7 +12,6 @@ obj-y += aspeed/
 obj-y += atmel/
 obj-y += cadence/
 obj-y += chips-media/
-obj-y += davinci/
 obj-y += intel/
 obj-y += marvell/
 obj-y += mediatek/mtk-jpeg/
@@ -42,6 +41,7 @@ obj-y += sti/hva/
 obj-y += sti/stm32/
 obj-y += ti-vpe/
 obj-y += ti/am437x/
+obj-y += ti/davinci/
 obj-y += via/
 obj-y += xilinx/
 
diff --git a/drivers/media/platform/davinci/Kconfig b/drivers/media/platform/ti/davinci/Kconfig
similarity index 100%
rename from drivers/media/platform/davinci/Kconfig
rename to drivers/media/platform/ti/davinci/Kconfig
diff --git a/drivers/media/platform/davinci/Makefile b/drivers/media/platform/ti/davinci/Makefile
similarity index 100%
rename from drivers/media/platform/davinci/Makefile
rename to drivers/media/platform/ti/davinci/Makefile
diff --git a/drivers/media/platform/davinci/ccdc_hw_device.h b/drivers/media/platform/ti/davinci/ccdc_hw_device.h
similarity index 100%
rename from drivers/media/platform/davinci/ccdc_hw_device.h
rename to drivers/media/platform/ti/davinci/ccdc_hw_device.h
diff --git a/drivers/media/platform/davinci/dm355_ccdc.c b/drivers/media/platform/ti/davinci/dm355_ccdc.c
similarity index 100%
rename from drivers/media/platform/davinci/dm355_ccdc.c
rename to drivers/media/platform/ti/davinci/dm355_ccdc.c
diff --git a/drivers/media/platform/davinci/dm355_ccdc_regs.h b/drivers/media/platform/ti/davinci/dm355_ccdc_regs.h
similarity index 100%
rename from drivers/media/platform/davinci/dm355_ccdc_regs.h
rename to drivers/media/platform/ti/davinci/dm355_ccdc_regs.h
diff --git a/drivers/media/platform/davinci/dm644x_ccdc.c b/drivers/media/platform/ti/davinci/dm644x_ccdc.c
similarity index 100%
rename from drivers/media/platform/davinci/dm644x_ccdc.c
rename to drivers/media/platform/ti/davinci/dm644x_ccdc.c
diff --git a/drivers/media/platform/davinci/dm644x_ccdc_regs.h b/drivers/media/platform/ti/davinci/dm644x_ccdc_regs.h
similarity index 100%
rename from drivers/media/platform/davinci/dm644x_ccdc_regs.h
rename to drivers/media/platform/ti/davinci/dm644x_ccdc_regs.h
diff --git a/drivers/media/platform/davinci/isif.c b/drivers/media/platform/ti/davinci/isif.c
similarity index 100%
rename from drivers/media/platform/davinci/isif.c
rename to drivers/media/platform/ti/davinci/isif.c
diff --git a/drivers/media/platform/davinci/isif_regs.h b/drivers/media/platform/ti/davinci/isif_regs.h
similarity index 100%
rename from drivers/media/platform/davinci/isif_regs.h
rename to drivers/media/platform/ti/davinci/isif_regs.h
diff --git a/drivers/media/platform/davinci/vpbe.c b/drivers/media/platform/ti/davinci/vpbe.c
similarity index 100%
rename from drivers/media/platform/davinci/vpbe.c
rename to drivers/media/platform/ti/davinci/vpbe.c
diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/ti/davinci/vpbe_display.c
similarity index 100%
rename from drivers/media/platform/davinci/vpbe_display.c
rename to drivers/media/platform/ti/davinci/vpbe_display.c
diff --git a/drivers/media/platform/davinci/vpbe_osd.c b/drivers/media/platform/ti/davinci/vpbe_osd.c
similarity index 100%
rename from drivers/media/platform/davinci/vpbe_osd.c
rename to drivers/media/platform/ti/davinci/vpbe_osd.c
diff --git a/drivers/media/platform/davinci/vpbe_osd_regs.h b/drivers/media/platform/ti/davinci/vpbe_osd_regs.h
similarity index 100%
rename from drivers/media/platform/davinci/vpbe_osd_regs.h
rename to drivers/media/platform/ti/davinci/vpbe_osd_regs.h
diff --git a/drivers/media/platform/davinci/vpbe_venc.c b/drivers/media/platform/ti/davinci/vpbe_venc.c
similarity index 100%
rename from drivers/media/platform/davinci/vpbe_venc.c
rename to drivers/media/platform/ti/davinci/vpbe_venc.c
diff --git a/drivers/media/platform/davinci/vpbe_venc_regs.h b/drivers/media/platform/ti/davinci/vpbe_venc_regs.h
similarity index 100%
rename from drivers/media/platform/davinci/vpbe_venc_regs.h
rename to drivers/media/platform/ti/davinci/vpbe_venc_regs.h
diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/ti/davinci/vpfe_capture.c
similarity index 100%
rename from drivers/media/platform/davinci/vpfe_capture.c
rename to drivers/media/platform/ti/davinci/vpfe_capture.c
diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/ti/davinci/vpif.c
similarity index 100%
rename from drivers/media/platform/davinci/vpif.c
rename to drivers/media/platform/ti/davinci/vpif.c
diff --git a/drivers/media/platform/davinci/vpif.h b/drivers/media/platform/ti/davinci/vpif.h
similarity index 100%
rename from drivers/media/platform/davinci/vpif.h
rename to drivers/media/platform/ti/davinci/vpif.h
diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
similarity index 100%
rename from drivers/media/platform/davinci/vpif_capture.c
rename to drivers/media/platform/ti/davinci/vpif_capture.c
diff --git a/drivers/media/platform/davinci/vpif_capture.h b/drivers/media/platform/ti/davinci/vpif_capture.h
similarity index 100%
rename from drivers/media/platform/davinci/vpif_capture.h
rename to drivers/media/platform/ti/davinci/vpif_capture.h
diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/ti/davinci/vpif_display.c
similarity index 100%
rename from drivers/media/platform/davinci/vpif_display.c
rename to drivers/media/platform/ti/davinci/vpif_display.c
diff --git a/drivers/media/platform/davinci/vpif_display.h b/drivers/media/platform/ti/davinci/vpif_display.h
similarity index 100%
rename from drivers/media/platform/davinci/vpif_display.h
rename to drivers/media/platform/ti/davinci/vpif_display.h
diff --git a/drivers/media/platform/davinci/vpss.c b/drivers/media/platform/ti/davinci/vpss.c
similarity index 100%
rename from drivers/media/platform/davinci/vpss.c
rename to drivers/media/platform/ti/davinci/vpss.c
-- 
2.35.1

