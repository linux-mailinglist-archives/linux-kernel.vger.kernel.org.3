Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929714D8A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbiCNQjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiCNQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A207812A94;
        Mon, 14 Mar 2022 09:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5660D61470;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285C1C36AE9;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=ODM/IkOmYAwq/vkJYjmzsxKa6YSUrDrJltVkrB28qH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAGc/dOuX0o3nwAyOg4joq04zCz5oNnsegYUQA2GWN7TFE3jvfC7MQ7jMgq5g/in7
         Tfs8i/oO9jDqNr2Z3/oFh1tNmfls9xRcztfKW27G5kyUyduHSFu7Vl23iKK3mUzt/l
         SoqxGHWSWgmiw9cMSq+c+FCAdU/K2O8ojOBjZfLe7/oS3u3iHRmuWhjrcpUWFhKv+b
         su7DBAez8msFdkz1igNA7AooIj8ouCJZ/ATGDnjoLGu9gdMljJU2D+09IB2uy6/prF
         fiWR3eBfC3/KoRu88qZDXf9vhsvBX+nQQ3svkcvAzE+ay6ZIRcm67bDhaHa6FiQQ1I
         LxRGOJ5tuI5aw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf0-001wzQ-VX; Mon, 14 Mar 2022 17:35:06 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 51/67] media: platform: rename s3c-camif/ to samsung/s3c-camif/
Date:   Mon, 14 Mar 2022 17:34:46 +0100
Message-Id: <41b562b77ab3d3210c6cf41104971fd19de7f3ff.1647274407.git.mchehab@kernel.org>
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
rename s3c-camif/ to samsung/s3c-camif/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 MAINTAINERS                                                    | 2 +-
 drivers/media/platform/Kconfig                                 | 2 +-
 drivers/media/platform/Makefile                                | 2 +-
 drivers/media/platform/{ => samsung}/s3c-camif/Kconfig         | 0
 drivers/media/platform/{ => samsung}/s3c-camif/Makefile        | 0
 drivers/media/platform/{ => samsung}/s3c-camif/camif-capture.c | 0
 drivers/media/platform/{ => samsung}/s3c-camif/camif-core.c    | 0
 drivers/media/platform/{ => samsung}/s3c-camif/camif-core.h    | 0
 drivers/media/platform/{ => samsung}/s3c-camif/camif-regs.c    | 0
 drivers/media/platform/{ => samsung}/s3c-camif/camif-regs.h    | 0
 10 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{ => samsung}/s3c-camif/Kconfig (100%)
 rename drivers/media/platform/{ => samsung}/s3c-camif/Makefile (100%)
 rename drivers/media/platform/{ => samsung}/s3c-camif/camif-capture.c (100%)
 rename drivers/media/platform/{ => samsung}/s3c-camif/camif-core.c (100%)
 rename drivers/media/platform/{ => samsung}/s3c-camif/camif-core.h (100%)
 rename drivers/media/platform/{ => samsung}/s3c-camif/camif-regs.c (100%)
 rename drivers/media/platform/{ => samsung}/s3c-camif/camif-regs.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 13dd4693b898..80f2a0eea3f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17063,7 +17063,7 @@ M:	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
 L:	linux-media@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-F:	drivers/media/platform/s3c-camif/
+F:	drivers/media/platform/samsung/s3c-camif/
 F:	include/media/drv-intf/s3c_camif.h
 
 SAMSUNG S3FWRN5 NFC DRIVER
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 0a05ef7304c0..aed4394ddd05 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -88,12 +88,12 @@ source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
 source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/Kconfig"
-source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
 source "drivers/media/platform/s5p-jpeg/Kconfig"
 source "drivers/media/platform/s5p-mfc/Kconfig"
 source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
 source "drivers/media/platform/samsung/exynos4-is/Kconfig"
+source "drivers/media/platform/samsung/s3c-camif/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 996ec99be08f..cb5e6d1df248 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -30,12 +30,12 @@ obj-y += qcom/venus/
 obj-y += renesas/
 obj-y += rockchip/rga/
 obj-y += rockchip/rkisp1/
-obj-y += s3c-camif/
 obj-y += s5p-g2d/
 obj-y += s5p-jpeg/
 obj-y += s5p-mfc/
 obj-y += samsung/exynos-gsc/
 obj-y += samsung/exynos4-is/
+obj-y += samsung/s3c-camif/
 obj-y += sti/bdisp/
 obj-y += sti/c8sectpfe/
 obj-y += sti/delta/
diff --git a/drivers/media/platform/s3c-camif/Kconfig b/drivers/media/platform/samsung/s3c-camif/Kconfig
similarity index 100%
rename from drivers/media/platform/s3c-camif/Kconfig
rename to drivers/media/platform/samsung/s3c-camif/Kconfig
diff --git a/drivers/media/platform/s3c-camif/Makefile b/drivers/media/platform/samsung/s3c-camif/Makefile
similarity index 100%
rename from drivers/media/platform/s3c-camif/Makefile
rename to drivers/media/platform/samsung/s3c-camif/Makefile
diff --git a/drivers/media/platform/s3c-camif/camif-capture.c b/drivers/media/platform/samsung/s3c-camif/camif-capture.c
similarity index 100%
rename from drivers/media/platform/s3c-camif/camif-capture.c
rename to drivers/media/platform/samsung/s3c-camif/camif-capture.c
diff --git a/drivers/media/platform/s3c-camif/camif-core.c b/drivers/media/platform/samsung/s3c-camif/camif-core.c
similarity index 100%
rename from drivers/media/platform/s3c-camif/camif-core.c
rename to drivers/media/platform/samsung/s3c-camif/camif-core.c
diff --git a/drivers/media/platform/s3c-camif/camif-core.h b/drivers/media/platform/samsung/s3c-camif/camif-core.h
similarity index 100%
rename from drivers/media/platform/s3c-camif/camif-core.h
rename to drivers/media/platform/samsung/s3c-camif/camif-core.h
diff --git a/drivers/media/platform/s3c-camif/camif-regs.c b/drivers/media/platform/samsung/s3c-camif/camif-regs.c
similarity index 100%
rename from drivers/media/platform/s3c-camif/camif-regs.c
rename to drivers/media/platform/samsung/s3c-camif/camif-regs.c
diff --git a/drivers/media/platform/s3c-camif/camif-regs.h b/drivers/media/platform/samsung/s3c-camif/camif-regs.h
similarity index 100%
rename from drivers/media/platform/s3c-camif/camif-regs.h
rename to drivers/media/platform/samsung/s3c-camif/camif-regs.h
-- 
2.35.1

