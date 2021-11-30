Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC84636DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhK3OkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:40:03 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:55316 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhK3OkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:40:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3PtL6lgYz9yT9h
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:36:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pmOUE4rOVXF6 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 08:36:42 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3PtL4gbLz9yT9X
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:36:42 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3PtL4gbLz9yT9X
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3PtL4gbLz9yT9X
Received: by mail-pj1-f69.google.com with SMTP id h15-20020a17090a648f00b001a96c2c97abso6876180pjj.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYCNT3kO7HfP/FKczPCMqhEA+GzsNhj1SS1NjAYBh+E=;
        b=NJKuEDH9aFfVM044j6gAjxuULJ4lkl4JYrb2jNz+y9mFasatcBqPILuTaPBBVHA6My
         j1jaQW0108Alax3nT58iUAwNZjS/p04DnRc92xeKvi35NEluJoPbU1SrQGlO4xGsAU/y
         kFHkPArX8MTkkFd0DHiRXSVroeMI0IV6Ss8x9jpvkRbZHGe410x3PQWxN8uRJiXCTgRj
         dy5ZOdG14QhW0/nqiDLxNmupTZW/DnluL2Z/Z1uAdueMWOoZvZDm4KxypqFrmBH1KT5r
         qfFfvXQV3l/WF/3ymzsQiruxTXyEwJH82HPBFH4cMXBLKtihoFSiHLxO15Bboz2htlVB
         OYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYCNT3kO7HfP/FKczPCMqhEA+GzsNhj1SS1NjAYBh+E=;
        b=3dVy6ydtVyIxeeuhsd/JkDr0JLxl8zEmgMSEeUvoQPp+dWq1eBcMn+6LH+mgiIH0mr
         6RSY7MOgn3PihtHEndossJ9VxVZGHQEPgS6HhYg360zjfES7XilXvWUFp4kYv88yKxmu
         /AB4EFNdj0ZNWQH9vlgxo1vU9X7y9PdTJtn1aKg8+hMfgj9GwxfyFu2AplUBrPg8fnDq
         +eS9lV5f8FEt7KnnzC/caiBgwfXpusHMNrLGl+7gXAO1MT2xaHlAiVtr3TaawUgwx1Lo
         F6zymkvgJhAMO7ky+Lp0HM9dINesM8Jev0Q+zsGy2qQJROh2RLF8Zghmt/4+nAWQazxr
         8dxg==
X-Gm-Message-State: AOAM531btxPsR9F05mngwq0TBgr95zyoPxEbqe/G6jNXtGexlruR37eM
        q2SIbKkh80o/BXjldUQ34rv1o/BghJNnX/X0BiuA+I+NtcyovmGsF3YJsG+gQDaiE386HfxWbOh
        /eeux4s8hnkzapkJFbot+GrTbE3xY
X-Received: by 2002:a63:1f0e:: with SMTP id f14mr40052881pgf.242.1638283001948;
        Tue, 30 Nov 2021 06:36:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBqar7smd0w2cVXcze+DnRqaj/Gm5ZSZ66JCEvvEpV8Pf+L9IE/rqGBer8vT+8b6zPimz/xQ==
X-Received: by 2002:a63:1f0e:: with SMTP id f14mr40052863pgf.242.1638283001761;
        Tue, 30 Nov 2021 06:36:41 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id o129sm21447892pfg.44.2021.11.30.06.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:36:41 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: Fix a NULL pointer dereference in versatile_panel_get_modes()
Date:   Tue, 30 Nov 2021 22:36:35 +0800
Message-Id: <20211130143635.160440-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In versatile_panel_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode and there is a dereference of it in
versatile_panel_get_modes(), which could lead to a NULL pointer
dereference on failure of drm_mode_duplicate().

Fix this bug by adding a check of mode.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_PANEL_ARM_VERSATILE=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: aa6c43644bc5 ("drm/panel: drop drm_device from drm_panel")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/panel/panel-arm-versatile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-arm-versatile.c b/drivers/gpu/drm/panel/panel-arm-versatile.c
index abb0788843c6..5e73083c09a2 100644
--- a/drivers/gpu/drm/panel/panel-arm-versatile.c
+++ b/drivers/gpu/drm/panel/panel-arm-versatile.c
@@ -267,6 +267,9 @@ static int versatile_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = vpanel->panel_type->bus_flags;
 
 	mode = drm_mode_duplicate(connector->dev, &vpanel->panel_type->mode);
+	if (!mode)
+		return -ENOMEM;
+
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
-- 
2.25.1

