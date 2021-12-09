Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B4946E918
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhLIN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:28:43 -0500
Received: from smtpbg587.qq.com ([113.96.223.105]:53127 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhLIN2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:28:42 -0500
X-QQ-mid: bizesmtp49t1639056302tw2fn4nj
Received: from wangx.lan (unknown [218.88.126.113])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 09 Dec 2021 21:24:54 +0800 (CST)
X-QQ-SSF: 0100000000200050C000B00A0000000
X-QQ-FEAT: 8oXz5ILWlO5KLItnaQtdB5C8c1kwy8TTz2+QFZGGQNjP+yXTAnzu/O4XWhLu8
        MEBrrXOErdpQ1eHrjsFAWvOssxtQTzOhi26E5spOCH372moHqJPjnGSO/Ekunz7fgGzO06i
        drgOGeoANKTATLnga33b+c9tipLgE6Hakq6BOxqtMI7Mks0zFpIb3FQyhSnBrrg1cV26gFy
        srjY0n1FQHrLCRSmYa1ANUgzp3Nqf9jtHuJmwP8sgwejA0nkrRtevNviplj9nOzs+9vrpot
        UQnj12QyX5OOEsmR4Vxalr4CESguD/uR+EM7Nw+kUg8v9to2UUT4/BPSqEzhlynvWQF40aQ
        aEJ/rpqVCxlTtlVxw2/hWJhvO1gJg==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] irqchip/gic-v2m:add const to of_device_id
Date:   Thu,  9 Dec 2021 21:24:53 +0800
Message-Id: <20211209132453.25623-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct of_device_id should normally be const.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/irqchip/irq-gic-v2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 9349fc68b81a..f2d252dff5f3 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -405,7 +405,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	return ret;
 }
 
-static struct of_device_id gicv2m_device_id[] = {
+static const struct of_device_id gicv2m_device_id[] = {
 	{	.compatible	= "arm,gic-v2m-frame",	},
 	{},
 };
-- 
2.20.1

