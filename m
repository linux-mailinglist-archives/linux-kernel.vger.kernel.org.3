Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E2D591B55
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiHMPVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiHMPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:21:50 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1566E14D10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:21:48 -0700 (PDT)
X-QQ-mid: bizesmtp67t1660404092tf92fl03
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 13 Aug 2022 23:21:24 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: LE7C6P2vL8T+s3sonMkFf/rAL+0AqqSci5O9kSihS3FOgdkd8IC3qJ6+yvHgJ
        DZ2t9QYQQvU71Dfs5YKLaHBfiUXVCu+A+NQHr6uFPsqebYimDcG2LOS0WNipLqoLE+QYJ4Y
        Wy2pjOTmrvIs41Rkdj0aDoQhILMdbGmxMXJLTNKgLZCC1I9DxZbklod39y/JQS4pIVvqEhI
        /akEj58HEHoN1Z1o0VLBhfTXSv23HLFcheedvEEYXm2bCvozxebTrgUEikG4tnqdjb4SYuF
        qywyOp9eRd9Oac5VWlVJWCqcGdhy9v6HJqPsbou7Q8RWb4qkwUTyxN0p0YMnUagEg/tpJ4E
        5l8W5AHUln3I5c0xS8plq/Vn308fIBIDkPG3xrTH+rEGceZ7Vw23qGSQBBLXg==
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] sched/core: Unneeded semicolon
Date:   Sat, 13 Aug 2022 23:21:12 +0800
Message-Id: <20220813152112.4341-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no semicolon after '}' in line 208.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 kernel/sched/core_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 38a2cec21014..8d2dc54043de 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -204,7 +204,7 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	default:
 		err = -EINVAL;
 		goto out;
-	};
+	}
 
 	if (type == PIDTYPE_PID) {
 		__sched_core_set(task, cookie);
-- 
2.17.1

