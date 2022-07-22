Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D725B57D815
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiGVBsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGVBsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:48:01 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A6D972D8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:47:56 -0700 (PDT)
X-QQ-mid: bizesmtp65t1658454472t5saw605
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 09:47:47 +0800 (CST)
X-QQ-SSF: 0100000000000030C000000A0000020
X-QQ-FEAT: iQygIJK8D+fJ/gB1c8hy7EMrB92aFy80KT+cy3Z8AHlzWXecaEdV/s9v3FOMf
        sx1UTOzGA7ZAIJGZgLfrqloD6aEx32z05acI/0n5AdYSG04pm7w6GIYPlU2ak1NUt7ZpuH2
        vnCur2nCV+bQjZSiqZzhhNCxVJMoxxcziCK0V5dbntFzAXwkAoQlbz0xmXGFThSXabV4Ork
        itYd8kVdStu6ggcuhG51rMKGP8azUnbkwgFmxQfMoF7X5XWpK+uD+E0Qj/YX8ynlL4MnC0p
        JNszs/MvJzE3P0UM3dvWN/u/jQAGldyV+1bgGcf4p6dXlgGvP7rw8Izj/LcxdmfwQLKxRuv
        0k3gmVHXUyccbeHnWeKh4mp/SIp14TzYBceuMQF
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] lib: zstd: Fix comment typo
Date:   Fri, 22 Jul 2022 09:47:45 +0800
Message-Id: <20220722014745.14614-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
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

The double `when' is duplicated in line 999, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
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
2.30.2

