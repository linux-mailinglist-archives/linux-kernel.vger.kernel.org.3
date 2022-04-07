Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F0C4F8989
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiDGUiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiDGUiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:38:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DF349501
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:24:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n6so13130905ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kl7+Z31b5z6e9h/LI2V0ilKJ0VcXvm6riW22IR6e9P4=;
        b=mB705bVuyZl3/NMxV7eUgN95OzuueFRixaknj9i2n3wKMl0BwbuCo8W1GLDn+zd83x
         HXsOEqoDXBmFuRhqFS3A8KWqgs2pnLxDh0abuhrYiMHKkNhjRLs1xtfBvjCa4WR5Artu
         VhSokuLh24e7T6GlOSuMKVnBLdFDU4G7DTzbVZpT1rS58B1+XPMPgoME+nGpci+dYWmQ
         iynijdlznbraMZGvc542+HBpAQ/8YWpYF/JLAYc9MwBfUAVe6RhQ8dKzsKFK6vo1Vts+
         PaYpWBp93SXsdmKMq1EbvrBEs/1ZtafqWPRSUcE95Vz9XEYKQYMNHEqw6IqixaMydQSE
         I+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kl7+Z31b5z6e9h/LI2V0ilKJ0VcXvm6riW22IR6e9P4=;
        b=lXZpEWCy42VYdcciSiJikFrds351a4afGUOoJ4d0/+OrJIOwRQ4uI5HLzx/w4Vny5Q
         hGOisbA0ZyRcNPYxQ3WzUjAObXxo2E5zfy+9oV/r98U5dr/Disgcq7xa2xHcPBGGDWuR
         3CXFrTjC82ez6FGEZFDqeTG1bjPRpPsO6t3Sj5H23gJ32R/9z1UB8w2HA8UfG7gPJhRQ
         /tmX6RdVUbx5JZ/roXWYZ9/GYfVqC0zkehS9k3BbZe55dk3pbo/nog41fJX1x8iqM2zU
         t9W56o23izIZUW5qIAARm2GGjVg/YCS0i1hpS3RhCEkMrae+jLi/5+BIAD+s2ZIhFgRB
         E8FQ==
X-Gm-Message-State: AOAM531ur1puUzB8JSN25Ggmw+R41BiK1efe15F4c67L6JuqvRUT2avq
        v1tPBnWBovZ7gn3DR+4j/YgYdW26UW6wM4pv
X-Google-Smtp-Source: ABdhPJzLTFn1k0bcXsd3ZFpEaE41vvoUC2g+Pk7R+jCWVYVnRJZxC3JFtm2ZAcr4WsZw/KYi47Xp1A==
X-Received: by 2002:a17:906:dc8c:b0:6e0:6216:3698 with SMTP id cs12-20020a170906dc8c00b006e062163698mr14845834ejc.144.1649363093087;
        Thu, 07 Apr 2022 13:24:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id y17-20020a056402359100b0041926ea1e12sm9938420edc.53.2022.04.07.13.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:24:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] drm/armada: drop unneeded MODULE_ALIAS
Date:   Thu,  7 Apr 2022 22:24:43 +0200
Message-Id: <20220407202443.23000-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/armada/armada_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 0643887800b4..0a819a4908b5 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -285,4 +285,3 @@ module_exit(armada_drm_exit);
 MODULE_AUTHOR("Russell King <rmk+kernel@armlinux.org.uk>");
 MODULE_DESCRIPTION("Armada DRM Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:armada-drm");
-- 
2.32.0

