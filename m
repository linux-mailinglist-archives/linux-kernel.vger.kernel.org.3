Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8AC57ED10
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbiGWJ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiGWJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:27:09 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C3BE0A;
        Sat, 23 Jul 2022 02:27:01 -0700 (PDT)
X-QQ-mid: bizesmtp75t1658568403tlofweog
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 17:26:42 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: aBJFcW+uBGYxmhiel1Ariazskd9+D+7oHz6uF3Ic9MWYJmAb0KJoF8BIJsc2d
        gX71ra4b/xRLT1DPAgjk43NBzxYUZbVvNstmp8aV0EQNLXoeFUiboIxYSpdUQjGqTCh9fYr
        WPSGNQEJ/f/3WrUiMLui/FwQE4W0GBjBqZ37EaYSI6+9tMB5KF7jJggpVWfENqEmq4UrOt0
        aZY+CbqZiaQOVFMO4RB2dMU++5kqZ4DcXaljshuiqWjXBAC/tqd9V+J74Nx7v0Or4Arr+23
        j/QYDTdEMsLr+wpS+A7gR7AmBjqi6CmbzRLGemhgBQXzKt2E04YWgeOXOneKYrAokOiNEQ7
        urdivmEZun8PSLjNsM3I6oYj3/rflmiKdz6KufOxGubMmBlU2OsGqq/QeP21nun+U8USPoD
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] crypto: tcrypt - Remove the static variable initialisations to NULL
Date:   Sat, 23 Jul 2022 17:26:40 +0800
Message-Id: <20220723092640.7559-1-wangborong@cdjrlc.com>
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

Initialise global and static variable to NULL is always unnecessary.
Remove the unnecessary initialisations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 crypto/tcrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index f56d1a9cf0a7..59eb8ec36664 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -58,7 +58,7 @@
  */
 static unsigned int sec;
 
-static char *alg = NULL;
+static char *alg;
 static u32 type;
 static u32 mask;
 static int mode;
-- 
2.35.1

