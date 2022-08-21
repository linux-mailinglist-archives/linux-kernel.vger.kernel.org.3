Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F44A59B4F2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiHUPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiHUPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:17:09 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F37622BFB;
        Sun, 21 Aug 2022 08:17:06 -0700 (PDT)
X-QQ-mid: bizesmtp75t1661095020tj5oj2rn
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:16:59 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: 5x8Sgf4S6/hFWBahP39Rgb4Kf1saLXr/yhurirXQ6SqRGr69wVXNpyKaFE+ft
        eJz/xIN+rUTFqdLXyclRfVptEJUYetaP6RM7n9L3DU6tcoPJ7yK4k8jhrHivyZlvgceNuhd
        klQ6kbtKQU6VYf8VLwlBIMdXCGkoU/USd7PjQlDpJ+mLh4oML28RBp40fDc8eBuuXc3/fUJ
        NYZUbX8ingldU6+hbc6Ezc3HKGN9esizjIAEjKkWSvykLanuc6YalPGT8Du2PQt64BbI7Fw
        zxIWfGK6UxKrc7JFIkIQXoYniiSvMTyZNtIdaN3NCpvSgopc+XZRwDJDztU949uT53bJUjb
        22GWqzFK61CruVzbQERTjXL9vGe/HxQCgtyiuwYgXFJXbfxVsE=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/core: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:16:38 +0800
Message-Id: <20220821151638.58606-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'can'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 68e9121c1878..04a73871254f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2029,7 +2029,7 @@ static void recursively_mark_NOTATTACHED(struct usb_device *udev)
  *
  * udev->state is _not_ fully protected by the device lock.  Although
  * most transitions are made only while holding the lock, the state can
- * can change to USB_STATE_NOTATTACHED at almost any time.  This
+ * change to USB_STATE_NOTATTACHED at almost any time.  This
  * is so that devices can be marked as disconnected as soon as possible,
  * without having to wait for any semaphores to be released.  As a result,
  * all changes to any device's state must be protected by the
-- 
2.36.1

