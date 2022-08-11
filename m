Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17858FDC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiHKNyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiHKNyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:54:05 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DAD66A67;
        Thu, 11 Aug 2022 06:54:02 -0700 (PDT)
X-QQ-mid: bizesmtp87t1660226030t3h4yaa2
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 21:53:48 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: SGbEDZt3ZyaQSSheb+YR/81LfilHQY+FTyZ7y0XarNBn/x6ElKX3Wrxfh3lm5
        0qszddFBJZIxBv3lPQc41a/fM/8aYWgzGIhVqT6InYE8VsIA1xzBEcw41vznmy344hMRpJD
        g+nNF/R321a8NdLaHYYP81XdDKpSPNO732yGmWiTsFtbDhm00si7wxWizP/+jmezW5bkttQ
        IBPTDxpz9tzpCAQ4oV5HUu/qgQxkNfzyNj+7fZhmmlC+3Ifx8j0S4bsyQc+xoXru7dVVYit
        qVmuITc8b09EkAPpTZI2YxhVh5ENGqU/k/6A0h34XqpscI+v/yAxdpyJsLPtSIEbWc/uk6B
        RWCjPO/Al9lleXlpOyAHQ7sTEwIyV6fGxhDSxuhFHhXFDt4J6pH0nMPI4Cobiuah4SAbofi
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     martin.petersen@oracle.com
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: lpfc: Fix comment typo
Date:   Thu, 11 Aug 2022 21:53:41 +0800
Message-Id: <20220811135341.21976-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `is' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 9be3bb01a8ec..ca7bb82a0eb2 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -1726,7 +1726,7 @@ lpfc_bsg_diag_mode_exit(struct lpfc_hba *phba)
  * This function is responsible for placing an sli3  port into diagnostic
  * loopback mode in order to perform a diagnostic loopback test.
  * All new scsi requests are blocked, a small delay is used to allow the
- * scsi requests to complete then the link is brought down. If the link is
+ * scsi requests to complete then the link is brought down. If the link
  * is placed in loopback mode then scsi requests are again allowed
  * so the scsi mid-layer doesn't give up on the port.
  * All of this is done in-line.
-- 
2.36.1

