Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D240D47A4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhLTGYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:24:10 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34735 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237538AbhLTGYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:24:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.7dF9F_1639981447;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V.7dF9F_1639981447)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Dec 2021 14:24:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     kernel@esmil.dk
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] pinctrl: starfive: remove unneeded semicolon
Date:   Mon, 20 Dec 2021 14:24:06 +0800
Message-Id: <20211220062406.108789-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/pinctrl/pinctrl-starfive.c:1029:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pinctrl/pinctrl-starfive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
index 0b912152a405..ed6c9b36849b 100644
--- a/drivers/pinctrl/pinctrl-starfive.c
+++ b/drivers/pinctrl/pinctrl-starfive.c
@@ -1026,7 +1026,7 @@ static int starfive_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
 		break;
 	default:
 		return -ENOTSUPP;
-	};
+	}
 
 	starfive_padctl_rmw(sfp, starfive_gpio_to_pin(sfp, gpio), mask, value);
 	return 0;
-- 
2.20.1.7.g153144c

