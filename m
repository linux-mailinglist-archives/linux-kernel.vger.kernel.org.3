Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC9557439
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiFWHqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiFWHqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:46:30 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CB6E46B2B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:46:29 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 1E9AF1E80CCC;
        Thu, 23 Jun 2022 15:46:11 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id go9QteFcLc7O; Thu, 23 Jun 2022 15:46:08 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.33])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A7C561E80C7D;
        Thu, 23 Jun 2022 15:46:07 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     vgupta@kernel.org
Cc:     rppt@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] ARC: Fix spelling mistake
Date:   Thu, 23 Jun 2022 15:46:23 +0800
Message-Id: <20220623074623.6584-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'seperate' to 'separate'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 arch/arc/include/asm/entry-compact.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index 5aab4f93ab8a..67ff06e15cea 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -21,7 +21,7 @@
  *      r25 contains the kernel current task ptr
  *  - Defined Stack Switching Macro to be reused in all intr/excp hdlrs
  *  - Shaved off 11 instructions from RESTORE_ALL_INT1 by using the
- *      address Write back load ld.ab instead of seperate ld/add instn
+ *      address Write back load ld.ab instead of separate ld/add instn
  *
  * Amit Bhor, Sameer Dhavale: Codito Technologies 2004
  */
-- 
2.25.1

