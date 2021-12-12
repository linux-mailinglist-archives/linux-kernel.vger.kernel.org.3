Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE45471807
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhLLDfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:35:38 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:22001 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231765AbhLLDfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:35:37 -0500
X-QQ-mid: bizesmtp43t1639280030ty2nqrbr
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 11:33:49 +0800 (CST)
X-QQ-SSF: 01000000002000D0H000B00A0000000
X-QQ-FEAT: 3uawQE1sH+04XG3jsbTLNJugQlxBu+NiCWEr6z3RUK2/pj7H1m2QR7NeskOdb
        e/ayOyHNVKY6g+gH7mNVl+wHEenBugH1ACD+UWhWoRI3R54suxQmO19qnspMflfr3BBnTIY
        KIcJPN6dfLYiBOish0hMHAQ5k9+azQsU3LuRDwttTEQ5GcVzLmqn6pEJmFwq7aaghXt4Kmf
        tw0EkhP/4oYCkySPmXZ5LXgGgl+PsUrQdoZ/LqP5FjADJUERPmfh0XUs8Q2AJhjf9NAmrhO
        rl7L2XOegKwOuxWi169xt/cM2c9zjA4ebjOT34ROEkW8fZ62byIm8eKWn68gMB0HNirA1a6
        6H1L2saf7e+SnvUYsBKvg/IHQudlkLkk0/InRCx
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     bcm-kernel-feedback-list@broadcom.com
Cc:     mmayer@broadcom.com, krzysztof.kozlowski@canonical.com,
        f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] memory: brcmstb_dpfe: fix typo in a comment
Date:   Sun, 12 Dec 2021 11:33:47 +0800
Message-Id: <20211212033347.67921-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `to' in the comment in line 427 is repeated. Remove it
from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/memory/brcmstb_dpfe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index f43ba69fbb3e..14412002775d 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -424,7 +424,7 @@ static void __finalize_command(struct brcmstb_dpfe_priv *priv)
 
 	/*
 	 * It depends on the API version which MBOX register we have to write to
-	 * to signal we are done.
+	 * signal we are done.
 	 */
 	release_mbox = (priv->dpfe_api->version < 2)
 			? REG_TO_HOST_MBOX : REG_TO_DCPU_MBOX;
-- 
2.34.1

