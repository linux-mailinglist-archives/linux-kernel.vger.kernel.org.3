Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7567952634D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiEMNyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347101AbiEMNyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:54:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AF05A597;
        Fri, 13 May 2022 06:53:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so11586738wrg.3;
        Fri, 13 May 2022 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7fZe7ZuhkcHkphV8RgWm+aqXThfc6HEs1D3+w7fnW1E=;
        b=c8pvij0fZVSEifHuKb4ntHQFJbaoWeF16rwR0TUUzsGtGA4msQL9RdM3IaImMp0HAJ
         QybhumSZY9ZmpjDfK/fwoZnyzH3wD712NJ8c6u6ePfCDoEDZBz7biWzeFeDbVQFjRqOK
         izQcfAhhn3OGdfF1r1Z5Y3v1DI5xkS7k7cuUNUBvyTtuqDNSjLeVJNZx4KAZeIvO27cg
         zHbge6ihXS69wXl3rGwOcBwzz/jumGXO/LNhxp0A1FqdwCenAty2cAih7XJMp2hu4r4Y
         jocIg7tcpjXOeKeUPLiYGzz78K/M4ZYMC6cDamRbPwOW+Q+NEU7Xt+8lg2+zHdOweNd+
         RQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7fZe7ZuhkcHkphV8RgWm+aqXThfc6HEs1D3+w7fnW1E=;
        b=5rPQcxDVF79X17qaTh9WBXafluLaVc2u2L7/Va17QdtwfXKeHGM+s6aTP11fNZG7qG
         PptCoig29tDStvCJthkPd9lw/PEFUhX3eb41UJMTdmuE9lJp+IPlfchJJ3Thgrpcx/KA
         IwUbafz2o2HRJjYfGFie4eIyxEQ/Hk60d2uDZnEWlvo3vpKXJJ2SkOutEWaGM1oNvRiN
         rTFJuBZcHFL1PeUcUsqLr87wlzBwUbEGo+ViM0Um0BNZ+DWZ9qLT/FkK6ZAjkf9r6alS
         qj6aZ+eUmcEjx7FEyXdQIP1EMMZFiswyEEIfSoCuNbD0yA9EIo/l64EGyPRrBW3Nvm2w
         iNVA==
X-Gm-Message-State: AOAM5307NLw5eFT+7GbdJvvAwu/YyMo/yXbc0MPMFdIxuBUsb7wfGgCW
        kHHxnFxaiw2oRmoAXC1lTbo=
X-Google-Smtp-Source: ABdhPJy+EwUp69L0cz2uBqQcXBfzCCAdTcl2Tk4p9WOhncRmnlPiaIfBKRewmbH8Fj20a+w1hQxW0w==
X-Received: by 2002:adf:e449:0:b0:20c:d56a:6020 with SMTP id t9-20020adfe449000000b0020cd56a6020mr4067091wrm.425.1652450023108;
        Fri, 13 May 2022 06:53:43 -0700 (PDT)
Received: from localhost (245.218.125.91.dyn.plus.net. [91.125.218.245])
        by smtp.gmail.com with ESMTPSA id l6-20020adfa386000000b0020c5253d903sm2161229wrb.79.2022.05.13.06.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:53:42 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/rockchip: Fix spelling mistake "aligened" -> "aligned"
Date:   Fri, 13 May 2022 14:53:41 +0100
Message-Id: <20220513135341.290289-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a drm_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 0b49fed16535..04e8e22a8640 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1202,7 +1202,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		 */
 		stride = (fb->pitches[0] << 3) / bpp;
 		if ((stride & 0x3f) && (xmirror || rotate_90 || rotate_270))
-			drm_err(vop2->drm, "vp%d %s stride[%d] not 64 pixel aligened\n",
+			drm_err(vop2->drm, "vp%d %s stride[%d] not 64 pixel aligned\n",
 				vp->id, win->data->name, stride);
 
 		rb_swap = vop2_afbc_rb_swap(fb->format->format);
-- 
2.35.1

