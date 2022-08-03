Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF98588AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiHCKmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiHCKmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:42:42 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93FF2637;
        Wed,  3 Aug 2022 03:42:32 -0700 (PDT)
X-QQ-mid: bizesmtp77t1659523333t492x03g
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 03 Aug 2022 18:42:11 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: zfj4kEUeXSYNzadscJ6QW9RfbqciXydduLNxxDqVFV4NdIs50s6qL9wWaX+Ls
        ANXKBozCdUqp0+ID0DlXVoPdK5vSdi6o1dYoceEahvJkgd5kyHNW5E+/Gu+BZa5vk6rbpxy
        MQSEumPSAAck+kt8EYlAVF53TxPyk6XAmMO4O9k1mDvpIk1BHezOYSiLTtRVfOcYtqid09u
        QE2UyQ6UdpsEyDCL8thws4/jj0tzjY9w91lw2OlQwtKmRn+cihFvLBiPJhnm4VnpBPWRlGo
        jAd7euv81JR0hbnVskXgaGQgpnpsbkOJ9ZYjhPg5wYO8Q2HSj39Bq1Y130ZuWKpMd7CKAj1
        95lChvx1FmmpOSVKTBWzVOB1u0qw9mE5QdsJL1I95V45KVyJxc=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] serial: fsl_lpuart: Fix comment typo
Date:   Wed,  3 Aug 2022 18:42:08 +0800
Message-Id: <20220803104208.4127-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `as' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fc7d235a1e27..19e36998f6db 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2776,7 +2776,7 @@ static int __maybe_unused lpuart_suspend(struct device *dev)
 		 * EDMA driver during suspend will forcefully release any
 		 * non-idle DMA channels. If port wakeup is enabled or if port
 		 * is console port or 'no_console_suspend' is set the Rx DMA
-		 * cannot resume as as expected, hence gracefully release the
+		 * cannot resume as expected, hence gracefully release the
 		 * Rx DMA path before suspend and start Rx DMA path on resume.
 		 */
 		if (irq_wake) {
-- 
2.35.1

