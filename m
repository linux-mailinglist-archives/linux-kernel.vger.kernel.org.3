Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606464D7CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiCNIBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiCNH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296341608;
        Mon, 14 Mar 2022 00:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D5F7611C0;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3F4C36B0A;
        Mon, 14 Mar 2022 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244562;
        bh=frM2TrgnfHXXWxzvLlBjDHJ6SZXKkAW32KrVCq9TUeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYplchdHkgp1dzoIMq6v5/pU/0JEfGkpMoc7Ci3sHQRRW4492Cjj+U7QzOCowIPz9
         982e6MnMwdtaOpVKIuBMg8dOwk92NUGtjJxzGkv/kZCxi0dhSXAIy7TQH1Qbjfcft1
         yJN11ww/PfxUXKSorLWUO1+Rdiax1Rg1txwntuODonaMRXqBthLP5UtHHDIAFmnN/Z
         /6DPxlTE5J4ARvkn915mAkRhLRiSVsbpWieIZ385Itaieds6tdsdgKVK9uwwmaav19
         bTYIoZHUzE1/LbeMmKbL6/FUjDdIu1nsawBpPkwofhnIzK5XTy4xECVOVVT0bJ6eua
         T0R34Ir6ZhP4A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYe-001kX9-7N; Mon, 14 Mar 2022 08:56:00 +0100
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
Subject: [PATCH 46/64] media: platform: rename mtk-vpu/ to mediatek/mtk-vpu/
Date:   Mon, 14 Mar 2022 08:55:38 +0100
Message-Id: <019918d9c896ddb1f3968d0fcd825c0ef1464899.1647242579.git.mchehab@kernel.org>
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
rename mtk-vpu/ to mediatek/mtk-vpu/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

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
index 10055af0c7f8..a9ad0c3bd0cc 100644
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

