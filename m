Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD9578390
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiGRNUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiGRNUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:20:52 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D2823BE0;
        Mon, 18 Jul 2022 06:20:44 -0700 (PDT)
X-QQ-mid: bizesmtp66t1658150428t089shao
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:20:26 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: k8Irs33ik7s8+LDNgwQfUQb5+vzWdafLy8ge4WgpIkeh6/AP3USDYHOEgBTU0
        MIJaDIsnc55bd6tFYynX3NepwRBGMvMbSXFKlNHIWc8TlUuuBGUDA4Vuckae7Ig8jG89MyO
        R2hp5KUrACg1+l7MynRa592dOc/lZt2/02MHN4/agoMKQzBzIPkyJ/rENHYlRS6uMDn42T5
        No3iCYnS34uPo+jCEFaVKMExr+RAAtXedtOThEgrnUXpw4fo1r4vMyPhE9Z9SajbULYuom9
        G9UAOAiQiu+GHTEoTWjSFUvAilaO2dKXxkPWfxBJnvOAvhrQ4MCskxwCRY9ATyvdz3b1wk8
        JsuAakuA1dpnzR568XW3l6htbQFqNJrN+eH3X5SMcM6hhGOQhI4O2DvlL0rU2wQfuFDguFU
        hL70BKgiqfam24i79MBLUA==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     j-keerthy@ti.com
Cc:     edubezval@gmail.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] thermal/ti-soc-thermal: Fix comment typo
Date:   Fri, 15 Jul 2022 13:18:29 +0800
Message-Id: <20220715051829.30927-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `and' is duplicated in line 229, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ea0603b59309..67050a1a5b07 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -226,7 +226,7 @@ static irqreturn_t ti_bandgap_talert_irq_handler(int irq, void *data)
 		/*
 		 * One TALERT interrupt: Two sources
 		 * If the interrupt is due to t_hot then mask t_hot and
-		 * and unmask t_cold else mask t_cold and unmask t_hot
+		 * unmask t_cold else mask t_cold and unmask t_hot
 		 */
 		if (t_hot) {
 			ctrl &= ~tsr->mask_hot_mask;
-- 
2.35.1

