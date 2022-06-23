Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6987B557346
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiFWGoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiFWGoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:44:16 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDF542EC6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:44:11 -0700 (PDT)
X-QQ-mid: bizesmtp76t1655966624tsricmyf
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 14:43:40 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: FXvDfBZI5O727lhUz+nlWuwIfirc6ZhVwF0lsZC8BwSjiLSB+j2tErHwKUCEo
        u4ALB53nlk8R7c38/r69vVBD5FtfCj4YC+mL7+Cj0OA0lfbE4vEBdYmdG+mTSWF/EMFZJPO
        Hgd1fCzDrJJggQy29veEENxJaaIylp069XwqndCQe7RmXCUXX2TjPZQagmz+Wd2uNzNt9iC
        2GYcqY8c770xj+H0bd6fPDSVRxxXizHgXZcC4hVNeVBOB3aaE9MSr003PrjcMeDu2bhzrvR
        L0MjOAYm3uwtVV+xKbxS16bMhKLUO0qyfMveijhPKESPlpmRaRyRQT1f/fE9Suse1rSw/m8
        nTgIfVwV0GgPIk1/XORHePgmXhGTg==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] ARM: mvebu: drop unexpected word 'a' in comments
Date:   Thu, 23 Jun 2022 14:43:38 +0800
Message-Id: <20220623064338.6496-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'a' in the comments that need to be dropped

file - arch/arm/mach-mvebu/pmsu.c
line - 404

	 * replace the restart code of the bootrom by a a simple jump
changed to:
	 * replace the restart code of the bootrom by a a simple jump

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 arch/arm/mach-mvebu/pmsu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index af27a7156675..ea4f5beeffb7 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -401,7 +401,7 @@ static __init int armada_370_cpuidle_init(void)
 	 * On Armada 370, there is "a slow exit process from the deep
 	 * idle state due to heavy L1/L2 cache cleanup operations
 	 * performed by the BootROM software". To avoid this, we
-	 * replace the restart code of the bootrom by a a simple jump
+	 * replace the restart code of the bootrom by a simple jump
 	 * to the boot address. Then the code located at this boot
 	 * address will take care of the initialization.
 	 */
-- 
2.17.1

