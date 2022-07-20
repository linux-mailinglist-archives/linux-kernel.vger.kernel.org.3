Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9E357BEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiGTTi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGTTi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:38:57 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44823624A1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:38:52 -0700 (PDT)
X-QQ-mid: bizesmtp91t1658345814tdzmi03q
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 03:36:45 +0800 (CST)
X-QQ-SSF: 0100000000200030C000C00A0000020
X-QQ-FEAT: r/cTxDoDoiH/pTL4nTBpUt0R87I470dGH2+XdWmc445JnQmOS3uO11QkskkhJ
        8UjrsAYIGVRgHy9Y+uNQN3QS4pJ8/0fljZSP9Vv1CHlfmPjfpv0rpfb9Mj/eovsxP0uJia7
        Aqo3tTG7fStGZ3gFD2qaKq4X32u8OgW0f3cAAPg4ZfRCGuEGDh0fYjiyA9s1+IlrtM9viet
        G7uTnQucIN/py+0pDSu/yZvJ+c5yzAzy6p4xztZ22rRchjQxHaPowonmtuco5CEAwqyHwOd
        NYQzSy4LkVlqH9TjcWhibIHJB3yVfaRgN8fifrH2+FNzeTS3b5gLM3IpXYHVphOS7bB6Ieb
        jpqK6ZQFsOKxIHAiL2mIXqFgBLCRSQHQJnsKqb27eAnc+UzFlxuUxEtBtfIXA==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] um:do not initialise statics to 0.
Date:   Thu, 21 Jul 2022 03:36:43 +0800
Message-Id: <20220720193643.8081-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
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

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/um/drivers/stdio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index e8b762f4d8c2..e0f7543ef499 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -90,7 +90,7 @@ static int con_remove(int n, char **error_out)
 }
 
 /* Set in an initcall, checked in an exitcall */
-static int con_init_done = 0;
+static int con_init_done;
 
 static int con_install(struct tty_driver *driver, struct tty_struct *tty)
 {
-- 
2.30.2

