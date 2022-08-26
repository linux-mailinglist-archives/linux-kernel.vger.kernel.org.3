Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F405B5A2550
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbiHZKCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbiHZKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:26 -0400
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA29C52B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx305.security-mail.net (Postfix) with ESMTP id 6FB27310036
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508083;
        bh=umoBrzjPnG2m1v0j35tkSFp28i8Ba8qZOyxSXnPg8MQ=;
        h=From:To:Cc:Subject:Date;
        b=Ln+F4+nPOJzCe3F4Z6RLmChY60CaLIUcBSXFAjHJQEPKvl6KowFd768JhjE6x78mO
         zRJga3eAsowkgJfMtRxaZQabNbVXcVKeaYlcGZ0ZX2HVnw4iUcbrfZX0KlAFFsD2Q5
         IjwuwEmMNeBOZhV4PknoIT00mTgdicQbIxBEq+9k=
Received: from fx305 (localhost [127.0.0.1])
        by fx305.security-mail.net (Postfix) with ESMTP id BBEA831003E;
        Fri, 26 Aug 2022 12:01:22 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <2fc6.630899f0.68c2d.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx305.security-mail.net (Postfix) with ESMTPS id 6A7F630FFCF;
        Fri, 26 Aug 2022 12:01:20 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 34C3227E02FA;
        Fri, 26 Aug 2022 12:01:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 1E04527E0392;
        Fri, 26 Aug 2022 12:01:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 1E04527E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508080;
        bh=qlS3TQ1NwgkTiN2EYW9/bZ69MTDwdwON9dReysFiWzU=;
        h=From:To:Date:Message-Id;
        b=XE69OwlcM5AknaeXYDqX5urW9fjEhE82kwI2/0Nklv8oHKj8SoEZLdxxcK3ZeRjWR
         IzGFE3X+PxFOrV68jZLIWvMLkoE0ojRe3j7TKF1G3mGwhRiUq6ZmUph5ya7NoX+X3+
         IqJOuD4zXVwqr506X1Spclk2TFEADM6lkME3EzmM=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nzlufxVqqmbY; Fri, 26 Aug 2022 12:01:20 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 021F827E02FA;
        Fri, 26 Aug 2022 12:01:20 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <jstultz@google.com>
Subject: [PATCH] dma-buf: heaps: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:43 +0200
Message-Id: <20220826100052.22945-15-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `by`.

CC: Sumit Semwal <sumit.semwal@linaro.org>
CC: John Stultz <jstultz@google.com>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
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
2.17.1

