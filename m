Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F29F4D7CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiCNIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbiCNH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08D74162A;
        Mon, 14 Mar 2022 00:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C93C8611DF;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D02C36B1F;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244563;
        bh=sa8b7brGOGN9yHxRgRniVHVGaYs4Y9V4omrOIDbvqzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMMm05Uwn+ESXtf+QhzFDjS6tqeOFAH0CRl9ymtqjHOouZ4zu0MMtuFOumIuf4oSV
         CmGIePgdKqyYCWEs9lhcAWIZsQpeZY7Mo4k2xX1Yc0C7y3ZRH6H1a6I9U2Ay0WUqKN
         NWExi23DWoAfBks3MwuMS7aH57r+RnQaubvrA7NqIKuL2Qa6J7RNdCDBXFUdnteGIm
         lbS77HW6ab9EWHUfhkP84qFmFb0etXdNHIuVKFQJ9jaVEHC/LRQTyxCPcCwNmCLKmS
         qBIGVNYDOsbGWylQI4WSTjquXJhpduBx8T74+aQt5alJxAt1Xu5l5+TBnC96ndfpkP
         rneZDUl0Gkq1w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYe-001kY3-Sn; Mon, 14 Mar 2022 08:56:00 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 60/64] media: platform: rename omap/ to ti/omap/
Date:   Mon, 14 Mar 2022 08:55:52 +0100
Message-Id: <ca424b45f0ffb1b1f7f2cd8b1bd1ccb6b808f5e0.1647242579.git.mchehab@kernel.org>
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
rename omap/ to ti/omap/.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                        | 2 +-
 drivers/media/platform/Makefile                       | 2 +-
 drivers/media/platform/{ => ti}/omap/Kconfig          | 0
 drivers/media/platform/{ => ti}/omap/Makefile         | 0
 drivers/media/platform/{ => ti}/omap/omap_vout.c      | 0
 drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.c | 0
 drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.h | 0
 drivers/media/platform/{ => ti}/omap/omap_voutdef.h   | 0
 drivers/media/platform/{ => ti}/omap/omap_voutlib.c   | 0
 drivers/media/platform/{ => ti}/omap/omap_voutlib.h   | 0
 10 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/media/platform/{ => ti}/omap/Kconfig (100%)
 rename drivers/media/platform/{ => ti}/omap/Makefile (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_vout.c (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.c (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.h (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_voutdef.h (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_voutlib.c (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_voutlib.h (100%)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 22d462f43a21..57094394d30b 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -81,7 +81,6 @@ source "drivers/media/platform/mediatek/mtk-vpu/Kconfig"
 source "drivers/media/platform/nvidia/tegra-vde/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
 source "drivers/media/platform/nxp/amphion/Kconfig"
-source "drivers/media/platform/omap/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
 source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/Kconfig"
@@ -96,6 +95,7 @@ source "drivers/media/platform/sti/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/ti/am437x/Kconfig"
 source "drivers/media/platform/ti/davinci/Kconfig"
+source "drivers/media/platform/ti/omap/Kconfig"
 source "drivers/media/platform/ti/omap3isp/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index ef6c00b2ed64..a9740f6021d2 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -21,7 +21,6 @@ obj-y += mediatek/mtk-vpu/
 obj-y += nvidia/tegra-vde/
 obj-y += nxp/
 obj-y += nxp/amphion/
-obj-y += omap/
 obj-y += qcom/camss/
 obj-y += qcom/venus/
 obj-y += renesas/
@@ -41,6 +40,7 @@ obj-y += sti/stm32/
 obj-y += ti-vpe/
 obj-y += ti/am437x/
 obj-y += ti/davinci/
+obj-y += ti/omap/
 obj-y += ti/omap3isp/
 obj-y += via/
 obj-y += xilinx/
diff --git a/drivers/media/platform/omap/Kconfig b/drivers/media/platform/ti/omap/Kconfig
similarity index 100%
rename from drivers/media/platform/omap/Kconfig
rename to drivers/media/platform/ti/omap/Kconfig
diff --git a/drivers/media/platform/omap/Makefile b/drivers/media/platform/ti/omap/Makefile
similarity index 100%
rename from drivers/media/platform/omap/Makefile
rename to drivers/media/platform/ti/omap/Makefile
diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/ti/omap/omap_vout.c
similarity index 100%
rename from drivers/media/platform/omap/omap_vout.c
rename to drivers/media/platform/ti/omap/omap_vout.c
diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/media/platform/ti/omap/omap_vout_vrfb.c
similarity index 100%
rename from drivers/media/platform/omap/omap_vout_vrfb.c
rename to drivers/media/platform/ti/omap/omap_vout_vrfb.c
diff --git a/drivers/media/platform/omap/omap_vout_vrfb.h b/drivers/media/platform/ti/omap/omap_vout_vrfb.h
similarity index 100%
rename from drivers/media/platform/omap/omap_vout_vrfb.h
rename to drivers/media/platform/ti/omap/omap_vout_vrfb.h
diff --git a/drivers/media/platform/omap/omap_voutdef.h b/drivers/media/platform/ti/omap/omap_voutdef.h
similarity index 100%
rename from drivers/media/platform/omap/omap_voutdef.h
rename to drivers/media/platform/ti/omap/omap_voutdef.h
diff --git a/drivers/media/platform/omap/omap_voutlib.c b/drivers/media/platform/ti/omap/omap_voutlib.c
similarity index 100%
rename from drivers/media/platform/omap/omap_voutlib.c
rename to drivers/media/platform/ti/omap/omap_voutlib.c
diff --git a/drivers/media/platform/omap/omap_voutlib.h b/drivers/media/platform/ti/omap/omap_voutlib.h
similarity index 100%
rename from drivers/media/platform/omap/omap_voutlib.h
rename to drivers/media/platform/ti/omap/omap_voutlib.h
-- 
2.35.1

