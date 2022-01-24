Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9FE498588
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbiAXQ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:58:04 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:40556 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243685AbiAXQ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:58:01 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4JjGQ11wNqz9vvsq
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:58:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WQFxJMtFL_ov for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jan 2022 10:58:01 -0600 (CST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4JjGPk10nvz9vKfQ
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:57:46 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4JjGPk10nvz9vKfQ
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4JjGPk10nvz9vKfQ
Received: by mail-pl1-f197.google.com with SMTP id b15-20020a1709027e0f00b0014a922bc3a9so3640118plm.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMFfnAra5OAPA2izCo6QzwQ1sU01OGFtg5xgGw3BVmI=;
        b=S5ZZStViBVCiSgrJgAPXiRKX3V4djwyrlnB6OeTG4NG6+lxAOXy+29Wuihu+/e9t5U
         sH5hNg7qOIvGf3Q1MMfagwm7osjrG9TKG8hddH3EbNMYSRBbaewNw9B5vpX1UZnmzFME
         BsU07O7fqLmJgYObCqfe/WIyIEux3XoN91Rn3QuGbaXd0oS/+bDEYKEFTMg1JEkvBF1d
         /ky91uNUGtQcUsznxztF+HkLCjOzeBBo+ChsTcLqdE9A5ViJkSchONnPUCrOn8XjYR8r
         c3/aMOq1VHBdqJV22eq7L5gC2vdW5HXd9kMNLdKTXDW0fdJEcHqeobKu+nukzGp8ojhj
         YvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMFfnAra5OAPA2izCo6QzwQ1sU01OGFtg5xgGw3BVmI=;
        b=HNNXnyXhWJUXdL9npJy8cuUktSDgZdorHNou7UwOSQ7ru7E6rx43MQ+0lo8A47NGfg
         NH4EHMqeT23DhAphGEDPZU79Odz+4qmMhfyL9MZTrse1cSoMsfqxyZgViZzitaqT/BdQ
         9A+v43foqAxSmRQ5jUTSymC3buAQQWc+CFAaqjWp013+r0D1ZH5AmUDAWU4TUCyuSFmR
         r/1tm5semo4wuFz1kD/FP3AkJgVQzrNhMI4SF8jbCbSa+t2Z1F8asP5QdakrB6CLusu1
         D1EFyrfbM9FHX6JPtRvI+zEkXQ2mSng8QJn3hVAeuK5Q7P7WP+yDEkW2apzvX0KLtrWX
         SCKA==
X-Gm-Message-State: AOAM531mJIyAyLhspjlzXsj6K/ug76qp6yQJnsq3ohcGz2wj/79rnCTT
        TeS8IKVA7xUrqfjdWn1bdErbejKDeJiz15uSzLmomGikV7Qh3Tqoflyida7ETyapZ0L4WjdV0VI
        p35i4uawb+SrumGwTfHkK5otL5soP
X-Received: by 2002:a65:610b:: with SMTP id z11mr12719331pgu.205.1643043465359;
        Mon, 24 Jan 2022 08:57:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQnFXtF5Ph8R6eAihtOj2AR0vQXbTXIbQRkEBMw+neKa1NwTrsboSIeKwGF8tXd48OBGjhBA==
X-Received: by 2002:a65:610b:: with SMTP id z11mr12719303pgu.205.1643043465076;
        Mon, 24 Jan 2022 08:57:45 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.61.248])
        by smtp.gmail.com with ESMTPSA id a15sm17826365pfv.212.2022.01.24.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:57:44 -0800 (PST)
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
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Jude Shih <shenshih@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>, Roman Li <Roman.Li@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix a NULL pointer dereference in amdgpu_dm_connector_add_common_modes()
Date:   Tue, 25 Jan 2022 00:57:29 +0800
Message-Id: <20220124165732.56587-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amdgpu_dm_connector_add_common_modes(), amdgpu_dm_create_common_mode()
is assigned to mode and is passed to drm_mode_probed_add() directly after
that. drm_mode_probed_add() passes &mode->head to list_add_tail(), and
there is a dereference of it in list_add_tail() without recoveries, which
could lead to NULL pointer dereference on failure of
amdgpu_dm_create_common_mode().

Fix this by adding a NULL check of mode.

This bug was found by a static analyzer.

Builds with 'make allyesconfig' show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
The analysis employs differential checking to identify inconsistent 
security operations (e.g., checks or kfrees) between two code paths 
and confirms that the inconsistent operations are not recovered in the
current function or the callers, so they constitute bugs. 

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7f9773f8dab6..9ad94186b146 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8143,6 +8143,9 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 		mode = amdgpu_dm_create_common_mode(encoder,
 				common_modes[i].name, common_modes[i].w,
 				common_modes[i].h);
+		if (!mode)
+			continue;
+
 		drm_mode_probed_add(connector, mode);
 		amdgpu_dm_connector->num_modes++;
 	}
-- 
2.25.1

