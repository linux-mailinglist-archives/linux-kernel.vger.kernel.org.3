Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934715B1CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiIHM0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiIHM0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:26:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF8C59CB;
        Thu,  8 Sep 2022 05:25:58 -0700 (PDT)
X-QQ-mid: bizesmtp79t1662639947th9pafrx
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:25:46 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: LG+NUo/f6sH17zbjV4I0WjCDUKCcmxd2yaCeECp/PwM5GxfX4RCLbyJnPKwWC
        IcH5g3/u41AhlcnSvBHheBhiy30Kw2jbpXngQ/wzlh3sp0xV+ZUjdQ+7Op6UCbA1UbmYH1z
        Lz4Djiz4/e+iKCSNoQKrA9tP847EuWoVrp48GNtNkEmrDgDU9zlb0gjZ8LY7tMS3l839S7X
        t/Zprnj2jBp40XL3sf6s0hcBUl7eewGR1jOHhfDc+tVUZ7V6Rql71+kOy++uIoifooBmHs6
        DXDQrSjrZ8S1Rxm5tjIVJXz5WTruskW3JGYVELaCidfejGxLlceom7DOsFMcOPw8ifGcPoo
        ReZe7me9VpANwLlvVrjSrilxZIuEVfFs/SDB5Ra9C2yBPr+HLw=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] scsi/lpfc: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:25:38 +0800
Message-Id: <20220908122538.12317-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/lpfc/lpfc_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index b555ccb5ae34..75eaac273a89 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -889,7 +889,7 @@ lpfc_ns_rsp(struct lpfc_vport *vport, struct lpfc_dmabuf *mp, uint8_t fc4_type,
 	}
 
 	/* All GID_FT entries processed.  If the driver is running in
-	 * in target mode, put impacted nodes into recovery and drop
+	 * target mode, put impacted nodes into recovery and drop
 	 * the RPI to flush outstanding IO.
 	 */
 	if (vport->phba->nvmet_support) {
-- 
2.36.1

