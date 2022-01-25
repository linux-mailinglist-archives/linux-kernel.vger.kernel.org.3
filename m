Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA73D49A809
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316030AbiAYCzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:55:04 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34034 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S3410177AbiAYA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:28:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V2nnv0z_1643070520;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V2nnv0z_1643070520)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Jan 2022 08:28:41 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mchehab@kernel.org
Cc:     matthias.bgg@gmail.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] media: mtk-vcodec: Remove duplicated include in mtk_vcodec_enc_drv.c
Date:   Tue, 25 Jan 2022 08:28:39 +0800
Message-Id: <20220125002839.92004-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following includecheck warning:
./drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c:
linux/pm_runtime.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 507ad1ea2104..a3870628c9f0 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -15,7 +15,6 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
-#include <linux/pm_runtime.h>
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
-- 
2.20.1.7.g153144c

