Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E430476D62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhLPJ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:28:39 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:33660 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232844AbhLPJ2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:28:36 -0500
X-QQ-mid: bizesmtp37t1639646878tmz4uqv7
Received: from localhost.localdomain (unknown [182.148.14.255])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 16 Dec 2021 17:27:09 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: d4aHnNlt5vwRWrdWAtjrWAKNCTgm9j9yYuHUnhqKgnCbEOWR+X75l8+YzZXHx
        ADCyePQrpwVF4Jivy9jZJa1W38pL/8/rn69CKPMjCnL6nTacpnOG8ft3wt1z3CL/iu7VMb7
        1HLGVUPLJjBnpB24td7YnsXR1b7BXIpo4PZblSItWSp8bq0l5wYjSWdXTJhvX9lZPKdY+f9
        nVApjcbbQgGdTJZ92oD7rTqHquB3UDV1VlrtxMjLmnNcD2mdWqosjpJukSTFOHPbTSFPP4Y
        UGXLf6B3U4anuKWBdFVx9WWKZ5G8rxzatRc/du2pF8cXn1t2Nkc2upnADqSBrDMOX6b+iL0
        NH6q+5ofJSgrqoJUG8tdUaTxMm/N9G7E2H7GUrE
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jyri.sarha@iki.fi
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v2] drm/tilcdc: add const to of_device_id
Date:   Thu, 16 Dec 2021 17:26:52 +0800
Message-Id: <20211216092652.33414-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
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

Changes since v1
* add const in line 63

 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 3ddb7c710a3d..7c36ecd82ebc 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -60,7 +60,7 @@ void tilcdc_module_cleanup(struct tilcdc_module *mod)
 	list_del(&mod->list);
 }
 
-static struct of_device_id tilcdc_of_match[];
+static const struct of_device_id tilcdc_of_match[];
 
 static int tilcdc_atomic_check(struct drm_device *dev,
 			       struct drm_atomic_state *state)
@@ -587,7 +587,7 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tilcdc_of_match[] = {
+static const struct of_device_id tilcdc_of_match[] = {
 		{ .compatible = "ti,am33xx-tilcdc", },
 		{ .compatible = "ti,da850-tilcdc", },
 		{ },
-- 
2.34.1

