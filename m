Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10492579A52
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiGSMNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbiGSMMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:12:34 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D88252DED;
        Tue, 19 Jul 2022 05:03:48 -0700 (PDT)
X-QQ-mid: bizesmtp63t1658232196tpkrid79
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:03:15 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: aY2i9zFuVEdYQaK9NrWPr3TcjKUZd4OaaQJYTAEmIEOF7x3r499XB6Wj2cXFI
        omRP31bjPKvsZ6uxADKQoDKUS3dj58z5/7aWdxX1USMbn37qgT81Jcpc8Nr807fwHQl37mN
        W2HRLjAGTlhDiApZQTXllvvDU85Tt0Ktgr76fs5CnqwN4lJtoTtjsL18Pcamu5JCu+xqYZl
        ZldkhVPZFio0Y9Or4e7X1/X4/+NwSAiVQMbcEJ0iAifCZF4hgryT1mBJDRxvPpUNKABArmX
        9VBHXtBnRhVrGS8WXGhe3icI/EbH40a4co4ODQ/8YqbNOkTt5kAPiBJbG/k4xywiQvYUF89
        3M3cOyyw5mM1e1oIT6xELt8G0A28aJx9NGgg8CCraxLgs5OYdOPnxv6knHkANzEn1trFO7f
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     zajec5@gmail.com
Cc:     hauke@hauke-m.de, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] MIPS: Fix comment typo
Date:   Sat, 16 Jul 2022 12:01:19 +0800
Message-Id: <20220716040119.31221-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
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

Fix the typo `s/that that/than that/' in line 72.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/mips/bcm47xx/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 0a63721d0fbf..ab203e66ba0d 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -69,7 +69,7 @@ static __init void prom_init_mem(void)
 	 * call them at the beginning of the boot.
 	 *
 	 * BCM47XX uses 128MB for addressing the ram, if the system contains
-	 * less that that amount of ram it remaps the ram more often into the
+	 * less than that amount of ram it remaps the ram more often into the
 	 * available space.
 	 */
 
-- 
2.35.1

