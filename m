Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D32579FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiGSNgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbiGSNfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:35:50 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E27BD4E21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:50:37 -0700 (PDT)
X-QQ-mid: bizesmtp90t1658234967tsg1hgsi
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:49:25 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000020
X-QQ-FEAT: ZckECEo/G3Uum03WG870D95g2lSCvMX/RfgCdbHNjIZ41rX3xccqlvMkYCC9q
        HUs3t5NKk0gWa7NR0HKROBdBV8KiRMJKNyIYULCJe+hkEKc9nQHjQATxaMW69LocY6jzc9h
        5X06nopzmPxx1a/ZgDSmfcSyU171Sye180yXSa82NF1c/P3Lg/STV3Y+JAw8umMUaiw0e0X
        Jr9/z4FHwmVcxELoiditiJbIWXOr0PiXo9aKpCtOAjpp6hQihMdSmCUfISuHVPPKihixQjS
        Wo0MJdloq4D2OOitFEo2HeSjjywjGJ8Lh1I7hDzv3Pnm9eOiE7hXxwG8xy9THwiwjqoT3Uv
        NhXKDv2y55YMBEPlK6DXk9TsVPTx85hJeQU3fAfthPW414OgyzBPW2pG12VmydRK5G6m0gV
        2R17EucYWfU=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] lib: zstd: Fix comment typo
Date:   Sat, 16 Jul 2022 12:47:13 +0800
Message-Id: <20220716044713.44407-1-wangborong@cdjrlc.com>
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

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 lib/zstd/decompress/zstd_decompress_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/decompress/zstd_decompress_block.c b/lib/zstd/decompress/zstd_decompress_block.c
index 2d101d9a842e..3067eb172c5d 100644
--- a/lib/zstd/decompress/zstd_decompress_block.c
+++ b/lib/zstd/decompress/zstd_decompress_block.c
@@ -434,7 +434,7 @@ void ZSTD_buildFSETable_body(ZSTD_seqSymbol* dt,
             }
         }
         /* Now we spread those positions across the table.
-         * The benefit of doing it in two stages is that we avoid the the
+         * The benefit of doing it in two stages is that we avoid the
          * variable size inner loop, which caused lots of branch misses.
          * Now we can run through all the positions without any branch misses.
          * We unroll the loop twice, since that is what emperically worked best.
-- 
2.35.1

