Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6983658EA75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiHJKaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:30:15 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F07F2611;
        Wed, 10 Aug 2022 03:30:13 -0700 (PDT)
X-QQ-mid: bizesmtp65t1660127408tjw07dsw
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 10 Aug 2022 18:30:01 +0800 (CST)
X-QQ-SSF: 0100000000200050B000B00A0000000
X-QQ-FEAT: SFhf6fKhx/8zobKRJHvEpxeB4d8W7ooEEJ6PlN7CphtEVGpfhkt1xLZWWHacD
        8xPRJgI3ihWNKl9Nm5sOnC5LKVUL8ZcouwHxSSro/82Sr6svm+v34JgJaQ8t967y4qft3XD
        /tQMlVbslHaleSJSDDsTs0GIZSuRLVykvZhM7ri3fv4Ud8rBTsvX4AzMBXvRWNMh4dMvznC
        jCszZIcZLisJT/j9yFp8Z2+fNtWjj1RoRQvSTaGWzWsgCu6DOAFwgX0FWtvID4dZobOmJXQ
        xJJhVscuxtwqTK4DmBKgDRTLaowPhSHgMXl6Qyps54gEetaBlIq33HyIFF8aN9mHQu/epy7
        S1d1K0vxs7TphGV8CuDSANICaHSWSVfUIy6/rRv5bWq3BM12q1QSdGTNJ7BlKdvLxTLJ2ze
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] usb: usbtest: Fix typo in comments
Date:   Wed, 10 Aug 2022 06:30:00 -0400
Message-Id: <20220810103000.8721-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
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

Delete the rebundant word "with" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/usb/misc/usbtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 150090ee4ec1..ac0d75ac2d2f 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -2638,7 +2638,7 @@ usbtest_do_ioctl(struct usb_interface *intf, struct usbtest_param_32 *param)
  * different busses) to use when testing, and allocate one thread per
  * test.  So discovery is simplified, and we have no device naming issues.
  *
- * Don't use these only as stress/load tests.  Use them along with with
+ * Don't use these only as stress/load tests.  Use them along with
  * other USB bus activity:  plugging, unplugging, mousing, mp3 playback,
  * video capture, and so on.  Run different tests at different times, in
  * different sequences.  Nothing here should interact with other devices,
-- 
2.35.1

