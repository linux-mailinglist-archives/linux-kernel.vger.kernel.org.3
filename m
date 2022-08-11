Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BA558FBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiHKMLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKMLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:11:43 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E7956A6;
        Thu, 11 Aug 2022 05:11:41 -0700 (PDT)
X-QQ-mid: bizesmtp91t1660219897t7fi4bbx
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:11:36 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: izenvNSMpb2fBsYHDX/nyEI9YI0MZYUayuTWXXnlNWuJF2TC+/gBQ+f+lAT4V
        YUUnCJEItbG+5vi/5IezJWxd3DdMmb4nCf2PMa13RgN0uSyF3IjReXICDlpEWmGxtESGTMp
        2ZZz6xKEE5tNgx6qUjW/bh3DXZ/en7/vvNVub5saD8A2tS8ChLU+hCWkEhz59UZpWwYfWKH
        aoLjBx0l73k5q379IrLTiXcbO2T1OOYi9PD3so6FStyffurkC5V1+5ACl6DQUWC625RkN+M
        9h0EdU7dBlDMpg+K7SgMb4qQwM0E4q21vfY4hNNb4dZOVWSjz91YTOLfMJXP0HcYuqhB51L
        LPe0ctxCvrrtwt3Gzlr3IydDAzZQGMuANAsxCfysjaGpJ9N7hisJ6iNnwHUJt1KTG2ObYI0
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tony@atomide.com
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] bus: ti-sysc: Fix comment typo
Date:   Thu, 11 Aug 2022 20:11:19 +0800
Message-Id: <20220811121119.20288-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 51d772bb8046..2386e8013e18 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -915,7 +915,7 @@ static int sysc_check_registers(struct sysc *ddata)
  * within the interconnect target module range. For example, SGX has
  * them at offset 0x1fc00 in the 32MB module address space. And cpsw
  * has them at offset 0x1200 in the CPSW_WR child. Usually the
- * the interconnect target module registers are at the beginning of
+ * interconnect target module registers are at the beginning of
  * the module range though.
  */
 static int sysc_ioremap(struct sysc *ddata)
-- 
2.36.1

