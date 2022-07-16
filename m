Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ACC576E63
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiGPN5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGPN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:57:37 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268651F2E8;
        Sat, 16 Jul 2022 06:57:32 -0700 (PDT)
X-QQ-mid: bizesmtp88t1657979811tq99e2f2
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:56:48 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: IB0NYmI01jL2njAYgN1Dw1LFRKlaFuVqGCKx3LicXb0VSJF5LIg+5fCodeJxO
        AY43AMgPCRju6xF/y0XkZCB60DqsCRdkeKB34qrSRV4C8SaJQ0//ry+jQvlfFsXNJcL+ReP
        QaisOetH8okZreLlwqIqejTR0lL3aSCnG8PM3SKa8sluLT03urItdZ0Do6AwsglkCD3wpwe
        8Nymk2iyhi1s3+x98993aRMFrCQN1PY8uaCmQtYwWLZhwJsD2hLjPdFCNi44TX190WGKB4G
        rbYgFoBKbbj5q5ttLh2XyCaxB87vsjNhnWs57S79M9JJkesWrc1apW2GI+iiP/2hC2cQs1d
        nMBjwgwB4WdkCHgq8Jmz4sLGeHOSuF2YnQNz2dxMB7/1iIplIPM9aAUwqEAdHW99GAMe+SO
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/typec/tcpm: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:56:42 +0800
Message-Id: <20220716135642.52460-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3bc2f4ebd1fe..2d80b5b17ea4 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4453,7 +4453,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 * The specification suggests that dual mode ports in sink
 		 * mode should transition to state PE_SRC_Transition_to_default.
 		 * See USB power delivery specification chapter 8.3.3.6.1.3.
-		 * This would mean to to
+		 * This would mean to
 		 * - turn off VCONN, reset power supply
 		 * - request hardware reset
 		 * - turn on VCONN
-- 
2.36.1

