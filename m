Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CAA583F24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiG1MpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiG1MpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:45:01 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4296C4E87D;
        Thu, 28 Jul 2022 05:44:55 -0700 (PDT)
X-QQ-mid: bizesmtp63t1659012288tmchyob3
Received: from localhost.localdomain ( [171.223.98.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 28 Jul 2022 20:44:47 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: qcKkmz/zJhyV0l1tqTHK25eKWd4wPvsATJkV0VKzR/G35M6qBYCyqvmuH1MWl
        o1kzwllm0h3cFoZs8d/ZQk/8WrmHg44Jhfb7SHEmGxMTmVqYV9lInDXLWQfdZMUjFkEiWtO
        A4882PgjAo6jZC7JzGK3xocqh6I++B2mVgeaBniCef5s5/mZN2XQ9ugdByIo6FCcZ/5/3IE
        zi2HNTX8EnkTVTljJQZhrz7tf1UuZ74jFG8iNDLysakI/3hvkhtIBmIhXquMkKe0Th28wyX
        4dhtgt3Dqwo5RdpenqMzvNW4MynYM/sTNgRy+tRVzuPkCYWZ8fxVCLNpndzGHCOko/mm/jF
        1MDvAn+QTRFJUY4wdoTPMFHlda5/N0Tmdmmm0xchDJudojZsRn5S6wWdv87t/ptR1+Lknrj
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] block: Fix comment typo
Date:   Mon, 25 Jul 2022 12:42:53 +0800
Message-Id: <20220725044253.8883-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `can' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 3d3a2678fea2..e2a7f0db7f29 100644
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
2.35.1

