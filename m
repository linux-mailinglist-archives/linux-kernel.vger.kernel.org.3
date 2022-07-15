Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED50057840D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiGRNoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiGRNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:44:04 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767C2BD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:43:59 -0700 (PDT)
X-QQ-mid: bizesmtp78t1658151835tnq0bkhj
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:43:53 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: r/cTxDoDoiF3HCrEHCv9biv9VXFbohB0C5Cp9KHCi5ERz3Du3npci8/OyTrwA
        8udCmJBCfOtws/rtSqyzme0eeE2NXce5nY7vFTECU2kxNFrls05Xu7XqEYZ5y4WAlMwUj+G
        2YNj6NhITif9Y6PzZMvfhieqwh1TqzdVerXUMJlv9W0KFjejYmfndRXDlMALfTO2SkxQlVA
        Jd3auJd+AEUdGX5fE1xbMAfBfYQVf2UqJT5woE/Hr8cKtP7lPv6UamuvwLzd3kihC3Z4G7J
        tlGZndqXb9WUcSWqrvXzuZzmurLOsEGjDeQu2iDjJsOEWuYmqMHYi7O/cbOzE2Qm35latC+
        xuOS6HJwIJP/ozcI5J/WkhM/hmbean6/4/S8TOPIkZ8VIhMzH+OwKXsYw6IqjGMsCGxCzsp
        Ot1V1QRF7FqhFOc0T0Y3sw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     openipmi-developer@lists.sourceforge.net
Cc:     minyard@acm.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ipmi: Fix comment typo
Date:   Fri, 15 Jul 2022 13:41:56 +0800
Message-Id: <20220715054156.6342-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in line 4360, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 703433493c85..c8a3b208f923 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4357,7 +4357,7 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
 
 			/*
 			 * The message starts at byte 4 which follows the
-			 * the Channel Byte in the "GET MESSAGE" command
+			 * Channel Byte in the "GET MESSAGE" command
 			 */
 			recv_msg->msg.data_len = msg->rsp_size - 4;
 			memcpy(recv_msg->msg_data, &msg->rsp[4],
-- 
2.35.1

