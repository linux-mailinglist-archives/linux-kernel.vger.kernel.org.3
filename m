Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40498534FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbiEZNCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiEZNCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:02:01 -0400
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4603FCFE22;
        Thu, 26 May 2022 06:02:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VESMMfK_1653570115;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VESMMfK_1653570115)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 May 2022 21:01:56 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     andreas.noever@gmail.com
Cc:     michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] thunderbolt: Fix some kernel-doc comments
Date:   Thu, 26 May 2022 21:01:54 +0800
Message-Id: <20220526130154.89745-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

drivers/thunderbolt/ctl.c:701: warning: expecting prototype for
tb_cfg_start(). Prototype was for tb_ctl_start() instead
drivers/thunderbolt/ctl.c:722: warning: expecting prototype for
tb_ctrl_stop(). Prototype was for tb_ctl_stop() instead
drivers/thunderbolt/ctl.c:930: warning: expecting prototype for
tb_cfg_write(). Prototype was for tb_cfg_write_raw() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/thunderbolt/ctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index e92c658dba1c..e5ede5debfb0 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -694,7 +694,7 @@ void tb_ctl_free(struct tb_ctl *ctl)
 }
 
 /**
- * tb_cfg_start() - start/resume the control channel
+ * tb_ctl_start() - start/resume the control channel
  * @ctl: Control channel to start
  */
 void tb_ctl_start(struct tb_ctl *ctl)
@@ -710,7 +710,7 @@ void tb_ctl_start(struct tb_ctl *ctl)
 }
 
 /**
- * tb_ctrl_stop() - pause the control channel
+ * tb_ctl_stop() - pause the control channel
  * @ctl: Control channel to stop
  *
  * All invocations of ctl->callback will have finished after this method
@@ -912,7 +912,7 @@ struct tb_cfg_result tb_cfg_read_raw(struct tb_ctl *ctl, void *buffer,
 }
 
 /**
- * tb_cfg_write() - write from buffer into config space
+ * tb_cfg_write_raw() - write from buffer into config space
  * @ctl: Pointer to the control channel
  * @buffer: Data to write
  * @route: Route string of the router
-- 
2.20.1.7.g153144c

