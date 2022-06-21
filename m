Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07961553276
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350656AbiFUMtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348761AbiFUMtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:49:07 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CC726AFB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:49:01 -0700 (PDT)
X-QQ-mid: bizesmtp68t1655815727t3pjrs78
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 20:48:42 +0800 (CST)
X-QQ-SSF: 0100000000700050B000B00A0000000
X-QQ-FEAT: NFbnPP6/4uIWMRe2RVMSAfxCWYTHS0vEZozftO/LFJyz3ZdYfuV7c2DCcw+15
        9mZ9yZr/m8R+cDcM//CL5WYPwT6VHhemBX/ln+P1U7b6F843gRji404H6twHU+YbhfFpnlz
        kNZP548R0GGp+vxogwFKUlwvsTQto22S1NlF3oIKFplM+3OEWRjyYcgiWAaYBUKWNeYcopN
        LW0dpVUS+1Hetigf4VSIvq/wCYxFUX4JsauHmFyH1vyNPmpKqy1+ayvvE/GX+pVxyRWKm9g
        l+CSDwXvEh38hSBlPqn0GoSgEQPt0Z/sQS2jRm10Y3b5+uE5QbZ6biUO+lwApgyJBC/ythk
        AbK+Er14/vSE59GMIDLC8srCy5NFA==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     robinmholt@gmail.com, steve.wahl@hpe.com
Cc:     mike.travis@hpe.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] sgi-xp: xpc_uv: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 20:48:40 +0800
Message-Id: <20220621124840.119875-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: ./drivers/misc/sgi-xp/xpc_uv.c
line: 1601
 * to put the the msg_slot back on the free list.
changed to
 * to put the msg_slot back on the free list.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/misc/sgi-xp/xpc_uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
index ba9ae0e2df0f..fff522d347e3 100644
--- a/drivers/misc/sgi-xp/xpc_uv.c
+++ b/drivers/misc/sgi-xp/xpc_uv.c
@@ -1598,7 +1598,7 @@ xpc_send_payload_uv(struct xpc_channel *ch, u32 flags, void *payload,
 		 * by xpc_notify_senders_of_disconnect_uv(), and to also get an
 		 * error returned here will confuse them. Additionally, since
 		 * in this case the channel is being disconnected we don't need
-		 * to put the the msg_slot back on the free list.
+		 * to put the msg_slot back on the free list.
 		 */
 		if (cmpxchg(&msg_slot->func, func, NULL) != func) {
 			ret = xpSuccess;
-- 
2.17.1

