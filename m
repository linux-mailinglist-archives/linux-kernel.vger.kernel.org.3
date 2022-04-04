Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6344F1ECE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347376AbiDDV4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379539AbiDDR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:26:26 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10BCE31909;
        Mon,  4 Apr 2022 10:24:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200"; 
   d="scan'208";a="116711391"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Apr 2022 02:24:29 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9E2D440B0B0A;
        Tue,  5 Apr 2022 02:24:27 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-mmc@vger.kernel.org
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] mmc: renesas_internal_dmac: Fix typo's
Date:   Mon,  4 Apr 2022 18:23:22 +0100
Message-Id: <20220404172322.32578-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 1685df00863b..b468368a4539 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -310,7 +310,7 @@ renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host) {
 }
 
 /*
- * renesas_sdhi_internal_dmac_map() will be called with two difference
+ * renesas_sdhi_internal_dmac_map() will be called with two different
  * sg pointers in two mmc_data by .pre_req(), but tmio host can have a single
  * sg_ptr only. So, renesas_sdhi_internal_dmac_{un}map() should use a sg
  * pointer in a mmc_data instead of host->sg_ptr.
@@ -344,7 +344,7 @@ renesas_sdhi_internal_dmac_map(struct tmio_mmc_host *host,
 
 	data->host_cookie = cookie;
 
-	/* This DMAC cannot handle if buffer is not 128-bytes alignment */
+	/* This DMAC cannot handle if buffer is not 128-bytes aligned */
 	if (!IS_ALIGNED(sg_dma_address(data->sg), 128)) {
 		renesas_sdhi_internal_dmac_unmap(host, data, cookie);
 		return false;
-- 
2.17.1

