Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9306A5545FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357372AbiFVLaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbiFVLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:30:12 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6672E3C4A6;
        Wed, 22 Jun 2022 04:30:08 -0700 (PDT)
X-QQ-mid: bizesmtp84t1655897393tgcbvmch
Received: from ubuntu.localdomain ( [223.104.103.173])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 19:29:47 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000B00A0000000
X-QQ-FEAT: geCjBjpTnm4EPRA56z0oDsbHcnkG/Lf+2Vs5rTpFY5rpDNiLyd+628nBmWm6N
        bVMvKa5eeFJl21o+x+3kjwaFalC7hzpPu7V6t3+uu56QhcyTVCEb7j49b6OvPNpxYjluIaG
        fQ8VtdcoepjaBM08atr8nHIBzyrOiC6MwWIOZkekf+/9jtqUzvwgDrLqkqS3mHfnj00wVe3
        vszQFV6BqD+ixohpElYR1m9Sw3azDnZwSM3w8PKhEHq3Xj0af6OrYldzVPrvR0oboRFE8bP
        QZnacJS1BBmjHdT4e9ReuEEGrrJE8ENdZHJT6A69JIlHFsY1hIZ2Np7LaQc6SyITp40TD+Q
        xn4JPJH5CEPJTisPL2WrWVeGApVah6ZmfV7UnTZ
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: bfa: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 19:29:43 +0800
Message-Id: <20220622112943.13524-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/scsi/bfa/bfa_fcs_rport.c
line: 1974

             * the the newly discovered pid, send an scn notice
changed to:
             * the newly discovered pid, send an scn notice

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/bfa/bfa_fcs_rport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfa_fcs_rport.c b/drivers/scsi/bfa/bfa_fcs_rport.c
index c21aa37b8adb..dd78bea3e111 100644
--- a/drivers/scsi/bfa/bfa_fcs_rport.c
+++ b/drivers/scsi/bfa/bfa_fcs_rport.c
@@ -1971,7 +1971,7 @@ bfa_fcs_rport_gidpn_response(void *fcsarg, struct bfa_fcxp_s *fcxp, void *cbarg,
 			/*
 			 * Device's PID has changed. We need to cleanup
 			 * and re-login. If there is another device with
-			 * the the newly discovered pid, send an scn notice
+			 * the newly discovered pid, send an scn notice
 			 * so that its new pid can be discovered.
 			 */
 			list_for_each(qe, &rport->port->rport_q) {
-- 
2.17.1

