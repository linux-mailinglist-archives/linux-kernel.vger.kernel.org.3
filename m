Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79947595BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiHPMll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiHPMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:41:39 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ACAA262C;
        Tue, 16 Aug 2022 05:41:37 -0700 (PDT)
X-QQ-mid: bizesmtp62t1660653693tjgl1i2o
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 20:41:32 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: D2GZf6M6C/ja8YmPvS8SZB65YCye/cCOr2VlXW5znBvD/SowE9KIWh1QNtWbA
        v/ziiEcPhZv7/rSEkg2IE25V7aNjAQLXDbHOqwOG5YzvAVUDG1Rd2xH+/RvUdoJJGIIxm7T
        8HL0b1ghjBLXpQn7VM4EFlS7U+tDHlDhBc+sdABHdGWeAYdT1J5tOTIqbRAtpYxapOGPMv4
        m7o7w92lqLo//4RcFc7GSOzEh+uP2BOayv+sCeY09u/BSA0ZmLs2bqWHGPrdLPsSp6pyxR6
        sBRnrERf4kJfG52ZtB4jCj6IOU+6UgHE/2yMUQev0TXM81BNk4okjuOjeuQPaXiSclefW13
        AK+OhiXujPsj8WUuU9s7nEZZwfZJ9emd4EOKSdum/SKMgmfieTvwcdEbteawu4RI46ZdpBE
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/watchdog: fix repeated words in comments
Date:   Tue, 16 Aug 2022 20:41:26 +0800
Message-Id: <20220816124126.14298-1-yuanjilin@cdjrlc.com>
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
 drivers/watchdog/wdt_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index d5e56b601351..a5fed7ea0243 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -347,7 +347,7 @@ static irqreturn_t wdtpci_interrupt(int irq, void *dev_id)
  *	@ppos: pointer to the position to write. No seeks allowed
  *
  *	A write to a watchdog device is defined as a keepalive signal. Any
- *	write of data will do, as we we don't define content meaning.
+ *	write of data will do, as we don't define content meaning.
  */
 
 static ssize_t wdtpci_write(struct file *file, const char __user *buf,
@@ -443,7 +443,7 @@ static long wdtpci_ioctl(struct file *file, unsigned int cmd,
  *	open and on opening we load the counters. Counter zero is a 100Hz
  *	cascade, into counter 1 which downcounts to reboot. When the counter
  *	triggers counter 2 downcounts the length of the reset pulse which
- *	set set to be as long as possible.
+ *	set to be as long as possible.
  */
 
 static int wdtpci_open(struct inode *inode, struct file *file)
-- 
2.36.1

