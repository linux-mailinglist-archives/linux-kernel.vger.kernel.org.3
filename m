Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48C95373A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 04:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiE3Cxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 22:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiE3Cxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 22:53:42 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3BBBF77
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 19:53:35 -0700 (PDT)
X-QQ-mid: bizesmtp62t1653879205tazgnq63
Received: from localhost.localdomain ( [125.70.163.149])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 30 May 2022 10:53:19 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: aP2oNmVYkM8uBnFjUZppHeBd4hr0l1hknLqTQdu8GP7UoYNBB7Nu/7pJ+Xp3C
        NB+jfQ7hg5v7dQq61kLhMYvBh4l3W0lF4FzuGyt68/DIUkPinP3U68q98mgm1W9bfNjnSkX
        8GKVNnagIleFTQSKVuDls/wnphjfBGKlURfYmFuwSBhUiHNZ70HL87ENmSSIX+OzQb+ZMd9
        B/5LXEjJ2bxCaotCXBYm/DJkpgiRhp+M8SlaYYTV7AM5UTobI57SVKkIl4J4QoKLgkQZhbb
        UbhF9Fvc78oU1H3DutdioT9dc44fdC/1jn7MHwA1ucp/n48RWpDsmD2C9FGC+yfu2kPSxy1
        JI+tFqeIYZe1AJrNNbDs7SrUY6QQg==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     gerg@linux-m68k.org
Cc:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] m68k: coldfire:Add const to clk_ops
Date:   Mon, 30 May 2022 10:53:12 +0800
Message-Id: <20220530025312.55057-1-wangxiang@cdjrlc.com>
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

Struct clk_ops should normally be const.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/m68k/coldfire/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index d03b6c4aa86b..a0cd4c79f0ee 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -50,7 +50,7 @@ static void __clk_disable0(struct clk *clk)
 	__raw_writeb(clk->slot, MCFPM_PPMSR0);
 }
 
-struct clk_ops clk_ops0 = {
+struct const clk_ops clk_ops0 = {
 	.enable		= __clk_enable0,
 	.disable	= __clk_disable0,
 };
@@ -66,7 +66,7 @@ static void __clk_disable1(struct clk *clk)
 	__raw_writeb(clk->slot, MCFPM_PPMSR1);
 }
 
-struct clk_ops clk_ops1 = {
+struct const clk_ops clk_ops1 = {
 	.enable		= __clk_enable1,
 	.disable	= __clk_disable1,
 };
-- 
2.36.1

