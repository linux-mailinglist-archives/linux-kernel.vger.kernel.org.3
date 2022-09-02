Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0220B5AA516
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiIBBca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIBBc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:32:28 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D0967159
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:32:23 -0700 (PDT)
X-QQ-mid: bizesmtp88t1662082339t5mcogcp
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Sep 2022 09:32:18 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: PeTlvEY0Q2DKEN3eff4vI55TGF3TOPQrrVITEjBBnYMs8WvBdY/Fabo0YQSAZ
        Aun7VXpostQ2MAD/fVvZV+5N7Pr7yinscxfuFp02u4mWW6SkFe9HvAXTTX/+RrwY/T7vdQr
        JgD4iWXJqqxKYcXwyUmDIz/lFY8+KCUfhQTKyKW2Ba40EbaDmqHGH+iTAuah8N+I0aFM3d0
        m3TV1mAJ502ZjNz8oPUxdms6YvpHh+t9yFQHwwtuCPl+woHqoUGpN+PkYzaJptemiYrUQi+
        7d8lMAZOhNGrm0Z/Y4gAUw2fUnexulPOUWco0ZGuyYqo6CmT7qadt6t2JZdfdaDBzmjn8vD
        BG/yDNGDVp5t0gW/rZ0r703ZpMZW2zH8EbuUT1FXFqHdT5esUg=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] lib: zstd: fix repeated words in comments
Date:   Fri,  2 Sep 2022 09:32:12 +0800
Message-Id: <20220902013212.3739-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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
2.36.1

