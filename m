Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5A5AA8C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiIBHd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiIBHd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:33:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86916BA146
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:33:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d12so1079128plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FoP5SmxHDvhR5MMTOuBriKm/iqFz8ohbUwqXDgamLLk=;
        b=gF8tVsKd7Ez2eCBfvRC2B2SL5HnknuIJ6R7e2FCDHwsjA9fOrWh367rTYJgIjM8mtR
         acAABfdewhPTbtouDv/F7C3IQbmM33vDU6sCNEbUzMqshNrfje16PeTZ9Giy571iAnQE
         cb9ZRe8qWVcvq9WgAxIj2jVQiHYVnWlDwE24spqxIlpu8GQK0s9NKahjTlKDZEV5EKMD
         ZdkP8EuJyaA6wiEb+JKu3YIxwWeyIlHkk5EOYsvULHRWuaiRBOpT8+d2KYeDNn32nd0S
         lwltICqlvOlKyRV0uHeHW+StdMj8Zj2SK4WIsaF0mylZU0f8ASwalVcPR7ME0nAIPGBz
         Fm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FoP5SmxHDvhR5MMTOuBriKm/iqFz8ohbUwqXDgamLLk=;
        b=nDrRvIRdOLI81RczPNvlDU+gqwrIoZYdW0DCQ9N1NY1lDRkOh8b5gYGBXTSKs+7rGA
         Gxx4hKkhfYhpmeSPoyw2wGkg9UJyQex2UTyLwKwVcu9XtL8nPU9Re4cYqCuVL03sTIA2
         5N3buU58e9hMQmTGzgzcFuQi9nFKku98u4gYUHETJEpvbsgox9ge2xH51LyzFt1AdTwI
         r0S3nz1u78s/OtRhoySSzmN4mD0ZQPAXcpZ1UppKtqJ1u6IHSMe0GXshcXCEnVHrC5xh
         JC3Cy1tllc+QMu+DX0v74/S/Ta8rsuMEcOMsqpHevWPGJFvh64y+dniAOENAM6B/mwFi
         JieQ==
X-Gm-Message-State: ACgBeo1zNSU6VJIZCuXVOUlidkt6tH4iHrFeGUZEpn0wAxV7Kl3Z8tYf
        ditGqrxQjJJ9RWslLPIOYog=
X-Google-Smtp-Source: AA6agR6+XHZX67T+BoAgwjK44Hrl+fIrbkXTuWyVPr7aaZVbk0t2Z1gXtLYB7b5yiqDbVnygn8Jb6w==
X-Received: by 2002:a17:90b:2704:b0:1fd:aaa9:6d0b with SMTP id px4-20020a17090b270400b001fdaaa96d0bmr3430674pjb.128.1662104004641;
        Fri, 02 Sep 2022 00:33:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0016d4f05eb95sm855797plk.272.2022.09.02.00.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:33:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/radeon: Remove the unneeded result variable
Date:   Fri,  2 Sep 2022 07:33:20 +0000
Message-Id: <20220902073320.319673-1-ye.xingchen@zte.com.cn>
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

Return the value radeon_drm_ioctl() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index a28d5ceab628..6cbe1ab81aba 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -512,14 +512,11 @@ long radeon_drm_ioctl(struct file *filp,
 static long radeon_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	unsigned int nr = DRM_IOCTL_NR(cmd);
-	int ret;
 
 	if (nr < DRM_COMMAND_BASE)
 		return drm_compat_ioctl(filp, cmd, arg);
 
-	ret = radeon_drm_ioctl(filp, cmd, arg);
-
-	return ret;
+	return radeon_drm_ioctl(filp, cmd, arg);
 }
 #endif
 
-- 
2.25.1
