Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FB75A0A16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiHYHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiHYHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:24:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21008A0303
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:02 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w13so12060957pgq.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/kpt2RV6NM9K6J+Df1fFRo6EZL8n/4JlPeLG7FAew6U=;
        b=UDBqe9YjPW7t3UyrluqNFqCKncHu/IFGNJrVjvdU/qUzU9/RInEy1OUH+YhUtqZSjo
         H5KCL6YWlLFAc4dzcpZLFyZWVItgkRUiUpAuGkDVWylwYv4S8vPQ3QzXirhjcM4BL5LJ
         IC7PGzR5x7uffJJB+z5VktykrB0bl6cMp52YSNx+AeW2KWjy/SgD7A2gxFuqBpWoV6hz
         QQ2zT5406WVkKvb/ykqJgDTja5ESHrRoCMht2AUVoU4nahwFzg2EKNda4NEP51N8k5B6
         BP2m6t52bad71ST+B+m0XnikxPtbmkkQKkqrjDi3cqas0dJOPRMc4Fgdaa/848EV5/eH
         /qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/kpt2RV6NM9K6J+Df1fFRo6EZL8n/4JlPeLG7FAew6U=;
        b=PmUYfGwEzOjJlmhjFdvXxw/BCAJJObYW3QFJAiKBz6l4FRmkGfRwfaA9IU0b3FVqzU
         HDP7dWdM5LvdiiLi0H4qSShomOE+ALZ6Ntr0s64bpk/QHRchdPWKJ+O9McvjXvO6lWe0
         oWlbV0g4uYu/+4o1rE7+nBA4i3eWoQOTnIr3Zfw+ZGNl/FMB9mQQDF0XDw97pwQzia2e
         vgNdTqBfeyz9D2/Wqss+TH3FllFK1dgEp5VCR6s2l8ekW7Zv5QoEjm7g1aUqI9Lv1x1X
         OlNlZj8HOxx0y9lyLnnH0q2VMlilnv7UiQ3lhFtOQ/YCKyDTuEhTrPpQQnnssAicrnQy
         fgWA==
X-Gm-Message-State: ACgBeo0ZaA9jRxFaHV6loRCj3WXTUAFZzYKbyqfLlh1C8GKmpGgb7/AE
        SwR0SM0DFKBM1+ai1/lSu0c=
X-Google-Smtp-Source: AA6agR7v/r3DRgd8SnJ0ZIUhy/OVQel9Bx9fmiJXxu11YC3eOwMJefcW1JsusLYI5j/00IiosOtX/w==
X-Received: by 2002:a65:6b8e:0:b0:42a:162c:e3a0 with SMTP id d14-20020a656b8e000000b0042a162ce3a0mr2215384pgw.464.1661412241538;
        Thu, 25 Aug 2022 00:24:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x124-20020a623182000000b00534cb3872edsm14256958pfx.166.2022.08.25.00.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:24:00 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     matthias.bgg@gmail.com
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next v2] drm/mediatek: Remove the unneeded result
Date:   Thu, 25 Aug 2022 07:23:35 +0000
Message-Id: <20220825072335.228921-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value drm_mode_config_helper_suspend() directly instead of
 storing it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
Add all the mailinglists that get_maintainers.pl give.
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 5f02f8d0e4fc..91f58db5915f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -833,11 +833,8 @@ static int mtk_drm_sys_prepare(struct device *dev)
 {
 	struct mtk_drm_private *private = dev_get_drvdata(dev);
 	struct drm_device *drm = private->drm;
-	int ret;
-
-	ret = drm_mode_config_helper_suspend(drm);
 
-	return ret;
+	return drm_mode_config_helper_suspend(drm);
 }
 
 static void mtk_drm_sys_complete(struct device *dev)
-- 
2.25.1
