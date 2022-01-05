Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283F4484C95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiAECxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:53:00 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:21069 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229584AbiAECw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:52:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V1-aAns_1641351175;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1-aAns_1641351175)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 10:52:56 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rdunlap@infradead.org, bigeasy@linutronix.de
Cc:     rafael.j.wysocki@intel.com, stern@rowland.harvard.edu,
        valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] notifier: Fix some kernel-doc comments
Date:   Wed,  5 Jan 2022 10:52:45 +0800
Message-Id: <20220105025245.29015-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.
kernel/notifier.c:68: warning: Excess function parameter 'returns'
description in 'notifier_call_chain'
kernel/notifier.c:116: warning: Function parameter or member 'v' not
described in 'notifier_call_chain_robust'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/notifier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index ba005ebf4730..0e3fef8ff816 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -59,8 +59,7 @@ static int notifier_chain_unregister(struct notifier_block **nl,
  *			value of this parameter is -1.
  *	@nr_calls:	Records the number of notifications sent. Don't care
  *			value of this field is NULL.
- *	@returns:	notifier_call_chain returns the value returned by the
- *			last notifier function called.
+ *	Return:		the value returned by the last notifier function called.
  */
 static int notifier_call_chain(struct notifier_block **nl,
 			       unsigned long val, void *v,
@@ -102,7 +101,7 @@ NOKPROBE_SYMBOL(notifier_call_chain);
  * @val_up:	Value passed unmodified to the notifier function
  * @val_down:	Value passed unmodified to the notifier function when recovering
  *              from an error on @val_up
- * @v		Pointer passed unmodified to the notifier function
+ * @v:		Pointer passed unmodified to the notifier function
  *
  * NOTE:	It is important the @nl chain doesn't change between the two
  *		invocations of notifier_call_chain() such that we visit the
-- 
2.20.1.7.g153144c

