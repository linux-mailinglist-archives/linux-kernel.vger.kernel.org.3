Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB65782C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiGRMwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbiGRMv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:51:56 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B620F58;
        Mon, 18 Jul 2022 05:51:51 -0700 (PDT)
X-QQ-mid: bizesmtp78t1658148705tr6iccbm
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:51:43 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: nUI8eyKROnHXnaQZjotUY3P+hV3DbtNiGzLUyrpyWQ7xU3b8dZirKfj/pzN4z
        cXdK+DFE3HsP0Nb1eInZT0cZCorKrPagagVpyJveqOfBT1xwD99axMU4C1xtC+p7O5M5Vxr
        cBK+M4ucfaNDdAddmWeFH7TRrqBA1Bl85SkSOTJ1Xtt+9WS468yq8Zrb82bJg3GMdD+aStu
        kVpH87ZqtSRPFWq+TuRHEXoxAGbdg99R6gB+df0JbckfYvlYLz/F+XxX/+z4vZfxDF/+BQ/
        Bf6880i5sfIKGIV+Nbv3UE9oIoKIxqU7QYKHzj6iiIQ9MXGDJYuxUyG5Bq+7MZfqCD8xcL/
        5EAfxLWqEIOYHsvXtNNqrstDey55IG/z/T4oHF2RQ/LdAxRN0gu6DNU+3+4wLOorBJ/Hxn1
        CQftNojluYE=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] block: Fix comment typo
Date:   Fri, 15 Jul 2022 12:49:47 +0800
Message-Id: <20220715044947.21260-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `can' is duplicated in line 570, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 06abd495c6ea..6cc1271a9f98 100644
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

