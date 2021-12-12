Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47508471800
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhLLD37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:29:59 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:24691 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229930AbhLLD36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:29:58 -0500
X-QQ-mid: bizesmtp41t1639279791t8qegwc7
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 11:29:50 +0800 (CST)
X-QQ-SSF: 01000000002000D0H000B00A0000000
X-QQ-FEAT: 3u0oYPVhaePrOG/sBsHqkrH/FYHPOZ/o5p2Cy2ToBFf3fFkVt7U0IBRu+2g12
        KPeAD0V7QBWsIX5SrdgPbOhzek/YIenU3qtW+FsbhMKUsNIc7R+w5ziCd4WLif2RqP2P2fb
        7pHdDeBeUnPVfajjAxiBmtnckOQleFd2pJRX4k4UF/fR1EevnFvNxRT/+fcKJWqfTbvh2eV
        bFKF/7PJHETkXf2XVEfn3Ty4PAwIa5n9LJ3vsDfPz1MzqK31bqQPUaEppKEH/AU6g7RxUK1
        AFwU5gsQ6uyQd03BWTFkKLiwLUAwLUJ1dhboWYp+48Jf3pVFrgFuM1TdCSZvToDnKDVAKOF
        4rit0IM+wbNWAozhZD0Mr5EC/g8gbAuAULLd9Px
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] cpuidle/coupled: fix typo in a comment
Date:   Sun, 12 Dec 2021 11:29:48 +0800
Message-Id: <20211212032948.61115-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `are' in the comment in line 57 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/cpuidle/coupled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 74068742cef3..9acde71558d5 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -54,7 +54,7 @@
  * variable is not locked.  It is only written from the cpu that
  * it stores (or by the on/offlining cpu if that cpu is offline),
  * and only read after all the cpus are ready for the coupled idle
- * state are are no longer updating it.
+ * state are no longer updating it.
  *
  * Three atomic counters are used.  alive_count tracks the number
  * of cpus in the coupled set that are currently or soon will be
-- 
2.34.1


