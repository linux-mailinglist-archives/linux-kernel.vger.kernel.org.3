Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2905AC53D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiIDQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiIDQCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:02:47 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4A438461
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 09:02:31 -0700 (PDT)
X-QQ-mid: bizesmtp73t1662307345tuejhcoe
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Sep 2022 00:02:20 +0800 (CST)
X-QQ-SSF: 01000000000000C0C000000A0000000
X-QQ-FEAT: i+oDgeEbg87WYkZT/inrAGK4MvmNG2d1F7a46nZfduM/rpWR1Ov6wUc+7JWs9
        FnkZPyWz49/MQZ/3cjISdwV7tCWEYb5AvJxkopZd/onzVuZsdreCwu3gR7fI4cA3na1RBrb
        7yE/X4FRCg3piRV4N8KVgVqIqRsATORi7lBZVtlJzZZxCqWt3CFv95+v/t16qF6Hloc0F4A
        52MFU7pGzs6qiHdJ2PSq96pkA7sotuDi6/4F/bEqvioaLTXUh5rhZXMcpGuDStaF8JkhBky
        A5GeYlzct+9gso2nbIEoK+YtWO6GLIeqBdZbwLkhyJEJQbDW8267XTBlC3YdPTmVbLqZDRo
        hKtZDYD4PoG6Y1FA+ekk13pVfa6eQ==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     minyard@acm.org, linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] ipmi:ipmb: Fix double word in comments
Date:   Sun,  4 Sep 2022 12:02:20 -0400
Message-Id: <20220904160220.30513-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the rebundant word "response" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/char/ipmi/ipmi_ipmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
index 25c010c9ec25..0966e95666ea 100644
--- a/drivers/char/ipmi/ipmi_ipmb.c
+++ b/drivers/char/ipmi/ipmi_ipmb.c
@@ -219,7 +219,7 @@ static void ipmi_ipmb_send_response(struct ipmi_ipmb_dev *iidev,
 	if ((msg->data[0] >> 2) & 1) {
 		/*
 		 * It's a response being sent, we needto return a
-		 * response response.  Fake a send msg command
+		 * response.  Fake a send msg command
 		 * response with channel 0.  This will always be ipmb
 		 * direct.
 		 */
-- 
2.35.1

