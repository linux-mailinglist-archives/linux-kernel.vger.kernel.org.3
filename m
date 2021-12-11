Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3BF471309
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhLKI53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:57:29 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:21908 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229852AbhLKI52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:57:28 -0500
X-QQ-mid: bizesmtp48t1639213043te1o4bc2
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 11 Dec 2021 16:57:22 +0800 (CST)
X-QQ-SSF: 01000000008000D0H000B00A0000000
X-QQ-FEAT: LXTjUhoj8YNaIxKReJih2KxEbYs9PQSr5tJ3QXlOawk+lPuFb3pBV32pmttNr
        cNe2cVmCr1afLjJYZ0CJBqLXV821wKOxEYuyMpbQRhR3Q1KjRK8sYqd4uu/ZWMO8icVaajq
        +D5ha8kdf8+s45fYaY6u9l2bO4HP9DTDUt9SPLczArfz355rCkvaOzxTCA98GBvtLfWDbr3
        rzFkS/z8U1LsZy2qTzafOMANTmlMcqVi4r5kBTtcZSFEMceLCZUC8kojpyXb9xnJpgXLDym
        kHjfN4X/Z8mpzUXYL7QrBD9B0tpS4RgL1+U7b4UqOJFn6Et2TArBV2CCE14J1c55VW1NOVm
        AlcMQZ1/4W7UBuN7UqX3zkVclpa7xo31chOlP6S
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     wangborong@cdjrlc.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: fix typo in a comment
Date:   Sat, 11 Dec 2021 16:57:15 +0800
Message-Id: <20211211085715.233633-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `Address' in the comment in line 487 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/mips/include/asm/sibyte/sb1250_mc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/sibyte/sb1250_mc.h b/arch/mips/include/asm/sibyte/sb1250_mc.h
index c02fe823effc..61411619dff3 100644
--- a/arch/mips/include/asm/sibyte/sb1250_mc.h
+++ b/arch/mips/include/asm/sibyte/sb1250_mc.h
@@ -484,7 +484,7 @@
 
 
 /*
- * Bank Address Address Bits Register (Table 6-22)
+ * Bank Address Bits Register (Table 6-22)
  */
 
 #define S_MC_BA_RESERVED	    0
-- 
2.34.1

