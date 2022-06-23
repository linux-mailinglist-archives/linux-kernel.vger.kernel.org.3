Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221F7557800
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiFWKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiFWKgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:36:01 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161B54AE36
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:35:56 -0700 (PDT)
X-QQ-mid: bizesmtp80t1655980487tlqo1v9w
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 18:34:44 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000D00A0000000
X-QQ-FEAT: ke64Y+R1JM3r3XabZSLawLGmZgSSz98nOPJ2NOYVUaL5aK1neRm1f92H9heXi
        /pPhPH0f3VrBuSfcNwbRqdt0onn4Zj5qtbFlR/cd4ZNMuQVisUcErcK0U4LEv31PV1rsGX0
        tAGnfQRB7NR3yXhDCG7bXzUe/a5mOcq3HW8CbrKVqaB6v/Z/PMXpTnRrZYhPdvV9prgbf+i
        s/JYlHJaVPNbDeHMRiyRHoEdtCPTWLrEsNSwD8WJkA7pb+lflnCSE9pIBGWpw0uGgoTbrxe
        XyKLsSNS69ftBIx31F3ZE1gJvrfSr0mDuonzNBMd6O3X+e3mw952G8sezfG28pHSwcYU4G5
        RC35yhG/+6sDD5bSWBGdHNbMf3YoUYjYo73Anf6
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com
Cc:     linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] bus: fsl-mc-msi: drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 18:34:42 +0800
Message-Id: <20220623103442.42154-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/bus/fsl-mc/fsl-mc-msi.c
line - 99

* IRQ is for for a child device of mc_bus_dev

changed to:

* IRQ is for a child device of mc_bus_dev

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
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
2.17.1

