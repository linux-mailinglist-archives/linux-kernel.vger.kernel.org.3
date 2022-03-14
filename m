Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6554D898B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiCNQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiCNQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C1C35860;
        Mon, 14 Mar 2022 09:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ECF96149A;
        Mon, 14 Mar 2022 16:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDB1C36B19;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=yFeoDdAXNpG8eqAcM9UKLZWnOV9MaJroObtIMCoZYG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/fi0cfYaKtBMr3aeSFDZkhH+NBVO135+RSKG15o9rMzZs0bKEkXniaXsat0KzO4Y
         k0uYZL16ii2D0EL8XpfdXl/KqMo0RdYq/JLZZiYd+tvRdVLu01no9DIGkJDhuOCxG3
         K844twOnwMeNUM0ludxLA/dV2p2DFm1zTDVLOGVlv34Nj9n4oJ4Ph++8RE9olngxWJ
         5/TjnGbeiDyEHAEUO8EP4zUBfdTGeWj71iucpVtqmvBUSNlxXgnPOua393XDPDL028
         N3A9F0O3mR4D6gkKDsFTjvVyPWvZ5ID5yQL1x890h60lP8z7f0RAop2UIyu8vR5e4r
         FHaBuHrUSyGhg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf1-001x0f-9c; Mon, 14 Mar 2022 17:35:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Dmitry Osipenko <digetx@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Evgeny Novikov <novikov@ispras.ru>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Foss <robert.foss@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sean Young <sean@mess.org>, Xiaofeng Cao <cxfcosmos@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 56/67] media: platform: rename sti/ to stm/sti/
