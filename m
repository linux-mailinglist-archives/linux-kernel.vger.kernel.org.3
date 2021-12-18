Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE0D479890
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 05:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhLREWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 23:22:48 -0500
Received: from mx.ucr.edu ([138.23.62.71]:43619 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhLREWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 23:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1639801369; x=1671337369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HiC3hCK63Qa8Qb4loFRgdeRVld94u+OjjR3csxq5Wus=;
  b=t1CYNVZ19RsyuR3XE5TL/kOtOt4k0vEiF4B0Ltu1TBHBMSi+S6TK0t8I
   yTSXlcMSmsvUvfZx0tdj5fL+crfYAGJekgUyTy03K5LbUIR7uArMV/ye1
   c1CRKMeIidF6HPAluOMtwkjthkCRzImJnHbwdJH2hM8Omk0uMSMWiU+Sa
   TH/ShoE/1L5tAvBlgsud0nCrPZjwXUE2xgxTibKhctExmBw4qQZxRmy8D
   RYn97awX/u5HjtNmE06pcu2CTFLwkzrShOz3+XSt+C135ZLnAVqalK13w
   WBWlERispVd9WV32ZdTHQX6a3vU7lG7U10vNYQaOZpouDcGLoZoKzMZY3
   g==;
IronPort-SDR: sfCja/5Et+X5cKx2ZcGFLKpZ1UGDsFgeOjMHRGVvd9Vi5QGdxjlNfUJF5D+OfvECkuTUtZGH/o
 6/X+oiXbAvn+7ha6qpUyQ2+5VcNM3SV4gQXv3RhjOEIEbkQs51QF5djMOL6qcO4qBm3fEJcyeC
 wxDtUZlS6Uxb56Ytj9jVfHCmvfm+Vw2bMoitjV690YySp5lLHsSSFd66PFcaHTUGa1po5cwUtS
 vugo0UPea9rF/f9txFXgDgSzrF1gQqxUkytzNwuMBUypqbSQMNx/AatGGczqPW8D0lTD76qKpZ
 /3t1ZJhmJINxdLt04ALuhvEc
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="267686071"
Received: from mail-qk1-f197.google.com ([209.85.222.197])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2021 20:22:34 -0800
Received: by mail-qk1-f197.google.com with SMTP id bp17-20020a05620a459100b0045e893f2ed8so2347330qkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 20:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFquvFdIStXIJTsPn2k5rBU0qh7wG0l4oiCoU43pQg8=;
        b=bXlm2lS0L1cyH2tSCF4kf3SQ17o+srdPcNuSX0IN5fdxXx90fPQz8j0OTE/DIoDyNG
         NBLMGRGfhKW/vXeGz0RyOrwHJPODREbZxxtNpZqx1FHpckyz9EkMB+GVjII3tzO39jqR
         54F6vn74a8bEU6PVKdMbAqjnZHWPkSh7B94io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFquvFdIStXIJTsPn2k5rBU0qh7wG0l4oiCoU43pQg8=;
        b=3x1v3A7mEk6mFDxKXYap7USDM0cSSZnFk40K1HItJlE8Pr4uj7X09pKVrtliYyETqH
         ZohM8ur1PT9QL+zfKhho19uEZ1WhLb4+aeyzy61wRScvv8ZY0JWISdb9qMH3THD8DNQy
         jlDny+FuM8uSehlbhWiY8lvZnmlBdy8RzxmR4QiPYzGlS2lO42KMg6EDzcgH4jdeDZS4
         P1vSP8OsBSpKLwBnG+zJJq4i3uSDB3TLpr+jZ7lOifP7uLQCSDPMIG+orL1CpOyO6TvM
         0paSh5mz4yARBf2eYW62s/cjig9JMJB83dxl3kR4h8fN0pJhAz3gEnJ1HrKUqSVT+zdh
         OzTw==
X-Gm-Message-State: AOAM533v7MmsgyG8s6eaRcAnfj9c5PgTialE7v9I8UWQvMSsH9aCQy1O
        akwZKkGVhCo0zjNlU4zZroeomE36Hs72FVoJS3+s3qrs1Mr7F+Efp9emHjyVtw9htyYsra+XVzj
        W60zKkr8sXK7GomQDqCmI3mIoCw==
X-Received: by 2002:a0c:edca:: with SMTP id i10mr5323756qvr.62.1639801351933;
        Fri, 17 Dec 2021 20:22:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyE3Tagh5RgslGVJv/eRvjbgxu42RfzRLSIimsqstN4aB/aqSAgEsFtcF+iB7KjMXViNfFsrg==
X-Received: by 2002:a0c:edca:: with SMTP id i10mr5323738qvr.62.1639801351765;
        Fri, 17 Dec 2021 20:22:31 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id s20sm9081682qtc.75.2021.12.17.20.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 20:22:31 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, stable@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>, Jun Lei <jun.lei@amd.com>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Mark Morra <MarkAlbert.Morra@amd.com>,
        Agustin Gutierrez <agustin.gutierrez@amd.com>,
        Robin Singh <robin.singh@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        "Guo, Bing" <Bing.Guo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix the uninitialized variable in enable_stream_features()
Date:   Fri, 17 Dec 2021 20:22:23 -0800
Message-Id: <20211218042226.2608212-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function enable_stream_features(), the variable "old_downspread.raw"
could be uninitialized if core_link_read_dpcd() fails, however, it is
used in the later if statement, and further, core_link_write_dpcd()
may write random value, which is potentially unsafe.

Fixes: 6016cd9dba0f ("drm/amd/display: add helper for enabling mst stream features")
Cc: stable@vger.kernel.org
Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c8457babfdea..fd5a0e7eb029 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1844,6 +1844,8 @@ static void enable_stream_features(struct pipe_ctx *pipe_ctx)
 		union down_spread_ctrl old_downspread;
 		union down_spread_ctrl new_downspread;
 
+		memset(&old_downspread, 0, sizeof(old_downspread));
+
 		core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
 				&old_downspread.raw, sizeof(old_downspread));
 
-- 
2.25.1

