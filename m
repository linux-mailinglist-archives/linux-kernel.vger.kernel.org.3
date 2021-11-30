Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA6463693
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbhK3O0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:26:32 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:51656 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242136AbhK3O03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:26:29 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3PZj4ZS3z9vJyM
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:23:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZyGeBIxRLfXU for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 08:23:09 -0600 (CST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3PZj2glVz9vJyK
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:23:09 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3PZj2glVz9vJyK
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3PZj2glVz9vJyK
Received: by mail-pg1-f199.google.com with SMTP id z19-20020a630a53000000b002dc2f4542faso10329161pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuQ42+umRcpPW+VMKGxj6sWr71Sv5xh4Rg14DLaks5k=;
        b=c7PDDDKGgIZzG8yK7s1dvsTrFzqOP94TJTfQVgUjUC1vIiHeToWPdM4TJ1y3yXSmYf
         S2cYQfUp9hdbA4DSGc2PMmQKeXQZnwcqb070hXLX3b+xPSIGu+0Op3gVRzNOGjF1pD/0
         8t+lsuotEN0QtcM2vkxayvnWsrI54FcCCsKjvqVcvkZEzzTF5/BpfpQur+zwdMNIUtw/
         8OrjqfVlT6P5wBfzZZdG+684uSzDiVJzo/FOhO8vBC/B2DwMITSTQrFrJvfV5k/ZQC0K
         6E2LOSzTfr440hfYhpyVOdTJf3wWIPPGquu6v2MRNl5srgnpWc5VVdRo8CVQvDOd20A+
         syXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuQ42+umRcpPW+VMKGxj6sWr71Sv5xh4Rg14DLaks5k=;
        b=XQZo4FYAM/6YqP9jvm5iD8wlUGp9wUCn8T8Rx/VhcyJy14c4UPTXmyIvb29ycXY+r3
         HofGg4GsY3RtQXhJ3Pl2SXW4aTWO7EJm/yyGpHxbodV+ArIOO39DTt+3oE/kMIR0Dd3H
         o6BNWCE2aQJ7+yPp+tBByEJ4xjv1xPGoa8XNp7bqlBTUrMT0F5t2AEfCK2Z/VdVYyK05
         K2qfAbI2aMqFbhB1os8lsS9UKJsNFL8ZMICyL+XLztcqtORfpgVZtpjK8dFNXQgVcl/W
         KKaEoi9LOSHll6b0UDAPcTE/kAHAv8nmFf1sv2bY4cPNwrzkt7U7Y0hvgGIxRfjwF5ND
         ejTg==
X-Gm-Message-State: AOAM532GSRE8YSjEJrP5W+W/275adsLy9AxynJbI/sJdeY5Kj/pObQBT
        7636VZgF5F32oEtaj+fpy/1JmMm8pCtfI/hTgxOUYXF7qcCQo128UDvguSKMg7KwYYFqlYEoXO+
        GQ+3w7/9Smt941xf1rrEGrq9D5UUo
X-Received: by 2002:a05:6a00:23cc:b0:49f:bfaa:e2f6 with SMTP id g12-20020a056a0023cc00b0049fbfaae2f6mr46262393pfc.35.1638282188515;
        Tue, 30 Nov 2021 06:23:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7y6QAe/YFHa5MXhGbQbbmD70LSJp+V4les/R1HFBQdmHJN0uEme/9FJ4o644D87kOv1DP1w==
X-Received: by 2002:a05:6a00:23cc:b0:49f:bfaa:e2f6 with SMTP id g12-20020a056a0023cc00b0049fbfaae2f6mr46262379pfc.35.1638282188275;
        Tue, 30 Nov 2021 06:23:08 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id d1sm22593883pfv.194.2021.11.30.06.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:23:07 -0800 (PST)
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
Date:   Tue, 30 Nov 2021 22:23:01 +0800
Message-Id: <20211130142301.155586-1-zhou1615@umn.edu>
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