Date:   Mon, 14 Mar 2022 17:34:51 +0100
Message-Id: <c4547b2dbe9937523305479f9b3a3aa9c55cc77b.1647274407.git.mchehab@kernel.org>
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
rename sti/ to stm/sti/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 MAINTAINERS                                               | 8 ++++----
 drivers/media/platform/Kconfig                            | 2 +-
 drivers/media/platform/Makefile                           | 8 ++++----
 drivers/media/platform/sti/Kconfig                        | 5 -----
 drivers/media/platform/stm/sti/Kconfig                    | 5 +++++
 drivers/media/platform/{ => stm}/sti/bdisp/Kconfig        | 0
 drivers/media/platform/{ => stm}/sti/bdisp/Makefile       | 0
 drivers/media/platform/{ => stm}/sti/bdisp/bdisp-debug.c  | 0
 drivers/media/platform/{ => stm}/sti/bdisp/bdisp-filter.h | 0
 drivers/media/platform/{ => stm}/sti/bdisp/bdisp-hw.c     | 0
 drivers/media/platform/{ => stm}/sti/bdisp/bdisp-reg.h    | 0
 drivers/media/platform/{ => stm}/sti/bdisp/bdisp-v4l2.c   | 0
 drivers/media/platform/{ => stm}/sti/bdisp/bdisp.h        | 0
 drivers/media/platform/{ => stm}/sti/c8sectpfe/Kconfig    | 0
 drivers/media/platform/{ => stm}/sti/c8sectpfe/Makefile   | 0
 .../platform/{ => stm}/sti/c8sectpfe/c8sectpfe-common.c   | 0
 .../platform/{ => stm}/sti/c8sectpfe/c8sectpfe-common.h   | 0
 .../platform/{ => stm}/sti/c8sectpfe/c8sectpfe-core.c     | 0
 .../platform/{ => stm}/sti/c8sectpfe/c8sectpfe-core.h     | 0
 .../platform/{ => stm}/sti/c8sectpfe/c8sectpfe-debugfs.c  | 0
 .../platform/{ => stm}/sti/c8sectpfe/c8sectpfe-debugfs.h  | 0
 .../platform/{ => stm}/sti/c8sectpfe/c8sectpfe-dvb.c      | 0
 .../platform/{ => stm}/sti/c8sectpfe/c8sectpfe-dvb.h      | 0
 drivers/media/platform/{ => stm}/sti/delta/Kconfig        | 0
 drivers/media/platform/{ => stm}/sti/delta/Makefile       | 0
 drivers/media/platform/{ => stm}/sti/delta/delta-cfg.h    | 0
 drivers/media/platform/{ => stm}/sti/delta/delta-debug.c  | 0
 drivers/media/platform/{ => stm}/sti/delta/delta-debug.h  | 0
 drivers/media/platform/{ => stm}/sti/delta/delta-ipc.c    | 0
 drivers/media/platform/{ => stm}/sti/delta/delta-ipc.h    | 0
 drivers/media/platform/{ => stm}/sti/delta/delta-mem.c    | 0
 drivers/media/platform/{ => stm}/sti/delta/delta-mem.h    | 0
 .../media/platform/{ => stm}/sti/delta/delta-mjpeg-dec.c  | 0
 .../media/platform/{ => stm}/sti/delta/delta-mjpeg-fw.h   | 0
 .../media/platform/{ => stm}/sti/delta/delta-mjpeg-hdr.c  | 0
 drivers/media/platform/{ => stm}/sti/delta/delta-mjpeg.h  | 0
 drivers/media/platform/{ => stm}/sti/delta/delta-v4l2.c   | 0
 drivers/media/platform/{ => stm}/sti/delta/delta.h        | 0
 drivers/media/platform/{ => stm}/sti/hva/Kconfig          | 0
 drivers/media/platform/{ => stm}/sti/hva/Makefile         | 0
 drivers/media/platform/{ => stm}/sti/hva/hva-debugfs.c    | 0
 drivers/media/platform/{ => stm}/sti/hva/hva-h264.c       | 0
 drivers/media/platform/{ => stm}/sti/hva/hva-hw.c         | 0
 drivers/media/platform/{ => stm}/sti/hva/hva-hw.h         | 0
 drivers/media/platform/{ => stm}/sti/hva/hva-mem.c        | 0
 drivers/media/platform/{ => stm}/sti/hva/hva-mem.h        | 0
 drivers/media/platform/{ => stm}/sti/hva/hva-v4l2.c       | 0
 drivers/media/platform/{ => stm}/sti/hva/hva.h            | 0
 48 files changed, 14 insertions(+), 14 deletions(-)
 delete mode 100644 drivers/media/platform/sti/Kconfig
 create mode 100644 drivers/media/platform/stm/sti/Kconfig
 rename drivers/media/platform/{ => stm}/sti/bdisp/Kconfig (100%)
 rename drivers/media/platform/{ => stm}/sti/bdisp/Makefile (100%)
 rename drivers/media/platform/{ => stm}/sti/bdisp/bdisp-debug.c (100%)
 rename drivers/media/platform/{ => stm}/sti/bdisp/bdisp-filter.h (100%)
 rename drivers/media/platform/{ => stm}/sti/bdisp/bdisp-hw.c (100%)
 rename drivers/media/platform/{ => stm}/sti/bdisp/bdisp-reg.h (100%)
 rename drivers/media/platform/{ => stm}/sti/bdisp/bdisp-v4l2.c (100%)
 rename drivers/media/platform/{ => stm}/sti/bdisp/bdisp.h (100%)
 rename drivers/media/platform/{ => stm}/sti/c8sectpfe/Kconfig (100%)
 rename drivers/media/platform/{ => stm}/sti/c8sectpfe/Makefile (100%)
 rename drivers/media/platform/{ => stm}/sti/c8sectpfe/c8sectpfe-common.c (100%)
 rename drivers/media/platform/{ => stm}/sti/c8sectpfe/c8sectpfe-common.h (100%)
 rename drivers/media/platform/{ => stm}/sti/c8sectpfe/c8sectpfe-core.c (100%)
 rename drivers/media/platform/{ => stm}/sti/c8sectpfe/c8sectpfe-core.h (100%)
 rename drivers/media/platform/{ => stm}/sti/c8sectpfe/c8sectpfe-debugfs.c (100%)
 rename drivers/media/platform/{ => stm}/sti/c8sectpfe/c8sectpfe-debugfs.h (100%)
 rename drivers/media/platform/{ => stm}/sti/c8sectpfe/c8sectpfe-dvb.c (100%)
 rename drivers/media/platform/{ => stm}/sti/c8sectpfe/c8sectpfe-dvb.h (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/Kconfig (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/Makefile (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-cfg.h (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-debug.c (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-debug.h (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-ipc.c (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-ipc.h (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-mem.c (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-mem.h (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-mjpeg-dec.c (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-mjpeg-fw.h (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-mjpeg-hdr.c (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-mjpeg.h (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta-v4l2.c (100%)
 rename drivers/media/platform/{ => stm}/sti/delta/delta.h (100%)
 rename drivers/media/platform/{ => stm}/sti/hva/Kconfig (100%)
 rename drivers/media/platform/{ => stm}/sti/hva/Makefile (100%)
 rename drivers/media/platform/{ => stm}/sti/hva/hva-debugfs.c (100%)
 rename drivers/media/platform/{ => stm}/sti/hva/hva-h264.c (100%)
 rename drivers/media/platform/{ => stm}/sti/hva/hva-hw.c (100%)
 rename drivers/media/platform/{ => stm}/sti/hva/hva-hw.h (100%)
 rename drivers/media/platform/{ => stm}/sti/hva/hva-mem.c (100%)
 rename drivers/media/platform/{ => stm}/sti/hva/hva-mem.h (100%)
 rename drivers/media/platform/{ => stm}/sti/hva/hva-v4l2.c (100%)
 rename drivers/media/platform/{ => stm}/sti/hva/hva.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cf03d253bc8..6c1055c27c65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2710,7 +2710,7 @@ F:	drivers/clocksource/clksrc_st_lpc.c
 F:	drivers/cpufreq/sti-cpufreq.c
 F:	drivers/dma/st_fdma*
 F:	drivers/i2c/busses/i2c-st.c
-F:	drivers/media/platform/sti/c8sectpfe/
+F:	drivers/media/platform/stm/sti/c8sectpfe/
 F:	drivers/media/rc/st_rc.c
 F:	drivers/mmc/host/sdhci-st.c
 F:	drivers/phy/st/phy-miphy28lp.c
@@ -3383,7 +3383,7 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
-F:	drivers/media/platform/sti/bdisp
+F:	drivers/media/platform/stm/sti/bdisp
 
 BECKHOFF CX5020 ETHERCAT MASTER DRIVER
 M:	Dariusz Marcinkiewicz <reksio@newterm.pl>
@@ -5482,7 +5482,7 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
-F:	drivers/media/platform/sti/delta
+F:	drivers/media/platform/stm/sti/delta
 
 DELTA AHE-50DC FAN CONTROL MODULE DRIVER
 M:	Zev Weiss <zev@bewilderbeest.net>
@@ -8870,7 +8870,7 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
-F:	drivers/media/platform/sti/hva
+F:	drivers/media/platform/stm/sti/hva
 
 HWPOISON MEMORY FAILURE HANDLING
 M:	Naoya Horiguchi <naoya.horiguchi@nec.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index c308de1a42a4..2ad5fde02543 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -94,7 +94,7 @@ source "drivers/media/platform/samsung/s3c-camif/Kconfig"
 source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
 source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
 source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
-source "drivers/media/platform/sti/Kconfig"
+source "drivers/media/platform/stm/sti/Kconfig"
 source "drivers/media/platform/stm/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/via/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 7f077c9a416d..f20f1287c665 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -36,10 +36,10 @@ obj-y += samsung/s3c-camif/
 obj-y += samsung/s5p-g2d/
 obj-y += samsung/s5p-jpeg/
 obj-y += samsung/s5p-mfc/
-obj-y += sti/bdisp/
-obj-y += sti/c8sectpfe/
-obj-y += sti/delta/
-obj-y += sti/hva/
+obj-y += stm/sti/bdisp/
+obj-y += stm/sti/c8sectpfe/
+obj-y += stm/sti/delta/
+obj-y += stm/sti/hva/
 obj-y += stm/stm32/
 obj-y += ti-vpe/
 obj-y += via/
diff --git a/drivers/media/platform/sti/Kconfig b/drivers/media/platform/sti/Kconfig
deleted file mode 100644
index 9fb5e78a92cf..000000000000
--- a/drivers/media/platform/sti/Kconfig
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-source "drivers/media/platform/sti/bdisp/Kconfig"
-source "drivers/media/platform/sti/c8sectpfe/Kconfig"
-source "drivers/media/platform/sti/delta/Kconfig"
-source "drivers/media/platform/sti/hva/Kconfig"
diff --git a/drivers/media/platform/stm/sti/Kconfig b/drivers/media/platform/stm/sti/Kconfig
new file mode 100644
index 000000000000..311930644281
--- /dev/null
+++ b/drivers/media/platform/stm/sti/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+source "drivers/media/platform/stm/sti/bdisp/Kconfig"
+source "drivers/media/platform/stm/sti/c8sectpfe/Kconfig"
+source "drivers/media/platform/stm/sti/delta/Kconfig"
+source "drivers/media/platform/stm/sti/hva/Kconfig"
diff --git a/drivers/media/platform/sti/bdisp/Kconfig b/drivers/media/platform/stm/sti/bdisp/Kconfig
similarity index 100%
rename from drivers/media/platform/sti/bdisp/Kconfig
rename to drivers/media/platform/stm/sti/bdisp/Kconfig
diff --git a/drivers/media/platform/sti/bdisp/Makefile b/drivers/media/platform/stm/sti/bdisp/Makefile
similarity index 100%
rename from drivers/media/platform/sti/bdisp/Makefile
rename to drivers/media/platform/stm/sti/bdisp/Makefile
diff --git a/drivers/media/platform/sti/bdisp/bdisp-debug.c b/drivers/media/platform/stm/sti/bdisp/bdisp-debug.c
similarity index 100%
rename from drivers/media/platform/sti/bdisp/bdisp-debug.c
rename to drivers/media/platform/stm/sti/bdisp/bdisp-debug.c
diff --git a/drivers/media/platform/sti/bdisp/bdisp-filter.h b/drivers/media/platform/stm/sti/bdisp/bdisp-filter.h
similarity index 100%
rename from drivers/media/platform/sti/bdisp/bdisp-filter.h
rename to drivers/media/platform/stm/sti/bdisp/bdisp-filter.h
diff --git a/drivers/media/platform/sti/bdisp/bdisp-hw.c b/drivers/media/platform/stm/sti/bdisp/bdisp-hw.c
similarity index 100%
rename from drivers/media/platform/sti/bdisp/bdisp-hw.c
rename to drivers/media/platform/stm/sti/bdisp/bdisp-hw.c
diff --git a/drivers/media/platform/sti/bdisp/bdisp-reg.h b/drivers/media/platform/stm/sti/bdisp/bdisp-reg.h
similarity index 100%
rename from drivers/media/platform/sti/bdisp/bdisp-reg.h
rename to drivers/media/platform/stm/sti/bdisp/bdisp-reg.h
diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/stm/sti/bdisp/bdisp-v4l2.c
similarity index 100%
rename from drivers/media/platform/sti/bdisp/bdisp-v4l2.c
rename to drivers/media/platform/stm/sti/bdisp/bdisp-v4l2.c
diff --git a/drivers/media/platform/sti/bdisp/bdisp.h b/drivers/media/platform/stm/sti/bdisp/bdisp.h
similarity index 100%
rename from drivers/media/platform/sti/bdisp/bdisp.h
rename to drivers/media/platform/stm/sti/bdisp/bdisp.h
diff --git a/drivers/media/platform/sti/c8sectpfe/Kconfig b/drivers/media/platform/stm/sti/c8sectpfe/Kconfig
similarity index 100%
rename from drivers/media/platform/sti/c8sectpfe/Kconfig
rename to drivers/media/platform/stm/sti/c8sectpfe/Kconfig
diff --git a/drivers/media/platform/sti/c8sectpfe/Makefile b/drivers/media/platform/stm/sti/c8sectpfe/Makefile
similarity index 100%
rename from drivers/media/platform/sti/c8sectpfe/Makefile
rename to drivers/media/platform/stm/sti/c8sectpfe/Makefile
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.c b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.c
similarity index 100%
rename from drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.c
rename to drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.c
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h
similarity index 100%
rename from drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h
rename to drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-core.c
similarity index 100%
rename from drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
rename to drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-core.c
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.h b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-core.h
similarity index 100%
rename from drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.h
rename to drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-core.h
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-debugfs.c b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-debugfs.c
similarity index 100%
rename from drivers/media/platform/sti/c8sectpfe/c8sectpfe-debugfs.c
rename to drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-debugfs.c
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-debugfs.h b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-debugfs.h
similarity index 100%
rename from drivers/media/platform/sti/c8sectpfe/c8sectpfe-debugfs.h
rename to drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-debugfs.h
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-dvb.c
similarity index 100%
rename from drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.c
rename to drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-dvb.c
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.h b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-dvb.h
similarity index 100%
rename from drivers/media/platform/sti/c8sectpfe/c8sectpfe-dvb.h
rename to drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-dvb.h
diff --git a/drivers/media/platform/sti/delta/Kconfig b/drivers/media/platform/stm/sti/delta/Kconfig
similarity index 100%
rename from drivers/media/platform/sti/delta/Kconfig
rename to drivers/media/platform/stm/sti/delta/Kconfig
diff --git a/drivers/media/platform/sti/delta/Makefile b/drivers/media/platform/stm/sti/delta/Makefile
similarity index 100%
rename from drivers/media/platform/sti/delta/Makefile
rename to drivers/media/platform/stm/sti/delta/Makefile
diff --git a/drivers/media/platform/sti/delta/delta-cfg.h b/drivers/media/platform/stm/sti/delta/delta-cfg.h
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-cfg.h
rename to drivers/media/platform/stm/sti/delta/delta-cfg.h
diff --git a/drivers/media/platform/sti/delta/delta-debug.c b/drivers/media/platform/stm/sti/delta/delta-debug.c
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-debug.c
rename to drivers/media/platform/stm/sti/delta/delta-debug.c
diff --git a/drivers/media/platform/sti/delta/delta-debug.h b/drivers/media/platform/stm/sti/delta/delta-debug.h
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-debug.h
rename to drivers/media/platform/stm/sti/delta/delta-debug.h
diff --git a/drivers/media/platform/sti/delta/delta-ipc.c b/drivers/media/platform/stm/sti/delta/delta-ipc.c
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-ipc.c
rename to drivers/media/platform/stm/sti/delta/delta-ipc.c
diff --git a/drivers/media/platform/sti/delta/delta-ipc.h b/drivers/media/platform/stm/sti/delta/delta-ipc.h
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-ipc.h
rename to drivers/media/platform/stm/sti/delta/delta-ipc.h
diff --git a/drivers/media/platform/sti/delta/delta-mem.c b/drivers/media/platform/stm/sti/delta/delta-mem.c
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-mem.c
rename to drivers/media/platform/stm/sti/delta/delta-mem.c
diff --git a/drivers/media/platform/sti/delta/delta-mem.h b/drivers/media/platform/stm/sti/delta/delta-mem.h
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-mem.h
rename to drivers/media/platform/stm/sti/delta/delta-mem.h
diff --git a/drivers/media/platform/sti/delta/delta-mjpeg-dec.c b/drivers/media/platform/stm/sti/delta/delta-mjpeg-dec.c
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-mjpeg-dec.c
rename to drivers/media/platform/stm/sti/delta/delta-mjpeg-dec.c
diff --git a/drivers/media/platform/sti/delta/delta-mjpeg-fw.h b/drivers/media/platform/stm/sti/delta/delta-mjpeg-fw.h
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-mjpeg-fw.h
rename to drivers/media/platform/stm/sti/delta/delta-mjpeg-fw.h
diff --git a/drivers/media/platform/sti/delta/delta-mjpeg-hdr.c b/drivers/media/platform/stm/sti/delta/delta-mjpeg-hdr.c
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-mjpeg-hdr.c
rename to drivers/media/platform/stm/sti/delta/delta-mjpeg-hdr.c
diff --git a/drivers/media/platform/sti/delta/delta-mjpeg.h b/drivers/media/platform/stm/sti/delta/delta-mjpeg.h
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-mjpeg.h
rename to drivers/media/platform/stm/sti/delta/delta-mjpeg.h
diff --git a/drivers/media/platform/sti/delta/delta-v4l2.c b/drivers/media/platform/stm/sti/delta/delta-v4l2.c
similarity index 100%
rename from drivers/media/platform/sti/delta/delta-v4l2.c
rename to drivers/media/platform/stm/sti/delta/delta-v4l2.c
diff --git a/drivers/media/platform/sti/delta/delta.h b/drivers/media/platform/stm/sti/delta/delta.h
similarity index 100%
rename from drivers/media/platform/sti/delta/delta.h
rename to drivers/media/platform/stm/sti/delta/delta.h
diff --git a/drivers/media/platform/sti/hva/Kconfig b/drivers/media/platform/stm/sti/hva/Kconfig
similarity index 100%
rename from drivers/media/platform/sti/hva/Kconfig
rename to drivers/media/platform/stm/sti/hva/Kconfig
diff --git a/drivers/media/platform/sti/hva/Makefile b/drivers/media/platform/stm/sti/hva/Makefile
similarity index 100%
rename from drivers/media/platform/sti/hva/Makefile
rename to drivers/media/platform/stm/sti/hva/Makefile
diff --git a/drivers/media/platform/sti/hva/hva-debugfs.c b/drivers/media/platform/stm/sti/hva/hva-debugfs.c
similarity index 100%
rename from drivers/media/platform/sti/hva/hva-debugfs.c
rename to drivers/media/platform/stm/sti/hva/hva-debugfs.c
diff --git a/drivers/media/platform/sti/hva/hva-h264.c b/drivers/media/platform/stm/sti/hva/hva-h264.c
similarity index 100%
rename from drivers/media/platform/sti/hva/hva-h264.c
rename to drivers/media/platform/stm/sti/hva/hva-h264.c
diff --git a/drivers/media/platform/sti/hva/hva-hw.c b/drivers/media/platform/stm/sti/hva/hva-hw.c
similarity index 100%
rename from drivers/media/platform/sti/hva/hva-hw.c
rename to drivers/media/platform/stm/sti/hva/hva-hw.c
diff --git a/drivers/media/platform/sti/hva/hva-hw.h b/drivers/media/platform/stm/sti/hva/hva-hw.h
similarity index 100%
rename from drivers/media/platform/sti/hva/hva-hw.h
rename to drivers/media/platform/stm/sti/hva/hva-hw.h
diff --git a/drivers/media/platform/sti/hva/hva-mem.c b/drivers/media/platform/stm/sti/hva/hva-mem.c
similarity index 100%
rename from drivers/media/platform/sti/hva/hva-mem.c
rename to drivers/media/platform/stm/sti/hva/hva-mem.c
diff --git a/drivers/media/platform/sti/hva/hva-mem.h b/drivers/media/platform/stm/sti/hva/hva-mem.h
similarity index 100%
rename from drivers/media/platform/sti/hva/hva-mem.h
rename to drivers/media/platform/stm/sti/hva/hva-mem.h
diff --git a/drivers/media/platform/sti/hva/hva-v4l2.c b/drivers/media/platform/stm/sti/hva/hva-v4l2.c
similarity index 100%
rename from drivers/media/platform/sti/hva/hva-v4l2.c
rename to drivers/media/platform/stm/sti/hva/hva-v4l2.c
diff --git a/drivers/media/platform/sti/hva/hva.h b/drivers/media/platform/stm/sti/hva/hva.h
similarity index 100%
rename from drivers/media/platform/sti/hva/hva.h
rename to drivers/media/platform/stm/sti/hva/hva.h
-- 
2.35.1

