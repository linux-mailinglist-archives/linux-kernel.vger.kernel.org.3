Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C632484BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 02:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiAEBJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 20:09:54 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46972 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233194AbiAEBJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:09:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V1-ZxNx_1641344990;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1-ZxNx_1641344990)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 09:09:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     bigeasy@linutronix.de
Cc:     rafael.j.wysocki@intel.com, stern@rowland.harvard.edu,
        valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] notifier: Fix some kernel-doc comments
Date:   Wed,  5 Jan 2022 09:09:48 +0800
Message-Id: <20220105010948.49695-1-yang.lee@linux.alibaba.com>
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
 kernel/notifier.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/notifier.c b/kernel/notifier.c
index ba005ebf4730..52b417951c0a 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -59,8 +59,6 @@ static int notifier_chain_unregister(struct notifier_block **nl,
  *			value of this parameter is -1.
  *	@nr_calls:	Records the number of notifications sent. Don't care
  *			value of this field is NULL.
- *	@returns:	notifier_call_chain returns the value returned by the
- *			last notifier function called.
  */
 static int notifier_call_chain(struct notifier_block **nl,
 			       unsigned long val, void *v,
@@ -102,7 +100,7 @@ NOKPROBE_SYMBOL(notifier_call_chain);
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

