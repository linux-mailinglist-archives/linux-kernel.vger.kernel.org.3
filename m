Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7F55444F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352718AbiFVIFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiFVIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:05:16 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C31BE32
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:05:11 -0700 (PDT)
X-QQ-mid: bizesmtp89t1655885081ty3h0se4
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 16:04:30 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: e00egQTBacRpAMH3MJBoJKnUaLjbSAMptizPG1hbxKXoyqNy5wEkA8mHq+fkZ
        GQR2oDXjDpITEYiQuAckQL/ItON3m//yG0EiEiTC3aIJQCodyatGCOK/ruRBk/EVXRH1sPT
        pBb70Uzuont6HsK6IYXuyVJlX4udTft0/WePrdoaUL0QvD9HVQUQaB8TVwYfoevmDBM23wl
        HDXeT12xMk/w0i433e7OQuUV9ToNI+w+2dQJAHr0ifTuSKcsgUpMmZP4GP/ZPyAd7nbrvP0
        zSuPuY75kCrcTFJQ+zqJOOgQLvC2jxyCDgT5d8nvGQryJldVORax8sy6uFIpbUk5ZPyPLZ0
        jkzC7PGRI9Kh0EWkXHNg8I+dbCPFA==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     vgupta@kernel.org, Julia.Lawall@inria.fr, rdunlap@infradead.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] ARC:mm:Fix syntax errors in comments
Date:   Wed, 22 Jun 2022 16:04:23 +0800
Message-Id: <20220622080423.41570-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arc/mm/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 5446967ea98d..84fe78c41c37 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -750,7 +750,7 @@ static inline void arc_slc_enable(void)
  *  -In SMP, if hardware caches are coherent
  *
  * There's a corollary case, where kernel READs from a userspace mapped page.
- * If the U-mapping is not congruent to to K-mapping, former needs flushing.
+ * If the U-mapping is not congruent to K-mapping, former needs flushing.
  */
 void flush_dcache_page(struct page *page)
 {
-- 
2.36.1

