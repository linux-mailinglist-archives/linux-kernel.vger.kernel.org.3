Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7124D8A08
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiCNQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbiCNQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB9C33A12;
        Mon, 14 Mar 2022 09:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E326B6148E;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892A3C36B18;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=yjhk1WnfCME5lgkmc2YABafZxpEaIU+HTH1U4IJx+Lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIzPOt2jxXOulu7zBGPXid3dKdD78OWbTV5+TsvWTWxgm5U7XvU9e2dHHUwH0JJKh
         T6ccjBif1n35i02/L95Qy01iThO9zHdZ/kkDXyE9wu/qfuD8AA7E0Lg+0papa73eJi
         IQfU26pIh3DN0zLq8W8iA0QfvmNe/dpipdEmmGrSQH+hTjLn1z14Ypi97X3leNza7O
         Cz5zE6fChM7JRnyPKiWSqmYSdZjo/bmnaPAkAXh4c4wpzl4Bl1gAEWsjZD6MjLrcCe
         dhTFtdmQjW0XaPU6d5VMyot5CovtWJLkoGlzaIS70QYdGNjOuyvs/XzjpvRUEYbyXh
         lQpvUJSNJq6vQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf1-001x1V-Cw; Mon, 14 Mar 2022 17:35:07 +0100
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
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 58/67] media: platform: rename davinci/ to ti/davinci/
Date:   Mon, 14 Mar 2022 17:34:53 +0100
Message-Id: <23bb79b3e168d684c5a71cc23db2a01922da0491.1647274407.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647274406.git.mchehab@kernel.org>
References: <cover.1647274406.git.mchehab@kernel.org>
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

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

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
index f0b262176a70..4674c70f8859 100644
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
index 5d56058fa397..9b1bccf9a621 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -73,7 +73,6 @@ source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/cadence/Kconfig"
 source "drivers/media/platform/chips-media/Kconfig"
-source "drivers/media/platform/davinci/Kconfig"
 source "drivers/media/platform/intel/Kconfig"
 source "drivers/media/platform/marvell/Kconfig"
 source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
@@ -97,6 +96,7 @@ source "drivers/media/platform/stm/sti/Kconfig"
 source "drivers/media/platform/stm/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/ti/am437x/Kconfig"
+source "drivers/media/platform/ti/davinci/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index f8c4617da0ae..70c87bd6468b 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -13,7 +13,6 @@ obj-y += aspeed/
 obj-y += atmel/
 obj-y += cadence/
 obj-y += chips-media/
-obj-y += davinci/
 obj-y += intel/
 obj-y += marvell/
 obj-y += mediatek/mtk-jpeg/
@@ -42,6 +41,7 @@ obj-y += stm/sti/hva/
 obj-y += stm/stm32/
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

