Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345A146E8E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhLINRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:17:53 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:15970 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237650AbhLINRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:17:52 -0500
X-QQ-mid: bizesmtp41t1639055575tjkpfook
Received: from wangx.lan (unknown [218.88.126.113])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 09 Dec 2021 21:12:46 +0800 (CST)
X-QQ-SSF: 0100000000200050C000B00A0000000
X-QQ-FEAT: Z5wRfCDkVUXygtspXHXLs/U/H+ym4z7Wqubl61YiMrdmQUz3uNHhSpbF0osD6
        pgb73hRY28+l+U2CwDYVnvzUBN9TNWJTuKE8hJYqTWAEH2RhaSlx0dXG9qmt6MSvoQ2hkH7
        VsegH0P5svPpHs8+KgWtRJKDyyI5OwYv/pNSiwM/s05Cou9PU4UvfORfnK8DZ+Q0jlvSE4Y
        S9QWipxZHk/liBQpOSFmdTN6P3lVix2FRVWIv2EainGqDhtArsGvyZlJ/NQz4QZNQMIJnwm
        1CpsPiwXJ1D9/Nu7kS8B8/DSo2J1OoPTWdnEgOrO/AeTfoCgkufPL98zZvPsSiP3Pexv+e+
        IY5qCfQfBEI+eLiqaEUHWr3Eu2wOQ==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     linus.walleij@linaro.org
Cc:     rjui@broadcom.com, brgl@bgdev.pl, f.fainelli@gmail.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] gpio: bcm-kona:add const to of_device_id
Date:   Thu,  9 Dec 2021 21:12:45 +0800
Message-Id: <20211209131245.23172-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct of_device_id should normally be const.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/gpio/gpio-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index d329a143f5ec..9cb3587d1441 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -505,7 +505,7 @@ static struct irq_chip bcm_gpio_irq_chip = {
 	.irq_release_resources = bcm_kona_gpio_irq_relres,
 };
 
-static struct of_device_id const bcm_kona_gpio_of_match[] = {
+static const struct of_device_id const bcm_kona_gpio_of_match[] = {
 	{ .compatible = "brcm,kona-gpio" },
 	{}
 };
-- 
2.20.1

