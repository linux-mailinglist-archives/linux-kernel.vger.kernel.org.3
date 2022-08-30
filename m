Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B85A5D56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiH3Hum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiH3Hui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:50:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8297962B;
        Tue, 30 Aug 2022 00:50:37 -0700 (PDT)
X-QQ-mid: bizesmtp82t1661845830tvbi6www
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 Aug 2022 15:50:25 +0800 (CST)
X-QQ-SSF: 01000000000000B0C000000A0000000
X-QQ-FEAT: BC0NppmhE9kviExaj2iXTtkhw3oOXdTo65tIsNUK1q4ApXM/coMCVU2jmjCmk
        nsSNVvmv+NxftehZhfIstEYuHrbEskhL2HXipauTpWEjUeB1CnfvgLgBKYuxsvsAUwFNA9V
        cGrVxjduW9NypzVWnlzDdlXVlQt0Qbunx63A8d5Xp4zSfHJenEQsRJbnFUtOdSafnv2TMUP
        HFvLppWsEnb2xVpeQc4BK3BIRKx+zch7SyNKqqLmYt1XVCCdvAAkgcb1YuTESkr1r71XTIb
        3V5loH85BANGM/Ifrn0DhRw6WU9C52Jd5Kqn+3bkgPK5zD5nKF9hXBYOf0SZMzkvk5q19MG
        33DiuxvRWxwptJq4INwL+4/ycUDSgG/coT1C991NcBDPeVJ4G8=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] ata: libata-sff: Fix double word in comments
Date:   Tue, 30 Aug 2022 03:50:24 -0400
Message-Id: <20220830075024.13917-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "Transfer" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/ata/libata-sff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b1666adc1c3a..7916e369e15e 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -776,7 +776,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
  *	@qc: Command on going
  *	@bytes: number of bytes
  *
- *	Transfer Transfer data from/to the ATAPI device.
+ *	Transfer data from/to the ATAPI device.
  *
  *	LOCKING:
  *	Inherited from caller.
-- 
2.35.1

