Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750624A55CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 05:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiBAEEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 23:04:39 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41891 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229654AbiBAEEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 23:04:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V3MZ6Gv_1643688273;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V3MZ6Gv_1643688273)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Feb 2022 12:04:34 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     eajames@linux.ibm.com
Cc:     mchehab@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        jammy_huang@aspeedtech.com, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] media: aspeed: Remove duplicated include in aspeed-video.c
Date:   Tue,  1 Feb 2022 12:04:31 +0800
Message-Id: <20220201040431.9881-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following includecheck warning:
./drivers/media/platform/aspeed-video.c: linux/videodev2.h is included
more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/platform/aspeed-video.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 51fb18453b81..53409d86fe44 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -32,7 +32,6 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-dma-contig.h>
-#include <linux/videodev2.h>
 
 #define DEVICE_NAME			"aspeed-video"
 
-- 
2.20.1.7.g153144c

