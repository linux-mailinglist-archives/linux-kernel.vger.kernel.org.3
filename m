Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC946F9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbhLJEcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:32:46 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49759 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234318AbhLJEco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:32:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V-7Yjgd_1639110530;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V-7Yjgd_1639110530)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 12:29:08 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rafael@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] cpuidle: Fix kernel-doc
Date:   Fri, 10 Dec 2021 12:28:48 +0800
Message-Id: <20211210042849.79924-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in sysfs.c kernel-doc comment
to remove a warning found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

drivers/cpuidle/sysfs.c:512: warning: expecting prototype for
cpuidle_remove_driver_sysfs(). Prototype was for
cpuidle_remove_state_sysfs() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/cpuidle/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 469e18547d06..e708e593db88 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -505,7 +505,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 }
 
 /**
- * cpuidle_remove_driver_sysfs - removes the cpuidle states sysfs attributes
+ * cpuidle_remove_state_sysfs - removes the cpuidle states sysfs attributes
  * @device: the target device
  */
 static void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
-- 
2.20.1.7.g153144c

