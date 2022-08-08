Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB52F58CB18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbiHHPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiHHPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:16:06 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768151021;
        Mon,  8 Aug 2022 08:16:04 -0700 (PDT)
X-QQ-mid: bizesmtp64t1659971746tpxd3omy
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:15:38 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: ILHsT53NKPjMUaRwTA/y5eY0zF6EgkGSYuEzDp2fnQ5Tip1yTzO1GSzF7D2Yq
        38ddwSfIjiJnA4KNxu/nycjVgPkTPfoLy+0x/EyCMsc4gE+NzEDzm62TP4mUxqaVcjybWce
        tZkumjoFIhOLSiKVKO6IJefmV3NLuLtleqb6jwelbtc+4sI9vma9pn2fAJ88NB8a83h1btx
        pJpJE9i78dXpE54ild0oUzdpZpib1SRAzhcFSo8J54eeJgeFWs0MGo4wZzyuVsm3tGJnIsy
        658mh7zv1qpJ2SqOfEKlpGCgp9r72lcyA3wS3nQckIqs1osgVaeyJC92sByBummjxdqzDw0
        j2oEh4DK5sG85k6cQfDaFwtb4hJSKaN9aWOLfnHxPO+Nv7K5OIs1XxUFqPa+SxY6Bb5Ucz6
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] serial: fsl_lpuart: Remove repeated word
Date:   Mon,  8 Aug 2022 11:15:37 -0400
Message-Id: <20220808151537.846-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "as" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 8fe0494d4057..acd527f95c9b 100644
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


