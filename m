Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DDC5A72E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiHaAru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiHaAr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:47:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1225C636C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:47:20 -0700 (PDT)
X-QQ-mid: bizesmtp83t1661906833t48eao95
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 08:47:11 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: hJ5650VbgwA8/tjv62vCT0tHLOwxMXc1psePX3XsSQrANH5abwqNW+o2xQi1S
        4iV/5l6erMyETcWRD4hdmei4oTdmru4UwKRL9K2fyUgBKYgkQN5ttBNJZPdMoC/XPFUHC72
        eUxFpcBOa4I6szeNIFyFJ9FjLP50m0UFqegvQuYih3GJciFyvqR2ZUtQif/bLxyrFzlquYP
        LATU9Iqn2+N5pohDqSzcibRfCELeR3zlfqC0IumikXSJyeyuOJRVPAnN1yJk4+FU5+dyjeh
        lxUmXf110J76JV5ha+RFtms1y3fgdfBLGY/WZq39fPDCdBkm4j7gkrF+Bp/SGsF7lc4q40X
        tlN9gSgJJdxXyEACm+WnZkFoWQLGay1O0ogioq3wPjAdP8jddw=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] powerpc/xive: fix repeated words in comments
Date:   Wed, 31 Aug 2022 08:47:06 +0800
Message-Id: <20220831004706.35280-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
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

Delete the redundant word 'set'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/powerpc/sysdev/xive/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 61b9f98dfd4a..a289cb97c1d7 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -783,7 +783,7 @@ static int xive_irq_set_type(struct irq_data *d, unsigned int flow_type)
 	 * the corresponding descriptor bits mind you but those will in turn
 	 * affect the resend function when re-enabling an edge interrupt.
 	 *
-	 * Set set the default to edge as explained in map().
+	 * Set the default to edge as explained in map().
 	 */
 	if (flow_type == IRQ_TYPE_DEFAULT || flow_type == IRQ_TYPE_NONE)
 		flow_type = IRQ_TYPE_EDGE_RISING;
-- 
2.36.1

