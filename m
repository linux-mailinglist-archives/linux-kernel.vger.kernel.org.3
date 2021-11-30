Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF07446356C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbhK3N35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:29:57 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:41468 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhK3N3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:29:55 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3NKS4xzBz9vYdC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7st8C8XzpA_y for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 07:26:36 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3NKS2yrZz9vYdK
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:26:36 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3NKS2yrZz9vYdK
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3NKS2yrZz9vYdK
Received: by mail-pj1-f71.google.com with SMTP id h15-20020a17090a648f00b001a96c2c97abso6770809pjj.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBS+mZ2iVM3nHnjNJPASEgQ/1xp2sRvwZZLo9zAhZ+g=;
        b=LEltKdDXxT46GNxTBJ/4F5cZvsfSfXUzH8HKDOjLSnnhCRfKVZe6Mz2G4Khay/TeFT
         KgYPbKes7yZQtJ+drFLi8M3Dm2r8WFNy76kFwplunV7KC8UxgTNdr7ExZJyfvGyvU/z7
         JWBk4Dy6zcbv1q00KWW4RCidihgISmUcVnykuDGFOfNNL13IQmlIwhpHVJ7PMI8ilr07
         7fT96HELphQbiOhAq012wbDxH/SXvLv2h2DqoaYUIVW8Lcbt5UAtmS9p1QOzyQOsqpfO
         sQsifFoVMm28IppldvNHv9PqNogpvmzXUzSHWViX71U0eh/ZLl3qur0DJy5Ltipzgh9A
         pwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBS+mZ2iVM3nHnjNJPASEgQ/1xp2sRvwZZLo9zAhZ+g=;
        b=EVwvROU9tAKFMyon5ZYINZfQ5Xj2szuMP3t/nKT8EnKvMnfPByVIwVyZ2yDS74evsh
         xX4J9o+b9qjZh+pxl/T/KqraC1k/2Nt5I0oeMWlFxKjE7r8gwTqW/Omfyrrq+TE7Dc2G
         ZPbU069ZpheHIGMLRtWhsndvdL0HqLFwf8wUK6FU0QVhAYjWkeosoOtfr1bccxquZA9r
         D+c7+Fwtijog81n5qtBupit9OIl9bN9Tm4Vcc0MD3O9qGu+dsojLFhaWrJmWHpOE/BKO
         InJ2BnrtHH/csUTi+Y3S18EfnEhCuqcj6twUzsY6utaZ8q98ajow+OMd9JgN/nK9g2oz
         EHBQ==
X-Gm-Message-State: AOAM531a/1Jv+oTSdumAV7EApySZxeHIIdeySzN6tqaKOL2KD4EpUfcr
        NiXe3IRkYkluQmXJUFj1btpUHfzplHpgWJKF4dhvPxAP0T4FF5E0kbnXEkB+oSZLulh4BmBHoXN
        o4MtCxMsuqiE69t9u+Uhi9Rbz0EGe
X-Received: by 2002:a63:111d:: with SMTP id g29mr39643302pgl.49.1638278795656;
        Tue, 30 Nov 2021 05:26:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuqPlPxAmiDNb3+ejvmnH8PEECcYwGXN6Y4pYfO0AsmmKmIvGisaHHVkTfKaUlbQrEd+O/eA==
X-Received: by 2002:a63:111d:: with SMTP id g29mr39643285pgl.49.1638278795435;
        Tue, 30 Nov 2021 05:26:35 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id mz7sm2604105pjb.7.2021.11.30.05.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 05:26:35 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gma500/cdv_intel_lvds: Fix a wild pointer dereference in cdv_intel_lvds_get_modes()
Date:   Tue, 30 Nov 2021 21:26:29 +0800
Message-Id: <20211130132629.130713-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cdv_intel_lvds_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode and used in drm_mode_probed_add().
drm_mode_probed_add() passes mode->head to list_add_tail().
list_add_tail() will further call __list_add() and there is a
dereference of mode->head in __list_add(), which could lead to a wild
pointer dereference on failure of drm_mode_duplicate().

Fix this bug by adding a checking of mode

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_GMA500=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 6a227d5fd6c4 ("gma500: Add support for Cedarview")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/gma500/cdv_intel_lvds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index 9e1cdb11023c..56aec41ebb1a 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -310,6 +310,9 @@ static int cdv_intel_lvds_get_modes(struct drm_connector *connector)
 	if (mode_dev->panel_fixed_mode != NULL) {
 		struct drm_display_mode *mode =
 		    drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
+		if (!mode)
+			return -ENOMEM;
+
 		drm_mode_probed_add(connector, mode);
 		return 1;
 	}
-- 
2.25.1

