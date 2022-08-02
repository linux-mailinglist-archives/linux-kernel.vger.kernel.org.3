Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AF587C55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiHBMWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiHBMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:22:48 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10444E874;
        Tue,  2 Aug 2022 05:22:42 -0700 (PDT)
X-QQ-mid: bizesmtp71t1659442798tgsihsb9
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:19:56 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: swyrzWPvyR2qDD5rPmQ/VXbiVD4x75MF6MoDQejb2G9zwz1gVFQdbfqXPwQ3P
        nOfI5MjJNkqkFJVKQERE7twIgTeivKoo1pgIrRhH5QAV0ExReKBBIBsH7uVFIHbolDd0SbS
        0Zn/fsIe+MQIe8UOMituqc1ghaBUZM/yF66LJqlMEcUY8caElLIsgYPVvIxKiNPYY8XMmcp
        2PPQPRwgjE2ZDPjo5miu9tgaGMxxRInviuBi8Rx0LH53ZF3VLtLi/EVzbm85685wloA/3yA
        ShZeq0tW52MBTgZgiuGZcZ1HJD6L3WpZe+OnW9t3ipJuENvC7MUDL3JXzdZPICSlUAw/Vh/
        x3871Ed3Q9Wc0uBSY/Ibf9WW5y9+Y0r1kLQeDjgTdzwnA+12xX7RUO+mLwajfP3fNEDGioM
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     christian.koenig@amd.com
Cc:     sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
        lmark@codeaurora.org, labbott@redhat.com, Brian.Starkey@arm.com,
        jstultz@google.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] dma-buf: heaps: Fix comment typo
Date:   Wed,  3 Aug 2022 04:19:55 +0800
Message-Id: <20220802201955.8634-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RDNS_NONE,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `by' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/dma-buf/heaps/cma_heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 28fb04eccdd0..cd386ce639f3 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -316,7 +316,7 @@ static struct dma_buf *cma_heap_allocate(struct dma_heap *heap,
 			kunmap_atomic(vaddr);
 			/*
 			 * Avoid wasting time zeroing memory if the process
-			 * has been killed by by SIGKILL
+			 * has been killed by SIGKILL
 			 */
 			if (fatal_signal_pending(current))
 				goto free_cma;
-- 
2.35.1

