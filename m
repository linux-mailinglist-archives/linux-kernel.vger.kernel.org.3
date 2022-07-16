Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74000579FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiGSNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiGSNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:35:02 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3578665CB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:50:08 -0700 (PDT)
X-QQ-mid: bizesmtp83t1658235004ts0gvr5d
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:50:03 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000020
X-QQ-FEAT: y5UFFkuhlmLJay+iUMfn5ZoRmWc5c/R+3h7kUQ/Xuhb+fjBpyfO3hH/QSLVlb
        5EyC+PfLl5v1Qm+pDYWpAycfmlYlO+vSXcAjLdTIv9ekq9A/X6NYmfjd4mv0xWyLk0i7hDi
        Zdi0/vKVLTPTsg2rzjmrCn330Aa2TzaX3iaAIvT/i/d1dG+Slg05+PCE9w6JUwL3iikXK8D
        wUVEJFZifaPC8I+e4NVGJhh/9T70Iv7ZFVSF/YGYEpVvNHwgL9oRMRFcFyJp/LWBLtUVvRk
        vSSFkydtO/3GRtU/R1a876XoBWH8VwKdjKAzfQ1Gl0lbNWH+Jvp5RiV8juMRVdMg2j25Ou4
        pYnK5Uej+i+2flsIPd35FY1uoFCaOs/rEu71YHg3qmo07YwYTXb8hG69WUTKSgToLkHUjcl
        CmG2HqClHOw=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] lib: zstd: Fix comment typo
Date:   Sat, 16 Jul 2022 12:47:59 +0800
Message-Id: <20220716044759.44603-1-wangborong@cdjrlc.com>
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

The double `when' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 lib/zstd/decompress/zstd_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/decompress/zstd_decompress.c b/lib/zstd/decompress/zstd_decompress.c
index b4d81d84479a..6928e85f9d19 100644
--- a/lib/zstd/decompress/zstd_decompress.c
+++ b/lib/zstd/decompress/zstd_decompress.c
@@ -996,7 +996,7 @@ size_t ZSTD_decompress(void* dst, size_t dstCapacity, const void* src, size_t sr
 size_t ZSTD_nextSrcSizeToDecompress(ZSTD_DCtx* dctx) { return dctx->expected; }
 
 /*
- * Similar to ZSTD_nextSrcSizeToDecompress(), but when when a block input can be streamed,
+ * Similar to ZSTD_nextSrcSizeToDecompress(), but when a block input can be streamed,
  * we allow taking a partial block as the input. Currently only raw uncompressed blocks can
  * be streamed.
  *
-- 
2.35.1

