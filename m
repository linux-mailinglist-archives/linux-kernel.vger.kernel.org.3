Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E24D7CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiCNIAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiCNH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD754163E;
        Mon, 14 Mar 2022 00:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDC94611E4;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C32EC341E6;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244563;
        bh=f0gLLvVNLq+QdnIAJ7MjXom3256f3cZ5lDOYgZlUuog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXDIn4JYtgKVAK0wu3HY06PJovgNXt65MRLLxOe+9MkNtugC/XM5bKAkcalzlGt4n
         x2W1dgUkVFw1wIuqiR8+bKy+xkIIvEXRpsUMcz5dTB/fAkQSWl/SjylVBHYnPZFfao
         gadeuuddQ1YofZCpg/ZPZcktApgHGYJSXC7zKhTmWUXMPeAFVq7QPI7qLmrMLqYSBl
         VThh2ijcUpevKWjMPoQM1etAN87jqnEkFw51Ye0OqYva30qkSnz7ADYDw40CPyuNO9
         nYC6CirQEzo9jscV3HEihZgUxKTqAIrJLkknBf2qmRD6dTbCZ3xJvP9bEWSphzwNCK
         JfyvJyQ5NS28A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYe-001kXX-Go; Mon, 14 Mar 2022 08:56:00 +0100
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
Subject: [PATCH 52/64] media: platform: rename s3c-camif/ to samsung/s3c-camif/
Date:   Mon, 14 Mar 2022 08:55:44 +0100
Message-Id: <3f964b49f49400603f871b73e25762e63142b732.1647242579.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647242578.git.mchehab@kernel.org>
References: <cover.1647242578.git.mchehab@kernel.org>
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
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

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
index b1418853d56f..8ce4894699cc 100644
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
index dca53f6a1b33..b371c0b258d1 100644
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
index 848cbd6147ae..c3dfe40b2def 100644
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

