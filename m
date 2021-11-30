Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3134C46369F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbhK3O3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:29:31 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:58238 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhK3O3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:29:30 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3PfB6JhCz9w98y
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:26:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b_E4O6-wRzs5 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 08:26:10 -0600 (CST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3PfB42T8z9w98v
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:26:10 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3PfB42T8z9w98v
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3PfB42T8z9w98v
Received: by mail-pg1-f197.google.com with SMTP id d2-20020a656202000000b00325603f7d0bso4891091pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuQ42+umRcpPW+VMKGxj6sWr71Sv5xh4Rg14DLaks5k=;
        b=PwoWlRWAMO0iWwLAo/aYQlakXElaCjD6VMo9NBp2f3HZSFUvXsfa1haSpu3NFk/jqH
         NljBRNM+7/3cQ89MDBH/6XqBC09gzgT/mLtnMdxH4K2ayiigmRu/zgfryY9PbWqCxlxj
         wsP1JQQ8Be0QOJ32s2uUM+JgauLV4N1tX6MRxaqvbBZVWzPKOM0xaISKrzkQDV0puX7Y
         RXFJxbQQBqpoasb/eaceP+V2HBd5Tp+1BQFaM9eCgscf1Lq99qVeFpjPP0ZYfONxNT6M
         pF/QV7sJRxs3Dv0ewAtua/bhkFQHWIrYdh1svhjso2tqPwrsMiUQEHCxdST3i8RflN7K
         ssFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuQ42+umRcpPW+VMKGxj6sWr71Sv5xh4Rg14DLaks5k=;
        b=sU7CdSJ81S0QhdHrWGQHgeXsUCoeKxprAbFibfoxf/HqNobaHNr4i7xcFOfsH348+T
         dICCPxjCMMzAO72b2yo8oOd6bXgE3uBVs3Ov9O9GvIopEGLCTwqyF8zQ0BXyfwaqc7XV
         pUx3NZaT2imMe05Ey69IVlOoibecCW8wFkfAC2a0aCftRUdCiHIY+y7z3FCl9B22ecJz
         WlhFahN8WtQgQsaQOwIBZHVt7KJNqezAwG653DqxFNv6/UVvA3cN1XDJoXkT4DW+AkI4
         bzwYar1rjkPvI5UtBQJNxo4FE7nvXIzJejK4GU4QIzk00Kt7b3l2WggQ19ZdwAFaohtt
         QQ0A==
X-Gm-Message-State: AOAM532nfS2ShLzXwrM5hZngMBSpOo5E9ndRTHaMaTzGtJ96QsoHnXH6
        8e9AgHZlEwlGFc4PPSbmqXMOkycMfO9o5VQgmTMfuWtdD7aG85+rvMCngbZa0ZhH2NxHm5COQKy
        jjR73vC5YMz03C8sOGkJPrOHYTgjz
X-Received: by 2002:a17:90a:2fc7:: with SMTP id n7mr6378167pjm.141.1638282369883;
        Tue, 30 Nov 2021 06:26:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7GdydZXDEWnsAUZ7LT9R88o7lt/wXSRMThDt6spxy2SRR9dULTljXwp0Ihnwi8tcyqu8CCQ==
X-Received: by 2002:a17:90a:2fc7:: with SMTP id n7mr6378125pjm.141.1638282369630;
        Tue, 30 Nov 2021 06:26:09 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id k19sm21540692pff.20.2021.11.30.06.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:26:09 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/komeda: Fix an undefined behavior bug in komeda_plane_add()
Date:   Tue, 30 Nov 2021 22:25:31 +0800
Message-Id: <20211130142531.156863-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In komeda_plane_add(), komeda_get_layer_fourcc_list() is assigned to
formats and used in drm_universal_plane_init().
drm_universal_plane_init() passes formats to
__drm_universal_plane_init(). __drm_universal_plane_init() further
passes formats to memcpy() as src parameter, which could lead to an
undefined behavior bug on failure of komeda_get_layer_fourcc_list().

Fix this bug by adding a check of formats.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_KOMEDA=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 61f1c4a8ab75 ("drm/komeda: Attach komeda_dev to DRM-KMS")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
index d63d83800a8a..dd3f17e970dd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -265,6 +265,10 @@ static int komeda_plane_add(struct komeda_kms_dev *kms,
 
 	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
 					       layer->layer_type, &n_formats);
+	if (!formats) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
 
 	err = drm_universal_plane_init(&kms->base, plane,
 			get_possible_crtcs(kms, c->pipeline),
-- 
2.25.1

