Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0506E595BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiHPMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiHPMme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:42:34 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D628CA2637;
        Tue, 16 Aug 2022 05:42:32 -0700 (PDT)
X-QQ-mid: bizesmtp69t1660653749t2c1dz9i
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 20:42:27 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: C2zsvWT0ctUc185TPlcDk3xBmBiZGn7vhVe51d07QQYkMvaAvJCRDC10zDQ92
        Guu3+c76nO1+BH+B+WJILNS0J/hJ4NdqzOMT1b4LrJ4Wfq+/6RfneE1Nf6jMTD4d6cIjPTX
        Hf4zwFITIAr1EaLhqNkV6CMHYdrp9NsdJ5KQHjdgB5qa3BuTT0hTyIW/X9nlIebKPYmNoW+
        WHt91IOYlCZhMGj88n484lXKNJtDvSdcxGoZ7ft8U7ThbZZEZWwuTU/p1/YRq8jA1t74GjG
        8N3ptywLtepwh2fO+nzDPUkmD4n5jcXObzbEgUzg1wBGTSW/nt9X4jrNE1cs+5vgFEigfkZ
        PuNUtqaihv1Kha8Ne6R5nAnd3QOxNu3ro40Hgbdu8VKaYOhTZo/bty8V5UlFvzM3C4/vpmE
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/watchdog: fix repeated words in comments
Date:   Tue, 16 Aug 2022 20:42:21 +0800
Message-Id: <20220816124221.14910-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'we'.
 Delete the redundant word 'set'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/watchdog/wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdt.c b/drivers/watchdog/wdt.c
index 183876156243..c358bebc42c2 100644
--- a/drivers/watchdog/wdt.c
+++ b/drivers/watchdog/wdt.c
@@ -311,7 +311,7 @@ static irqreturn_t wdt_interrupt(int irq, void *dev_id)
  *	@ppos: pointer to the position to write. No seeks allowed
  *
  *	A write to a watchdog device is defined as a keepalive signal. Any
- *	write of data will do, as we we don't define content meaning.
+ *	write of data will do, as we don't define content meaning.
  */
 
 static ssize_t wdt_write(struct file *file, const char __user *buf,
@@ -406,7 +406,7 @@ static long wdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
  *	open and on opening we load the counters. Counter zero is a 100Hz
  *	cascade, into counter 1 which downcounts to reboot. When the counter
  *	triggers counter 2 downcounts the length of the reset pulse which
- *	set set to be as long as possible.
+ *	set to be as long as possible.
  */
 
 static int wdt_open(struct inode *inode, struct file *file)
-- 
2.36.1

