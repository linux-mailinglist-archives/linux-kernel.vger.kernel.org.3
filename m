Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BBF58FBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiHKMNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKMNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:13:19 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5FB1D33A;
        Thu, 11 Aug 2022 05:13:16 -0700 (PDT)
X-QQ-mid: bizesmtp87t1660219991tok2cf0c
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:13:09 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: l1AKOOPZQsemhi97Bd6Satu2rAv8aQ/7jm4AUMiUYmwlMlzu+AvlGaOazpgdw
        5OOJQVPeT1xL+U7GOoY2wxDWPD/TuYFOzne7Idela/AX/0f7rgOyQVSyjwiUH1+5qWYyT8N
        /K3yNt/mHorUrOBLBct+5xC02fenRyHozbpakiVxW6WZjbjjM+3B1wt2bxbYSMKgQDRS4dQ
        VLlsZuzkZxW2h+LNIx3CUQgS8sML5+RQvOKpwgiRoM8k0BG4lATGBRIC9NEe23qYiqfffj7
        tmV/XO/lH2QXwgnTCPWSfLOWtdg2W7ix6jcL42T4Lp90vb4BTB0da06wmiFN0zgga5hNwgS
        pBpSKp3WCJhgNYYu4Hsb3hmj0bESDmfn3TbUfvbr4lSR3OQE7+7HtZBpZ26ofUQo9JLv2cV
        HJReWa9cJRg=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] block: Fix comment typo
Date:   Thu, 11 Aug 2022 20:13:03 +0800
Message-Id: <20220811121303.21834-1-wangborong@cdjrlc.com>
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
2.36.1

