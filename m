Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE77578053
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiGRK4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiGRK4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:56:17 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB34DF60
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:56:11 -0700 (PDT)
X-QQ-mid: bizesmtp88t1658141759ta2aiv9i
Received: from harry-jrlc.. ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 18:55:55 +0800 (CST)
X-QQ-SSF: 0100000000600010C000B00A0000020
X-QQ-FEAT: CmYupcol+WfxU1mjklTmx7HSTiwA6Q6Z5IcXBORdbcBbOYU3Rg0oGAh/Vsamb
        5WxON2dbYuCHZhrt0dC/ys4QN/37pSaitIG18zcVm48WbCVkfq2A3xQkmLAtZkpGCY2QUS+
        szjstlvr78UAlR+gNCpIs2CaxhqMntRslFU35tBG3Ew9CJ5r9kOcXJ4OjD9xjwUcHvB2r1m
        VT5I49HhTwfGUVynyfXoKVNboS0diVOCJeEx98ASRAjMR0RwSFT+B/uxxQtw1vYCq2kv9EU
        2xmTO+I0qn26kg1/WSl74VFzjJWD6AyRGQD8mHk1Uidu4NTDc5a5pb3c1/yHsNYHFc9JgY7
        wXQiti6+Tw/ioa5hrZtMy2b31Fo4cVSbuza1aso
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] m68k:do not initialise statics to 0.
Date:   Mon, 18 Jul 2022 18:55:53 +0800
Message-Id: <20220718105553.6529-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
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

Delete static variables initialized to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/m68k/q40/q40ints.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 6886a5d0007b..dfb307ba1185 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -201,8 +201,8 @@ static int ccleirq=60;    /* ISA dev IRQs*/
 #define DEBUG_Q40INT
 /*#define IP_USE_DISABLE *//* would be nice, but crashes ???? */
 
-static int mext_disabled=0;  /* ext irq disabled by master chip? */
-static int aliased_irq=0;  /* how many times inside handler ?*/
+static int mext_disabled;  /* ext irq disabled by master chip? */
+static int aliased_irq;  /* how many times inside handler ?*/
 
 
 /* got interrupt, dispatch to ISA or keyboard/timer IRQs */
-- 
2.30.2


