Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE79C4712F3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhLKIuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:50:11 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:49806 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhLKIuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:50:09 -0500
X-QQ-mid: bizesmtp40t1639212490tfk6v3a1
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 11 Dec 2021 16:48:08 +0800 (CST)
X-QQ-SSF: 01000000008000D0H000B00A0000000
X-QQ-FEAT: Mzskoac49OgM4JycWvfr9kGBMD8fREQROQVtqbfrfNw7yKiLF8bKhegTqbyVX
        fBIIq3+bKbxEi87SX7PqxkvP4jRJJgOiUJ+W4jHKbPWXWwSWveY83Tm+kXzrE5vCysjrxQc
        GKHN0UXyKP8O+1b4peL39LFrztSH0e2h7GltzkBZmqBjoPObjZ8/11cfKV6CwCTs0JQsLET
        zzbujJUiL32N4vLgI8mSqgjiCqW5lTOpL4QZmAN4rFyvborLoswRt6YLhT/rXHwHAJIAbgT
        9fAKewcOjsU4gVz8lNBp3KUzGkTcDKMe4c8sNvyIW62J5SIuz5/MzXdyi1lGPpWsTAWrdzr
        pJPeYmp
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     haojian.zhuang@gmail.com
Cc:     daniel@zonque.org, robert.jarzmik@free.fr, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] mmc: pxa: Fix typo in a comment
Date:   Sat, 11 Dec 2021 16:48:02 +0800
Message-Id: <20211211084802.217766-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `output' in the comment in line 170 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm/mach-pxa/pcm990-baseboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 8dfcc366d0fe..4be64aac16b5 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -167,7 +167,7 @@ static struct platform_device pcm990_backlight_device = {
  * - LCD support is in use
  *  - GPIO16 is output for back light on/off with PWM
  *  - GPIO58 ... GPIO73 are outputs for display data
- *  - GPIO74 is output output for LCDFCLK
+ *  - GPIO74 is output for LCDFCLK
  *  - GPIO75 is output for LCDLCLK
  *  - GPIO76 is output for LCDPCLK
  *  - GPIO77 is output for LCDBIAS
-- 
2.34.1

