Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854DB5548DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiFVKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiFVKqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:46:32 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B4339814;
        Wed, 22 Jun 2022 03:46:27 -0700 (PDT)
X-QQ-mid: bizesmtp69t1655894775t9r7j66b
Received: from ubuntu.localdomain ( [223.104.103.173])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 18:46:10 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000D00A0000000
X-QQ-FEAT: Jd++W0FxedHF5QzLnyr3TfpgjzXat/iGWZqC8gT0KAwwiMBY4RuAfJcSfAYWT
        HvjHIcYTOc+24MMwTkp71VlhhiJLWXp2ZTzu0Yx+xLSTo2RRfVdgY71fAcQsTlkqRH9agiC
        emARUnGd6b2pZnS9Mawro2upbALVCfZ0LfC/ic3DDvyD5lpE7YPmO/1Mt5biC0O/NrU4sJN
        wHVJCHa+r8lUgpdAKNENYPoLUQfYXdsIrLT3QdZfqcnbTMuDHvdtd8e1A8bGzfQ9KPOfuao
        l93XGaWdKanOGBe9wHXu8nA8Ln0mDQ9n7+NCPPx9MBJFA4e7GiB+zcxZHRsUkwHpVWUDzN4
        I0M6b8dIuWdgFRMvjoxHNJeHsNLpA==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] USB: serial: cypress_m8: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 18:46:08 +0800
Message-Id: <20220622104608.8871-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/usb/serial/cypress_m8.c
line: 259

     * chose to use the the general purpose firmware or not), if you
changed to:
     * chose to use the general purpose firmware or not), if you

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/usb/serial/cypress_m8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 6924fa95f6bd..da8913683104 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -256,7 +256,7 @@ static int analyze_baud_rate(struct usb_serial_port *port, speed_t new_rate)
 		/*
 		 * Mike Isely <isely@pobox.com> 2-Feb-2008: The
 		 * Cypress app note that describes this mechanism
-		 * states the the low-speed part can't handle more
+		 * states the low-speed part can't handle more
 		 * than 800 bytes/sec, in which case 4800 baud is the
 		 * safest speed for a part like that.
 		 */
-- 
2.17.1

