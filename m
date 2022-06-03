Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8453CA54
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbiFCNCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbiFCNCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:02:02 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389BA6455
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:01:54 -0700 (PDT)
X-QQ-mid: bizesmtp84t1654261308ty0dfdu0
Received: from localhost.localdomain ( [117.176.187.31])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Jun 2022 21:01:42 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: Mzskoac49OjjUdElT52QQBT8024YNvFxYcB8N1hdnLszXz4fyYEBVDsNqr6H8
        UUUkRWjXTrh/c9t0UuSVOKtAsGpzwT4qlpURu+luHYllW9INpjUSfpvdSBLHal2ToRSasDS
        6TlE47r1i39SItOAOPh3tbonl6QHrZlD+lbWwaJuJZ2h1dVF1/jawezi4JfseD6b08eDX8h
        iEFH70jD9j6tMAS1vYuk4eTAdCXz3B6lxo31DDG96u7IRCkvZq0d9lF9ihPCM0yb6kp226k
        8mNXlI+HyixjYIO5KYTLvebn0Sih/KIfB6zSS/gqWyZwk8IaQKA/CN0JwxREO7HxneeKNGU
        oTqEGMx/tJRgkKL2lE=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     vgupta@kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] ARC: Fix syntax errors in comments
Date:   Fri,  3 Jun 2022 21:01:41 +0800
Message-Id: <20220603130141.6516-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.
Delete the redundant word 'since'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/arc/mm/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 5446967ea98d..55c6de138eae 100644
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
@@ -910,7 +910,7 @@ EXPORT_SYMBOL(flush_icache_range);
  * @vaddr is typically user vaddr (breakpoint) or kernel vaddr (vmalloc)
  *    However in one instance, when called by kprobe (for a breakpt in
  *    builtin kernel code) @vaddr will be paddr only, meaning CDU operation will
- *    use a paddr to index the cache (despite VIPT). This is fine since since a
+ *    use a paddr to index the cache (despite VIPT). This is fine since a
  *    builtin kernel page will not have any virtual mappings.
  *    kprobe on loadable module will be kernel vaddr.
  */
-- 
2.36.1

