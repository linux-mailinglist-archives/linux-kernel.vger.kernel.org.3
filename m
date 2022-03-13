Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB944D749A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiCMKzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiCMKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:54:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554E539179;
        Sun, 13 Mar 2022 03:52:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C937BB80CAB;
        Sun, 13 Mar 2022 10:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8ACC340FC;
        Sun, 13 Mar 2022 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647168729;
        bh=+XUrxUNJJc78O+G+Ztb+zSl+5Iq7rWoIkMhUhvOheWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IG+X9wJ1YQpuJ79qHtaVUuZ9k1cWgA9Wts6EoW3UWDux4fElQnuv8sKbU14YuK1GF
         +7tjg3rOVRRUOL8EnEjnGZQ3K4XaRAY6gquOqf38M1Uh+tfb02Bzo3uk8GCd841ziJ
         7m+U+2fjAlX4wGc1vXBNrhSeJdJhTc4qrjK9C+JgDYsB2bHztmCiQ7AooqFtI8wNuC
         yXxgYNwmlPZJM9A5cCQ6NAyWusoFXMB617ie3O+eOS31X8c3Mi3k6Un4FhGRK9orQC
         rCN3UFOL04S0mnfDKB2n7ahehABI471RPQrJ9M9ikQKym0WsK+zqGzvoxj9yZh3j5x
         TcgdOEQfIJ4pQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTLpX-001I1g-1I; Sun, 13 Mar 2022 11:52:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ding Senjie <dingsenjie@yulong.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 07/24] media: platform: rename mtk-vpu/ to mediatek/mtk-vpu/
Date:   Sun, 13 Mar 2022 11:51:48 +0100
Message-Id: <e42fa23cbaa6aec532da7e9683553ee4091ed4b8.1647167750.git.mchehab@kernel.org>
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
rename mtk-vpu/ to mediatek/mtk-vpu/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/

 MAINTAINERS                                             | 4 ++--
 drivers/media/platform/Kconfig                          | 2 +-
 drivers/media/platform/Makefile                         | 2 +-
 drivers/media/platform/mediatek/mtk-mdp/Makefile        | 2 +-
 drivers/media/platform/{ => mediatek}/mtk-vpu/Kconfig   | 0
 drivers/media/platform/{ => mediatek}/mtk-vpu/Makefile  | 0
 drivers/media/platform/{ => mediatek}/mtk-vpu/mtk_vpu.c | 0
 drivers/media/platform/{ => mediatek}/mtk-vpu/mtk_vpu.h | 0
 8 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/media/platform/{ => mediatek}/mtk-vpu/Kconfig (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vpu/Makefile (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vpu/mtk_vpu.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vpu/mtk_vpu.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index bfe014870a77..58e0d42b1278 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12139,7 +12139,7 @@ M:	Andrew-CT Chen <andrew-ct.chen@mediatek.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek-mdp.txt
 F:	drivers/media/platform/mediatek/mtk-mdp/
-F:	drivers/media/platform/mtk-vpu/
+F:	drivers/media/platform/mediatek/mtk-vpu/
 
 MEDIATEK MEDIA DRIVER
 M:	Tiffany Lin <tiffany.lin@mediatek.com>
@@ -12148,7 +12148,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek-vcodec.txt
 F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
 F:	drivers/media/platform/mediatek/mtk-vcodec/
-F:	drivers/media/platform/mtk-vpu/
+F:	drivers/media/platform/mediatek/mtk-vpu/
 
 MEDIATEK MMC/SD/SDIO DRIVER
 M:	Chaotian Jing <chaotian.jing@mediatek.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 8ba10b657164..33f8f41b2771 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -81,7 +81,7 @@ source "drivers/media/platform/marvell/Kconfig"
 source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mediatek/mtk-mdp/Kconfig"
 source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
-source "drivers/media/platform/mtk-vpu/Kconfig"
+source "drivers/media/platform/mediatek/mtk-vpu/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 source "drivers/media/platform/omap3isp/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 637a3a7ac036..954ad8f2cde1 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -21,7 +21,7 @@ obj-y += marvell/
 obj-y += mediatek/mtk-jpeg/
 obj-y += mediatek/mtk-mdp/
 obj-y += mediatek/mtk-vcodec/
-obj-y += mtk-vpu/
+obj-y += mediatek/mtk-vpu/
 obj-y += nxp/
 obj-y += omap/
 obj-y += omap3isp/
diff --git a/drivers/media/platform/mediatek/mtk-mdp/Makefile b/drivers/media/platform/mediatek/mtk-mdp/Makefile
index 5982d65c9971..eab6f984aeea 100644
--- a/drivers/media/platform/mediatek/mtk-mdp/Makefile
+++ b/drivers/media/platform/mediatek/mtk-mdp/Makefile
@@ -7,4 +7,4 @@ mtk-mdp-y += mtk_mdp_vpu.o
 
 obj-$(CONFIG_VIDEO_MEDIATEK_MDP) += mtk-mdp.o
 
-ccflags-y += -I$(srctree)/drivers/media/platform/mtk-vpu
+ccflags-y += -I$(srctree)/drivers/media/platform/mediatek/mtk-vpu
diff --git a/drivers/media/platform/mtk-vpu/Kconfig b/drivers/media/platform/mediatek/mtk-vpu/Kconfig
similarity index 100%
rename from drivers/media/platform/mtk-vpu/Kconfig
rename to drivers/media/platform/mediatek/mtk-vpu/Kconfig
diff --git a/drivers/media/platform/mtk-vpu/Makefile b/drivers/media/platform/mediatek/mtk-vpu/Makefile
similarity index 100%
rename from drivers/media/platform/mtk-vpu/Makefile
rename to drivers/media/platform/mediatek/mtk-vpu/Makefile
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mediatek/mtk-vpu/mtk_vpu.c
similarity index 100%
rename from drivers/media/platform/mtk-vpu/mtk_vpu.c
rename to drivers/media/platform/mediatek/mtk-vpu/mtk_vpu.c
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.h b/drivers/media/platform/mediatek/mtk-vpu/mtk_vpu.h
similarity index 100%
rename from drivers/media/platform/mtk-vpu/mtk_vpu.h
rename to drivers/media/platform/mediatek/mtk-vpu/mtk_vpu.h
-- 
2.35.1

