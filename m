Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83D5782AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiGRMsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiGRMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:48:37 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F7DE68
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:48:32 -0700 (PDT)
X-QQ-mid: bizesmtp89t1658148492tsxcrv93
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:48:09 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: DoD8xN2rKoxAP8/fu1tuCKlag0SB7dqJTqaMuJo231AWh67zfmwauvVmrpKAF
        w/IWHsRJSzLvc5gHwmI/Bc0AihKg0B2oTpNT5WzGWc6ZcQtRUCmx9aUyKmArKk9b8SRUXgx
        maFKLD7kNfyUAe6CAKfILcF2SLpBGorMPD0uKUhgFpR9p33/d+lNLlQPNWTQb64OYVYUOWQ
        Ln6u2jHRjYwIzs4zG9zRZn7rsb6ES5k2Buz8s+sVDl+cKj7nJNd8+wDtOqXKgwQfNP0is3T
        qK9THjHTuXqAyQCDZnRMSiNf/eZDgF0ZpkUDSu5dUyNhrmBbk0Zu49k0Ql+OcX/nTAGIRlz
        190YzL2XLIfq1fOAtIUSLk/IepAYE/BR0Mb/bVhQ1FilmcppMMgbUw6NREeIWUrWip5ioUs
        8KcA53K+Hd0=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mingo@redhat.com
Cc:     tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, logang@deltatee.com,
        martin.oliveira@eideticom.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] x86/amd_gart: Fix comment typo
Date:   Fri, 15 Jul 2022 12:46:13 +0800
Message-Id: <20220715044613.19908-1-wangborong@cdjrlc.com>
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

The double `also' is duplicated in line 56, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/x86/kernel/amd_gart_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 194d54eed537..19a0207e529f 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -53,7 +53,7 @@ static u32 *iommu_gatt_base;		/* Remapping table */
  * of only flushing when an mapping is reused. With it true the GART is
  * flushed for every mapping. Problem is that doing the lazy flush seems
  * to trigger bugs with some popular PCI cards, in particular 3ware (but
- * has been also also seen with Qlogic at least).
+ * has been also seen with Qlogic at least).
  */
 static int iommu_fullflush = 1;
 
-- 
2.35.1

