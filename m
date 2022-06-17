Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B990C54FF14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiFQVCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiFQVCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:02:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B06EAE53
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:02:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w29so4986932pgl.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yl1WnhoCY1o1ij3d39EJgjFHyM+kps2gtjL5Md9kHN0=;
        b=g/JQ/8dzqqtIkIvMuzLXPCPAptiDE/pZLC6GdUbH/ozO+s5fyKrqv8i6sCLYcVi0X3
         wtDKCl3HtnTV0r+sSscUzEfWXmWjOoHIm4yX2925WDDezljG+qLN8icnKJ3H1i3Aov+z
         ekzoLLrijG+GCDf+d3sZ47ecIKCxJAl6t0PaUX1hQJhBHspwLkGHmdExUf1D/cAD8WHQ
         74oEY7dgy1g6PHyBIzy4CfC/cWkdi3Cfx4Ug44v4yqXJW9c1A9Lqh3LyOHLMYlvSdGIW
         we3beQyVYMFEFusqqqCmCf62LTSZn50HeEdiE+vsfVNXX4kmlBV8z9ZrvWsM/4hV0LJM
         W0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yl1WnhoCY1o1ij3d39EJgjFHyM+kps2gtjL5Md9kHN0=;
        b=M5IyXnalHWl3Yy7tBpMwH7qBj7Hda2dtO86KAQZhdy0XmgmZ2NmAnCUUC/XVSQY7cd
         wzcq1N4OhgGcAelpwDXOpM1CKD0RCsRoaBdC4HSKSrUuuwnUJNBJ0m+7UvcJIvpc6K7Q
         flPxjUsS5FRGWctyzpKloG9Pjw6qeRGkCximzoVAz+15pe+H/Z8FQAhoMXz7uWV8U5te
         DNo5lyPc7Sucteq89XLB/mtpwfEtAffE0VTtHFW6G/adTDolZBujShA1pWGrckqIFtPj
         dgu59ESIpceJo2cG/mZwf6V/JWHULpXonMZw2IugR00DtuC2U8YqncpjhkFdi9iX5EcL
         /glw==
X-Gm-Message-State: AJIora/5f+iIhCxGWS/hKpdToKAFfx5LBDdrbwCVJ/jL3ryf09ZWIo85
        tsyZ9azdGFXjQEsD2IGQ5QDWhE5pfidowQ==
X-Google-Smtp-Source: AGRyM1spHaLkiHnAC4RwNbMh43KO7QMzojOVAbtMH0vwbOBz5txQsJDt50hUaHDhToilZeG/xzy/kw==
X-Received: by 2002:a63:88:0:b0:3fe:2558:674 with SMTP id 130-20020a630088000000b003fe25580674mr10392898pga.504.1655499760034;
        Fri, 17 Jun 2022 14:02:40 -0700 (PDT)
Received: from localhost.localdomain ([216.9.110.13])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b0015e8d4eb209sm4039200pla.83.2022.06.17.14.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 14:02:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] MAINTAINERS: update ASoC Qualcomm maintainer email-id
Date:   Fri, 17 Jun 2022 14:02:30 -0700
Message-Id: <20220617210230.7685-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Banajit's email address from codeaurora.org to quicinc.com, as
codeaurora.org is not in use anymore.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 440f3d7c93b9..171fa3160696 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16247,7 +16247,7 @@ F:	drivers/crypto/qat/
 
 QCOM AUDIO (ASoC) DRIVERS
 M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
-M:	Banajit Goswami <bgoswami@codeaurora.org>
+M:	Banajit Goswami <bgoswami@quicinc.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/codecs/lpass-va-macro.c
-- 
2.25.1

