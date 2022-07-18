Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FAA577966
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiGRBop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGRBon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:44:43 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB5247;
        Sun, 17 Jul 2022 18:44:37 -0700 (PDT)
X-QQ-mid: bizesmtp63t1658108668tleh5lgp
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 09:44:27 +0800 (CST)
X-QQ-SSF: 01000000000000E0U000000A0000020
X-QQ-FEAT: UMQM+3VOEYvZkqF8Bin70NeWfgcsabK23JnSW2fZTCgxYKkn5UpeMCSw0rP2k
        shk4+a58C/S81CkBxOUkmQjWxWM1QcOhbNVVAGdEHX3I+XeZ6Swp74RHSWCPvL1Pqg37Zjz
        fiPnyvtvs94yIEROXWCy2yOZLFj18IDFpcvjmB5JrC+gni56fPReHYNS8ZEoD2lIX+wOnV3
        mb2PHFiAFz3vi3+LZqcQkhcHbbzBOYAweDJTsRvhuvepe/zdHhIy6jz6O8gyyDEThwECJwu
        9eot9c0bYHrF8ZYBrFre7ud/o87S/ouLDrVfdDM5t2pm0ZHlMSgYZx0Ej1Q2wlewKnVb9Xy
        lSfpfkBMHdEz++lPEOZrVAmnN2Mw0d1LEEGukhQ
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: qlogicpti: Remove unneeded semicolon
Date:   Mon, 18 Jul 2022 09:44:08 +0800
Message-Id: <20220718014408.12486-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon after the `}' in line 1152 is unneeded.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/scsi/qlogicpti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 57f2f4135a06..59c82d740139 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1149,7 +1149,7 @@ static struct scsi_cmnd *qlogicpti_intr_handler(struct qlogicpti *qpti)
 		case COMMAND_ERROR:
 		case COMMAND_PARAM_ERROR:
 			break;
-		};
+		}
 		sbus_writew(0, qpti->qregs + SBUS_SEMAPHORE);
 	}
 
-- 
2.35.1

