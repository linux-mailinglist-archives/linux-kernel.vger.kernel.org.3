Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF346E516
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhLIJJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhLIJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:09:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F916C0698D9;
        Thu,  9 Dec 2021 01:05:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37F9CB823F5;
        Thu,  9 Dec 2021 09:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EB7C341CB;
        Thu,  9 Dec 2021 09:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639040716;
        bh=RreclebAyHQqrP6cf15289fjcLo5PLKZjSo7S8zyp+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+JhUio54KR611gjeoZ/uV2RbcO6flR5mWFyspAC0QH27/sdcJCR81Lk/VRNyHn8Z
         UbGqgI2jbzn1NrgKHE+LbR2Fw5egU/aP64fuwnAip5IkQOl1U57748SjM0Rg2Gz6Qj
         1xvcXbnTh9WcIuBxLGMTfZGZdNs6yO3jmKaOQM3SZXLqyCs2VjFQZLN1JWiceLBamW
         P7w1ruBHu/amYZ6ZADS/sG5XzjevwqPOkIX4pDnROu+7NpRFwyOdmbC27WiwRkijfv
         NZiZWIlaAd6OtGz3Y7uv4URMEpK0TetLrYkvo71Ic0OE4OMcvvEjF/XJs6Dthfmd/k
         C63lNAN8mCe4w==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     vigneshr@ti.com, kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 4/6] mtd: rawnand: omap2: Add compatible for AM64 SoC
Date:   Thu,  9 Dec 2021 11:04:56 +0200
Message-Id: <20211209090458.24830-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209090458.24830-1-rogerq@kernel.org>
References: <20211209090458.24830-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 SoC contains the GPMC NAND controller. Add compatible for it.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/omap2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 224c91282c87..0c7ee26171ad 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2286,6 +2286,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 
 static const struct of_device_id omap_nand_ids[] = {
 	{ .compatible = "ti,omap2-nand", },
+	{ .compatible = "ti,am64-nand", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_nand_ids);
-- 
2.17.1

