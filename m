Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC5576E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiGPNYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGPNYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:24:30 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24FCB861;
        Sat, 16 Jul 2022 06:24:24 -0700 (PDT)
X-QQ-mid: bizesmtp65t1657977852tbzk9yep
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:24:10 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: XBN7tc9DADLcu2uX1djkO7Gts01/A6b0NkR6RGNeCs+SC6nJ8/WEgj7daYA3l
        yIpX+/FdIw/TIuQgryNA/GRuB/FxuZAvKtu4jntTNLuvMdx83L9fecKmc8eoSACGUbiDTbX
        N4BrumRnJNQ/uxE3ArqI3wA53TdfsM8tRkgwno6iqb2cTLMOtGUVf11TZ6crEFAJ/IxPZ9+
        I3yBRWIYgVXANBIfotj+BIrvl8kmbeCCWPy0SRQoqIXpXS2yAmiU+GpPYyE6zeahGnF8o9+
        urM91KN3LPYKdrEYsEKSAUur/vQwcigFngHuX0KUdLWfM1CdeKiWnJzhxu/s7jSiL1eSE41
        YKLQe9oFkJ8NFOQld22KEQf1qPmEvhuFaZNJPp5XjBah0FNHt7jwrX/ILjjHeC7ZQIpJBXV
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, jj251510319013@gmail.com,
        heikki.krogerus@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/core: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:24:03 +0800
Message-Id: <20220716132403.35270-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/core/driver.c | 2 +-
 drivers/usb/core/usb.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index b87452e22835..7e7e119c253f 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1482,7 +1482,7 @@ static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
  * @msg: Power Management message describing this state transition
  *
  * This is the central routine for resuming USB devices.  It calls the
- * the resume method for @udev and then calls the resume methods for all
+ * resume method for @udev and then calls the resume methods for all
  * the interface drivers in @udev.
  *
  * Autoresume requests originating from a child device or an interface
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 2f71636af6e1..11b15d7b357a 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -801,7 +801,7 @@ EXPORT_SYMBOL_GPL(usb_intf_get_dma_device);
  * is simple:
  *
  *	When locking both a device and its parent, always lock the
- *	the parent first.
+ *	parent first.
  */
 
 /**
-- 
2.36.1

