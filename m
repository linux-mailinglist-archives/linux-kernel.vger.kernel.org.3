Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD64476E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhLPJ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:56:08 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:64739 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233454AbhLPJ4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:56:04 -0500
X-QQ-mid: bizesmtp46t1639648546t1eiuno4
Received: from localhost.localdomain (unknown [182.148.14.255])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 16 Dec 2021 17:55:42 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000C00A0000000
X-QQ-FEAT: +FcubzMZu+TnobKZkdDu+fxyIxHuYmZYeBOhSMi1C8hoANf/t1LVAaRCWFSj+
        uMXtU+o568Prhwpg1dYeBW2Tft0KUciqB4A4gJvPR3gF5GnWuaJzjXJCfofR8JGXnC/nL7j
        /6u8m7riB8v6MF59mRMGQ46ei8sMFqA7xXlvR2BXEBASVD8rgkoFWcbfIXfn2ZonkI+vptP
        9Ely+lPXfoeA5rEuvf7iyPft3aD6UNtgPded5whqLyEXUHT5v/w78rirE3KPJD5So4HC8rj
        DbDxHv1bWYlFIxApuXAcbjc+yd1prXfTLW27OT3yg759mYDJJ9YZOCQMFJA6bqRtIbi9kJz
        iTG9x2JysuFyY0hQJMC9OWqmHY2LlrcTnhEJuba
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jyri.sarha@iki.fi
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v3] drm/tilcdc: add const to of_device_id
Date:   Thu, 16 Dec 2021 17:55:36 +0800
Message-Id: <20211216095536.58577-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct of_device_id should normally be const.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---

Changes since v1
* add const in line 63

Changes since v2
* removed line 63

 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 3ddb7c710a3d..cc567c87057d 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -60,8 +60,6 @@ void tilcdc_module_cleanup(struct tilcdc_module *mod)
 	list_del(&mod->list);
 }
 
-static struct of_device_id tilcdc_of_match[];
-
 static int tilcdc_atomic_check(struct drm_device *dev,
 			       struct drm_atomic_state *state)
 {
@@ -587,7 +585,7 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tilcdc_of_match[] = {
+static const struct of_device_id tilcdc_of_match[] = {
 		{ .compatible = "ti,am33xx-tilcdc", },
 		{ .compatible = "ti,da850-tilcdc", },
 		{ },
-- 
2.34.1

