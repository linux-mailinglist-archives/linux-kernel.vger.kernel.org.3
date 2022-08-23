Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675CB59EE29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiHWVXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiHWVXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:23:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F01089815
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:23:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v23so8660251plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tuz1493y5LHiNwEe6XwII/bIcU4nWijq2K6QDL5tITs=;
        b=PChKyPfKBGLrWsDb3RQw8hHWPW6P36wY6RVrVp3cyccjsLkcv15Yd3SHixUb2vTkbu
         eNhUbCACRrkfRDBpDRNYQUjwod7L/nG1Slt82LDV1lTM+TCPjxEGwI001CFCrdgz7puz
         BUXvO3pbe490/hfyoWviGBhaL5Qj0YdJM3gxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tuz1493y5LHiNwEe6XwII/bIcU4nWijq2K6QDL5tITs=;
        b=M+dz3Qd8z1Pn83OTNfL4vEgvH3CA/3JhMXexeTtQ9mOfb+EbDsOFhsQzP3l+WXiRJM
         i5JrVF5B7mkmQLqC5okYyP65EpwG7H1TH77N1535TwBq5W559dPo+cNXV3KSnbLvbg7I
         YrYKWxI7xD5mT89c3tOSVU6VzkCwNw7dmyKU8xFyggpACO6net5YE9R5KQO5Fv5KTLWu
         bQMiCw3TVrWEf0HmfZv5F71Tn2ifjRKZj07VDgvvhlurtkOxjWl/Ola4Hnx8v65ywuER
         KX5+hl+6FYcW0GS34AygfVSxDWflZySfAftXVlPEaZBCaeAZ5bNXn1FAALCjhcTqGNRr
         alKg==
X-Gm-Message-State: ACgBeo1oV6zfnUOeaVrwBgSDJILmDPJ2/3oHSqP10AYr3epJJ67hTTGl
        J5y2WO+MZ6yET7+y9snFgQa1Fg==
X-Google-Smtp-Source: AA6agR61U3W1D49veW7t3wdUmwP8XfdySJz1qFxuH+VdrROwQk4UomkZ9pJJz3k8edQqVlH2jNY7fA==
X-Received: by 2002:a17:902:e552:b0:16d:d3c0:85fb with SMTP id n18-20020a170902e55200b0016dd3c085fbmr25427017plf.38.1661289783919;
        Tue, 23 Aug 2022 14:23:03 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:653f:9151:f544:1470])
        by smtp.gmail.com with ESMTPSA id a1-20020aa795a1000000b005366696b735sm6544811pfk.77.2022.08.23.14.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 14:23:03 -0700 (PDT)
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
Subject: [PATCH v2] drm/msm/dp: Silence inconsistent indent warning
Date:   Tue, 23 Aug 2022 14:23:02 -0700
Message-Id: <20220823212302.1744145-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build robots complain

 smatch warnings:
 drivers/gpu/drm/msm/dp/dp_link.c:969 dp_link_process_link_status_update() warn: inconsistent indenting

Fix it along with a trailing space from the same commit.

Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Fixes: ea530388e64b ("drm/msm/dp: skip checking LINK_STATUS_UPDATED bit")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20220823024356.783318-1-swboyd@chromium.org)
 * Roll in extra whitespace fix

 drivers/gpu/drm/msm/dp/dp_link.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 36f0af02749f..36bb6191d2f0 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -786,7 +786,7 @@ static int dp_link_process_link_training_request(struct dp_link_private *link)
 			link->request.test_lane_count);
 
 	link->dp_link.link_params.num_lanes = link->request.test_lane_count;
-	link->dp_link.link_params.rate = 
+	link->dp_link.link_params.rate =
 		drm_dp_bw_code_to_link_rate(link->request.test_link_rate);
 
 	return 0;
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

