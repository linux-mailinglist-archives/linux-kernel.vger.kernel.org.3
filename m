Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD45782BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiGRMuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiGRMuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:50:54 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B29220EE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:50:49 -0700 (PDT)
X-QQ-mid: bizesmtp68t1658148616t7bhdokv
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:50:13 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000000
X-QQ-FEAT: 7EdZ+jItOgQ0M+YFKI/1jLmKSWgXwzWjw+WakznY+pAmmCGIbajVHS6xM0CZp
        /AfsMMw/WjziiNOG9kp9UHiemgMkFAiwCJfRzV50qoJTnAMK6L+bLiafkL7dmXmuzuKi25y
        MyOq6rSQq4PyYmLtC3WcgWuYYP5gdJPsXAppSXUTuePNYsD0lRz+11YMDDs3293ZhTPgM47
        prOd7lZpeVbyEka34sZKU4jjcoKgxEJO0k7kYskF44UfTp6h30juXI8CE2Qfz6FfgcrMB43
        RK11UhCvMFVqej07ERFG68sPgeBcObH903z6GoDOgK1t4cRhFS7sxmsXxXtl7+VKtkC+uOx
        THv2Nz1PZwy76o4ZvQj07kBiuWiqMxTLecp5qqy6x6sNOyyhO4Ex0ank8BrcwFqchsISO4r
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mingo@redhat.com
Cc:     tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
        mick@ics.forth.gr, kirill.shtuemov@linux.intel.com,
        david@redhat.com, rppt@kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] x86: Fix comment typo
Date:   Fri, 15 Jul 2022 12:48:09 +0800
Message-Id: <20220715044809.20572-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `with' is duplicated in line 39, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/x86/kernel/aperture_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 7a5630d904b2..4feaa670d578 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -36,7 +36,7 @@
 /*
  * Using 512M as goal, in case kexec will load kernel_big
  * that will do the on-position decompress, and could overlap with
- * with the gart aperture that is used.
+ * the gart aperture that is used.
  * Sequence:
  * kernel_small
  * ==> kexec (with kdump trigger path or gart still enabled)
-- 
2.35.1

