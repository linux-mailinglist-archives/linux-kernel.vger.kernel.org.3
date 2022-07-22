Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226FC57DFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiGVKYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiGVKYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:24:37 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 787909C24F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JFTEZ
        XTdSl0soA032IjfvpaeJZtwHAoPVhleTEumd8w=; b=jhlkrsVxYx1YpxOTsNq7j
        ivdEAW3JQsXbsKoAgtt7jnVFHzen3ynFswY1zb8Vz6OxOrU5MZMrdJLzWjlJWfbO
        SIKFdyHieBvIMrM1qtaruaYKYCg2DJ+UozISw4sbunQLTUwFrEEXFbe2v2Owa0PH
        EnxZG0FPno7Rcg4kgsL8MM=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp2 (Coremail) with SMTP id GtxpCgDH16fcetpiIcFqQg--.3885S2;
        Fri, 22 Jul 2022 18:24:29 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] lib: zstd: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:24:26 +0800
Message-Id: <20220722102426.81464-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDH16fcetpiIcFqQg--.3885S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyDAw4kJry5Xr43Ww48Zwb_yoWkGFg_G3
        WrXa1DuFs8AF1akF4xtrZ8ZFn7ZrZ5ur1UJr98GrnxZryvyanIyrykX395GFyxXryYvwnI
        gw4UXFy5Zws8CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREpuW3UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJR1GZGAJpKfvDwAAsQ
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
 lib/zstd/compress/zstd_compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/compress/zstd_compress.c b/lib/zstd/compress/zstd_compress.c
index a4e916008b3a..73fff4c60149 100644
--- a/lib/zstd/compress/zstd_compress.c
+++ b/lib/zstd/compress/zstd_compress.c
@@ -4441,7 +4441,7 @@ static size_t ZSTD_validateSequence(U32 offCode, U32 matchLength,
                                     size_t posInSrc, U32 windowLog, size_t dictSize, U32 minMatch) {
     size_t offsetBound;
     U32 windowSize = 1 << windowLog;
-    /* posInSrc represents the amount of data the the decoder would decode up to this point.
+    /* posInSrc represents the amount of data the decoder would decode up to this point.
      * As long as the amount of data decoded is less than or equal to window size, offsets may be
      * larger than the total length of output decoded in order to reference the dict, even larger than
      * window size. After output surpasses windowSize, we're limited to windowSize offsets again.
-- 
2.25.1

