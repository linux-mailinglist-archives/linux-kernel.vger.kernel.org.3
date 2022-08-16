Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1096C595B90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiHPMQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiHPMPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:15:16 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C743A48A;
        Tue, 16 Aug 2022 05:10:10 -0700 (PDT)
X-QQ-mid: bizesmtp86t1660651801tm1ik1lg
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 20:10:00 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: 5x8Sgf4S6/hEid5+0EMTFNWT1lMwH5fir4bYCXKG37zV429uH/yppgCRr6lZp
        qtgW+5ZkhTyqosvsawDvCH8tBHHen6xHQaiYlcxVQglMR6XQOw12J/USQ2vDpFA88RzXo0O
        m7ZhVW8LZ7fPz/wG1mrVQAfUPCELTuHnlwyZEVjJ8oitSUCOLB8IJFGQv5TOXnRqDOKyXbt
        hagdjhbhW19LoYxJ5bhAgau4udpWPSy+Qn1hY3lNDbevgKcMTPqoyz0LwbVev7rf1WU+fRi
        ymqDPh+c+04yWxEj3LHzjmE0RqlDIlYHRhjw6rBOUTUfZeVgg0/zzTF8Zsw1SNE7uJIyCvJ
        FThLeY9yoIxW3vhktZ+zznu0QkUI9dCk8wn2QNa/NBkSnu1/A8=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] block: fix repeated words in comments
Date:   Tue, 16 Aug 2022 20:09:52 +0800
Message-Id: <20220816120952.56713-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'can'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index f92d0223247b..c883f8963c14 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -567,7 +567,7 @@ EXPORT_SYMBOL(bio_alloc_bioset);
  * be reused by calling bio_uninit() before calling bio_init() again.
  *
  * Note that unlike bio_alloc() or bio_alloc_bioset() allocations from this
- * function are not backed by a mempool can can fail.  Do not use this function
+ * function are not backed by a mempool can fail.  Do not use this function
  * for allocations in the file system I/O path.
  *
  * Returns: Pointer to new bio on success, NULL on failure.
-- 
2.36.1

