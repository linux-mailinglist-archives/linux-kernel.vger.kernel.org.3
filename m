Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C94C53BDC5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiFBSJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiFBSJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:09:43 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE629C80
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:09:38 -0700 (PDT)
X-QQ-mid: bizesmtp75t1654193368t3ree0vg
Received: from localhost.localdomain ( [117.176.187.31])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Jun 2022 02:09:21 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: ddlUhmC0HYuUgOt6BCAn3RkrdkLk7QCyCdnsP2jd2sDr9WVqgjwkffivrXMrN
        Q6HEe9zsISwvxFesHcdZrvT3zTyF6GhJ5XHNXiefGZR0Yklpd2/1q7gGIMDPIBzAbDp5WxV
        o5xPILjYpiy4SzW9Hjk3pmDREVsjqsr0td84ba4jrgk3FLLEvNBHYZYZ+5yCuDGR1GsSOX0
        gAEqYfRxiaejE8tjoqa4eTS74yc4F0WX5QtwmDg1v8NgWdzH9GvxJ8ynzDzSHLRkCUmW+zt
        ZLx7Wu1ijBW7GavXfDL2ZOiAy08/A5zhKdIwo3fdVPYqMrgGNQzZDYjnWJDnZdFpVjYngCh
        AwjPP907aN4Xuz7lWY=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     gerg@linux-m68k.org
Cc:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] m68k: Fix syntax errors in comments
Date:   Fri,  3 Jun 2022 02:09:19 +0800
Message-Id: <20220602180919.4856-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/m68k/coldfire/intc-2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/coldfire/intc-2.c b/arch/m68k/coldfire/intc-2.c
index 995093357c59..376e37855ebd 100644
--- a/arch/m68k/coldfire/intc-2.c
+++ b/arch/m68k/coldfire/intc-2.c
@@ -7,7 +7,7 @@
  * family, the 5270, 5271, 5274, 5275, and the 528x family which have two such
  * controllers, and the 547x and 548x families which have only one of them.
  *
- * The external 7 fixed interrupts are part the the Edge Port unit of these
+ * The external 7 fixed interrupts are part the Edge Port unit of these
  * ColdFire parts. They can be configured as level or edge triggered.
  *
  * (C) Copyright 2009-2011, Greg Ungerer <gerg@snapgear.com>
-- 
2.36.1

