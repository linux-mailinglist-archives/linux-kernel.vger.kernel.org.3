Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4296E4712F9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhLKIvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:51:49 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:57189 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229764AbhLKIvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:51:49 -0500
X-QQ-mid: bizesmtp42t1639212696trxqxjbd
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 11 Dec 2021 16:51:35 +0800 (CST)
X-QQ-SSF: 01000000008000D0H000B00A0000000
X-QQ-FEAT: LXTjUhoj8YP3VATQczryXFkrDWl9oLJYyVuZGuMdcD4O6jC5PCng9Wadb9DMB
        v4YV0a77TAfqPKPN00kuMxjxDmyLn0D3ULIz+kqZ2MJQ66UqeNfsmPN7OhDsW5robt0gZA2
        vh3wJ39LeY39m9UX+ShPuvGChT1k/MUcIxdVzHEEW8tDg0nGXdQrYcfHV0oCMLbrcSCgHQG
        XyDJNGFANcVx/mUSFYlr8P4/Mr8qhBZ1YQm7JAhzrdNElTorG/DEPc085nk9BEPkmVHViPG
        Vsu5GcnmpyGGYKRNY9lERkkZa0/xjWjdHKBlDUJ2EfJ7pIyJKjF3ebmXr6zp6zKsQoWbEov
        XfniABFXINqXZHN/woxrvIVJqaw5w==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     rdunlap@infradead.org, wangborong@cdjrlc.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Fix typo in a comment
Date:   Sat, 11 Dec 2021 16:51:32 +0800
Message-Id: <20211211085132.224082-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in the comment in line 344 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/mips/mm/c-octeon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 490322b01f91..737870d8fd94 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -341,7 +341,7 @@ asmlinkage void cache_parity_error_octeon_recoverable(void)
 }
 
 /*
- * Called when the the exception is not recoverable
+ * Called when the exception is not recoverable
  */
 
 asmlinkage void cache_parity_error_octeon_non_recoverable(void)
-- 
2.34.1

