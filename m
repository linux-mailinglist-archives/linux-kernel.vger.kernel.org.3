Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F1C4D74B4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiCMKyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiCMKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CA12D925;
        Sun, 13 Mar 2022 03:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57CDA6100F;
        Sun, 13 Mar 2022 10:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80889C34105;
        Sun, 13 Mar 2022 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647168729;
        bh=H6riGIBHtNh9i24lR1ghBv7IWPMVqrM/Sm5wev2DUhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVtAdKkqtZ5ZA+NofFZGNPilI5nhFHIelynGP6u9aLDHjlnnZI8mhfuvhe8RcyeFC
         KcB7E119SVcPvrk4Zja01XLAEa5gesea29Ew1WRq/Wey6Ca4f3uQEv/dY+CHYsROzs
         BwVCM1dEzzCv3Z3PQKmIS+PHtVup2fnL5YjStCNasCHMbChQ5SB8Ox7hHgU8nLCjlV
         CRl0rM8ylwr/PXDaBNJ4EiSrZBeTrMFi/KUuRGIKu2j6V+6sh1j1w+198r8MX3pH6K
         Pzd+Gp7tRLWlPF6UiFJE3MOKeIhR73JubY+rz/5hGv80/844Nk2PPYb+GwapuffzUf
         6tZVVEXk0Ky/Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTLpX-001I20-94; Sun, 13 Mar 2022 11:52:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 12/24] media: platform: rename exynos-gsc/ to samsung/exynos-gsc/
Date:   Sun, 13 Mar 2022 11:51:53 +0100
Message-Id: <d070ff68a414fb51eb6dc1b3c77d275912f1c5d1.1647167750.git.mchehab@kernel.org>
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
rename exynos-gsc/ to samsung/exynos-gsc/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                             | 2 +-
 drivers/media/platform/Makefile                            | 2 +-
 drivers/media/platform/{ => samsung}/exynos-gsc/Kconfig    | 0
 drivers/media/platform/{ => samsung}/exynos-gsc/Makefile   | 0
 drivers/media/platform/{ => samsung}/exynos-gsc/gsc-core.c | 0
 drivers/media/platform/{ => samsung}/exynos-gsc/gsc-core.h | 0
 drivers/media/platform/{ => samsung}/exynos-gsc/gsc-m2m.c  | 0
 drivers/media/platform/{ => samsung}/exynos-gsc/gsc-regs.c | 0
 drivers/media/platform/{ => samsung}/exynos-gsc/gsc-regs.h | 0
 9 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/media/platform/{ => samsung}/exynos-gsc/Kconfig (100%)
 rename drivers/media/platform/{ => samsung}/exynos-gsc/Makefile (100%)
 rename drivers/media/platform/{ => samsung}/exynos-gsc/gsc-core.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos-gsc/gsc-core.h (100%)
 rename drivers/media/platform/{ => samsung}/exynos-gsc/gsc-m2m.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos-gsc/gsc-regs.c (100%)
 rename drivers/media/platform/{ => samsung}/exynos-gsc/gsc-regs.h (100%)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 1bbada840723..81888d348149 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -74,7 +74,6 @@ source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/cadence/Kconfig"
 source "drivers/media/platform/chips-media/Kconfig"
 source "drivers/media/platform/davinci/Kconfig"
-source "drivers/media/platform/exynos-gsc/Kconfig"
 source "drivers/media/platform/intel/Kconfig"
 source "drivers/media/platform/marvell/Kconfig"
 source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
@@ -93,6 +92,7 @@ source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
 source "drivers/media/platform/s5p-jpeg/Kconfig"
 source "drivers/media/platform/s5p-mfc/Kconfig"
+source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
 source "drivers/media/platform/samsung/exynos4-is/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 613ca6a3efa7..848cbd6147ae 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -14,7 +14,6 @@ obj-y += atmel/
 obj-y += cadence/
 obj-y += chips-media/
 obj-y += davinci/
-obj-y += exynos-gsc/
 obj-y += intel/
 obj-y += marvell/
 obj-y += mediatek/mtk-jpeg/
@@ -35,6 +34,7 @@ obj-y += s3c-camif/
 obj-y += s5p-g2d/
 obj-y += s5p-jpeg/
 obj-y += s5p-mfc/
+obj-y += samsung/exynos-gsc/
 obj-y += samsung/exynos4-is/
 obj-y += sti/bdisp/
 obj-y += sti/c8sectpfe/
diff --git a/drivers/media/platform/exynos-gsc/Kconfig b/drivers/media/platform/samsung/exynos-gsc/Kconfig
similarity index 100%
rename from drivers/media/platform/exynos-gsc/Kconfig
rename to drivers/media/platform/samsung/exynos-gsc/Kconfig
diff --git a/drivers/media/platform/exynos-gsc/Makefile b/drivers/media/platform/samsung/exynos-gsc/Makefile
similarity index 100%
rename from drivers/media/platform/exynos-gsc/Makefile
rename to drivers/media/platform/samsung/exynos-gsc/Makefile
diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/samsung/exynos-gsc/gsc-core.c
similarity index 100%
rename from drivers/media/platform/exynos-gsc/gsc-core.c
rename to drivers/media/platform/samsung/exynos-gsc/gsc-core.c
diff --git a/drivers/media/platform/exynos-gsc/gsc-core.h b/drivers/media/platform/samsung/exynos-gsc/gsc-core.h
similarity index 100%
rename from drivers/media/platform/exynos-gsc/gsc-core.h
rename to drivers/media/platform/samsung/exynos-gsc/gsc-core.h
diff --git a/drivers/media/platform/exynos-gsc/gsc-m2m.c b/drivers/media/platform/samsung/exynos-gsc/gsc-m2m.c
similarity index 100%
rename from drivers/media/platform/exynos-gsc/gsc-m2m.c
rename to drivers/media/platform/samsung/exynos-gsc/gsc-m2m.c
diff --git a/drivers/media/platform/exynos-gsc/gsc-regs.c b/drivers/media/platform/samsung/exynos-gsc/gsc-regs.c
similarity index 100%
rename from drivers/media/platform/exynos-gsc/gsc-regs.c
rename to drivers/media/platform/samsung/exynos-gsc/gsc-regs.c
diff --git a/drivers/media/platform/exynos-gsc/gsc-regs.h b/drivers/media/platform/samsung/exynos-gsc/gsc-regs.h
similarity index 100%
rename from drivers/media/platform/exynos-gsc/gsc-regs.h
rename to drivers/media/platform/samsung/exynos-gsc/gsc-regs.h
-- 
2.35.1

