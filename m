Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC251EB2D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 05:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447127AbiEHDHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 23:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiEHDHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 23:07:18 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307DB9FFF
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 20:03:26 -0700 (PDT)
X-QQ-mid: bizesmtp84t1651978948twf40apl
Received: from localhost.localdomain ( [125.69.42.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 08 May 2022 11:02:26 +0800 (CST)
X-QQ-SSF: 01000000002000E0S000B00A0000000
X-QQ-FEAT: Mzskoac49OiMPXbnyEYdI4Qsrzbl4IKmMFgaE+lCQmtRRuGsyeNZUiwnpsEvu
        xqrzS2H1cvueaTfYzJG7DTrGofNXFBFvh8IljyG6LVuOOLnwRQU4kg14SJZP9nyzIUg6mgH
        SOzS0Kjswg+b8g4SptPRaWLFwrwjceQxyW+Q7eforwGeet11nePI5kq+8ZOMe6lZ7+/ereq
        70c4y8MIvemARkEIqIsCdaGw0TLbgMwMbUArnyEZ7wZY3Cdf656jI9lXmNpClE2mYW0OlBc
        +hfHS21BXl8q8ZRLyATqw8O/tKjPl1zNkwokM6ytgregXvFHqkBcSVKKEToe8IheD47zhKz
        Y5u8kBJF1AncqxuxGx0qTFWN7bWJA==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     vgupta@kernel.org
Cc:     peterz@infradead.org, will@kernel.org, wangborong@cdjrlc.com,
        Julia.Lawall@inria.fr, vschneid@redhat.com,
        deng.changcheng@zte.com.cn, libang.linuxer@gmail.com,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARC: Fix comment typo
Date:   Sun,  8 May 2022 11:02:24 +0800
Message-Id: <20220508030224.124797-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove one of the repeated 'call' in comment line 396.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1

