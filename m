Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2BC486EC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbiAGA2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:28:31 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60476 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343753AbiAGA2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:28:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V17mJbt_1641515308;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V17mJbt_1641515308)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jan 2022 08:28:29 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     robh+dt@kernel.org
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] of: unittest: remove unneeded semicolon
Date:   Fri,  7 Jan 2022 08:28:26 +0800
Message-Id: <20220107002826.77939-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/of/unittest.c:1961:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/of/unittest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index ab4f61cc6a95..70992103c07d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1958,7 +1958,7 @@ static void of_unittest_remove_tracked_overlays(void)
 				__func__, overlay_name, ret);
 		}
 		of_unittest_untrack_overlay(save_ovcs_id);
-	};
+	}
 
 }
 
-- 
2.20.1.7.g153144c

