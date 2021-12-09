Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975B846E510
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhLIJJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhLIJIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43921C0698C5;
        Thu,  9 Dec 2021 01:05:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10C1DB823F5;
        Thu,  9 Dec 2021 09:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3C2C341CC;
        Thu,  9 Dec 2021 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639040710;
        bh=5QCuzqHM21YzM/FzKde2w/D1g6ZloHN6p+IE4Gqk6DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxk0jmWosXjEYMvBR2miC/9dX7bB1ZdqcNpX0983WEGSxaOZGNByAkKjwGDrssbmf
         m+FIIx602i5RPySVCVC1YZReGgDZPfwjy5wgddRaHXd56U1aQ53uopAvVxD7VCXHQx
         9PofJ0GPl/Km4deEr0oZeF+FzxZZoQ+UL5eA70aHZl/DuSzKcdCH6hXRGmB2uabzQW
         tUWwfDzul7Sysp/X12bFm74Y6bYBERxTwRKWsch4lABbsjWLZhZ17l23Dh9Mse7gKo
         hS3OXsXsTjB9hfOUOOXtr/PGPDxLX6Q2WZ1ljMjRxHqqg4/wKiEiL5CLwpcDOgd/bl
         it0vEJNPBQ7lg==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     vigneshr@ti.com, kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 2/6] mtd: rawnand: omap2: Allow build on K3 platforms
Date:   Thu,  9 Dec 2021 11:04:54 +0200
Message-Id: <20211209090458.24830-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209090458.24830-1-rogerq@kernel.org>
References: <20211209090458.24830-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K3 platforms come with GPMC. Enable GPMC build for
K3 platforms.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 67b7cb67c030..d719316467a1 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -40,7 +40,7 @@ config MTD_NAND_AMS_DELTA
 
 config MTD_NAND_OMAP2
 	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
-	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
+	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  Support for NAND flash on Texas Instruments OMAP2, OMAP3, OMAP4
-- 
2.17.1

