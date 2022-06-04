Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0C753D738
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiFDO1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiFDO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:27:45 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA85CE1A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:27:40 -0700 (PDT)
X-QQ-mid: bizesmtp63t1654352852tnf3ldmm
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Jun 2022 22:27:25 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: wn0SsWgTYqIqpUJEEluAL6aYu1hPJPHSXlF8B42e4Ev/8rIVqy+thImHeHnuB
        5zzP9toKcvkiGMiQIbJ+oXw7f8pSy+0tGKcK3qr7R/a713B8q2cFr6OR7GmK7D142Y7KcfB
        kTCI8KDTWX76rvkeP0S8hoZkDnbUG1bQ572/EZXEpA1lYyFg8sGfAFIGy/OlbiJMTXgB5SH
        f+iui2IE0X0Z948BNuE0iQgqrKWpzVtxp8M+Kb0KFzvqsuK26/ZBgWn5tzkFYzWeUYilwMv
        uP1Rd2VuHWlrFrEhOzOMMKxunOu8gpSBgpQThOgp8ZBarc7GUOhkojVQU9/h6hp8lzH7XSc
        QkvimAlCsP8pc/P2kk=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     stuyoder@gmail.com
Cc:     laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] bus: fsl-mc-msi: Fix syntax errors in comments
Date:   Sat,  4 Jun 2022 22:27:24 +0800
Message-Id: <20220604142724.15002-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'for'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 0cfe859a4ac4..df3318f1a292 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -96,7 +96,7 @@ static void __fsl_mc_msi_write_msg(struct fsl_mc_device *mc_bus_dev,
 		}
 	} else {
 		/*
-		 * IRQ is for for a child device of mc_bus_dev
+		 * IRQ is for a child device of mc_bus_dev
 		 */
 		error = dprc_set_obj_irq(mc_bus_dev->mc_io,
 					 MC_CMD_FLAG_INTR_DIS | MC_CMD_FLAG_PRI,
-- 
2.36.1

