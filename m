Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C236857825A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiGRMa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiGRMaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:30:24 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB69FF7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:30:20 -0700 (PDT)
X-QQ-mid: bizesmtp73t1658147384tla2pq15
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:29:42 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: MFQNDABwGMnG3QsZatbGD4I1WiXIyJyAzMqiZ/sq9ymsqWHZaTxRD8C1sUp0j
        weG4VLNP13F2upYyDFzGL4ign7OARYznrnjudfnKh1ZVprTt24A8h9HhTU9/dRKtbTBFgSQ
        mFndtoV5zqDneUISK4eV3Oeo2lKWSN1c/ylTD1PyA2/TC14bhmPTyYOyfnRG/b4ymvD+37j
        OTMHw0m7Z9x+Q+lJSLvduZSYWfGIyIVMouR0V4gwtAljd1epyXtWUhkPJjxEUIG5HHaKEwd
        VxBzNrFb0Qb/47npqGwhB7N2eJnyLU639Kop8RUKj1msJIQMp+uGHhwkDggwWbGX7krXLKb
        zt4Ut0Tum387alsqj4PcBLMSK3J5aLr3YE5gYtg/vFc7r36F/SCvkvqCD4bFsRTtjjMp+vW
        mx+dqcRadG0=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     haojian.zhuang@gmail.com
Cc:     daniel@zonque.org, robert.jarzmik@free.fr, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ARM: pxa: hx4700: Fix comment typo
Date:   Fri, 15 Jul 2022 12:27:45 +0800
Message-Id: <20220715042745.14883-1-wangborong@cdjrlc.com>
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

The double `the' is duplicated in line 33, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm/mach-pxa/hx4700-pcmcia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/hx4700-pcmcia.c b/arch/arm/mach-pxa/hx4700-pcmcia.c
index e2331dfe427d..860b78aed18c 100644
--- a/arch/arm/mach-pxa/hx4700-pcmcia.c
+++ b/arch/arm/mach-pxa/hx4700-pcmcia.c
@@ -30,7 +30,7 @@ static int hx4700_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	/*
 	 * IRQ type must be set before soc_pcmcia_hw_init() calls request_irq().
 	 * The asic3 default IRQ type is level trigger low level detect, exactly
-	 * the the signal present on GPIOD4_CF_nCD when a CF card is inserted.
+	 * the signal present on GPIOD4_CF_nCD when a CF card is inserted.
 	 * If the IRQ type is not changed, the asic3 interrupt handler will loop
 	 * repeatedly because it is unable to clear the level trigger interrupt.
 	 */
-- 
2.35.1

