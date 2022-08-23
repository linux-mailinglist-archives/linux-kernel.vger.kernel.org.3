Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC859E8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbiHWRMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344858AbiHWRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:11:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9501412BF;
        Tue, 23 Aug 2022 06:58:18 -0700 (PDT)
X-QQ-mid: bizesmtp80t1661263058ti9axcll
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 21:57:36 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: 7jw2iSiCazpcpWLYY9JDQRUg2umnfyrSoTbLpj+5zriu6kFBSFJZ/EdpHon9h
        hgdBLSfqxqAxKV470ajTz5Mluo7hGtS6yg6GhNdG4vX85FkAVIKc/+2GJCtfLEfRaQyGxrl
        FRvYWbIo2XIHEyddqCdr6kNxENjbwmSFg6hAOqgrCsBWjOwBAhZMI7aWOZ5z8jbWPRI8BlX
        HlS0I/t5quUzLHLW7gH9oSzTmnVoDDZi7f89vJC1D53VQ53o0I/5udfMEAP+e2Fx9TEZPgB
        zHqf+TaxIi5bgh53oVUNPzzigifkBF8NCQsPskYaeZFaPYFlkEih7V/kHxriDdwvsZ0uMSE
        qUK2WoGesxMrQAyKw35pEHBJXiAZD5gm/cLgD5VHV6MDyGY0xFTvPwzIGan8A==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] crypto/bcm: fix repeated words in comments
Date:   Tue, 23 Aug 2022 21:57:30 +0800
Message-Id: <20220823135730.697-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/crypto/bcm/cipher.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/bcm/cipher.h b/drivers/crypto/bcm/cipher.h
index 71281a3bdbdc..d6d87332140a 100644
--- a/drivers/crypto/bcm/cipher.h
+++ b/drivers/crypto/bcm/cipher.h
@@ -231,7 +231,7 @@ struct iproc_ctx_s {
 
 	/*
 	 * shash descriptor - needed to perform incremental hashing in
-	 * in software, when hw doesn't support it.
+	 * software, when hw doesn't support it.
 	 */
 	struct shash_desc *shash;
 
-- 
2.36.1

