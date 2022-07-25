Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CBC583F26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiG1Mpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiG1Mph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:45:37 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5CE1A5;
        Thu, 28 Jul 2022 05:45:30 -0700 (PDT)
X-QQ-mid: bizesmtp65t1659012326tdbgplrz
Received: from localhost.localdomain ( [171.223.98.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 28 Jul 2022 20:45:25 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: SFhf6fKhx//w7iSJlCXhT6KJ3Wj3HCbMRbGOtz0uibZcblkdhhoPLS/lcCr+5
        oXTAHNKyFmkR3glz2P8kIb2ytq6V1M1A+hBx/ENKNVok34+bOiWlyepamY3Z7Y3b9yTUY8v
        xWtZidhoTStqYm1/zRabKyo18i8qPnpyOdbGD08FNXwbvQjjn4yDJ3YdBUFQNj/JjNj4nNK
        J1uJSFxjHEMS5lN9K/4Giat1tr5jquS/uctZLvolG74ForJoQsQIuaesBlZlgsYL9YeiGyN
        cfd9W1/DL2ZkQBZhLEoGSzfwMi6I9yVEosmkSzggwT5A43GWafji23FtL71pLk3mc4LV4dq
        3oqN5euJ2DFTRKlFnTbWG8AQZUOjaHZKV1RWC1pFoTuhCl1iDpJDMzxsy5fJe+ksdITWsyy
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tony@atomide.com
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] bus: ti-sysc: Fix comment typo
Date:   Mon, 25 Jul 2022 12:43:33 +0800
Message-Id: <20220725044333.9161-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
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
2.35.1


