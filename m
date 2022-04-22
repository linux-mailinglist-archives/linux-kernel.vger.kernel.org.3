Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F5450B34B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445634AbiDVIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiDVIzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:55:12 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3EADF8D;
        Fri, 22 Apr 2022 01:52:20 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id hf18so5084730qtb.0;
        Fri, 22 Apr 2022 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R6g4D7mTtXbmJbP4V29JqDtbmx2cmeevRLcE291yfLw=;
        b=dceCRkgeMucI4j00b+6DMN6jUHuFGTzb9UsP2b6PAVaekNpBuYgNj8cI3MS39K4cbT
         tz51tIx68lnxOEk/UKNv0E6NFWbf2isguESFyfRMWIH6el5JVs5NKvRK9NWHxUb2ViZn
         SSaMpwUugcmKN2jU9/kmdhrunh/uItjSG7Z6qCSKtmfJoTvZEJRU2cAHYfo27EYMX/aA
         aqs6ajvV2jcObr8TaxdfotUVxCiuEc/pvuwplX2kb09dHqZhMjpA9RNMpSCO7TSOs1aQ
         4hduk1dvqcQS1mWD0/Z6NvqfplgM4CQCLUGulpUN326fbry8sX4L3rKT6eh+yQpGHhOJ
         p5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R6g4D7mTtXbmJbP4V29JqDtbmx2cmeevRLcE291yfLw=;
        b=Rt7UTHW2LV5MMlfV5lb1jaoilQE+xiuPC6nx4EYRgEwhs3259N7fBT/45VTr9kyLq6
         P5aK09bgf6O8eo6aGKdIUdE5N2jDlVF1FCmg2xyn4wXhTuQM1N+ToJhQixX6zkZ/POpp
         I6z8My33RpH5JLqA4F87NfYBNgFIOo/l1JeoUmCkQKuOo4HJ0mgAskXco+ejA7N8JZjV
         oa1I+2aflrYzt1TL6CwLwO3Qcab2A4eY6cvms/ATSd2xNt3DnEz8SIEl7uXNn62VeHrn
         ZsHlqR8muK9FDHkv4MlBTB6OajsXflctEK+pFcZWRgqhKKbjyrQoozdv06G6tRqk532X
         e+gA==
X-Gm-Message-State: AOAM530FNDJNQj4S1KFXNDWEu1us8l1OocXQyGQMDmPmTj3/h781q59U
        QzWiJdNeTusMEgYuOqdmfhs=
X-Google-Smtp-Source: ABdhPJwObvkgqUBfe9bcmTg2V6y72e0AwWi8Lhh/TLBS9aIbfzev1hrlTn7rpRBejrw9L44qjVZBRw==
X-Received: by 2002:a05:622a:4cd:b0:2f3:3f55:fba7 with SMTP id q13-20020a05622a04cd00b002f33f55fba7mr2401053qtx.524.1650617539473;
        Fri, 22 Apr 2022 01:52:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002f1fc230725sm900764qta.31.2022.04.22.01.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 01:52:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     robdclark@gmail.com, sean@poorly.run, dmitry.baryshkov@linaro.org
Cc:     quic_abhinavk@quicinc.com, airlied@linux.ie, daniel@ffwll.ch,
        swboyd@chromium.org, quic_mkrishn@quicinc.com,
        angelogioacchino.delregno@collabora.com, vulab@iscas.ac.cn,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm: msm: fix error check return value of irq_of_parse_and_map()
Date:   Fri, 22 Apr 2022 08:52:11 +0000
Message-Id: <20220422085211.2776419-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

The irq_of_parse_and_map() function returns 0 on failure, and does not
return an negative value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 3b92372e7bdf..1fb1ed9e95d9 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -570,7 +570,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
 	}
 
 	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (irq < 0) {
+	if (!irq) {
 		ret = irq;
 		DRM_DEV_ERROR(&pdev->dev, "failed to get irq: %d\n", ret);
 		goto fail;
-- 
2.25.1

