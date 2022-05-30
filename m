Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3EB537390
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 04:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiE3C1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 22:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiE3C1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 22:27:07 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F426362;
        Sun, 29 May 2022 19:27:01 -0700 (PDT)
X-QQ-mid: bizesmtp81t1653877550tla6dmdm
Received: from localhost.localdomain ( [125.70.163.149])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 30 May 2022 10:25:29 +0800 (CST)
X-QQ-SSF: 01000000000000B0G000000A0000000
X-QQ-FEAT: 5wH7dOxX7oR+WXYlG5sJme5jIR7Dy0nt12sqSwKbXTeKaacCe1o+hwWb/90rH
        kzXdQ7Ah0BU6Rdn2/uHj1CzdnHdkKDLmVVo8C/55Zppy9Od5Ifmedml4vJM17pCmc82vz94
        PFSm8kT1Gbg9T4j7D3PVrnWqJYk8Dmdr+cOTSO8nJTCV84xREm2nnZDVEAVwFetiUNun+Ze
        b4fMi0+E6nbQzOEzB8d0HgD/XA1z800DoInSRH/1AeXzBj5ARaQx2EFDOOUoaQDqcrTezi0
        KsLCnHY1vVKKzjS50q4vdsGljriFMYGnY1aTMOYRqylTxfz98fcGilKn1Qk672bpL90+CjX
        gMH3TSi
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] scsi: lpfc: Fix warning in using sizeof
Date:   Mon, 30 May 2022 10:25:23 +0800
Message-Id: <20220530022523.21402-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sizeof fc_host_symbolic_name should be sizeof(fc_host_symbolic_name).

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index dd4c51b6ef4e..7d0c3aa0ae5e 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -6822,7 +6822,7 @@ lpfc_get_host_symbolic_name(struct Scsi_Host *shost)
 	struct lpfc_vport *vport = (struct lpfc_vport *)shost->hostdata;
 
 	lpfc_vport_symbolic_node_name(vport, fc_host_symbolic_name(shost),
-				      sizeof fc_host_symbolic_name(shost));
+				      sizeof(fc_host_symbolic_name(shost)));
 }
 
 /**
-- 
2.36.1

