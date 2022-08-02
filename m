Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79236587BFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiHBMIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiHBMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:08:48 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5554D83B;
        Tue,  2 Aug 2022 05:08:43 -0700 (PDT)
X-QQ-mid: bizesmtp71t1659442111t5u4881p
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:08:29 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: cbck7jzG4wb+TU89ydOaXfDkxfj3cykWmoTPgMDJ3wpzyGE9g8fX1VqCwh1Bm
        9bsWs1/gKqHqOdHYo6ZStwtJC35E23u3mVWTudbDU0hxNddUZb7lPwVU++AfUj4G4echLWW
        YnI4HoJzEa7JovTS7etEHx3r5vcrY//44JSiQpQWv8TG9RGus758XkytsXHuDba508FoHoN
        RbY4li+WkWmZRmp4KkeR2OxZUYsY+n8xyGx2a3Mj89f+jhAcy24Pb6QPpikWLjOJ73cu9bs
        +TtjTBWE7kP9U/IGXR3T5mPb8tPLkkbExlfg8MsYbVEoZ9dQIG5hLhfXchZ3XO6FWN+243J
        aJDYtN9kPurA94+TsGbVKMxFZLM7l30z33mxstZWTl3fWMwBW/zYVvmlaxmJcDNRAQgmjuK
        7o2WOcvdRAE=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     stf_xl@wp.pl
Cc:     castet.matthieu@free.fr, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] usb: atm: ueagle-atm: Fix comment typo
Date:   Wed,  3 Aug 2022 04:08:28 +0800
Message-Id: <20220802200828.6092-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RDNS_NONE,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `was' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1

