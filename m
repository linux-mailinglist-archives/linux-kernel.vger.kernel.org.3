Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336714D89A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbiCNQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbiCNQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ADB31216;
        Mon, 14 Mar 2022 09:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0DAB61494;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5606C36AF8;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=HLc4jvOCekbQHiN+36Yh/cdxMFHz8dNm6MrTTyNtl88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtWNVztgazkG9qqSI/dl2jT2uljqsuARQiK6gx+apcps6CrcUyb0hvNTS8CSQ5Tdu
         MLlH/rY6Hc9Lx5EJTNWFf+u2Oqu5IP/wVeYQHX4a0VacINZdcNrr/HZENZyayn9gfi
         Y6l5lB/N8vXD5EptAWFADOgOorasTviPsyDq86IZGRMQDNQoHgfBlc2ZdFbTRiaTh5
         PgQvO4z4qjmDNdo9wpyFuwd+VgG6glZH1nE+MTamt8x9FrK+cFZcCJyHlNuG5ogtnm
         OY9ZhceLa5cBTdp+CXDu3SDyCRD0ep53D7rOu38Gk1qbJWDefGUv2Cjm/OFZsrLO73
         GsG5GXtFXpebQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf1-001x3s-LF; Mon, 14 Mar 2022 17:35:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 62/67] media: platform: ti/Kconfig: move VPE/CAL entries to it
Date:   Mon, 14 Mar 2022 17:34:57 +0100
Message-Id: <19dfb55be38c6937ffec07dc4e7cd4cf212c6bb9.1647274407.git.mchehab@kernel.org>
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

In order to follow the changes made by the previous patch,
which moved platform/ti-vpe to platform/ti, move the Kconfig
entries to the same place.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/{ti-vpe => ti}/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
 rename drivers/media/platform/{ti-vpe => ti}/Kconfig (94%)

diff --git a/drivers/media/platform/ti-vpe/Kconfig b/drivers/media/platform/ti/Kconfig
similarity index 94%
rename from drivers/media/platform/ti-vpe/Kconfig
rename to drivers/media/platform/ti/Kconfig
index a9ee0189f2f2..82e285c2de64 100644
--- a/drivers/media/platform/ti-vpe/Kconfig
+++ b/drivers/media/platform/ti/Kconfig
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+comment "Texas Instruments drivers"
+
 # TI VIDEO PORT Helper Modules
 # These will be selected by VPE and VIP
 config VIDEO_TI_VPDMA
@@ -15,7 +17,7 @@ config VIDEO_TI_CSC
 
 config VIDEO_TI_CAL
 	tristate "TI CAL (Camera Adaptation Layer) driver"
-	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on VIDEO_DEV
 	depends on V4L_PLATFORM_DRIVERS
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
@@ -44,7 +46,7 @@ config VIDEO_TI_CAL_MC
 config VIDEO_TI_VPE
 	tristate "TI VPE (Video Processing Engine) driver"
 	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on VIDEO_DEV
 	depends on SOC_DRA7XX || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
-- 
2.35.1

