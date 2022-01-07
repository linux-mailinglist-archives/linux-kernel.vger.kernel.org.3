Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD97486EDE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbiAGAbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:31:34 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60588 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343798AbiAGAbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:31:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V18Mzg9_1641515490;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V18Mzg9_1641515490)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jan 2022 08:31:31 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] MIPS: Remove duplicated include in local.h
Date:   Fri,  7 Jan 2022 08:31:28 +0800
Message-Id: <20220107003128.81300-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following includecheck warning:
./arch/mips/include/asm/local.h: asm/asm.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/mips/include/asm/local.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index d4d47c846bb2..08366b1fd273 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -8,7 +8,6 @@
 #include <asm/asm.h>
 #include <asm/cmpxchg.h>
 #include <asm/compiler.h>
-#include <asm/asm.h>
 
 typedef struct
 {
-- 
2.20.1.7.g153144c

