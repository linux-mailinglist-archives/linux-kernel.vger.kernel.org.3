Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157DA4651A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244738AbhLAPce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:32:34 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:60890 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhLAPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:32:33 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J430Q3Y4Tz9vhLV
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oFMWA_NirCl0 for <linux-kernel@vger.kernel.org>;
        Wed,  1 Dec 2021 09:29:10 -0600 (CST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J430Q1h5nz9vhLd
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:29:10 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J430Q1h5nz9vhLd
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J430Q1h5nz9vhLd
Received: by mail-pl1-f199.google.com with SMTP id l3-20020a170902f68300b00142892d0a86so10340501plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFrv0I+b421T8Co7IK4ytoKL4fI+fmNuqvVukqaGei8=;
        b=jovfNoz5FrEQBAY1aW8WLrm9EKHyo29fm5jcwMSE75bCWdwgx9sYR4tizF31JfJ4ZK
         3lIP2xDAGqm/aFlBUqxU3txrarLiwYrUEC3NzS7WDWb1ED0mMEK3ZK8G7eALjSFRRl/9
         ToXR+eaxf2qHZfnZjAWMhmrS1E3LXNaPbZu8zqZYhqySzwJgcW095EB6udfNZSYNGeKc
         TCpHgcLtaVgy4Y2n5fsyB1x+/wJChNR06/Zzz8sT9sGTXhLpwSFGXXDP9Kxyo7H+uJVO
         jGiRTkN2NAO0NdhMKN6s1AxlZyXA8gGTvVF3V/10Ip8ypTJ0Vg5rR/dZIq2UqeNBlQ53
         JolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFrv0I+b421T8Co7IK4ytoKL4fI+fmNuqvVukqaGei8=;
        b=wX8N64jibOiMguxGPk3BfY3oG4MzUEvUftud8QD0/7ln4BIdrbeihNBpdzyuFPQsIL
         Ux26ksUZR91UPuPpgiU4s52FJxZQpkfYpflWWFJ+MdKq9efcD9I+D+nztMQ9VygXzmfk
         aLrpk61OIKyBkdc8Y3VU89qQZH/6I8UIrcK0NiTyiw2b2loB3JslPM85Y/jWGThkmlHV
         QIIcsa2e30v+AcHHNWOfDzytJgqB1NwC7E9vG2MFxByQbIABC8w9tRjb6JbgXexsRZVo
         +1ouiDVU+apO+gJsK5JHHmKNL1xk/U/2FPXQaasz/rNFpkQP89HnEve4/pEQmtMVC4b3
         E3HQ==
X-Gm-Message-State: AOAM532qxukvSKHTb2WMpbFbUYSS5mUREQB7DZXX/3L4W6tEA//JRyDN
        +2D0RC0OpJ8NkhADY2qTNy5xS5pJjzjteB/A3+cpn6KHHMARz6o68XK3Brx27UHPpX5ibKI8u4t
        hvTZRKzK7I1qwWYUZKOQDsOh+cOai
X-Received: by 2002:a17:903:1d2:b0:142:24f1:1213 with SMTP id e18-20020a17090301d200b0014224f11213mr8248592plh.81.1638372549470;
        Wed, 01 Dec 2021 07:29:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4wUy8vRXj4pRKn23RcK2Pn9zl7CFG5jhQM4oARYVdwFjzP439hi9eQO882QxodiL9CJhB6g==
X-Received: by 2002:a17:903:1d2:b0:142:24f1:1213 with SMTP id e18-20020a17090301d200b0014224f11213mr8248556plh.81.1638372549241;
        Wed, 01 Dec 2021 07:29:09 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.22])
        by smtp.gmail.com with ESMTPSA id u3sm201310pfk.32.2021.12.01.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 07:29:09 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/gma500/cdv: Fix a wild pointer dereference in cdv_intel_dp_get_modes()
Date:   Wed,  1 Dec 2021 23:29:03 +0800
Message-Id: <20211201152904.182293-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YaZP2HzTQw1QJxOK@intel.com>
References: <YaZP2HzTQw1QJxOK@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cdv_intel_dp_get_modes(), the third return value of
drm_mode_duplicate() is assigned to mode and used in
drm_mode_probed_add(). drm_mode_probed_add() passes mode->head to
list_add_tail(). list_add_tail() will further call __list_add() and
there is a dereference of mode->head in __list_add(), which could lead
to a wild pointer dereference on failure of drm_mode_duplicate().

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

Fixes: d112a8163f83 ("gma500/cdv: Add eDP support")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
Changes in V2:
  -  Instead of returning -ENOMEM, this patch returns 0
  -  Use DRM_DEBUG_KMS to report the failure of drm_mode_duplicate()

 drivers/gpu/drm/gma500/cdv_intel_dp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index ba6ad1466374..bf47db488b7b 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -1773,6 +1773,11 @@ static int cdv_intel_dp_get_modes(struct drm_connector *connector)
 		if (intel_dp->panel_fixed_mode != NULL) {
 			struct drm_display_mode *mode;
 			mode = drm_mode_duplicate(dev, intel_dp->panel_fixed_mode);
+			if (!mode) {
+				DRM_DEBUG_KMS("Failure in drm_mode_duplicate()\n");
+				return 0;
+			}
+
 			drm_mode_probed_add(connector, mode);
 			return 1;
 		}
-- 
2.25.1

