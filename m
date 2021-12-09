Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0668E46E906
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhLINW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:22:57 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:15963 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237827AbhLINV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:21:56 -0500
X-QQ-mid: bizesmtp43t1639055898td6jrqkw
Received: from wangx.lan (unknown [218.88.126.113])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 09 Dec 2021 21:18:10 +0800 (CST)
X-QQ-SSF: 0100000000200050C000B00A0000000
X-QQ-FEAT: Mx1dxJbW4IU3v1pQK408uQMITlWvmZWOXgkfwWP1usey8JlQUr7sOEPCPAVz1
        w3FDrkUrpr4cqPjkw6aw1z02W1lDq3wHEPZsKljT/zvh0GpXOga0x9wJqpZdha+4MoZLm2n
        BhL72hF2jodFEIBk66O4hebphZBMWlJTKLfdA7kZiNI7EqJW27rT2yhwF9Nm67N8TRuooCp
        iuuMUifeHoP+RaxaAm0jhyZRwJQh97Z9F98v8D+LXGYjlhlCXJoipyue9R609LyrXmV/N2m
        dRxWRVGRc3N0QzN9HAQFniTakhZeRXgXAhan8ZZCUjinddMsZieFNcdA4gp1g3jWFKfb+na
        dCj4gY2modKbUUFwTV2npdHY7T8zA==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     ysato@users.sourceforge.jp
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org, wangx <wxmige@gmail.com>
Subject: [PATCH] h8300:replace #include <linux/processor.h> instead of <asm/processor.h>
Date:   Thu,  9 Dec 2021 21:18:08 +0800
Message-Id: <20211209131808.24040-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
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

