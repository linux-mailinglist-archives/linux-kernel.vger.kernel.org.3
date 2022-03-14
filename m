Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814D44D89B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243956AbiCNQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbiCNQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B683F2FFED;
        Mon, 14 Mar 2022 09:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7E086147D;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22316C36B0C;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=rh8izbyUs0LVVLbnTQd1n2+7Cp3WpK+wYz//UpHm9ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eq/vqDcfxbg07/cyT/KlRTzilSvJW1efry+nrXLdt4JmU7aNvBTo5hU/H3qFKPSyE
         0jpnKeteT/zCnr4fnK+I8ehIb7CUdWGfoixG/W9Qb2DhzwP4DVA0LadletsXCbAIl2
         XvY9e/EyPVE2Pj/t5T2G0o0HkOt6KsAmyrpsm1lAzLQIPErvw0P/bxkbXHjTnJl/8V
         XteXN279HdjNWb0D7mLQ7m3z/EttmC7Fh79id3VUDVGoyZDiH/PvFh0Kt3W3KhGV9Q
         DiNHs5CevcqZzc04AdxGd/tyMYdhNpXVkzomzvFNCgIuZYRw4r1JhpSm8b84qWk2KS
         Rzd8vAEsVBuhg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf0-001wzI-SP; Mon, 14 Mar 2022 17:35:06 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Ming Qian <ming.qian@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 49/67] media: platform: rename exynos4-is/ to samsung/exynos4-is/
