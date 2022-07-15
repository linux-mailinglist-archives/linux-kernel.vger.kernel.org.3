Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B258575C33
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiGOHSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGOHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:18:44 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0D7A21BF;
        Fri, 15 Jul 2022 00:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pFPdW
        o32C2z4BES280q0lcpi6YS7wb8DqIA3+9MA7bw=; b=lM0puH4U77kj0j1nVwAcg
        Uu6BSMDLAeFgOaxmnIwKGL5q2XPGA3NoELxVNtyEVYpuYzJ6PL7qzB5JB8D4mJ43
        RzkW1l2+t+sn5+UlU7xZi8f/DTFMKpXx7XblX1/gYVwd0nfdxh3QNBW6+5PQCsLS
        akTPKhJQArz9NzfrjqwXJE=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp13 (Coremail) with SMTP id EcCowAAH446qFNFiWHS8Ng--.38475S2;
        Fri, 15 Jul 2022 15:18:03 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        njavali@marvell.com, GR-QLogic-Storage-Upstream@marvell.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] scsi: qla2xxx: Fix spelling typo in comment
Date:   Fri, 15 Jul 2022 15:17:35 +0800
Message-Id: <20220715071735.856293-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAAH446qFNFiWHS8Ng--.38475S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5Gw15KFyxuFg_yoWfXFb_uF
        WYq3yIgry5CF4S9w18Zr4avr1IvFZ5Wr18Aw1FvrW3Aw43Z3ZrJrn0qrWava47K3yIyFZ8
        Zw48XrWYyr1UWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0siSJUUUUU==
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivgs-+1ZceGPAggAAsi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/scsi/qla2xxx/qla_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 3f3417a3e891..b8a9f923fb32 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -6661,7 +6661,7 @@ qla2x00_loop_resync(scsi_qla_host_t *vha)
 * Description: This function will set the appropriate flags and call
 *              qla2x00_loop_resync. If successful loop will be resynced
 * Arguments : scsi_qla_host_t pointer
-* returm    : Success or Failure
+* return    : Success or Failure
 */
 
 int qla2x00_perform_loop_resync(scsi_qla_host_t *ha)
-- 
2.25.1

