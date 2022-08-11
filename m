Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AB158FC07
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiHKMQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiHKMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:16:14 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF11267150;
        Thu, 11 Aug 2022 05:16:11 -0700 (PDT)
X-QQ-mid: bizesmtp68t1660220157t5dpm7km
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:15:56 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: zT6n3Y95oi1uXJeIJOIPYFHk21dy5wfcO9D4iGPpg1bI/kWDUsC4oM0APLJTV
        miaxX2WsrwHo4wZZF5Us1zEKgAxQ2fUocyBnxyLUn2AGgAS6vVVkJ2qrMgLBDebcYGMTZo0
        pmuIo1NkiVg6UsqaGn9WD5wSROQAlPeVb3SqTxQToLe+TtnyuvlkOyMJ4TORKlvefReWB0M
        bfilwLpBohk8UdQgH/Z2kRxPhI7eLbe9PIusLdfEWO/kiWRx62HEVacfYZyTbL5WXi68eve
        3BZ7gD23HYDNY+m7vTkrOKIhMpqzCDYS+EDFxjLIv/Z8l6QWHqp+If8DjxnvFgCGELrQsoJ
        ZXspCG94XoTaM+JhTRR3+vjdH1pxsBUIMZcS5Y3DOx2I0+uNaOp4J+q9rQ4MjtTg9j/zJiR
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     svens@linux.ibm.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, tmricht@linux.ibm.com,
        sumanthk@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] s390/cpumf: Fix comment typo
Date:   Thu, 11 Aug 2022 20:15:49 +0800
Message-Id: <20220811121549.25094-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/s390/kernel/perf_cpum_sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 332a49965130..0fda19b1e21d 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1160,7 +1160,7 @@ static void perf_event_count_update(struct perf_event *event, u64 count)
  * combined-sampling data entry consists of a basic- and a diagnostic-sampling
  * data entry.	The sampling function is determined by the flags in the perf
  * event hardware structure.  The function always works with a combined-sampling
- * data entry but ignores the the diagnostic portion if it is not available.
+ * data entry but ignores the diagnostic portion if it is not available.
  *
  * Note that the implementation focuses on basic-sampling data entries and, if
  * such an entry is not valid, the entire combined-sampling data entry is
-- 
2.36.1

