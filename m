Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750BB4717EC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhLLDHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:07:13 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:59739 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232503AbhLLDHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:07:12 -0500
X-QQ-mid: bizesmtp46t1639278425tke52wg3
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 11:07:03 +0800 (CST)
X-QQ-SSF: 01000000002000D0H000B00A0000000
X-QQ-FEAT: opOEk+37y/xdMGsA7kIbW+FBz+coLKZWrSaq+Hvn9QJatP7NSNLQWZrnrZZvV
        VX1kPBgg5ASG4hCsyMrUGoqo3aC0fko8+aUpUkAZCFZRkRVoD8fqUxbshFPmQ59Zi7KXYjs
        tA9xYT0VmmoFlEkvV74QNYD7Pn30xqMQdn2u5OKiQ5s/5XAQFBztofmg6zOdtOarpeNbOhV
        BA3w6lG27spyLZ92iXc+2zC0ZnUoRhtrwrVSrArJtGYsr5o2YjRvMBdBH8tEOXKpp+hhqNB
        zaMoPD6eTtEdz4wAv7JuGBjOeQZFFW5aRxVod+t5nlmSNpzEXQbQ9RPIlS9EvRidgu+eUhN
        JpDN/MD59dUcaa/+Z0=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] powercap: fix typo in a comment
Date:   Sun, 12 Dec 2021 11:06:40 +0800
Message-Id: <20211212030640.25486-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in the comment in line 15 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/powercap/idle_inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 6e1a0043c411..a20bf12f3ce3 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -12,7 +12,7 @@
  *
  * All of the kthreads used for idle injection are created at init time.
  *
- * Next, the users of the the idle injection framework provide a cpumask via
+ * Next, the users of the idle injection framework provide a cpumask via
  * its register function. The kthreads will be synchronized with respect to
  * this cpumask.
  *
-- 
2.34.1

