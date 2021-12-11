Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F914712FF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhLKIyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:54:50 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:61225 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhLKIyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:54:49 -0500
X-QQ-mid: bizesmtp45t1639212874ty89mzkk
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 11 Dec 2021 16:54:32 +0800 (CST)
X-QQ-SSF: 01000000008000D0H000B00A0000000
X-QQ-FEAT: /m5psauyXMdc21/HPztZ5Q2TUiQSmnN8VbR8AsXyLxOcy2mQlgQ3WJAYucPAM
        /aDHCTZYNbTFS1i7QgXrsshyRWrBnnnAsArQQ+0HvNyP1MHSUUPvO+rECwHluN7Id/DoBs4
        4c17UQafkAnodkRTh+IoP1sqEqeO/O+DOVAlE3HEzd+Ejl//f/+8dfThODSoN4F3zPUbI92
        zgLRQODsa/C2o5LqArYsHK7FI7SeNwjcHjJngFwTvL3cIsqWe8XSQ/Jr2AOBfSpw3QC5O+N
        saISXuR5FnOC+kf+mI/VcB9c9Z9q5Z68wduO2rg2MNIPZcYE44sd5YO0AtAENYeA273dPIe
        GltCDb7PwTwvCaqIdqeVCOvFEGw9umhdRPSTIHS
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     john@phrozen.org, wangborong@cdjrlc.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: lantiq: Fix typo in a comment
Date:   Sat, 11 Dec 2021 16:54:18 +0800
Message-Id: <20211211085418.228537-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `if' in the comment in line 144 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/mips/lantiq/falcon/sysctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 42222f849bd2..64726c670ca6 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -141,7 +141,7 @@ static void falcon_gpe_enable(void)
 	unsigned int freq;
 	unsigned int status;
 
-	/* if if the clock is already enabled */
+	/* if the clock is already enabled */
 	status = sysctl_r32(SYSCTL_SYS1, SYS1_INFRAC);
 	if (status & (1 << (GPPC_OFFSET + 1)))
 		return;
-- 
2.34.1

