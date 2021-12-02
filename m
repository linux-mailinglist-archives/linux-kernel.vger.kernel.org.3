Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C1D465C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354372AbhLBCTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:19:48 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48504 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354342AbhLBCTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:19:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uz6wKRb_1638411366;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uz6wKRb_1638411366)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 10:16:09 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] script/sorttable: code style improvements
Date:   Thu,  2 Dec 2021 10:16:06 +0800
Message-Id: <20211202021606.48812-3-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211202021606.48812-1-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211202021606.48812-1-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modified the code style issue of if() {},
keep the code style consistent.

Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
---
 scripts/sorttable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a7a5b8078954..7d51e53ba6aa 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -462,11 +462,11 @@ static int do_sort(Elf_Ehdr *ehdr,
 		void *retval = NULL;
 		/* wait for ORC tables sort done */
 		rc = pthread_join(orc_sort_thread, &retval);
-		if (rc)
+		if (rc) {
 			fprintf(stderr,
 				"pthread_join failed '%s': %s\n",
 				strerror(errno), fname);
-		else if (retval) {
+		} else if (retval) {
 			rc = -1;
 			fprintf(stderr,
 				"failed to sort ORC tables '%s': %s\n",
-- 
2.19.1.6.gb485710b

