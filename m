Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3716F47B8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 04:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhLUD1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:27:31 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:49377 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229602AbhLUD1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:27:30 -0500
X-QQ-mid: bizesmtp54t1640057229ty4nk7ad
Received: from localhost.localdomain (unknown [182.148.14.81])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 21 Dec 2021 11:27:07 +0800 (CST)
X-QQ-SSF: 01000000000000B0D000B00A0000000
X-QQ-FEAT: PdU/eI8FBMDN3cWF//zk6F7BwJpO7VkR3CPKBKr+K25EmTb69UlggmcCDYbor
        8L/oWjt3FuZhaOrB1BqyjOkawjPi3c/xlVKOLx5lGIOcl14+XOto2N7IMVP0M9r8mKZc1sQ
        F1hPp8gBNB0m1DWTCses2Cqm02kAQR6oAFFkj7hl+vIOfbSIWn9oWWjHWHkOraZ6cJmRHiz
        lVj8l89zSSmvWduWnskr2jdUydshW+lskPcS45r/EfsAUToL+aRABZTE7CvWuJ67bpDtHEo
        s2UNofS8cqtVsq1ebIzbp9of9Yxaf29UK9abqkj8h516A7aPFxYC0WmE9CLRdCJcradkuy0
        hO3eHxV
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] perf tools: Fix typo in a comment
Date:   Tue, 21 Dec 2021 11:27:00 +0800
Message-Id: <20211221032700.35977-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `and' in a comment is repeated, thus it should be removed.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2f1d20553a0a..c1ef5000ab1b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2735,7 +2735,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 
 		/*
 		 * Suppress this argument if its value is zero and
-		 * and we don't have a string associated in an
+		 * we don't have a string associated in an
 		 * strarray for it.
 		 */
 		if (val == 0 &&
-- 
2.34.1

