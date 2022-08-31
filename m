Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFA85A7684
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiHaG1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiHaG1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:27:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A6BD122
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:27:31 -0700 (PDT)
X-QQ-mid: bizesmtp74t1661927236tjgbxm13
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:27:15 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: 6ArnuSDJ+ilCFKeoVND6qynFyDn9ciwdoSmXO42LaapPP7QZn8hY0VUUPQyAP
        nRppWaYoWg7YZ6IWUo/0xQcVgzIYk4E2Z64YAq5P3fChvu4vi8tFu1VLVqqk9e1QIdVnguO
        otqFncw24s2NRcSQOzDttd4rUcl3+K5mjuFb8JPAFi5KwjC/gHWq7FhEGEaQc/aWWPh1aqz
        s3ZRkosGvmraemxkkIPBKFGTSjSYzgEfm5Uo9T9u/Qr/F3l0hy5DJjxhLU85eqrfeQiUNjr
        /9eS4jQKVaZclahol4oqIPpLsIhXPVhp0Jbkrf2VcqOTz+h6Q910g12fAcEmGsJpGcxLEKk
        ckFUW2diqWdEa13cv7n3Y+OJQ7ti4Ah2OuTLrjZ8FYd0fbSp0PzH5fBBBEi/w==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] ARM: mm: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:27:08 +0800
Message-Id: <20220831062708.10239-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'there'.
Delete the redundant word 'as'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arm/mm/cache-b15-rac.c | 2 +-
 arch/arm/mm/mmu.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-b15-rac.c b/arch/arm/mm/cache-b15-rac.c
index 9c1172f26885..b7cb31bda8ab 100644
--- a/arch/arm/mm/cache-b15-rac.c
+++ b/arch/arm/mm/cache-b15-rac.c
@@ -203,7 +203,7 @@ static struct notifier_block b15_rac_reboot_nb = {
  *      set RAC_ENABLED
  *   However, there is no hotplug activity based on the Linux booting procedure.
  *
- * Since we have to disable RAC for all cores, we keep RAC on as long as as
+ * Since we have to disable RAC for all cores, we keep RAC on as long as
  * possible (disable it as late as possible) to gain the cache benefit.
  *
  * Thus, dying/dead states are chosen here
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a49f0b9c0f75..1207d431e1b4 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1301,7 +1301,7 @@ static __init void prepare_page_table(void)
 	/*
 	 * Skip over the KASan shadow area. KASAN_SHADOW_END is sometimes
 	 * equal to MODULES_VADDR and then we exit the pmd clearing. If we
-	 * are using a thumb-compiled kernel, there there will be 8MB more
+	 * are using a thumb-compiled kernel, there will be 8MB more
 	 * to clear as KASan always offset to 16 MB below MODULES_VADDR.
 	 */
 	for (addr = KASAN_SHADOW_END; addr < MODULES_VADDR; addr += PMD_SIZE)
-- 
2.36.1

