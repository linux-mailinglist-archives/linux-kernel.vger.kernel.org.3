Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4722B57DFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiGVKMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiGVKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:12:38 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E854F74CC2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HCl8T
        UD0bXKvXx8/Cke/OlVOH8QjWRAXDt6hhlRkT8A=; b=GP3liKscKAdISqcnQ8abs
        AjhgOfus2yGOFR5oHyFS9BMOu+5atvasLlfTuA1n8LsCD6WHw4NlZQfY9349acKh
        KGri16jhv7u8BN3rNoDxuiaCiXIQjMhayTWldUyq05evcsJqNwvVTU1+bSKKgE2k
        SB8CgEfLlG5vumQiKfCzoQ=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp5 (Coremail) with SMTP id HdxpCgAn3EgFeNpiesu5Pg--.23789S2;
        Fri, 22 Jul 2022 18:12:23 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] seqlock: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:12:15 +0800
Message-Id: <20220722101215.80603-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgAn3EgFeNpiesu5Pg--.23789S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyDAFW8Ar1fKw47Wr13CFg_yoW3Xrb_Zw
        48Xr4kWr48Wrn3u34ruFs3AF4UKa48GFy3W3Z5Kr13JFyDA39Y93Z3Xa1DtF1YganFk343
        u3WS9wn7G3W8ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXL00DUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGQdGZFyPdm1F7wAAse
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
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
2.25.1

