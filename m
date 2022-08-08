Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE058CB68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbiHHPkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiHHPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:40:09 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35F14D2A;
        Mon,  8 Aug 2022 08:40:08 -0700 (PDT)
X-QQ-mid: bizesmtp83t1659973203tgapgwly
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:39:57 +0800 (CST)
X-QQ-SSF: 0100000000200050B000B00A0000000
X-QQ-FEAT: oxgq2YVMtX/GHD/05992BC82PK3kkLB9bc+DuY2NKRmsZ7cEiCCPqiQa+PH9y
        LWsrFYjZV6eyoa62qErH/+8RSUIQREmIvaYAkqmHUb7ExGXXHXNtVBv7lTvdsM0YjfhHYhA
        HSSqUTINAR2NOcr/TJmAQ4wV0Y7T9dx3gBVqpVhf50pOvFvAol0bIKZkxhrMpN0Qp9r1FPw
        krpZU3AZfiT4It7/VbeEA4PUdFfaghm2ODESaX3w4UCVrKAN4ksmD4fIlRGwRexQ8umELnP
        Xbz0Yunu39U0IW9hSg1mzFZKLXjhUs2hLmJ5Ow4xQ7YWCOPYzQ/UIeRPneJnAV7oYFWKrWI
        jkrLtiErKif8EB/LAOC9kiBlqbTChsqIMUCAAO5kjwCyobN+fg1SUL4YOMG27ZqyeAdPliV
        sX8x+7pedVU=
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] watchdog: Remove redundant word in comments
Date:   Mon,  8 Aug 2022 11:39:56 -0400
Message-Id: <20220808153956.8374-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a rebundant word "we" in comments, so remove it.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/watchdog/eurotechwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
index ce682942662c..e26609ad4c17 100644
--- a/drivers/watchdog/eurotechwdt.c
+++ b/drivers/watchdog/eurotechwdt.c
@@ -192,7 +192,7 @@ static void eurwdt_ping(void)
  * @ppos: pointer to the position to write. No seeks allowed
  *
  * A write to a watchdog device is defined as a keepalive signal. Any
- * write of data will do, as we we don't define content meaning.
+ * write of data will do, as we don't define content meaning.
  */
 
 static ssize_t eurwdt_write(struct file *file, const char __user *buf,
-- 
2.35.1

