Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30E74717F1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhLLDLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:11:36 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:40522 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232503AbhLLDLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:11:36 -0500
X-QQ-mid: bizesmtp35t1639278670ti9jadrr
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 11:11:09 +0800 (CST)
X-QQ-SSF: 01000000002000D0H000000A0000000
X-QQ-FEAT: 8eV18jRLafSDr/OUbaHkXpxYLtKfqlvyNQR1r9ormXcNfgenhCDJ6OhrDkLFM
        OQukjaBRSxvfBMTSBN0l+YxAaRFjVjFI4+8dOsbv92yT11PeK3VL5aayeaVU/86sIxzQeGX
        wTjMrsLA2haDb2txm2j42t9c+aYUs0N0K6c5Zj/aGUhjXPuqKNQ7Cxn8VdaEPIO+kqzXBoZ
        irHQBqP9aNyjNk6pqLdLEWo6q8AA0PkYfOitJK9WCa4evlPOjdmY57+4+spzrFnvIPa3SAG
        mttmAs+sBKyYLjdvEr5ZXBj3qUQWePgv18JafQTM6FrT/j8vhXxJxpj1/ORikpStdohkCQ3
        5KaAFv5QbVfo2GzeCby9h3jxJuv+w==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linus.walleij@linaro.org
Cc:     andy@kernel.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] gpio: sch: fix typo in a comment
Date:   Sun, 12 Dec 2021 11:11:08 +0800
Message-Id: <20211212031108.32212-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in the comment in line 142 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/gpio/gpio-sch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index 0600f71462b5..acda4c5052d3 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -139,7 +139,7 @@ static int sch_gpio_direction_out(struct gpio_chip *gc, unsigned int gpio_num,
 	/*
 	 * according to the datasheet, writing to the level register has no
 	 * effect when GPIO is programmed as input.
-	 * Actually the the level register is read-only when configured as input.
+	 * Actually the level register is read-only when configured as input.
 	 * Thus presetting the output level before switching to output is _NOT_ possible.
 	 * Hence we set the level after configuring the GPIO as output.
 	 * But we cannot prevent a short low pulse if direction is set to high
-- 
2.34.1

