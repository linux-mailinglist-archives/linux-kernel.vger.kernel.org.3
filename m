Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AA5576E1F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiGPNNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGPNNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:13:50 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB2E1EC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 06:13:42 -0700 (PDT)
X-QQ-mid: bizesmtp91t1657977209tojpb1pg
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:13:20 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: VqIPTbZ3iV2ZCV/45OMlU4gQPrvTTqKj/8An4aWfdo0LQUsJFdjaxxb6s6RKy
        9ZEbeQT/mxN5/Ba9DkMPwxmOIxoQiYV6aUA3tHon9ldeLI2JaF2uOE9jXZQnjagfjhqvmjp
        YcuvEcZmCZCx9wTeaFKChDN0FTIXCK0eWNRTK7y/rxLf9ZMVVU4ZRlOQ5S9udByJFomastS
        jeyfjiFlyxEpCZzvuQgdRIHWGSe7rJtL8dqvKqa/TTCovYrX6kOZ7oP/gRmGZHi3CKxFy3E
        Mw6Amh7/0fTiMu1QHXbt65r28iBgjdMXvJhLK7436jeABrR2e1RAjKUX2W/qCCqJUjpd7jG
        r9+UqgdDT03idnpCK0E2zMFG12n6dkAC+7564HG
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     castet.matthieu@free.fr, stf_xl@wp.pl, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/atm: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:13:12 +0800
Message-Id: <20220716131312.31767-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'was'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/atm/ueagle-atm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index 786299892c7f..5812f7ea7f90 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -9,7 +9,7 @@
  * HISTORY : some part of the code was base on ueagle 1.3 BSD driver,
  * Damien Bergamini agree to put his code under a DUAL GPL/BSD license.
  *
- * The rest of the code was was rewritten from scratch.
+ * The rest of the code was rewritten from scratch.
  */
 
 #include <linux/module.h>
-- 
2.36.1

