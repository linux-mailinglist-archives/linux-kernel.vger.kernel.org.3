Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE16576E44
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiGPNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPNlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:41:36 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3051CFD5;
        Sat, 16 Jul 2022 06:41:30 -0700 (PDT)
X-QQ-mid: bizesmtp66t1657978885tcpa5y94
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:41:22 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: hItiEz2SZNLkk3ygyGT3GTihHMkj0G0d5Fnkl/yQq2zuSbclJocP4T2FXA+Uy
        T8LJ4f6k5BUpIDVs+kmFLpgCFbLBd0Su9z4UkCWxlBPo+3SrjODmWkqKDBBLWvubdEkaRUe
        0lSjdqyK1RNPtO7BLXWpOYZxwBXkK3Q5rtOFkRS3q7CglAYsgoVyhE1xAXzUIvQE/FxDzCf
        Eb117pE/qlSCMyC8snshuQ6b1WnMyh/gInvVArQxl5a0SQ77EbUEDU6skoRaGUAF7QaKIdG
        /7DDZGmlZU7suOzJp0ZGSqQQUX2fwlO+ZKKOAWQF4bBr9suLYTQN+yF8FNYSTjfarMAaARn
        TYaxs1hTRtyQ+UQPHwaOx8yLud7jy5Jgpa2h33LD4bynGqWYg1/P25QuR0ZcQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/misc: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:41:05 +0800
Message-Id: <20220716134105.44710-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'with'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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
2.36.1

