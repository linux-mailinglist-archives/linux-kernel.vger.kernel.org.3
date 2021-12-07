Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB346BEF8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhLGPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:17:25 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44480 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229485AbhLGPRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:17:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UzneqvB_1638890029;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0UzneqvB_1638890029)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Dec 2021 23:13:51 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] script/sorttable: code style improvements
Date:   Tue,  7 Dec 2021 23:13:47 +0800
Message-Id: <20211207151348.54921-3-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211207151348.54921-1-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211207151348.54921-1-yinan@linux.alibaba.com>
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
index d1fbee1f81ef..1e8b77928fa4 100644
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
2.27.0

