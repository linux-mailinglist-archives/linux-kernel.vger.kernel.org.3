Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9DD5574CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiFWIEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiFWIEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:04:09 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC072C679;
        Thu, 23 Jun 2022 01:04:03 -0700 (PDT)
X-QQ-mid: bizesmtp76t1655971425tv9azafg
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 16:03:41 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: q+RiK5VMyhdrKJTkFlW0S+gkbfUgGEBuJY3t2hG/RuFQ0pZpdgkRM9NkAdhT8
        UmZADEHOOe7AbKBf4IDeNomGUu4qp12Ffh7OXllETIRS43ifue/vnVs9R6DdcD+TXG2XTpz
        wGS/cp8Zkf6/KLcd3dWsiL/I+Jf/maR1gdk6YmYJ7z3LJWMv36T0EHjOfkfqPiIxPkgAA7z
        AWlpK/jOhX7ToxU2n5B1nxvGDykXGFjAmD/6Ra44DZeJDrrFWOxikAOwu4DraSlSjev9Om+
        9rxp1v/7DdSYGlNb41gWGlikWhg381rmYzOF9xbGSMaeNvH0Q1PEtf51VASeh7u/xOO++qN
        kBl3vct4tZMKXjVh6AhvTcVd2FMHLAp/FRSR/be
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: bfa: drop unexpected word 'are' in comments
Date:   Thu, 23 Jun 2022 16:03:39 +0800
Message-Id: <20220623080339.21087-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'are' in the comments that need to be dropped

file - drivers/scsi/bfa/bfa_fcpim.h
line - 70

/* Buckets are are 512 bytes to 2MB */

changed to:

/* Buckets are 512 bytes to 2MB */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/bfa/bfa_fcpim.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfa_fcpim.h b/drivers/scsi/bfa/bfa_fcpim.h
index 8bf09433549b..a9eae709da39 100644
--- a/drivers/scsi/bfa/bfa_fcpim.h
+++ b/drivers/scsi/bfa/bfa_fcpim.h
@@ -67,7 +67,7 @@ void bfa_fcp_res_recfg(struct bfa_s *bfa, u16 num_ioim_fw, u16 max_ioim_fw);
 #define BFA_IOIM_IOTAG_MASK 0x07ff /* 2K IOs */
 #define BFA_IOIM_RETRY_MAX 7
 
-/* Buckets are are 512 bytes to 2MB */
+/* Buckets are 512 bytes to 2MB */
 static inline u32
 bfa_ioim_get_index(u32 n) {
 	int pos = 0;
-- 
2.17.1

