Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D26591BB4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbiHMPrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbiHMPrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:47:25 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0312CCA1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:47:02 -0700 (PDT)
X-QQ-mid: bizesmtp79t1660405605tnprrhri
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 13 Aug 2022 23:46:38 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: znfcQSa1hKYt2IoUPBjevx8mKySQnssQnKK7vf126xDyuZK4KrwLfQ0UvJzsi
        mNblXruhi4V6j+x44Tghtj31vIwN8O0mWEGhp/+sHU5Mj+uYoHYxPB/qfjMM59Du/jKpP5T
        ZvOxI396Rl91Fx8LP8pI/B/iLej59RO56N0WgXTxHQDBeMH+TbYCG7JXk6xGHAKOSt4hCJ+
        IhADTa9m8qpnSDg13GoXwmEoq4qFjzCw7nzXZYu5lCc440mrP6pqRxKj+3z/0gmI+SvG96+
        vDzb/8Mg1Rr/JwTJD4mHshHAAUkNh++Up7BhXzlwcA0MEJiZopvikuU5Z8WII8nc8imevyu
        4ww2OJ5/83HBqrV2JMKnkb0lg2iQcRNoaib8fhrbKHIipMb2jXhbYX6+GJr8a/N1CQ03cvm
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     jesper.nilsson@axis.com, lars.persson@axis.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-kernel@vger.kernel.org,
        min tang <tangmin@cdjrlc.com>
Subject: [PATCH] arm: Unneeded semicolon
Date:   Sat, 13 Aug 2022 23:46:25 +0800
Message-Id: <20220813154625.5208-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
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

There is no semicolon after '}' in line 42.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 arch/arm/mach-artpec/board-artpec6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-artpec/board-artpec6.c b/arch/arm/mach-artpec/board-artpec6.c
index d3cf3e8603e8..c27e7bbcd7bc 100644
--- a/arch/arm/mach-artpec/board-artpec6.c
+++ b/arch/arm/mach-artpec/board-artpec6.c
@@ -39,7 +39,7 @@ static void __init artpec6_init_machine(void)
 		 */
 		regmap_write(regmap, ARTPEC6_DMACFG_REGNUM,
 			     ARTPEC6_DMACFG_UARTS_BURST);
-	};
+	}
 }
 
 static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
-- 
2.17.1

