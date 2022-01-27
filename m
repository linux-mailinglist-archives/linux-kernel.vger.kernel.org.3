Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32EE49DB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiA0HQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:16:51 -0500
Received: from smtpbgjp3.qq.com ([54.92.39.34]:36214 "EHLO smtpbgjp3.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237227AbiA0HQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:16:50 -0500
X-QQ-mid: bizesmtp14t1643267787tzf13wi9
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jan 2022 15:16:21 +0800 (CST)
X-QQ-SSF: 0140000000000090E000000A0000000
X-QQ-FEAT: G+mSt178IQrJBHnxSZvES1j4qrJ+NGxhGYzW1xWPkjrC+2mDO3yDXx/OatzsP
        rpFzB65yG8K96v0yHlz7OjzrsifQuZypfOFE97MwElGHAOZfXtaTHS8Xk9qSdTwdMHglGcc
        KwGEsDeoLtsqRuXZmiZTAhYXd6OmLxYWE3nXl3F3GUkheEWU+3pT8lTLOb6ZbEGcjip0s9W
        wptkp1q5CCd+dQFm3sqPY1mEXI5Ub+PYrKgz7o6yLT8dYGsw9+FPgaUosi2PwpxHUMO8AsS
        pHImjPHS9H89Odjs5YU72qQIfj9AJF3TPMsqZK/D3POE43nPF3Vjz2Y5lI/Kjdr8aQjpk3V
        AqMiae0vKwzi1j1E6OHUmCO4NLI9g==
X-QQ-GoodBg: 1
From:   tangmeng <tangmeng@uniontech.com>
To:     Peter.Chen@nxp.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] usb: udc: Fix typo in comment
Date:   Thu, 27 Jan 2022 15:16:19 +0800
Message-Id: <20220127071619.31812-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace disbale with disable

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 drivers/usb/chipidea/udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index f9ca5010f65b..dc6c96e04bcf 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -2152,7 +2152,7 @@ static void udc_id_switch_for_host(struct ci_hdrc *ci)
 {
 	/*
 	 * host doesn't care B_SESSION_VALID event
-	 * so clear and disbale BSV irq
+	 * so clear and disable BSV irq
 	 */
 	if (ci->is_otg)
 		hw_write_otgsc(ci, OTGSC_BSVIE | OTGSC_BSVIS, OTGSC_BSVIS);
-- 
2.20.1



