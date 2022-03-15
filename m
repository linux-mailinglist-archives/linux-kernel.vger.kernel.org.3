Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D0A4D9451
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbiCOGHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243546AbiCOGHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:07:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E779D49F0A;
        Mon, 14 Mar 2022 23:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A883B80F96;
        Tue, 15 Mar 2022 06:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0C8C340E8;
        Tue, 15 Mar 2022 06:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647324361;
        bh=QZSeIPPqcpDbCmahkEFz7bv6hHEXwmVyN9YGitV6Xok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qC+o4y5XvxZV+TDdT9Moc9Y7mKtW5Jx4N1/HMZ1gnpLFbCNQAHo6ZtWNEPll4kiay
         1d4b+b3Cummwbsp0D1Q31PnsWomNA11CyLvNsvmhWxb/N5aR7RFqYnaeU6CynL+5kg
         abLsoId0YHJF7g24hebZCyJkcLZ6DpkLOxnhpzBJHMFaqLvLoGMm8ZUFyiih9UalHS
         Fcrkys2LCuJMXzLSx7Vs42SG+VXx/nujoPXbIPXRTJgnAhOFYob2vAxbU2L124pwKc
         leN5CFuSnrWDwqTWfRzOKgsMiOJlgYAUueJdmGkQy+pzTV7hSF/NmBtDMyXLxXiOsb
         mttwe27roQXZA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nU0Ji-002BxR-Sp; Tue, 15 Mar 2022 07:05:58 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 2/2] media: spi: Kconfig: Place SPI drivers on a single menu
Date:   Tue, 15 Mar 2022 07:05:57 +0100
Message-Id: <7064723b900730175fbeabf5d696ec21ee70b418.1647324346.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <f2d22b8cdf095b6b907eafa1b92c8c3a046b61be.1647324346.git.mchehab@kernel.org>
References: <f2d22b8cdf095b6b907eafa1b92c8c3a046b61be.1647324346.git.mchehab@kernel.org>
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

It makes no sense to have two menus for SPI drivers, each
one with a single driver. Merge them and keep the Kconfig
sorted.

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/spi/Kconfig | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/media/spi/Kconfig b/drivers/media/spi/Kconfig
index 01e4e6cce027..4656afae5bb4 100644
--- a/drivers/media/spi/Kconfig
+++ b/drivers/media/spi/Kconfig
@@ -1,25 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
-if VIDEO_DEV
+if VIDEO_DEV && SPI
 
 comment "SPI I2C drivers auto-selected by 'Autoselect ancillary drivers'"
 	depends on MEDIA_HIDE_ANCILLARY_SUBDRV && SPI
 
-menu "SPI helper chips"
-	visible if !MEDIA_HIDE_ANCILLARY_SUBDRV
-
-config VIDEO_GS1662
-	tristate "Gennum Serializers video"
-	depends on SPI && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  Enable the GS1662 driver which serializes video streams.
-
-endmenu
-
-endif
-
-if SPI
 menu "Media SPI Adapters"
 
 config CXD2880_SPI_DRV
@@ -29,6 +13,14 @@ config CXD2880_SPI_DRV
 	help
 	  Choose if you would like to have SPI interface support for Sony CXD2880.
 
+config VIDEO_GS1662
+	tristate "Gennum Serializers video"
+	depends on SPI && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  Enable the GS1662 driver which serializes video streams.
+
 endmenu
 
 endif
-- 
2.35.1

