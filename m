Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B747D4DA3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245528AbiCOUVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiCOUVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:21:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7F1AF23;
        Tue, 15 Mar 2022 13:20:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r6so195188wrr.2;
        Tue, 15 Mar 2022 13:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTszUtVXhMXCklp1DkwPfLyUBq8IyS44PJQOjnsl7zM=;
        b=SPqWmTFtkfahHl0PUZs9Lg2ZO2M/oEw97UPxTfJ/vQHXox2hjbH8lSKWcWMAHe4puk
         8mF+u7KkA0GwkJH+47537hJBjA9aE+0wp3L8MBZfWI+eYyqtmGkBSCpPy8E4f76r0VMO
         G+jMTTdRvYNumxJE+6+hhRD+mWljFffNtADIU4RGL/EoqeQlbDAUKqFSHuCiU/y2gAjT
         rcYkS43vdDuGxYzmaWpVQ1rG+oLa67n0aP/QSjfNZjyTcTNeTOFu9eNSdoK7pXLolGr6
         MlbLwjNi+iIxEZYKll19BCfQNuuQRQf7yc0gT3Xzp+pf7SM9k6ZeOj7V39CI2N5NC53v
         LKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DTszUtVXhMXCklp1DkwPfLyUBq8IyS44PJQOjnsl7zM=;
        b=sug66b4HjEaJjaZbW40kXbBSdrUYxfBPw6SF5p1BMNdgBMg2AfmhzZMPfO8gB+rOm1
         XgUv4gp1SXykqtcQTDxUtLTNh+s6v5Q2oIcyZFThvlRjhZEx8/7pbpY4W3BQSAr7ZAN6
         QHqisjmaATh8iKHAIw3YdyJAf6cA2L0NS9A9aiYCjqsIZXrf3wpxTG3B8XYIn7ehV4m3
         nvq0dF4MXYidvqndmgl5RLxgdfMijfWSY98WBlcG2VPuAYFGz72T8KgyvTsuylFM1cZm
         22TrK0PyroXqiP3BQZpRu90MSnzPbrNUtV9ERUfTWpMhDduqCtdQmFWWB5MPk2QttBG7
         Joww==
X-Gm-Message-State: AOAM530zVXfs+p7U5nrbLperRKfiWYAyfATgcc13V0jRxDABu1sI64rM
        MoEQnqgxDjQQ3bqWkX+3F1AsF0gGX4D2zQ==
X-Google-Smtp-Source: ABdhPJxQNMuNpDzGV85jK9DavDvA+ngvgzAqBLvkyT6j8b8JEHgSYCJaSLlNbf5IIq5d6udlcm+CKA==
X-Received: by 2002:a05:6000:1847:b0:203:8141:9d58 with SMTP id c7-20020a056000184700b0020381419d58mr21770796wri.262.1647375600540;
        Tue, 15 Mar 2022 13:20:00 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d548c000000b001f1f99e7792sm16084895wrv.111.2022.03.15.13.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:20:00 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix spelling mistake "regiser" -> "register"
Date:   Tue, 15 Mar 2022 20:19:59 +0000
Message-Id: <20220315201959.2952327-1-colin.i.king@gmail.com>
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

There is a spelling mistake in a dev_error error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a025f080aa6a..9aa355a5ac3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -919,7 +919,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 						"wrong operation type, rlcg failed to program reg: 0x%05x\n", offset);
 				} else if (tmp & AMDGPU_RLCG_REG_NOT_IN_RANGE) {
 					dev_err(adev->dev,
-						"regiser is not in range, rlcg failed to program reg: 0x%05x\n", offset);
+						"register is not in range, rlcg failed to program reg: 0x%05x\n", offset);
 				} else {
 					dev_err(adev->dev,
 						"unknown error type, rlcg failed to program reg: 0x%05x\n", offset);
-- 
2.35.1

