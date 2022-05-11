Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E077522BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242090AbiEKFld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241940AbiEKFlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:41:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD58D1580F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:41:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x23so1042967pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXF3SCNfjM2bxLwQ5AjghUOySdcJkYrZZ8M04WZEgOE=;
        b=je2OkTXoLAiJsYF6ntKWkXMs5+pyupPPj6tCBhGU4fGDuWvUG10HQ0BqCMmSaUA5YX
         tXf1U6mKLkDBRGx5eW6S6uconZii8wv4a2pMYNv799tH9Qqt/KcmfzF3ZbfGGMrgNhTr
         KmRxZla6QKPpnw9wUoXoDmACI0tmIBBKs4PuuqjSNvT6BPINoH8w2ftMVsH9U/GN/S+u
         cnFkluyiZ5jsPtVzFtHl6EYQaAVaijYDfifiA2+YhZXtkPdksSOyaU/H6xCmd8iYsg5k
         utWCOxed4g2PcsPd2RHU/ew5XSyPFWPuJvUwN8XXRuw9kWQa69naewIi9ULUljOm212V
         ArnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXF3SCNfjM2bxLwQ5AjghUOySdcJkYrZZ8M04WZEgOE=;
        b=zxNsKuGgFuic/3u/BwJF6PK2HgYPnP+Z8M2PcegqhspQLy6+FIpkC1PtnqLjMkX/Fi
         uqj0DAzScEctYsEf8gTeG4QZ79e7mnKGUweUgaNQPfW4eVRX8RBQw9HJ+2+nxAiGwnCl
         aDcpBh1kWgvYEeYrR76FgG8IKe9sS2iDvdj2cliwop1D7gd7pEeUc1E8OduBC2W9wJAz
         lqd5u5FGdAKZUiW0L4+pxHPHhM7f6D49M/g1NZrmn6Iplm86+ya0s23mTnttD5U8/nbQ
         XLuGRTheQCaQY2qqFWESt91+5On+cRXMjwYYsT3RFewUOqLlcAJv3MDMekx2z4AqxVk8
         8Aqw==
X-Gm-Message-State: AOAM532IQHVsRE6G4ZMDjXBVBUwTEkk4yzYxElNLHbCZDh4SgWnnehpj
        OQ1tmQlU328E1BD5zJXk3pE=
X-Google-Smtp-Source: ABdhPJw7a6nCTB9DlRmTN0EmUxMmxzMov1YhkKH8myZAr3gidDhmH5/zIHIY+HZx3JcDbV79Xk2ULw==
X-Received: by 2002:a05:6a00:21c8:b0:4fd:f89f:ec0e with SMTP id t8-20020a056a0021c800b004fdf89fec0emr23243222pfj.83.1652247661317;
        Tue, 10 May 2022 22:41:01 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id r17-20020a170903021100b0015e8d4eb20bsm673772plh.85.2022.05.10.22.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 22:41:00 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/meson: Fix refcount leak in meson_encoder_hdmi_init
Date:   Wed, 11 May 2022 09:40:51 +0400
Message-Id: <20220511054052.51981-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_device_by_node() takes reference, we should use put_device()
to release it when not need anymore.
Add missing put_device() in error path to avoid refcount
leak.

Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 5e306de6f485..de87f02cd388 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -435,8 +435,10 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
 		cec_fill_conn_info_from_drm(&conn_info, meson_encoder_hdmi->connector);
 
 		notifier = cec_notifier_conn_register(&pdev->dev, NULL, &conn_info);
-		if (!notifier)
+		if (!notifier) {
+			put_device(&pdev->dev);
 			return -ENOMEM;
+		}
 
 		meson_encoder_hdmi->cec_notifier = notifier;
 	}
-- 
2.25.1

