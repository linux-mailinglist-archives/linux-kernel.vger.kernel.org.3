Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D75751576F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351530AbiD2V4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349622AbiD2V4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:56:47 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A75C83B19
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:53:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q14so11975226ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mx96GF5mK2X2Q9SZlgJmIqotjYYuzoJNpzCjKgQvXXc=;
        b=zQM1rexPb+PuCeQE3rGh8yDNn0rfbjhAYBLT/pCtmSftZ+l8negFH45+12uqdbCIq7
         f34QunA7P3tbi4Aj6F5SfdH+TkMNhRqgq8CdqyqgPFwl9hqHQZ7aDS74hCPXut+oQ+i3
         45IP3qxP5JBqEWQYkrdBjSgiB4DST48lDrtg5Th3IAc+pXs4CkrqjruPfX6ITKBkjQxa
         2ER8y2fZR3jsN/0pP7bw6uMwKxUrMSLPWZPM7xcYczbEw5DmzN/0fPvwkoGqX3Ce1qpK
         gwUO8OpBVBBZADCHddKhbknM5suUAADtHI4x/Jt6039iFbzxsJgAZwsJonAX9maOEcbq
         uvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mx96GF5mK2X2Q9SZlgJmIqotjYYuzoJNpzCjKgQvXXc=;
        b=ZyrpW6LUOh54oh72PeXvk8Zr5nNyjobXnxxzIGDpOq2PCrkWIadx2lllNcPAmrMMIx
         Z0I4cWMs14ooC+yCPZfGtf2dxlaFRk1ar1yo9jgWY2uyrkuiRhEdLL6qlHtZ0cz4lx7O
         g4116sfZ49uWjJcwNXyPpDuRD6YChb6+CuL9Wx/um+k1sbp7ph/uDGsy31lfhry4XBKS
         YSsahDFBz0qm3A0DylkKd1D01P7y57QAP4HJwFTGbguT36mETfvFOuLg0RjxYIJaGpuS
         9sLyJx+MkLtnqHkkdLPIS3FvyZ91I4EyIvCu4A584T1hX720PAUyCixLcFkir/CQaHkS
         VUJQ==
X-Gm-Message-State: AOAM531ovA8K4TyhNcb1Pm1Pec95naKkKunh93Gk9XuieaAG1gphkqp2
        kEXbSl9cCDmum9xkwpq2q7iT2SH7xq6KLQ==
X-Google-Smtp-Source: ABdhPJxTCMaDPQsKPWv6eVS+a/KAs7Y2FdPT/TsKt8CoWZ8/JPGV9PwjBnt3nTK4XNlR4U+ne07m7Q==
X-Received: by 2002:a2e:b8c3:0:b0:24f:3395:16e8 with SMTP id s3-20020a2eb8c3000000b0024f339516e8mr801971ljp.378.1651269206070;
        Fri, 29 Apr 2022 14:53:26 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 11-20020ac2568b000000b0047255d21182sm32637lfr.177.2022.04.29.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:53:25 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Clark <robdclark@gmail.com>, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: Add Dmitry as MSM DRM driver co-maintainer
Date:   Sat, 30 Apr 2022 00:53:24 +0300
Message-Id: <20220429215324.3729441-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the past several releases I have been assisting Rob by writing,
collecting, testing and integrating patches for non-GPU and non-core
parts of MSM DRM driver, while Rob is more interested in improving the
GPU-related part. Let's note this in the MAINTAINERS file.

While we are at it, per Rob's suggestion let's also promote Abhinav
Kumar to M: (as he is actively working on the driver) and switch Sean
Paul to R: (since he isn't doing much on msm these days).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f114c37f..782934f318d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6254,8 +6254,9 @@ F:	drivers/gpu/drm/tiny/panel-mipi-dbi.c
 
 DRM DRIVER FOR MSM ADRENO GPU
 M:	Rob Clark <robdclark@gmail.com>
-M:	Sean Paul <sean@poorly.run>
-R:	Abhinav Kumar <quic_abhinavk@quicinc.com>
+M:	Abhinav Kumar <quic_abhinavk@quicinc.com>
+M:	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+R:	Sean Paul <sean@poorly.run>
 L:	linux-arm-msm@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	freedreno@lists.freedesktop.org
-- 
2.35.1

