Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60689475D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbhLOQUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:20:15 -0500
Received: from smtpbg587.qq.com ([113.96.223.105]:34373 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244446AbhLOQUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:20:15 -0500
X-QQ-mid: bizesmtp39t1639585092tzk1ch7u
Received: from wangx.lan (unknown [171.221.148.2])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 16 Dec 2021 00:18:04 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: TMbHAYExFrnCiy5Sipe7jG7PBJl0MFknZtWaCapYqBY7aJtaR1CDHRlTgtsxH
        wO0uRCiatUczPqLnqfOmc5dyPtbc7cCmPt1MN+FTBOaYVA15KCAhkBzb6AqJ0h3eZDNo3n4
        b2MXKDzxcc3x1txptQtMvKRXrnK9Sain0b+UNapWof5CiekKePwemnd2QvmvgsxwYx7GzoR
        9oSEbqbxa9YvP9GgNIEc+1oVFQfXKBQs9EWLrrui19UqT+yp/x2Z3pM4h5wLqaTMM7qvjMH
        Cyosjbsjc3Iwn6q95+B+kve7z8GSUFHZlT3/vQPMFW++EjYa4/qetLOdhG2ubCd0oxxg==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jyri.sarha@iki.fi
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] drm/tilcdc: add const to of_device_id
Date:   Thu, 16 Dec 2021 00:18:03 +0800
Message-Id: <20211215161803.5900-1-wangxiang@cdjrlc.com>
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
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 3ddb7c710a3d..d23ed0e2e87b 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -587,7 +587,7 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tilcdc_of_match[] = {
+static const struct of_device_id tilcdc_of_match[] = {
 		{ .compatible = "ti,am33xx-tilcdc", },
 		{ .compatible = "ti,da850-tilcdc", },
 		{ },
-- 
2.20.1

