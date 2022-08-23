Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E27D59CEBE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiHWCoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238943AbiHWCoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:44:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2285F33A20
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:43:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x19so9387847pfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=PynmO5Jk7dMLlFmc4BJabIpYsmxogYHpegMgoaOMSq4=;
        b=MabqGyxwHR/rSORTB7TeITLkNwTwRIAZ0fWVRA14qsIbhD91j0WkB+KTPJh+TjKtd2
         Kfa/Xj/wbblHUFxT3lmhHujC6EqGMMnjAQ3hmAZxYdBihPag2jQXaLyIJcrSAKvbZUEx
         3FHOEZdXgHO8p5RN4ENZM0QcmNDqOThrG57A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=PynmO5Jk7dMLlFmc4BJabIpYsmxogYHpegMgoaOMSq4=;
        b=EtwIpgHT0K14Ma8LM0Mds6KSgYi0KJ1rAoqw5li2vq1nqYL2ZbyD/u2Fa6sBmWSgYt
         8nHpc/irsZzshNAzNXGAUwUQBajD9YoycoylBxh/9BLdTbaJYzX/MIfHD8JVVH3r8q26
         iYN/WaAEWdzq+Vnp0BwrA68BxQN2ue2YErXji2LArFhaXP8I5HIoHIgJvdyYX+RH2RGL
         Mntsg7bkhppJQeGhHqOgZLR/aQ1+fgpxAxJSW0Ihecj7un7A1FfzP5OBVOFnyQ/S+ssd
         1qdnqInqDjjVEle1KEE8yVIJPrObWQ4jfIxPqA/ZVd5M/HN/xERDcpHEgg3uDeQyrFiV
         /FJw==
X-Gm-Message-State: ACgBeo3QQxGmwGBKkjcPNPvX1aWRKIgsLk75YX1Fr5aWBOAB3lnWgJiH
        0CdCkzXPgCQmFiKP/y3GRu8thA==
X-Google-Smtp-Source: AA6agR72B2tpzoHRr2X1icCS5N1hJfZlnCktZgRksrhuGPX7UJF1L2xySUvV0LfAKMWPy7NvsdM88Q==
X-Received: by 2002:a62:be0e:0:b0:536:76fe:ee96 with SMTP id l14-20020a62be0e000000b0053676feee96mr8956523pff.44.1661222639316;
        Mon, 22 Aug 2022 19:43:59 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:14dd:44db:a286:d093])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b001728eb339e2sm9140538plh.286.2022.08.22.19.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 19:43:58 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/msm/dp: Silence inconsistent indent warning
Date:   Mon, 22 Aug 2022 19:43:56 -0700
Message-Id: <20220823024356.783318-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build robots complain

 smatch warnings:
 drivers/gpu/drm/msm/dp/dp_link.c:969 dp_link_process_link_status_update() warn: inconsistent indenting

Fix it.

Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Fixes: ea530388e64b ("drm/msm/dp: skip checking LINK_STATUS_UPDATED bit")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_link.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 36f0af02749f..1620110806cf 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -965,8 +965,7 @@ static int dp_link_process_link_status_update(struct dp_link_private *link)
 	if (channel_eq_done && clock_recovery_done)
 		return -EINVAL;
 
-
-       return 0;
+	return 0;
 }
 
 /**

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
https://chromeos.dev

