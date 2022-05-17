Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD770529993
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiEQG36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbiEQG3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:29:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84B0D44772
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:29:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EFB3ED1;
        Mon, 16 May 2022 23:29:49 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.43.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 337D93F718;
        Mon, 16 May 2022 23:29:45 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] amba: Drop builtin_amba_driver()
Date:   Tue, 17 May 2022 11:59:29 +0530
Message-Id: <20220517062929.3109873-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop builtin_amba_driver() which is not used anymore.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Wang Kefeng <wangkefeng.wang@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.18-rc7

 include/linux/amba/bus.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 6562f543c3e0..7c5d2aa73437 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -171,14 +171,4 @@ struct amba_device name##_device = {				\
  */
 #define module_amba_driver(__amba_drv) \
 	module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)
-
-/*
- * builtin_amba_driver() - Helper macro for drivers that don't do anything
- * special in driver initcall.  This eliminates a lot of boilerplate.  Each
- * driver may only use this macro once, and calling it replaces the instance
- * device_initcall().
- */
-#define builtin_amba_driver(__amba_drv) \
-	builtin_driver(__amba_drv, amba_driver_register)
-
 #endif
-- 
2.20.1

