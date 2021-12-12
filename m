Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EAE471AC7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhLLOcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:32:54 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:54047 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231406AbhLLOcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:32:53 -0500
X-QQ-mid: bizesmtp50t1639319555t1akmfe7
Received: from wangx.lan (unknown [171.221.148.2])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 22:32:27 +0800 (CST)
X-QQ-SSF: 0100000000200080C000000A0000000
X-QQ-FEAT: Ut0pB98mtT9mtSCSBynrgk0hwtA6k7NbxMkVVaLjQ4MlY6St+ei8ddVcoXZ0Q
        2TpYu5xuZ4bHhQ98lmbzEfbeAOd2P4CuR3ZO0zmZR/pu1jYuT569dIh/nnCPv0avs91az0v
        t7SQjItTPHq/2X/ElEf4NUIZrlzF/fd+kRtR0u9sCF6/98Z4+GtZXyKFagVicc+86oSWjt/
        hlzX06XPfaSseHnWD6qxCqir8m/VdLbG1cEzZEA6ZNkTjJ4K7r8DZQuk7AIkiyFJnN4wLzD
        mdGqiXL3WHZrh+yY14CrzmMqsyF6yeeNlW0uEvjQP3DZJ3Od6tTFJ4vo/+7gOFQJghbV+zv
        drLmotkrWn9TS7XxOWF9q14JGcckptdu+zylFN5
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     john.stultz@linaro.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] time/timekeeping: Fix syntax errors in comments
Date:   Sun, 12 Dec 2021 22:32:25 +0800
Message-Id: <20211212143225.13727-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'time'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b348749a9fc6..b1fbedd35300 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1148,7 +1148,7 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
 			return ret;
 	}
 
-	/* Fixup monotonic raw and real time time values */
+	/* Fixup monotonic raw and real time values */
 	if (interp_forward) {
 		ts->sys_monoraw = ktime_add_ns(history->raw, corr_raw);
 		ts->sys_realtime = ktime_add_ns(history->real, corr_real);
-- 
2.20.1

