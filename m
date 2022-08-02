Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D26C587C13
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbiHBMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbiHBMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:12:58 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF294D83A;
        Tue,  2 Aug 2022 05:12:54 -0700 (PDT)
X-QQ-mid: bizesmtp76t1659442224t38kaiui
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:10:22 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: CR3LFp2JE4kvdAkg1838GGR9h1B20aUDo+DYhQrsi99En5o0bwJthNDcQ5DRs
        JeCQObOQ6GIX+kQ3dyrpJ/BF0TKQy+sJ/aUL9tLn/3HCTAKAbIV7ymKxd3SXN42eW4mHV13
        wpBrTKmJKRDMSoPKfhdQok1XXDawHk7IQl9HLb9C8S+G5G8M2W4vkRrBV70xVv4HqnDCe4H
        tHYcYv7hN7ahNU6DmniODa+05HuEtXQJT+pj7Y7RtlnirqmLN3F7r6RfgjLxCbvVmxWKI4j
        Z3dmVJq+5Dvm3pLPliri0QN6wuZmf6nogCL7Lvb0q0mBk5zYgSA27oq2lAFYiMlcEkSPuyb
        G3f8zyjHgcB3p4U5W7k2Yq9f39P/x581896qnbRvx38D86dtCy7cNvQvBPG3Q==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mathias.nyman@linux.intel.com
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        kai.heng.feng@canonical.com, dianders@chromium.org,
        dan.carpenter@oracle.com, m.grzeschik@pengutronix.de,
        mka@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] usb: core: hub: Fix comment typo
Date:   Wed,  3 Aug 2022 04:10:19 +0800
Message-Id: <20220802201019.6657-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `can' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 2633acde7ac1..7d19f09dbd01 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2036,7 +2036,7 @@ static void recursively_mark_NOTATTACHED(struct usb_device *udev)
  *
  * udev->state is _not_ fully protected by the device lock.  Although
  * most transitions are made only while holding the lock, the state can
- * can change to USB_STATE_NOTATTACHED at almost any time.  This
+ * change to USB_STATE_NOTATTACHED at almost any time.  This
  * is so that devices can be marked as disconnected as soon as possible,
  * without having to wait for any semaphores to be released.  As a result,
  * all changes to any device's state must be protected by the
-- 
2.35.1

