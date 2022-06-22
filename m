Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD617554319
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350986AbiFVG3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiFVG3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:29:11 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FFF13E9A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:29:06 -0700 (PDT)
X-QQ-mid: bizesmtp90t1655879336tbj1o6i1
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 14:28:44 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: HoyAXBWgsklVvob0kjHjkPepFLnQrxhtfvdDLL6RxEdYS0fYuJCAo0sqkm9Hx
        d8ipVibSteWdQDAPhONQrlk7kUQz3sd9W4X/wqEXcIk8ymH26SedI9fxLa7EH3tParpoYt1
        J7tdHWn4UBqFzwjZPRC2B1IbVrna7GwSVx2PzvaQ/9R320s1OZocuHV+G5zZ179oOVPBBUG
        4tKTSiYFrRt+6WlEPaS0zPYlJwgsM9aTEO7yFUBzDO9wi23uo3dKq3zR62Am+h2l5CTgeoT
        +rAKKmtLkeU0HoYYV8afEdTtUmkW7q7zVlzxGAvwRrAsPgOIELmc081apgumQV6EzqaUqnS
        7MxplLKRwK6snyn+xk=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gerg@linux-m68k.org, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] m68k:coldfire:Fix typos in comments
Date:   Wed, 22 Jun 2022 14:28:35 +0800
Message-Id: <20220622062835.53980-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
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

