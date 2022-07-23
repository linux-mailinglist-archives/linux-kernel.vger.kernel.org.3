Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1AA57ED0A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiGWJYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiGWJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:24:10 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2C1B7A2;
        Sat, 23 Jul 2022 02:24:05 -0700 (PDT)
X-QQ-mid: bizesmtp72t1658568229t3z4a5d0
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 17:23:47 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: OICyp1OkQRKndH9F0Qp603hXMB+jOD7gUnBkqJrFVmU/ujnQ1kvKKpiWmqMkZ
        USkipFIkDHhKq4UopB8l3seBH9w8JqeujndJ2guTTQ3xw2NhhaZ/0EBQ/UvtfR+TzwrJQhh
        yz4U0MndvXZ76CX9ROXTJo7MLAnIB/+pYnKdoPeCvXIFIJIUWVfLRf8Jq2lMjU35cne7s8h
        7h3jPppxrcO7iBiXyv1J7CvWe6ca4Sk0LuyGEh4dSa+3MenQclBzuNbcZ9Tv7278Ht/xLhG
        3yeLfM6Tde9yoUN3pC7kyeHwlq62cv7qB90BR0du4ZQ4Qa9bDksY286LA+pRasvby8sqtJC
        WecjmsNyqRKL/Za1L+Op8Mw5tmkklDFhhs3N3e3phbZGlfz/u5YbicSnIQrh8Am/Sabk7Qo
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     deller@gmx.de
Cc:     James.Bottomley@HansenPartnership.com, svens@stackframe.org,
        hanyihao@vivo.com, akpm@linux-foundation.org, willy@infradead.org,
        dave.anglin@bell.net, anshuman.khandual@arm.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] parisc/mm: Remove the static variable initialisations to 0
Date:   Sat, 23 Jul 2022 17:23:41 +0800
Message-Id: <20220723092341.6885-1-wangborong@cdjrlc.com>
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

Initialise global and static variable to 0 is always unnecessary.
Remove the unnecessary initialisations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/parisc/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index f03e0961fa25..b0c43f3b0a5f 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -722,7 +722,7 @@ static unsigned long space_id[SID_ARRAY_SIZE] = { 1 }; /* disallow space 0 */
 static unsigned long dirty_space_id[SID_ARRAY_SIZE];
 static unsigned long space_id_index;
 static unsigned long free_space_ids = NR_SPACE_IDS - 1;
-static unsigned long dirty_space_ids = 0;
+static unsigned long dirty_space_ids;
 
 static DEFINE_SPINLOCK(sid_lock);
 
-- 
2.35.1

