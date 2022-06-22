Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A35543C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354857AbiFVHyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354718AbiFVHyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:54:05 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830692EA3B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:53:59 -0700 (PDT)
X-QQ-mid: bizesmtp65t1655884341tb59pkwn
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 15:52:12 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: 1al0Ay5k4U3zy32h2+cL9Bj/nzhdZvtHEPp4Zgzg0Yx2lFQN5BPKd26xaupcm
        hCCh81ivB1rljGvEbnpmisY90FvofLSpcfFjIlLSUHf0fIGTw+exuAgn/sViSuPnfRHG5kV
        WnPZXZ9KYcr/HvOu8RixaKnEGUEtfeXSa1h9yEReLE6b9FV0NHgpMpYEjzuX4xGIEPCU97D
        o9p3mRuEc4PHVBxfPFZ2u65qbgBfOLnx2fxgyIe8Bjg7Qv1opxxYVZ/H7aswHm19VUExHna
        wpWReBYA5A6xjp85y52uVI0S9/EqA2D344I2w85RY4UIfV3ArluIjp9dp4aucUAUK8/31fL
        AiptNTuE91u1oLu4JE=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        vgupta@kernel.org, Julia.Lawall@inria.fr,
        deng.changcheng@zte.com.cn, libang.linuxer@gmail.com
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] ARC:kernel:Fix typos in comments
Date:   Wed, 22 Jun 2022 15:52:04 +0800
Message-Id: <20220622075204.35329-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'call'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/arc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index d947473f1e6d..6c22a53711e9 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -393,7 +393,7 @@ irqreturn_t do_IPI(int irq, void *dev_id)
  * API called by platform code to hookup arch-common ISR to their IPI IRQ
  *
  * Note: If IPI is provided by platform (vs. say ARC MCIP), their intc setup/map
- * function needs to call call irq_set_percpu_devid() for IPI IRQ, otherwise
+ * function needs to call irq_set_percpu_devid() for IPI IRQ, otherwise
  * request_percpu_irq() below will fail
  */
 static DEFINE_PER_CPU(int, ipi_dev);
-- 
2.36.1

