Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A2558FDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiHKN5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiHKN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:57:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFECB804A8;
        Thu, 11 Aug 2022 06:57:18 -0700 (PDT)
X-QQ-mid: bizesmtp85t1660226222tbhiahg5
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 21:57:01 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: SGbEDZt3Zybfc3s74YKhE6ILnhOuPw7a5eYaBUV/U7cvE1hff5zxioMm3+iiU
        75k0tRnQe6TnGxBm7ZiGUhiA7Q61lXXuThp45++M3pBKdnuONE6OWuzNE47xPf3iCyL7VOh
        85iohTZjy+SAQVgM57Qi38BSI2hgvfsjI2wyUa1/lQc9Ah+7JAEPzYzW9wdiA3Vh2rYeAes
        rEZhJnSWaemjSBSGptdFz6ui4t3autKuUenPf1R0hjWLfnnRv66kOmQTeKr2iK2xQAFbUO2
        GGuCenGNDNMszu6pfo7Uj5g2tZg7grA86aM2PrrL1Wa/3p78ngM7gr/43xwff5Dd6sOCWZ6
        Q5MOK+fhUYZXIEGL6OmeWeZmqjEPPIK3uWmt8FB6M5dq+egUmHRMYwwa7+yTIDn3jXLxrKv
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     martin.petersen@oracle.com
Cc:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: snic: Fix comment typo
Date:   Thu, 11 Aug 2022 21:56:54 +0800
Message-Id: <20220811135654.24862-1-wangborong@cdjrlc.com>
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

The double `to' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/scsi/snic/snic_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 57bdc3ba49d9..a03493ca1e87 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -362,7 +362,7 @@ void snic_stats_debugfs_init(struct snic *snic)
  *
  * Description:
  * When Debufs is configured this routine removes debugfs file system
- * elements that are specific to to snic stats
+ * elements that are specific to snic stats
  */
 void
 snic_stats_debugfs_remove(struct snic *snic)
-- 
2.36.1

