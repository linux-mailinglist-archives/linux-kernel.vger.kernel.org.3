Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1C946357A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbhK3Nd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:33:57 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:42164 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbhK3Ndn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:33:43 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3NPq3TGYz9vjJB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MNLQnAcZQOGk for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 07:30:23 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3NPq1MPZz9vjJF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:30:23 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3NPq1MPZz9vjJF
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3NPq1MPZz9vjJF
Received: by mail-pj1-f71.google.com with SMTP id g14-20020a17090a578e00b001a79264411cso6781025pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/BkYKhAYDRvCU9BA50ZAHDXbEjS7ZYXZYlZfMe/zTsg=;
        b=lTINGR/FdIkP4B1IPin6tk9l5kaUpYn6ZTOVoWYb6/d2JmLrhlMfFlG4RIPBGIAcMm
         9xQo5WXjSMiFhPTvnmn2v8OJP4l9Z6hEwOsptIhKC2+BLMvg6PArEhqqtUuoQrva3Ygb
         Gdr2sd92NKNgszBn8+F1jUKeJQqNETEpDDjzadFOf5FS+XgtUkx7j/z1OrhoxMEcRRH5
         dAPyWLCpYcdAEJcy2Xd+r193kL1dILxGL/0pYFYwjoUm0yH7K47uZ6zBv2feXrlWXPXZ
         JJ0yMfhZMljguw6i37EFapxYPQj26u4IbPB4lmBZNEIaWhd+DuIVDluMuWdTfpzOuC4R
         +0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/BkYKhAYDRvCU9BA50ZAHDXbEjS7ZYXZYlZfMe/zTsg=;
        b=LYIZdrYrSjOU69yUhUTEgMFMR2Fj+cHEK7JK1ESx405lLLKZgjUXSmxYG0sdYdgRdF
         X+j1oui/VWBkhnJCe5QBfI5le0RObiEJFGD0zdTWWQYb7WNENOkZ1bDI7HQwJwPjwXSY
         +ZruwUozyFNuHglYNMftyWp8AC//5tHgu8UoDkOEqXlYHdxjSHKO7pMlYDKWccom2DLm
         7ga6yiyALF7mG0e0eQ/OQwtlwIMT6nq777VQl2X7ZxiDOIElLB8KyrdoMRURJMdtDwvM
         gjE+SmhPYgJvvJNae1IdSYw6Eo8pSrGYF16ewu+POJwi2YHJA1D5KWRWaEAx2vfhVFQB
         EKrw==
X-Gm-Message-State: AOAM531hLP9Be2wImvg366yO8Wd66ZmPv6uliJ5gBmon1sJF5q/AvEuI
        AKwabGPhTp62lPfqDnmrwptYrvZ6aiMy4WnwBl5PAfUVE1Na+wzPOw9azx2vkIFPWM/ZhNIBdS7
        pRljVDzwV6/HGQ3AaUcSn4Vo5Egmu
X-Received: by 2002:a17:90b:4d0a:: with SMTP id mw10mr6088948pjb.89.1638279022189;
        Tue, 30 Nov 2021 05:30:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpTw2cHCau1ckvwMhlR7lH625HDu7cgITYjkAjSWVlE3HONwyGQ+1MBDgvF/5aG5KUSSkGiA==
X-Received: by 2002:a17:90b:4d0a:: with SMTP id mw10mr6088910pjb.89.1638279022023;
        Tue, 30 Nov 2021 05:30:22 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id 130sm19981782pfu.13.2021.11.30.05.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 05:30:21 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alan Cox <alan@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gma500/psb_intel_lvds: Fix a wild pointer dereference in psb_intel_lvds_get_modes()
Date:   Tue, 30 Nov 2021 21:29:12 +0800
Message-Id: <20211130132912.131985-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In psb_intel_lvds_get_modes(), the return value of drm_mode_duplicate()
is assigned to mode and used in drm_mode_probed_add().
drm_mode_probed_add() passes mode->head to list_add_tail().
list_add_tail() will further call __list_add() and there is a
dereference of mode->head in __list_add(), which could lead to a wild
pointer dereference on failure of drm_mode_duplicate().

Fix this bug by adding a check of mode.

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

Fixes: 89c78134cc54 ("gma500: Add Poulsbo support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/gma500/psb_intel_lvds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index ac97e0d3c7dd..da928189be91 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -505,6 +505,9 @@ static int psb_intel_lvds_get_modes(struct drm_connector *connector)
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

