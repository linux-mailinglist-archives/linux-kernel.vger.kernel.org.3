Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED25AA513
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiIBBan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiIBBaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:30:39 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A1822B27
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:30:34 -0700 (PDT)
X-QQ-mid: bizesmtp85t1662082227t31puwkl
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Sep 2022 09:30:26 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: prZinsztHh9V2zodRTFduMOAO3Dbs48bYrMaoTok4/gXB3uPh2ashbegAtV3c
        2DO9tgxrak/JUkxZAwjI4E5gVQBN0/9b1+Cu5SUlUSzhlGeMixdtyB2gkd/MgnVFEs29yck
        NDUfoy8QveIHAtOC0PwumrPqwCIAAsTF3MtcgmPRc5iU7YaDHusTcsHk67DeMfslNMkNKy0
        4joB7sYnzqbXem6WiarAmxjDLZYPes/YzoPJX2DmcCpEGFHm+/ik794ZS2sKP2F9zwLcWNY
        5drbuFKIHcAOwBA05iyiFwtuozHQpBXKJpKalkzQ8Th4qsmEgKlmZHnqQNzEQ1ndQITkloL
        Sl/pswg/f1aBg/W+3t4qahYSxFiJW3JBFGny3uKwFQ7YZWv/vg=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] seqlock: fix repeated words in comments
Date:   Fri,  2 Sep 2022 09:30:20 +0800
Message-Id: <20220902013020.1934-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 3926e9027947..4e2ae90554cd 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -863,7 +863,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use the the internal
+ * For all seqlock_t write side functions, use the internal
  * do_write_seqcount_begin() instead of generic write_seqcount_begin().
  * This way, no redundant lockdep_assert_held() checks are added.
  */
-- 
2.36.1

