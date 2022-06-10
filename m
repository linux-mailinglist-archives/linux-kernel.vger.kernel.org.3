Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBC4545EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346851AbiFJI0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347678AbiFJI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:26:36 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66A417CC2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:22:17 -0700 (PDT)
X-QQ-mid: bizesmtp78t1654849322teff790j
Received: from localhost.localdomain ( [182.148.15.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 10 Jun 2022 16:21:57 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: IBzvWsVKsbiz2eu4BK/wnJ8fyZnzf/4qSyLzCSJ7lxl8O6S4hjP26FXoVmW9s
        E2AvUUEhXeDUZIQZoj+oX0Tz8RCLRXb1HFSiUwkXfWlJe5FY3+pu4YwtRHiBFqrcl32PKsJ
        Y0BW63fKM2qzIW9VC6WiS6wGlZjG216HVN5rKxKFmc3HfhAyFu1Ljxpp/yvMKbCXEpCBDV3
        1pNfQ7UXY0vtZoDWMiu4unU7yMVef/JlihvKHnTIUAJuaP7C6uZqUAFPa9oLqHd9Xj3fHRk
        bC+JJFfAFMSJ7TyatFovSnkzQrLQD0vjJ45xqX89lnt3j/lDCJn5Hx0SxiTKHPGn2GQJz13
        9jdpsDzs9QqxJ7YWvnrJZN6L7NKlg==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     geert@linux-m68k.org
Cc:     funaho@jurai.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] m68k: mac: Fix typo in comment
Date:   Fri, 10 Jun 2022 16:21:50 +0800
Message-Id: <20220610082150.23677-1-wangxiang@cdjrlc.com>
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
Delete the redundant word 'and'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/m68k/mac/iop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index de156a027f5b..b0e1db19f45f 100644
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
+ * an incoming and outgoing message queue with a depth of one.
  *
  * A message is 32 bytes plus a state byte for the channel (MSG_IDLE, MSG_NEW,
  * MSG_RCVD, MSG_COMPLETE). To send a message you copy the message into the
-- 
2.36.1

