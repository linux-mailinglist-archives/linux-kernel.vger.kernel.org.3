Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651EF58CB7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbiHHPpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbiHHPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:45:13 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5FA1E8;
        Mon,  8 Aug 2022 08:45:09 -0700 (PDT)
X-QQ-mid: bizesmtp69t1659973505t2w49uas
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:44:58 +0800 (CST)
X-QQ-SSF: 0100000000200050B000B00A0000000
X-QQ-FEAT: mRz6/7wsmIhlzHKj0YPyARWgDoZt8mu1HzJB+5kNjN9Ou3AYISo7wgJWT1MdI
        Wcl8IuhSuTsWf0QjurwFBjPrX5Ijlraq9DQ4oI4Bz4XURd4ddaXrRhrNURQX2zyotdkIvij
        JMYI9PJl70AXkfKMVw0ogD1YRLEqP0umjtSqNFFxx0QCQy82sv8HSwecwVPhh/YFeu1fp91
        HO4Wq4Zz7Sm3R4GcpyrrcrwskJK3XBaZ2Oe2ZQd5nXEgvvyfZTxHfMZzefVb4f+ae71Ltvk
        kLaau2XQXtVOKfJpUirAFHANHMCxVJuKWmoiz6rQ0mjuuF7a18+StTb6cMGwFO3RCuGcwoJ
        ZmYts4Vas/fsHX+ms4QMwuSMSWQ0QF2p60WrUEVmvkcvYe0YEtM4jUMcB957mCA+LQmFXeC
        dN05ITftGVE=
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] watchdog: Fix typo in comments
Date:   Mon,  8 Aug 2022 11:44:57 -0400
Message-Id: <20220808154457.9879-1-dengshaomin@cdjrlc.com>
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

Delete the repeated word "we" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/watchdog/pc87413_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index 9f9a340427fc..14f37b3b903f 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -333,7 +333,7 @@ static int pc87413_status(void)
  *	@ppos: pointer to the position to write. No seeks allowed
  *
  *	A write to a watchdog device is defined as a keepalive signal. Any
- *	write of data will do, as we we don't define content meaning.
+ *	write of data will do, as we don't define content meaning.
  */
 
 static ssize_t pc87413_write(struct file *file, const char __user *data,
-- 
2.35.1

