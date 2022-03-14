Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF334D89D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244434AbiCNQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243258AbiCNQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDFC2E69C;
        Mon, 14 Mar 2022 09:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4017B6146C;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12876C36B08;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=0ZSwqbQK4ePZKheqhZHLog2xX0lLdzzxaB/EnIUMw8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSZU1eKGqVgpP/e5GdCSqDXAhb9zMBVMT9PFR6F83MaAfQhCtTkyzRUAsztBECsHd
         DnRgrXdX9mBlbuNPBbZ42gHSehJVFkmk9jJTTyd4hf2fmEZmbzJzrnpxZx2dJyqN0d
         x/KltiOClRzMWq/q46vYgtDxOUC/REJ/IQ2IZ+jRWvrGoLEIfroaESEeiePPpQfsGF
         mhmd/ZMMOXA/r88DRywT+8dvVGXj6cHb0Se9/xkYtRm6iMJ2Q971xuE0g/3AXgRbYD
         +MaV75QRt9GS0jj2OEGQn9gdYD8X7Ew9CZFKF5+sfNGpGR9KuJQ+hF5YMp7SWIu+uc
         HZ13btulBHDiA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf0-001wzM-UG; Mon, 14 Mar 2022 17:35:06 +0100
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
Subject: [PATCH v2 50/67] media: platform: rename exynos-gsc/ to samsung/exynos-gsc/
Date:   Mon, 14 Mar 2022 17:34:45 +0100
Message-Id: <602ebbef489f54515b2f25d4fb58c5fb00c78f5e.1647274407.git.mchehab@kernel.org>
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
rename exynos-gsc/ to samsung/exynos-gsc/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

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
index 3d0f431c167d..0a05ef7304c0 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -75,7 +75,6 @@ source "drivers/media/platform/atmel/Kconfig"
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
index 6ef541bdb225..996ec99be08f 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -15,7 +15,6 @@ obj-y += atmel/
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

