Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EEF4D7492
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiCMKzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiCMKx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3877118622;
        Sun, 13 Mar 2022 03:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C01261019;
        Sun, 13 Mar 2022 10:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD89C340FA;
        Sun, 13 Mar 2022 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647168729;
        bh=HoopYOEpxuaYPaONTVhJjIO5eFHfFTSdNlpQocjOuNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKBcRn2CzfXUR2sCEdms5vFAj4K7/mxfXAjBMFBzPriFIVdBakehntZwv0MjYlH+1
         LwkFzfobDbTnM02r2u9H7yAjufCIVkWG/gEQZSis4evNXz4RTOqCXPT1nePiPCb3AE
         cz+6+DyiIOnwDj+1ZtIkXl2aEscOA4Ztvy7+MjaoXMWvbP7FJln/8bOFDbJGwlUYsP
         p6uRpEHMJeS86/2BiCxws0uux7QpuAyPXG6HHd1nH2dGXNp9f402zxk1C+h6iQ68H1
         APjZ7d+IAbafL/Dgn9UBN8pz2RrkTMCdCImmQCtk9SOTJbr3JCEGMTShMqIJTmByG6
         TS17BB0kYuVrQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTLpW-001I1c-Vd; Sun, 13 Mar 2022 11:52:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Courbot <acourbot@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hirokazu Honda <hiroh@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Steve Cho <stevecho@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 06/24] media: platform: rename mtk-vcodec/ to mediatek/mtk-vcodec/
