Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDAC579834
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiGSLL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiGSLLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:11:25 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C93A32BA7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:11:17 -0700 (PDT)
X-QQ-mid: bizesmtp82t1658229053tvikeula
Received: from harry-jrlc.. ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 19:10:45 +0800 (CST)
X-QQ-SSF: 0100000000600030C000B00A0000020
X-QQ-FEAT: sxL8zoGpsGeZDDSqZrLEZdJyVF+ZNsb/wAe8uGZJl6H9ScKdXB3WYaVRP5qSw
        dwGyA+CsdugVfPVuuZaqk2PwqRXHQykRK+f46T4BXiDCvpuI+kFLtFRwlJz+OboWKQLL67F
        VEYwBe/RYxYpM1Vp1oMSVcYRx+PKtDSKte58UM07TlDiHVcVnTWJdnI9UwT16zzc75S9gN8
        BZdbraPin8bItv18yqMdRg6gCT4FMcaFAr8NYeE9QwXTSOKjrSOI4/Tha5pDmeyyVk69RPU
        jNoUfDcuPmbrFVRmHe32o4Lx40xRx/RK0jWHn7A6F42kNTMRRg7LcwbXLl5Abq7RJx9Waed
        UqOtFmgbO3g2Omz3fAEqMShq92tLVQ60/II6XOaJt8hlC5cb+HQhq/GvjUSAkyUcCdaF5OI
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] sched:Unneeded semicolon
Date:   Tue, 19 Jul 2022 19:10:44 +0800
Message-Id: <20220719111044.7095-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unneeded semicolon

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
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
2.30.2

