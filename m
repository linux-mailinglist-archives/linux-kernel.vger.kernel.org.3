Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5871455528B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiFVRgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbiFVRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:36:35 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0D29326D8;
        Wed, 22 Jun 2022 10:36:34 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,212,1650898800"; 
   d="scan'208";a="125313337"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jun 2022 02:36:33 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4591A40108F5;
        Thu, 23 Jun 2022 02:36:30 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/2] mmc: renesas_sdhi: Fix typo's
Date:   Wed, 22 Jun 2022 18:36:14 +0100
Message-Id: <20220622173614.12778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220622173614.12778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220622173614.12778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo's,
* difference -> different
* alignment -> aligned

While at it replaced 128-bytes -> 128 byte.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 3084b15ae2cb..4eb65b3c36bb 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -321,7 +321,7 @@ renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host)
 }
 
 /*
- * renesas_sdhi_internal_dmac_map() will be called with two difference
+ * renesas_sdhi_internal_dmac_map() will be called with two different
  * sg pointers in two mmc_data by .pre_req(), but tmio host can have a single
  * sg_ptr only. So, renesas_sdhi_internal_dmac_{un}map() should use a sg
  * pointer in a mmc_data instead of host->sg_ptr.
@@ -355,7 +355,7 @@ renesas_sdhi_internal_dmac_map(struct tmio_mmc_host *host,
 
 	data->host_cookie = cookie;
 
-	/* This DMAC cannot handle if buffer is not 128-bytes alignment */
+	/* This DMAC cannot handle if buffer is not 128 byte aligned */
 	if (!IS_ALIGNED(sg_dma_address(data->sg), 128)) {
 		renesas_sdhi_internal_dmac_unmap(host, data, cookie);
 		return false;
-- 
2.17.1

