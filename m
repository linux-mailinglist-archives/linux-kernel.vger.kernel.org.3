Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DB94D898F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbiCNQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbiCNQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49AC21E27;
        Mon, 14 Mar 2022 09:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 677F06138B;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A283C36B0E;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=SpPr2lerPnw32f/oo2meeT4LKxL8ie8JCciAY4xJDAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/LnPyFxtDntOYigyp1UIE8sHpu6PIacEmKyi8vM6GSPqRpv6i9kEqv9XZ57VMWOv
         SJmlmm9lYzaWQZ6aSL8v+mmnA/gcJkqiOwqd95HeT40Tdt+SZi3TnrWkFAd1VGAxhI
         CHNIBvvYx3tjXnnjO117QKEewDfcu6UTv6mG3xHu7PKVU32tSXKjVvic4dFtPQATzA
         EN5uZsZvzlHRcqbzv4wVozv/oGMdpgzknQ1g73TyEjD8jfTasZEdG87YFlAidR5tmX
         HAPQs0TsSZB82c2c8d1vsFIEyCmq9CGXHoEbQdiO3tgovMLZiaadlagff77gB5VjtW
         By9ISrFnCY8Aw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf1-001wzU-0h; Mon, 14 Mar 2022 17:35:07 +0100
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
Subject: [PATCH v2 52/67] media: platform: rename s5p-g2d/ to samsung/s5p-g2d/
Date:   Mon, 14 Mar 2022 17:34:47 +0100
Message-Id: <a26328cf8c9aaa8b5052102f205f1cfce6d69d2c.1647274407.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647274406.git.mchehab@kernel.org>
References: <cover.1647274406.git.mchehab@kernel.org>
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
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

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
index 80f2a0eea3f7..4b03db9ee31e 100644
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
index aed4394ddd05..8dd178e1a359 100644
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
index cb5e6d1df248..aa822365d8d0 100644
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