Date:   Mon, 14 Mar 2022 17:34:44 +0100
Message-Id: <e94d7863a951d040f0e200b96ae3bcc0b9ab0028.1647274407.git.mchehab@kernel.org>
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
rename exynos4-is/ to samsung/exynos4-is/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 Documentation/admin-guide/media/fimc.rst           |  2 +-
 .../driver-api/media/drivers/fimc-devel.rst        | 14 +++++++-------
 MAINTAINERS                                        |  2 +-
 drivers/media/platform/Kconfig                     |  2 +-
 drivers/media/platform/Makefile                    |  2 +-
 .../platform/{ => samsung}/exynos4-is/Kconfig      |  0
 .../platform/{ => samsung}/exynos4-is/Makefile     |  0
 .../platform/{ => samsung}/exynos4-is/common.c     |  0
 .../platform/{ => samsung}/exynos4-is/common.h     |  0
 .../{ => samsung}/exynos4-is/fimc-capture.c        |  0
 .../platform/{ => samsung}/exynos4-is/fimc-core.c  |  0
 .../platform/{ => samsung}/exynos4-is/fimc-core.h  |  0
 .../{ => samsung}/exynos4-is/fimc-is-command.h     |  0
 .../{ => samsung}/exynos4-is/fimc-is-errno.c       |  0
 .../{ => samsung}/exynos4-is/fimc-is-errno.h       |  0
 .../{ => samsung}/exynos4-is/fimc-is-i2c.c         |  0
 .../{ => samsung}/exynos4-is/fimc-is-i2c.h         |  0
 .../{ => samsung}/exynos4-is/fimc-is-param.c       |  0
 .../{ => samsung}/exynos4-is/fimc-is-param.h       |  0
 .../{ => samsung}/exynos4-is/fimc-is-regs.c        |  0
 .../{ => samsung}/exynos4-is/fimc-is-regs.h        |  0
 .../{ => samsung}/exynos4-is/fimc-is-sensor.c      |  0
 .../{ => samsung}/exynos4-is/fimc-is-sensor.h      |  0
 .../platform/{ => samsung}/exynos4-is/fimc-is.c    |  0
 .../platform/{ => samsung}/exynos4-is/fimc-is.h    |  0
 .../{ => samsung}/exynos4-is/fimc-isp-video.c      |  0
 .../{ => samsung}/exynos4-is/fimc-isp-video.h      |  0
 .../platform/{ => samsung}/exynos4-is/fimc-isp.c   |  0
 .../platform/{ => samsung}/exynos4-is/fimc-isp.h   |  0
 .../{ => samsung}/exynos4-is/fimc-lite-reg.c       |  0
 .../{ => samsung}/exynos4-is/fimc-lite-reg.h       |  0
 .../platform/{ => samsung}/exynos4-is/fimc-lite.c  |  0
 .../platform/{ => samsung}/exynos4-is/fimc-lite.h  |  0
 .../platform/{ => samsung}/exynos4-is/fimc-m2m.c   |  0
 .../platform/{ => samsung}/exynos4-is/fimc-reg.c   |  0
 .../platform/{ => samsung}/exynos4-is/fimc-reg.h   |  0
 .../platform/{ => samsung}/exynos4-is/media-dev.c  |  0
 .../platform/{ => samsung}/exynos4-is/media-dev.h  |  0
 .../platform/{ => samsung}/exynos4-is/mipi-csis.c  |  0
 .../platform/{ => samsung}/exynos4-is/mipi-csis.h  |  0
 40 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/media/platform/{ => samsung}/exynos4-is/Kconfig (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/Makefile (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/common.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/common.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-capture.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-core.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-core.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-command.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-errno.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-errno.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-i2c.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-i2c.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-param.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-param.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-regs.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-regs.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-sensor.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is-sensor.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-is.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-isp-video.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-isp-video.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-isp.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-isp.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-lite-reg.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-lite-reg.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-lite.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-lite.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-m2m.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-reg.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/fimc-reg.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/media-dev.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/media-dev.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/mipi-csis.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos4-is/mipi-csis.h (100%)

diff --git a/Documentation/admin-guide/media/fimc.rst b/Documentation/admin-guide/media/fimc.rst
index 56b149d9a527..267ef52fe387 100644
--- a/Documentation/admin-guide/media/fimc.rst
+++ b/Documentation/admin-guide/media/fimc.rst
@@ -14,7 +14,7 @@ data from LCD controller (FIMD) through the SoC internal writeback data
 path.  There are multiple FIMC instances in the SoCs (up to 4), having
 slightly different capabilities, like pixel alignment constraints, rotator
 availability, LCD writeback support, etc. The driver is located at
-drivers/media/platform/exynos4-is directory.
+drivers/media/platform/samsung/exynos4-is directory.
 
 Supported SoCs
 --------------
diff --git a/Documentation/driver-api/media/drivers/fimc-devel.rst b/Documentation/driver-api/media/drivers/fimc-devel.rst
index 956e3a9901f8..4c6b7c8be19f 100644
--- a/Documentation/driver-api/media/drivers/fimc-devel.rst
+++ b/Documentation/driver-api/media/drivers/fimc-devel.rst
@@ -12,22 +12,22 @@ Files partitioning
 
 - media device driver
 
-  drivers/media/platform/exynos4-is/media-dev.[ch]
+  drivers/media/platform/samsung/exynos4-is/media-dev.[ch]
 
 - camera capture video device driver
 
-  drivers/media/platform/exynos4-is/fimc-capture.c
+  drivers/media/platform/samsung/exynos4-is/fimc-capture.c
 
 - MIPI-CSI2 receiver subdev
 
-  drivers/media/platform/exynos4-is/mipi-csis.[ch]
+  drivers/media/platform/samsung/exynos4-is/mipi-csis.[ch]
 
 - video post-processor (mem-to-mem)
 
-  drivers/media/platform/exynos4-is/fimc-core.c
+  drivers/media/platform/samsung/exynos4-is/fimc-core.c
 
 - common files
 
-  drivers/media/platform/exynos4-is/fimc-core.h
-  drivers/media/platform/exynos4-is/fimc-reg.h
-  drivers/media/platform/exynos4-is/regs-fimc.h
+  drivers/media/platform/samsung/exynos4-is/fimc-core.h
+  drivers/media/platform/samsung/exynos4-is/fimc-reg.h
+  drivers/media/platform/samsung/exynos4-is/regs-fimc.h
diff --git a/MAINTAINERS b/MAINTAINERS
index c9333d46047e..13dd4693b898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17103,7 +17103,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.linuxtv.org/project/linux-media/list/
-F:	drivers/media/platform/exynos4-is/
+F:	drivers/media/platform/samsung/exynos4-is/
 
 SAMSUNG SOC CLOCK DRIVERS
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 13d8f3e59116..3d0f431c167d 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -76,7 +76,6 @@ source "drivers/media/platform/cadence/Kconfig"
 source "drivers/media/platform/chips-media/Kconfig"
 source "drivers/media/platform/davinci/Kconfig"
 source "drivers/media/platform/exynos-gsc/Kconfig"
-source "drivers/media/platform/exynos4-is/Kconfig"
 source "drivers/media/platform/intel/Kconfig"
 source "drivers/media/platform/marvell/Kconfig"
 source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
@@ -94,6 +93,7 @@ source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
 source "drivers/media/platform/s5p-jpeg/Kconfig"
 source "drivers/media/platform/s5p-mfc/Kconfig"
+source "drivers/media/platform/samsung/exynos4-is/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index ce9909534218..6ef541bdb225 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -16,7 +16,6 @@ obj-y += cadence/
 obj-y += chips-media/
 obj-y += davinci/
 obj-y += exynos-gsc/
-obj-y += exynos4-is/
 obj-y += intel/
 obj-y += marvell/
 obj-y += mediatek/mtk-jpeg/
@@ -36,6 +35,7 @@ obj-y += s3c-camif/
 obj-y += s5p-g2d/
 obj-y += s5p-jpeg/
 obj-y += s5p-mfc/
+obj-y += samsung/exynos4-is/
 obj-y += sti/bdisp/
 obj-y += sti/c8sectpfe/
 obj-y += sti/delta/
diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/samsung/exynos4-is/Kconfig
similarity index 100%
rename from drivers/media/platform/exynos4-is/Kconfig
rename to drivers/media/platform/samsung/exynos4-is/Kconfig
diff --git a/drivers/media/platform/exynos4-is/Makefile b/drivers/media/platform/samsung/exynos4-is/Makefile
similarity index 100%
rename from drivers/media/platform/exynos4-is/Makefile
rename to drivers/media/platform/samsung/exynos4-is/Makefile
diff --git a/drivers/media/platform/exynos4-is/common.c b/drivers/media/platform/samsung/exynos4-is/common.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/common.c
rename to drivers/media/platform/samsung/exynos4-is/common.c
diff --git a/drivers/media/platform/exynos4-is/common.h b/drivers/media/platform/samsung/exynos4-is/common.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/common.h
rename to drivers/media/platform/samsung/exynos4-is/common.h
diff --git a/drivers/media/platform/exynos4-is/fimc-capture.c b/drivers/media/platform/samsung/exynos4-is/fimc-capture.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-capture.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-capture.c
diff --git a/drivers/media/platform/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-core.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-core.c
diff --git a/drivers/media/platform/exynos4-is/fimc-core.h b/drivers/media/platform/samsung/exynos4-is/fimc-core.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-core.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-core.h
diff --git a/drivers/media/platform/exynos4-is/fimc-is-command.h b/drivers/media/platform/samsung/exynos4-is/fimc-is-command.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-command.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-command.h
diff --git a/drivers/media/platform/exynos4-is/fimc-is-errno.c b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-errno.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c
diff --git a/drivers/media/platform/exynos4-is/fimc-is-errno.h b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-errno.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
diff --git a/drivers/media/platform/exynos4-is/fimc-is-i2c.c b/drivers/media/platform/samsung/exynos4-is/fimc-is-i2c.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-i2c.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-i2c.c
diff --git a/drivers/media/platform/exynos4-is/fimc-is-i2c.h b/drivers/media/platform/samsung/exynos4-is/fimc-is-i2c.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-i2c.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-i2c.h
diff --git a/drivers/media/platform/exynos4-is/fimc-is-param.c b/drivers/media/platform/samsung/exynos4-is/fimc-is-param.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-param.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-param.c
diff --git a/drivers/media/platform/exynos4-is/fimc-is-param.h b/drivers/media/platform/samsung/exynos4-is/fimc-is-param.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-param.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-param.h
diff --git a/drivers/media/platform/exynos4-is/fimc-is-regs.c b/drivers/media/platform/samsung/exynos4-is/fimc-is-regs.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-regs.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-regs.c
diff --git a/drivers/media/platform/exynos4-is/fimc-is-regs.h b/drivers/media/platform/samsung/exynos4-is/fimc-is-regs.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-regs.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-regs.h
diff --git a/drivers/media/platform/exynos4-is/fimc-is-sensor.c b/drivers/media/platform/samsung/exynos4-is/fimc-is-sensor.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-sensor.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-sensor.c
diff --git a/drivers/media/platform/exynos4-is/fimc-is-sensor.h b/drivers/media/platform/samsung/exynos4-is/fimc-is-sensor.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is-sensor.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-is-sensor.h
diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/samsung/exynos4-is/fimc-is.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-is.c
diff --git a/drivers/media/platform/exynos4-is/fimc-is.h b/drivers/media/platform/samsung/exynos4-is/fimc-is.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-is.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-is.h
diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.c b/drivers/media/platform/samsung/exynos4-is/fimc-isp-video.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-isp-video.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-isp-video.c
diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.h b/drivers/media/platform/samsung/exynos4-is/fimc-isp-video.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-isp-video.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-isp-video.h
diff --git a/drivers/media/platform/exynos4-is/fimc-isp.c b/drivers/media/platform/samsung/exynos4-is/fimc-isp.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-isp.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-isp.c
diff --git a/drivers/media/platform/exynos4-is/fimc-isp.h b/drivers/media/platform/samsung/exynos4-is/fimc-isp.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-isp.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-isp.h
diff --git a/drivers/media/platform/exynos4-is/fimc-lite-reg.c b/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-lite-reg.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.c
diff --git a/drivers/media/platform/exynos4-is/fimc-lite-reg.h b/drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-lite-reg.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-lite-reg.h
diff --git a/drivers/media/platform/exynos4-is/fimc-lite.c b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-lite.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-lite.c
diff --git a/drivers/media/platform/exynos4-is/fimc-lite.h b/drivers/media/platform/samsung/exynos4-is/fimc-lite.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-lite.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-lite.h
diff --git a/drivers/media/platform/exynos4-is/fimc-m2m.c b/drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-m2m.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-m2m.c
diff --git a/drivers/media/platform/exynos4-is/fimc-reg.c b/drivers/media/platform/samsung/exynos4-is/fimc-reg.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-reg.c
rename to drivers/media/platform/samsung/exynos4-is/fimc-reg.c
diff --git a/drivers/media/platform/exynos4-is/fimc-reg.h b/drivers/media/platform/samsung/exynos4-is/fimc-reg.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/fimc-reg.h
rename to drivers/media/platform/samsung/exynos4-is/fimc-reg.h
diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/media-dev.c
rename to drivers/media/platform/samsung/exynos4-is/media-dev.c
diff --git a/drivers/media/platform/exynos4-is/media-dev.h b/drivers/media/platform/samsung/exynos4-is/media-dev.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/media-dev.h
rename to drivers/media/platform/samsung/exynos4-is/media-dev.h
diff --git a/drivers/media/platform/exynos4-is/mipi-csis.c b/drivers/media/platform/samsung/exynos4-is/mipi-csis.c
similarity index 100%
rename from drivers/media/platform/exynos4-is/mipi-csis.c
rename to drivers/media/platform/samsung/exynos4-is/mipi-csis.c
diff --git a/drivers/media/platform/exynos4-is/mipi-csis.h b/drivers/media/platform/samsung/exynos4-is/mipi-csis.h
similarity index 100%
rename from drivers/media/platform/exynos4-is/mipi-csis.h
rename to drivers/media/platform/samsung/exynos4-is/mipi-csis.h
-- 
2.35.1