Date:   Sun, 13 Mar 2022 11:51:47 +0100
Message-Id: <53a632ce79c9d02673d7540e18d681f123afb801.1647167750.git.mchehab@kernel.org>
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
rename mtk-vcodec/ to mediatek/mtk-vcodec/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/

 MAINTAINERS                                                     | 2 +-
 drivers/media/platform/Kconfig                                  | 2 +-
 drivers/media/platform/Makefile                                 | 2 +-
 drivers/media/platform/{ => mediatek}/mtk-vcodec/Kconfig        | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/Makefile       | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec.c   | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec.h   | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_drv.c     | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.c      | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.h      | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.c      | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.h      | 0
 .../{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_stateful.c         | 0
 .../{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_stateless.c        | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_drv.h   | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc.c   | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc.h   | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_drv.c     | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.c      | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.h      | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw.c    | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw.h    | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_priv.h     | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_scp.c      | 0
 .../platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_vpu.c      | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_intr.c  | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_intr.h  | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_util.c  | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_util.h  | 0
 .../platform/{ => mediatek}/mtk-vcodec/vdec/vdec_h264_if.c      | 0
 .../platform/{ => mediatek}/mtk-vcodec/vdec/vdec_h264_req_if.c  | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_vp8_if.c | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_vp9_if.c | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_base.h    | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_if.c  | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_if.h  | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_ipi_msg.h | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/vdec_msg_queue.c   | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/vdec_msg_queue.h   | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_vpu_if.c  | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_vpu_if.h  | 0
 .../platform/{ => mediatek}/mtk-vcodec/venc/venc_h264_if.c      | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/venc/venc_vp8_if.c | 0
 .../media/platform/{ => mediatek}/mtk-vcodec/venc_drv_base.h    | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_drv_if.c  | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_drv_if.h  | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_ipi_msg.h | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_vpu_if.c  | 0
 drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_vpu_if.h  | 0
 49 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/Kconfig (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/Makefile (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_drv.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_hw.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_pm.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_stateful.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_dec_stateless.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_drv.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_drv.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_enc_pm.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_priv.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_scp.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_fw_vpu.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_intr.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_intr.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_util.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/mtk_vcodec_util.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_h264_if.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_h264_req_if.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_vp8_if.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec/vdec_vp9_if.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_base.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_if.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_drv_if.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_ipi_msg.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_msg_queue.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_msg_queue.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_vpu_if.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/vdec_vpu_if.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc/venc_h264_if.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc/venc_vp8_if.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_drv_base.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_drv_if.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_drv_if.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_ipi_msg.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_vpu_if.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-vcodec/venc_vpu_if.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2203d98bbcf1..bfe014870a77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12147,7 +12147,7 @@ M:	Andrew-CT Chen <andrew-ct.chen@mediatek.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek-vcodec.txt
 F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
-F:	drivers/media/platform/mtk-vcodec/
+F:	drivers/media/platform/mediatek/mtk-vcodec/
 F:	drivers/media/platform/mtk-vpu/
 
 MEDIATEK MMC/SD/SDIO DRIVER
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index a45fd3fe103e..8ba10b657164 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -80,7 +80,7 @@ source "drivers/media/platform/intel/Kconfig"
 source "drivers/media/platform/marvell/Kconfig"
 source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mediatek/mtk-mdp/Kconfig"
-source "drivers/media/platform/mtk-vcodec/Kconfig"
+source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mtk-vpu/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 6f5d09cd8f9b..637a3a7ac036 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -20,7 +20,7 @@ obj-y += intel/
 obj-y += marvell/
 obj-y += mediatek/mtk-jpeg/
 obj-y += mediatek/mtk-mdp/
-obj-y += mtk-vcodec/
+obj-y += mediatek/mtk-vcodec/
 obj-y += mtk-vpu/
 obj-y += nxp/
 obj-y += omap/
diff --git a/drivers/media/platform/mtk-vcodec/Kconfig b/drivers/media/platform/mediatek/mtk-vcodec/Kconfig
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/Kconfig
rename to drivers/media/platform/mediatek/mtk-vcodec/Kconfig
diff --git a/drivers/media/platform/mtk-vcodec/Makefile b/drivers/media/platform/mediatek/mtk-vcodec/Makefile
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/Makefile
rename to drivers/media/platform/mediatek/mtk-vcodec/Makefile
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.h
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec.h
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_drv.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_drv.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_hw.h
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_hw.h
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_pm.h
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateful.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateful.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateless.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_dec_stateless.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_drv.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_drv.h
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc.h
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_drv.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_drv.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_enc_pm.h
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw.h
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_priv.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_priv.h
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_scp.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_scp.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_vpu.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_fw_vpu.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_intr.h
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_intr.h
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.c
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
rename to drivers/media/platform/mediatek/mtk-vcodec/mtk_vcodec_util.h
diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_if.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_if.c
diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_req_if.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec/vdec_h264_req_if.c
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_h264_req_if.c
diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp8_if.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp8_if.c
diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp9_if.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec/vdec_vp9_if.c
diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_base.h b/drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_base.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec_drv_base.h
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_base.h
diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec_drv_if.c
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.c
diff --git a/drivers/media/platform/mtk-vcodec/vdec_drv_if.h b/drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec_drv_if.h
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_drv_if.h
diff --git a/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h b/drivers/media/platform/mediatek/mtk-vcodec/vdec_ipi_msg.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_ipi_msg.h
diff --git a/drivers/media/platform/mtk-vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec_msg_queue.c
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.c
diff --git a/drivers/media/platform/mtk-vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec_msg_queue.h
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_msg_queue.h
diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.c
diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h b/drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
rename to drivers/media/platform/mediatek/mtk-vcodec/vdec_vpu_if.h
diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/mtk-vcodec/venc/venc_h264_if.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
rename to drivers/media/platform/mediatek/mtk-vcodec/venc/venc_h264_if.c
diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/mtk-vcodec/venc/venc_vp8_if.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
rename to drivers/media/platform/mediatek/mtk-vcodec/venc/venc_vp8_if.c
diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_base.h b/drivers/media/platform/mediatek/mtk-vcodec/venc_drv_base.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/venc_drv_base.h
rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_base.h
diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.c b/drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/venc_drv_if.c
rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.c
diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.h b/drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/venc_drv_if.h
rename to drivers/media/platform/mediatek/mtk-vcodec/venc_drv_if.h
diff --git a/drivers/media/platform/mtk-vcodec/venc_ipi_msg.h b/drivers/media/platform/mediatek/mtk-vcodec/venc_ipi_msg.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/venc_ipi_msg.h
rename to drivers/media/platform/mediatek/mtk-vcodec/venc_ipi_msg.h
diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.c b/drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.c
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/venc_vpu_if.c
rename to drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.c
diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.h b/drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.h
similarity index 100%
rename from drivers/media/platform/mtk-vcodec/venc_vpu_if.h
rename to drivers/media/platform/mediatek/mtk-vcodec/venc_vpu_if.h
-- 
2.35.1

