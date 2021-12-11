Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E924A471313
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 10:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhLKJJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 04:09:26 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:63473 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229455AbhLKJJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 04:09:25 -0500
X-QQ-mid: bizesmtp52t1639213729tc78ce8h
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 11 Dec 2021 17:08:48 +0800 (CST)
X-QQ-SSF: 01000000008000D0H000B00A0000000
X-QQ-FEAT: Jd++W0FxedEDKcq4dwEsswBBZ441+hy6eBxXh3hnKynnNk/Dfh2HgBbY0UvHW
        CDc8cdpSp4KMckPMzMXY/PXmyx3sEoK1ZXOs/QPdkMCGSZrxuY5eribfClmTu2aHM7ocv/V
        Q1D+kk/FVy0aPQeFqNpjzDSOqZFs725U9FDJjXdaL1pxmKWlrz/uRQjk09nHxHAY/76dELT
        vGKLnWdmDEAQJUIQ+ztoTWUp4MDLVP5TYMtb1ieI8jC8rSzRrrmILdvwQPN4lugdbv0ijtm
        9b5RhVy6Y6SmokMtmVxdT9e9nza1NfFiAUzZ8yle47opB85AIrIHrJpgEjHc9Cd65/yO6EE
        5wyk5CgyBjW5Ic+I0AXdOjzo+biwdYrQT1fdSbi
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     leoyang.li@nxp.com
Cc:     qiang.zhao@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] soc: fsl: qe: fix typo in a comment
Date:   Sat, 11 Dec 2021 17:08:45 +0800
Message-Id: <20211211090845.252700-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `is' in the comment in line 150 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/soc/fsl/qe/qe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 4d38c80f8be8..b3c226eb5292 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -147,7 +147,7 @@ EXPORT_SYMBOL(qe_issue_cmd);
  * memory mapped space.
  * The BRG clock is the QE clock divided by 2.
  * It was set up long ago during the initial boot phase and is
- * is given to us.
+ * given to us.
  * Baud rate clocks are zero-based in the driver code (as that maps
  * to port numbers). Documentation uses 1-based numbering.
  */
@@ -421,7 +421,7 @@ static void qe_upload_microcode(const void *base,
 
 	for (i = 0; i < be32_to_cpu(ucode->count); i++)
 		iowrite32be(be32_to_cpu(code[i]), &qe_immr->iram.idata);
-	
+
 	/* Set I-RAM Ready Register */
 	iowrite32be(QE_IRAM_READY, &qe_immr->iram.iready);
 }
-- 
2.34.1

