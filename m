Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70D554449
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351266AbiFVHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349834AbiFVHg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:36:27 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F5237034
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:36:18 -0700 (PDT)
X-QQ-mid: bizesmtp80t1655883369tezf4fg1
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 15:36:03 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: nBdYY0iG3IoCqkNbUznHd+mt0FG3OWXKFJvOAOGyC3A0yFix1+g0LteJfOUW9
        rIfVRvwTFSlfgO2i2ZedgnoBroOdg/CgKEcdUX9va6BW8a3fzLJZNe4CeL3n5CX1FhJljIn
        6seXzh1o+geItsKO8IdKsVAO6VJGu85bR0/sxtwFlLearGzWvHwSZIxj1f6VpKJB6pb6CbV
        8/dEwh5STKqn+LWrCF303H6DdXo/w6bUtbV32ji4YGz87lRinBmJvfFU7LxOasdJkANtSIe
        5LvIUeSGEnx/32pZMKpC+jfbc0XZEm7dORNgzxvxUATZVWQ2cDNR9izc62wfsDpyef68e/o
        P0IQwJr8h8r4Ic9psc=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gerg@linux-m68k.org, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] m68k:coldfire:Fix typos in comments
Date:   Wed, 22 Jun 2022 15:35:53 +0800
Message-Id: <20220622073553.64991-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The "the" should be replaced by "of" instead.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/m68k/coldfire/intc-2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/coldfire/intc-2.c b/arch/m68k/coldfire/intc-2.c
index 995093357c59..f74f0e473119 100644
--- a/arch/m68k/coldfire/intc-2.c
+++ b/arch/m68k/coldfire/intc-2.c
@@ -7,7 +7,7 @@
  * family, the 5270, 5271, 5274, 5275, and the 528x family which have two such
  * controllers, and the 547x and 548x families which have only one of them.
  *
- * The external 7 fixed interrupts are part the the Edge Port unit of these
+ * The external 7 fixed interrupts are part of the Edge Port unit of these
  * ColdFire parts. They can be configured as level or edge triggered.
  *
  * (C) Copyright 2009-2011, Greg Ungerer <gerg@snapgear.com>
-- 
2.36.1

