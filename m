Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8148649DB44
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbiA0HO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:14:26 -0500
Received: from smtpbg704.qq.com ([203.205.195.105]:32949 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237155AbiA0HOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:14:25 -0500
X-QQ-mid: bizesmtp8t1643267659tsk8ug4cr
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jan 2022 15:14:13 +0800 (CST)
X-QQ-SSF: 0140000000000090E000B00A0000000
X-QQ-FEAT: dpyQmELDBxGvNdU0KB4Xg+n+Lv+9csg8IUk4o9MWAPMY5ySR7qLyOnQ9sTfn2
        JAbXJQVhjmHkMFGiOASypaYE9RHGJjDZGQYuRjYkJ0jz3riPJQodtwdqAuBiCgfeg2/ioUS
        ZetmAlPo0ZnCdtGODTYQ1QATtgMw+rDZ2f4Dq9FsVsFEMpNVCk+P6KJsqXzvHJovmV6hBbw
        FMwhNEwSI+h5D+e8u6cv7x8eF0OgAc6b3nka9DkSUP2Zpo4X/pRqZg4DRuHfbaviFYHheMQ
        Zx1Q9lan1shvbcT9X35TVA2cIBFoGDpONhPD+2YPrv3WNjDErU0FEkPSa+njS0abkywDO5i
        DYRVVvC9RK3MP7LEqJDZglWqohnrNLG8cIYw7zP
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     jsarha@ti.com, tomi.valkeinen@ti.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] drm/tilcdc: Fix typo in comment
Date:   Thu, 27 Jan 2022 15:14:12 +0800
Message-Id: <20220127071412.31021-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace disbale with disable

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 29890d704cb4..b986946b3b10 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -996,7 +996,7 @@ irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc)
 	if (stat & LCDC_FRAME_DONE) {
 		tilcdc_crtc->frame_done = true;
 		wake_up(&tilcdc_crtc->frame_done_wq);
-		/* rev 1 lcdc appears to hang if irq is not disbaled here */
+		/* rev 1 lcdc appears to hang if irq is not disabled here */
 		if (priv->rev == 1)
 			tilcdc_clear(dev, LCDC_RASTER_CTRL_REG,
 				     LCDC_V1_FRAME_DONE_INT_ENA);
-- 
2.20.1



