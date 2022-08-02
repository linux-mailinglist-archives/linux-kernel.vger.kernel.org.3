Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1B3587C26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiHBMQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiHBMQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:16:29 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02914262C;
        Tue,  2 Aug 2022 05:16:23 -0700 (PDT)
X-QQ-mid: bizesmtp91t1659442572tox89pbw
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:16:10 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: zT6n3Y95oi0+GF2rz41IpklRcaOGRreCB/vyXaTX2YbnxIVMbcZECTfR9yO/3
        8npwl5Hj4lgtsMU4s/TMXiG0u2PUaRHZ8fHYtPbo2E/EelUGWi+5+4MV+jHV/ArGO1Dod8E
        Sz6nKxkDksp+W0UJod80LdUSoUxw9VXV9pAkYKjQJaSmPuqVh3TQYyOQpAzdhX/+JvWsg8q
        vQa+5hYtmzxp+ORs8hOwx43XouR9wfkvQfcdcjGyx3hE2JCmdbn1a1N00BbQn1x1Iwpgaih
        QaiptHfzunkKEeqmhPO8AvJVWeurP/C+I28AzPye4kXEF8MeUMQK3ru3PCPNycWYoZ4nFGY
        Kt0DjypTV/CNrBOMKf0VDbM6ZR/ALj51n8sSo1CzYptwRqo3d7+yAVh2/gFEg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     martin.petersen@oracle.com
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: lpfc: Fix comment typo
Date:   Wed,  3 Aug 2022 04:16:09 +0800
Message-Id: <20220802201609.7788-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RDNS_NONE,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `from' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 5037ea09a810..89c59d9fd040 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2538,7 +2538,7 @@ lpfc_debugfs_lseek(struct file *file, loff_t off, int whence)
  * @ppos: The position in the file to start reading from.
  *
  * Description:
- * This routine reads data from from the buffer indicated in the private_data
+ * This routine reads data from the buffer indicated in the private_data
  * field of @file. It will start reading at @ppos and copy up to @nbytes of
  * data to @buf.
  *
-- 
2.35.1

