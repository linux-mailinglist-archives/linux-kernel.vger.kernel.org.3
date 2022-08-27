Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9349A5A38C4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 18:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiH0QbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiH0QbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:31:02 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260B4371AF;
        Sat, 27 Aug 2022 09:30:56 -0700 (PDT)
X-QQ-mid: bizesmtp74t1661617853tz05ch9f
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 28 Aug 2022 00:30:47 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: NCCf6GxSCju50Zjnv1G3SZWBMuaBiM2psi+N6v8lrG4tF04IR0aXJ38AsTUQP
        wkzX9t9jKQ9nF1JUnzM+qIt15oti78F9k6g5wyswR/+polvyNw14+e/C5nh1NnmiFHoipop
        SATzNdheYgU7E1ZS2VwFLqYEs+i7BFcVlopei9zwdhKwHOkAWgXC1tKwAZENxYfLwjsSKDm
        OynNAaI1mJ46pP+MXbplOWvxmC7UefNcJjzxawn7L/AkPwivOLb7a53iUk9Q3JDbxN+ZL7m
        9qBz6KkemYXRCxSzVdqiVZ8lX3xhPVV5Gj4RRbIydNkYTWCTqenTTSf68iVCiP4jFSa2ufo
        Sr7MoDA00eVY1ey/CkK8w/ZGxV80gMmS7+hJ9F+rOdvU6Kmp5o=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] tty: Do not initialise statics to 0
Date:   Sat, 27 Aug 2022 12:30:47 -0400
Message-Id: <20220827163047.22095-1-dengshaomin@cdjrlc.com>
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

Compiler will initialise statics to 0, so there is no need to do that.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 arch/alpha/kernel/srmcons.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 6dc952b0df4a..5024318b14a8 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -23,7 +23,7 @@
 
 
 static DEFINE_SPINLOCK(srmcons_callback_lock);
-static int srm_is_registered_console = 0;
+static int srm_is_registered_console;
 
 /* 
  * The TTY driver
-- 
2.35.1

