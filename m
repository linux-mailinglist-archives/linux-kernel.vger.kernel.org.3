Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AA357D87A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiGVCYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGVCYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:24:09 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8275D974AC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:04 -0700 (PDT)
X-QQ-mid: bizesmtp84t1658456630t3xlbczz
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 10:23:39 +0800 (CST)
X-QQ-SSF: 0100000000000030C000000A0000020
X-QQ-FEAT: RFp2QSjOiS6rbUvJira6xFOlKpR+J4A3CFv/FClw9eltn2VU8keCg2k5NgEbd
        6TRXiky36Pge45onBYLwZOjRdpTfQAelJoGCID/NOdU9XflQ9S6w9GXjkaNdaJJX1/X9bTE
        T4yxWLLSPLGpj2T6Rygl345KgNlsbCSMlnylQrpBdLOk/EAMeMO3ko/eqF/FrHUsVCzBv99
        q/0BkPzCH2EhKyJSoJjqbrAjv+KUbEEUKujiDDtpfFYa+gGQ/hlLO6AvZnviHEiZ3/jyh7/
        DGhdRhVMqp2alQxu3SnjkZtgsqxEzaaAJyaQf48TedfmrwlVPqW8ars2oF3oDddNu2AmMNi
        2aE3OS47aIhrFQUZgNCehkTATskLA4i6YXizYxLWlEkJyK1YgGQ+kQ+hR3TzA==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     hdegoede@redhat.com, paul.gortmaker@windriver.com
Cc:     linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] platform/x86: Fix comment typo
Date:   Fri, 22 Jul 2022 10:23:37 +0800
Message-Id: <20220722022337.15903-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
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

The double `of' is duplicated in line 50, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 include/linux/platform_data/x86/pmc_atom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/x86/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
index 6807839c718b..3edfb6d4e67a 100644
--- a/include/linux/platform_data/x86/pmc_atom.h
+++ b/include/linux/platform_data/x86/pmc_atom.h
@@ -47,7 +47,7 @@
 #define	PMC_S0I2_TMR		0x88
 #define	PMC_S0I3_TMR		0x8C
 #define	PMC_S0_TMR		0x90
-/* Sleep state counter is in units of of 32us */
+/* Sleep state counter is in units of 32us */
 #define	PMC_TMR_SHIFT		5
 
 /* Power status of power islands */
-- 
2.30.2

