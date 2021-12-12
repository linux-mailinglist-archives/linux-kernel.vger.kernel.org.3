Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A184717F3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhLLDNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:13:53 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:44206 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232503AbhLLDNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:13:53 -0500
X-QQ-mid: bizesmtp48t1639278822tp79wwau
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 11:13:40 +0800 (CST)
X-QQ-SSF: 01000000002000D0H000000A0000000
X-QQ-FEAT: RQgt58ASpRERqq4KjOokDQSHuzI/Sxe6m+r0FwVwCpY3OOJWCQVmFA+TgAqI3
        rPpvWpo9+JXb7p3jV12bqLZ+W+MONlMBtxrkNziVAEAUrbhjW7WVaJdbskwHMQ5KyRcSFTP
        doFOPjvSZ2YOENcrp+ayiPcjxgfMooijDwEPjL9WpnDU7Gw1VZ85QdIrcQ84Re3t/wzxugk
        99N7D4wvT7XwyPWR7TQ2X6xMleoTctMrOLoePH3N6ndWguj4Wo576UoNMHOdzi+xb7bjaic
        smORcrSVlhsQuQq3XFtXiAA4tPTa/EqK66CFTUS9iVDdJBwDuHZE5RRdbikdCMDdB1I+NlI
        /cPFqo+1nfzJmJcT00cTbR831ADdA0vt/HZQfIv
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     brgl@bgdev.pl
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] gpio: sta2x11: fix typo in a comment
Date:   Sun, 12 Dec 2021 11:13:35 +0800
Message-Id: <20211212031335.36369-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `all' in the comment in line 327 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/gpio/gpio-sta2x11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
index 392fcab06ab8..e07cca0f8d35 100644
--- a/drivers/gpio/gpio-sta2x11.c
+++ b/drivers/gpio/gpio-sta2x11.c
@@ -324,7 +324,7 @@ static int gsta_alloc_irq_chip(struct gsta_gpio *chip)
 	if (rv)
 		return rv;
 
-	/* Set up all all 128 interrupts: code from setup_generic_chip */
+	/* Set up all 128 interrupts: code from setup_generic_chip */
 	{
 		struct irq_chip_type *ct = gc->chip_types;
 		int i, j;
-- 
2.34.1

