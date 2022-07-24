Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6326B57F3B6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiGXH35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiGXH3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:29:54 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A319013;
        Sun, 24 Jul 2022 00:29:49 -0700 (PDT)
X-QQ-mid: bizesmtp62t1658647783twvij97l
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:29:42 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: Lfq70Ube13yuzBrwXroEteH1PxUw5SIslGMQ5UjO9mI8a2VNZptZtO19vDBmO
        JrGHJ+OaSDNjWlCv4vzIgHbGWXCVPNVuncaLiKnY9o8lEvCE+ctdX6DmIW2SyVf1IJE9KmD
        2U6TYTARrAjDT73zj7g66DZ10hIkdfeDJ9dD0AD26fF9qEX5D5cZtw/FootSLBhWndTlcGG
        BqQi3wbQUPEzAmOIzQ133BZRntpk7hKQP2udAgaxyiNmG208rXHiB2DGuXE27K1beJtz9Tv
        tarFysXs4Tisw9Gse2UvlEy+ZzBtMAnlUWxC1Y28mpl8Bq21CVykdEfSdwyC5JTM8gWgq+f
        JfjY3kXtLd8VvihAn3utPQiQqbgXzoEnIVNmduS5LgH7/sIHko=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] input/serio: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:29:35 +0800
Message-Id: <20220724072935.14227-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/input/serio/q40kbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index bd248398556a..b2b572079e67 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -81,7 +81,7 @@ static void q40kbd_stop(void)
 
 /*
  * q40kbd_open() is called when a port is open by the higher layer.
- * It allocates the interrupt and enables in in the chip.
+ * It allocates the interrupt and enables in the chip.
  */
 
 static int q40kbd_open(struct serio *port)
-- 
2.36.1

