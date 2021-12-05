Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01664468AC1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 13:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhLEMVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 07:21:54 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:40313 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233599AbhLEMVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 07:21:54 -0500
X-QQ-mid: bizesmtp35t1638706702tzd8h6ni
Received: from wangx.lan (unknown [218.88.126.113])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 05 Dec 2021 20:18:14 +0800 (CST)
X-QQ-SSF: 0100000000600050B000B00A0000000
X-QQ-FEAT: 8eV18jRLafShyOOqmWW34YsgpWCvxxfl0Xllq3xBDzNd3T0f26zs045UVw7TK
        ZHotfLA5g2Mdyj5+go7x7SlsW+GFYKPGySVTGZOr9orWM5dcwo7TG5GvSghuWbJAsRrCLgV
        1gwb0r1X7J9qaMeg2izoTM/1ErTePyHOOZVdXSniycOvCLdmaCqGH0QkBnXZ6XLaubX5rAb
        TilyzKD1DlZHV1f0F6SwMbpOrl1IkqTqtJgclqPSz+PksyMYjnL+FZKtgMSAe9V1XaPGWJv
        /h3PRFzolOAKwGOvcVxWH4NfWhzBwCc9sPyXTNr5IHsH+8Ifb4QCdlLWZiezTLwCS878eGf
        D2I4irPoFnlGnpnz24=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     ysato@users.sourceforge.jp
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org, wangx <wxmige@gmail.com>
Subject: [PATCH] h8300:replace #include <linux/processor.h> instead of <asm/processor.h>
Date:   Sun,  5 Dec 2021 20:18:12 +0800
Message-Id: <20211205121812.17606-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangx <wxmige@gmail.com>

linux/processor.h is recommended

Signed-off-by: wangx <wxmige@gmail.com>
---
 arch/h8300/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/h8300/lib/delay.c b/arch/h8300/lib/delay.c
index f4277529a9b9..8ca72f3a4883 100644
--- a/arch/h8300/lib/delay.c
+++ b/arch/h8300/lib/delay.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <asm/param.h>
-#include <asm/processor.h>
+#include <linux/processor.h>
 #include <asm/timex.h>
 
 void __delay(unsigned long cycles)
-- 
2.20.1

