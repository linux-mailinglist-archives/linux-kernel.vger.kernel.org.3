Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FBE476CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhLPJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:11:10 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43373 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232874AbhLPJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:11:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-oH6cw_1639645859;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V-oH6cw_1639645859)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Dec 2021 17:11:05 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     paulmck@kernel.org
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] rcu/nocb: clean up some inconsistent indenting
Date:   Thu, 16 Dec 2021 17:10:57 +0800
Message-Id: <20211216091057.28675-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

kernel/rcu/tree_nocb.h:1262 rcu_spawn_cpu_nocb_kthread() warn:
inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/rcu/tree_nocb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index dd4753219dca..936badfffcee 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1259,7 +1259,8 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 		}
 		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
 	}
-	 mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
+
+	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
 
 	/* Spawn the kthread for this CPU. */
 	t = kthread_run(rcu_nocb_cb_kthread, rdp,
-- 
2.20.1.7.g153144c

