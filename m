Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708F751BDC6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356690AbiEELO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356687AbiEELO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:14:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7136E43AD2;
        Thu,  5 May 2022 04:10:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso4900785wma.0;
        Thu, 05 May 2022 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7fZe7ZuhkcHkphV8RgWm+aqXThfc6HEs1D3+w7fnW1E=;
        b=SF6NsgMh/aI7dxvNSm4J0F8dduL8PgQFBddrpPStEMC88whboFowO6an+39Xec59dR
         cialT9GTdpTTBlnhpUM3FJSMNcMenDRq9vxT4AhKLE3FnWOfGvhKUzv0XPRX4S9unHyq
         SJn01UIX7/0ppvj+tlyfSojkTUi5skbGGPe9dk8NaZoZdBQX9dYZ530f4HegVXm4Qjce
         4WoZ0Qoa/0mHf/bMvlgoA1/dkJSg9rWKe90SPua56pGHGvs7cDaJzGPwL7fBTageCK/X
         GnR+nS2Nf9KkS2HbQuhuIIJb9/NIPZKcM9hVS65VZ5Z+yNCJMxuXjicKlW+QD0DVUUP3
         RmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7fZe7ZuhkcHkphV8RgWm+aqXThfc6HEs1D3+w7fnW1E=;
        b=KgAfkD8+xBBhU7Bqpb463SlDDAofqRL4O1B56hWNjRz42tCb288ELICSgvqU5WDvQ6
         UICrO/v73BmGh6WkdauyRvls291cWxcd7kjYnws7idXfI9Dt1OOu5cRS9+liGoER2D1a
         Y/vrHPp8cskAOaZoBjn0yydflUQpIAIfy/ClfrXMP7Yujxoivy7abjHUWwDHphUZIcEP
         lj9OfWdy7wtzdgI0GytvTqKp/2S5izNuC1mMyyJIRSx01TCbCWHDYTCDTdIjiWdeHKYI
         YjNEkPCnncETUMYwNEW7duJfGfLG3wIHspzuUcQT1AaNkVRm0MZVRAdpRD8qmtEHggRZ
         3lvg==
X-Gm-Message-State: AOAM530jR958ilYr3EcGtRRS+938GEFITD/nwQT21MmkPGUID7fh264R
        2uLmqEDCGwCGvPnpcC/88bM=
X-Google-Smtp-Source: ABdhPJx/+pEPKFamTmmbN/plSGNtO72hEEKl6yTB7HoNEk+TwL9rhZ7ovl3RzseVO64gCmaWJwIfCg==
X-Received: by 2002:a05:600c:2045:b0:394:2457:9c36 with SMTP id p5-20020a05600c204500b0039424579c36mr4002675wmg.76.1651749045827;
        Thu, 05 May 2022 04:10:45 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4d07000000b0020c5253d920sm1122934wrt.108.2022.05.05.04.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:10:45 -0700 (PDT)
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
Date:   Thu,  5 May 2022 12:10:44 +0100
Message-Id: <20220505111044.374174-1-colin.i.king@gmail.com>
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

