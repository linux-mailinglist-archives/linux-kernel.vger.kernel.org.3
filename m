Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4A558CB56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbiHHPfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243601AbiHHPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:35:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5D7E6F;
        Mon,  8 Aug 2022 08:35:17 -0700 (PDT)
X-QQ-mid: bizesmtp85t1659972903t2p774qw
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:34:55 +0800 (CST)
X-QQ-SSF: 0100000000200050B000B00A0000000
X-QQ-FEAT: +ynUkgUhZJmsNTJJ6yUxxh0wvTEWS2SSLFe934YzFSqBPPwtlzaIYwRfw+rdy
        W7IGy+7s8OwZpC49FKTViEfr5t+Pe2xRj9r/O221D15z1OaUtUkVvfWk6vLYR4GF7wW4HIc
        lRpEF5f4t/dHNi5lTOGQI29cSMWhicqs6OIe2YQ+P56tcL7JivuzPhLnOZicP40vwwIH6Je
        d8Iy9kB65A7rD6iH/6Js8KZOvwWplGRS8S4MsxTFivnJS2efupqQt1jPW8+vKbAHFuyCDtg
        QrP2IabR7Doy6a1sATvk24sym9dh0mSQ3nMdJBtEyexE+QuYP0Uar6+f3nFLxh3I3XHk+0I
        3q6szO80MjkOOT1urPue7XK1MydbhCr71DsqEhYNL+96+1cnf+fYppXegvcj8zX3LOwUuRT
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] rtc: Fix typo in interface.c
Date:   Mon,  8 Aug 2022 11:34:54 -0400
Message-Id: <20220808153454.6844-1-dengshaomin@cdjrlc.com>
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

Delete repeated word "best" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/rtc/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 9edd662c69ac..7c30cb3c764d 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -256,7 +256,7 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	 *
 	 * This could all instead be done in the lower level driver,
 	 * but since more than one lower level RTC implementation needs it,
-	 * then it's probably best best to do it here instead of there..
+	 * then it's probably best to do it here instead of there..
 	 */
 
 	/* Get the "before" timestamp */
-- 
2.35.1

