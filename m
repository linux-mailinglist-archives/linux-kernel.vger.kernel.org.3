Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74245B1D35
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiIHMg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiIHMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:36:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FEEE6209
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:36:43 -0700 (PDT)
X-QQ-mid: bizesmtp71t1662640584tam1w07w
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:36:22 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: NCCf6GxSCjvw1iXhK9qC7rQ2uhCMxKhxNDHZO29CryP9okCDowcQgOAmGUBA0
        305O50IoPtW1SUwsa0tUrHDmdwPFSiTjiHFGZ2RIBqqfxz8+FFrxu7npK2b1+vEefTyrvGk
        eQMq5gOhqz9zxgs2N4WvGcgGzh0bmcDWSsd6/ivDZ2YsUmofRqaxaoPOhVG2ZbHsvFLltRU
        scoTeY4HqGgVng8EYIIcGnJZ99Pidz9egejujj+kuW4Q5KRFSTqmNztLUEMux01Y3G6o+qY
        TJ0KgNpewgfC71emy71V1rqOEkzO3WmYGWLGo1C0WEM0GmuGyJRPXqrdb4D3D9G8a1A7tg5
        ZLorMAQUpaPwMU1mESnLg9SVq/WUMkB90caIGn78FUUK+Y8qRg=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drm/rockchip: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:36:16 +0800
Message-Id: <20220908123616.19195-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index bdd48f87d098..fab710910997 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1188,7 +1188,7 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 	 *
 	 * Key points:
 	 *
-	 * - DRM works in in kHz.
+	 * - DRM works in kHz.
 	 * - Clock framework works in Hz.
 	 * - Rockchip's clock driver picks the clock rate that is the
 	 *   same _OR LOWER_ than the one requested.
-- 
2.36.1

