Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44045498580
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbiAXQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:56:18 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33184 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244003AbiAXQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:56:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4JjGMy2Rchz9vBrr
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hz0S1HyEeG2p for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 10:56:14 -0600 (CST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4JjGMx6fWXz9vBsL
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:56:13 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4JjGMx6fWXz9vBsL
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4JjGMx6fWXz9vBsL
Received: by mail-pg1-f199.google.com with SMTP id o20-20020a656a54000000b003441a994d60so10215048pgu.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5wazUphf657A8u85KxBx+8Rcz0Mc5JkcT16GzU8geFE=;
        b=mKuu8jAjF++IFpgduLN3RDEVefDAWyK1s4jcIwDrrK+XkSR3CLGnu6uzdybyWM/2C3
         n2Ka7vv2Kc4aFO7usHMBcS56BrfBYO+rChtPEsb85JbE7kFzCg+eZ97ccdjpG0AagJyl
         w2TOL8I+lRDJMovzuIUaKOjSCqvivDF5Sl34KOohYqPrdk97JIn8HtrZTRGtkoOgZQyS
         +BqNOR6gUwPP/qBFir0JaDtzbRBzxLMlEb+DKuppNoNmhV2dytprGUjKYlVanlscF3fL
         YnvpC74TvXg92Phex9UTG1VG/of07Q6Hc45DYRbggbr9jqtka4Z8CFLXtPXtW+vSjf7a
         gCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5wazUphf657A8u85KxBx+8Rcz0Mc5JkcT16GzU8geFE=;
        b=Pe0Xnn5fBAO6F+ZKHjUScKtoDyUC1PeSLtOEADUPtWw2Uv88dPo1e6CANCmAg/p3cT
         YgM6trywGJH5gSlTKpSStXZftd3/tP9UpJ907cV0IJ9Az5xz9ijPG+4ZKSkkImBFx9la
         E5sgmAlbg3DvbTkJrICn2h4ONPYWhD9yb4XpPvrxvIHex525UCO7Ua+5nQTT4wz8R2YU
         MAwrgCaAu29BpGsNXTcx2RZ/5e0YGpjnEYs4+86RYNM96HVE57Zq7J6IdiX8YK+7sf2x
         KQp0yVWvobottNYelgFqfNzCNp5JV9O5GWglKMkuxiEvDzO2dG/B6OxZ19Z3Y5jEc25G
         zt1w==
X-Gm-Message-State: AOAM530VFbCoi7pv8rcZ2ogDnkJPo+O3PE8bUwqWhX3DlE4wB88k86Ab
        FwW4bEuKLUoAXvzPaBeWhNFjNdHyL6Y6+ZvcH87254rp0vakLdKR2Rft8AKU1h0eQ7kDVVSrc+w
        f+y2K/PC4osJjZg1O5WKsQeJ12oEa
X-Received: by 2002:a17:903:110d:b0:149:a833:af21 with SMTP id n13-20020a170903110d00b00149a833af21mr15513349plh.14.1643043373165;
        Mon, 24 Jan 2022 08:56:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLuSK48OaRsgH3XF8ivq/y0OenHyrkB1/k/dcMZr1ADIQwnE4TW2Bda19qwmzB3Xd0i6sFJQ==
X-Received: by 2002:a17:903:110d:b0:149:a833:af21 with SMTP id n13-20020a170903110d00b00149a833af21mr15513334plh.14.1643043372944;
        Mon, 24 Jan 2022 08:56:12 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id p18sm18349600pfh.98.2022.01.24.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:56:12 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display/dc/calcs/dce_calcs: Fix a memleak in calculate_bandwidth()
Date:   Tue, 25 Jan 2022 00:55:51 +0800
Message-Id: <20220124165552.56106-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In calculate_bandwidth(), the tag free_sclk and free_yclk are reversed,
which could lead to a memory leak of yclk.

Fix this bug by changing the location of free_sclk and free_yclk.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 2be8989d0fc2 ("drm/amd/display/dc/calcs/dce_calcs: Move some large variables from the stack to the heap")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index ff5bb152ef49..e6ef36de0825 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -2033,10 +2033,10 @@ static void calculate_bandwidth(
 	kfree(surface_type);
 free_tiling_mode:
 	kfree(tiling_mode);
-free_yclk:
-	kfree(yclk);
 free_sclk:
 	kfree(sclk);
+free_yclk:
+	kfree(yclk);
 }
 
 /*******************************************************************************
-- 
2.25.1

