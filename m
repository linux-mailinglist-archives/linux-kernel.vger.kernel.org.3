Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90205545F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347451AbiFJImJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbiFJImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:42:07 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219551FA6C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:42:02 -0700 (PDT)
X-QQ-mid: bizesmtp63t1654850386tif11fbf
Received: from localhost.localdomain ( [182.148.15.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 10 Jun 2022 16:39:31 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8cOxDPLyuwRmzpNsjh1fQNcUTozYbxsddqVmpR3yZs0SiudcbKuW
        RztaTflJn89M1v+BOmlBdDa67Dqc3AM2U+2aTwLZZQr7fS6zQBwKnW8Ev/oqeRt8fx55g3l
        drXo36cmFGxsaESEYQSBJ1zLmie7lS+WoJ7w1cTWRItUSFh8DpAy0eh3H0S4mBtOlQj/2Cl
        TSZkVfcfVDmyeVcqjDGSNCFWG7C6c5IaxlzEwRFzEE88l0VI80XJN3BysvO23HZ4tVJgZQb
        Bsi7KGinRDb4BnuRYehbOqQCJJ8KuhFHI12Xw8OcQkDsHVVJWficNWXYJF1zFKmJEERi2in
        ih7HJyubBOsb0/Q0EAV33Tpp0QN4WANMIimkTg7
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     geert@linux-m68k.org
Cc:     funaho@jurai.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v2] m68k: mac: Fix typo in comment
Date:   Fri, 10 Jun 2022 16:39:24 +0800
Message-Id: <20220610083924.32877-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'an'.
The second "and" should not be deleted, but replaced by "an".

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
Changes since v1
*Change comments "and and" to "and an"

 arch/m68k/mac/iop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index de156a027f5b..010b3b5ae8e8 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -25,7 +25,7 @@
  *		  check this.)
  * 990605 (jmt) - Rearranged things a bit wrt IOP detection; iop_present is
  *		  gone, IOP base addresses are now in an array and the
- *		  globally-visible functions take an IOP number instead of an
+ *		  globally-visible functions take an IOP number instead of
  *		  an actual base address.
  * 990610 (jmt) - Finished the message passing framework and it seems to work.
  *		  Sending _definitely_ works; my adb-bus.c mods can send
@@ -66,7 +66,7 @@
  * a shared memory area in the IOP RAM. Each IOP has seven "channels"; each
  * channel is connected to a specific software driver on the IOP. For example
  * on the SCC IOP there is one channel for each serial port. Each channel has
- * an incoming and and outgoing message queue with a depth of one.
+ * an incoming and an outgoing message queue with a depth of one.
  *
  * A message is 32 bytes plus a state byte for the channel (MSG_IDLE, MSG_NEW,
  * MSG_RCVD, MSG_COMPLETE). To send a message you copy the message into the
-- 
2.36.1

