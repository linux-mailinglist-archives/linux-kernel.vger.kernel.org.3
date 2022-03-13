Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6702E4D74A5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiCMKzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiCMKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9B2559C;
        Sun, 13 Mar 2022 03:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F79D61011;
        Sun, 13 Mar 2022 10:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB75C3410A;
        Sun, 13 Mar 2022 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647168729;
        bh=Ea4tHUcZzHsvC8jPMtrVZPIkBJInNtKqb5Sb0WE9bIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSB3ZxefIF271ut1IN6g5rfalil4XIjf84z14M+L3+E6OZPXPl4t5w8D0zdxhp9S5
         sr3j4BWvtUeE2oBl3gfszEHbvjlY8ANbpZ8dJZoN9aPS+qB2o2k+Ete/rFM+Zh4fPn
         7ImG4H20lRVq9xQZX/1yZIU+nEIj4hGm0AUyuymCVOjarBBkG30FkZ1qPYEsBRZbog
         /NKtKBa6M1cJmF0Og7vvmobrkz5sn5sKIPhOMcjtvE2rNtw9oMriP7/eJGFaNdvzAR
         pjbKsPveGaf7ULAGmtp8HK1kcgtizGotAJet5tss5buAtXbMHqKAQaA2cKbc5PVdVt
         3vvtkaa8JI99Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTLpX-001I28-CU; Sun, 13 Mar 2022 11:52:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 14/24] media: platform: rename s5p-g2d/ to samsung/s5p-g2d/
Date:   Sun, 13 Mar 2022 11:51:55 +0100
Message-Id: <64b2de2b91994d66a405d08d43feb96d876098df.1647167750.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647167750.git.mchehab@kernel.org>
References: <cover.1647167750.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
rename s5p-g2d/ to samsung/s5p-g2d/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/

 MAINTAINERS                                             | 2 +-
 drivers/media/platform/Kconfig                          | 2 +-
 drivers/media/platform/Makefile                         | 2 +-
 drivers/media/platform/{ => samsung}/s5p-g2d/Kconfig    | 0
 drivers/media/platform/{ => samsung}/s5p-g2d/Makefile   | 0
 drivers/media/platform/{ => samsung}/s5p-g2d/g2d-hw.c   | 0
 drivers/media/platform/{ => samsung}/s5p-g2d/g2d-regs.h | 0
 drivers/media/platform/{ => samsung}/s5p-g2d/g2d.c      | 0
 drivers/media/platform/{ => samsung}/s5p-g2d/g2d.h      | 0
 9 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{ => samsung}/s5p-g2d/Kconfig (100%)
 rename drivers/media/platform/{ => samsung}/s5p-g2d/Makefile (100%)
 rename drivers/media/platform/{ => samsung}/s5p-g2d/g2d-hw.c (100%)
 rename drivers/media/platform/{ => samsung}/s5p-g2d/g2d-regs.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-g2d/g2d.c (100%)
 rename drivers/media/platform/{ => samsung}/s5p-g2d/g2d.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ce4894699cc..4c4be0d7ec14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2616,7 +2616,7 @@ M:	Łukasz Stelmach <l.stelmach@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	drivers/media/platform/s5p-g2d/
+F:	drivers/media/platform/samsung/s5p-g2d/
 
 ARM/SAMSUNG S5P SERIES HDMI CEC SUBSYSTEM SUPPORT
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 0a87d835b2f5..f70fc95e4195 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -88,12 +88,12 @@ source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
 source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/Kconfig"
-source "drivers/media/platform/s5p-g2d/Kconfig"
 source "drivers/media/platform/s5p-jpeg/Kconfig"
 source "drivers/media/platform/s5p-mfc/Kconfig"
 source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
 source "drivers/media/platform/samsung/exynos4-is/Kconfig"
 source "drivers/media/platform/samsung/s3c-camif/Kconfig"
+source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index c3dfe40b2def..a5a068e18492 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -30,12 +30,12 @@ obj-y += qcom/venus/
 obj-y += renesas/
 obj-y += rockchip/rga/
 obj-y += rockchip/rkisp1/
-obj-y += s5p-g2d/
 obj-y += s5p-jpeg/
 obj-y += s5p-mfc/
 obj-y += samsung/exynos-gsc/
 obj-y += samsung/exynos4-is/
 obj-y += samsung/s3c-camif/
+obj-y += samsung/s5p-g2d/
 obj-y += sti/bdisp/
 obj-y += sti/c8sectpfe/
 obj-y += sti/delta/
diff --git a/drivers/media/platform/s5p-g2d/Kconfig b/drivers/media/platform/samsung/s5p-g2d/Kconfig
similarity index 100%
rename from drivers/media/platform/s5p-g2d/Kconfig
rename to drivers/media/platform/samsung/s5p-g2d/Kconfig
diff --git a/drivers/media/platform/s5p-g2d/Makefile b/drivers/media/platform/samsung/s5p-g2d/Makefile
similarity index 100%
rename from drivers/media/platform/s5p-g2d/Makefile
rename to drivers/media/platform/samsung/s5p-g2d/Makefile
diff --git a/drivers/media/platform/s5p-g2d/g2d-hw.c b/drivers/media/platform/samsung/s5p-g2d/g2d-hw.c
similarity index 100%
rename from drivers/media/platform/s5p-g2d/g2d-hw.c
rename to drivers/media/platform/samsung/s5p-g2d/g2d-hw.c
diff --git a/drivers/media/platform/s5p-g2d/g2d-regs.h b/drivers/media/platform/samsung/s5p-g2d/g2d-regs.h
similarity index 100%
rename from drivers/media/platform/s5p-g2d/g2d-regs.h
rename to drivers/media/platform/samsung/s5p-g2d/g2d-regs.h
diff --git a/drivers/media/platform/s5p-g2d/g2d.c b/drivers/media/platform/samsung/s5p-g2d/g2d.c
similarity index 100%
rename from drivers/media/platform/s5p-g2d/g2d.c
rename to drivers/media/platform/samsung/s5p-g2d/g2d.c
diff --git a/drivers/media/platform/s5p-g2d/g2d.h b/drivers/media/platform/samsung/s5p-g2d/g2d.h
similarity index 100%
rename from drivers/media/platform/s5p-g2d/g2d.h
rename to drivers/media/platform/samsung/s5p-g2d/g2d.h
-- 
2.35.1

