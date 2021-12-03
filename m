Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57122467A58
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381826AbhLCPg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:36:59 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:36746 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381811AbhLCPgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:36:52 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J5H0S16ytz9wjXX
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hsrE0qZIiEPu for <linux-kernel@vger.kernel.org>;
        Fri,  3 Dec 2021 09:33:28 -0600 (CST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J5H0R6DR4z9wjXf
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:33:27 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J5H0R6DR4z9wjXf
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J5H0R6DR4z9wjXf
Received: by mail-pg1-f200.google.com with SMTP id r15-20020a63ec4f000000b002e582189837so2051307pgj.20
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 07:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HjgNKDbbr6ZOOlNKpxwBIvbqs7099djs3WiwVtq38m0=;
        b=lNvxGiJuGWJmPAZR23PeQYeKAew/1RyNFlpUXAVn8VcKZ93jJTPCc4rKB36nIqSTUh
         Ew+0PujB3bAP6H0pjgLc07lSSJ/PJvJlHexdkTzfe03ZCkAHkOKRI7enOq9SNJfZLZl4
         G0EAbZWS97jE9s9NIxTt6meWodMADoj4DM8c7iO5EDGi4v1I5Y2IdZSYvZLff+u8tAV6
         9TWvj7OE2NYsqXZxPpgATlZYVkM+o4hvZM9KdZ/Rd8KgRxPPiBz4TfBhXFgljRD3m4Hc
         iNKhtEejo4bHD3TQW9xZd/9e1xu9E5uRes+CtR1TLzkyHJk5JUKEPrwiP1bsTStb3rGY
         15zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HjgNKDbbr6ZOOlNKpxwBIvbqs7099djs3WiwVtq38m0=;
        b=q8LBdJo5/4F5LnqUIEZaRkoygEhW08egZxFwuwzpgjqdqaqW4zDwXQSt2LtswktrX5
         damq9rq90ArN1Lny5HRpDoh9PdCKUm0XdVcZfRnLgjgkKGMa6nSTNXw8nngqRMNzFzWU
         mdC/gLPp38gfCgafTIbnZTVEmZgjwg6brjquDPdNYg+wdMn90g/AXPz+eKcpqDyAeKGT
         RPcLbyw8HCjyQumD0JWZ0NhuP5wyFppp+kkpRoy1MBkXaEZ3zxIUfwFnNqShP8mBrG4i
         mUUCjoRsj+W5AH2s01StCspkGIPe9T+ZyoAhu1zFp5cE6YTR8A0p84U8j4zWR7T5gyjS
         wIHQ==
X-Gm-Message-State: AOAM531dAEyZxuvVZ+xjLiPKG3COf1lGYAvn6YcGAL6OhsbYRmqoqrmb
        PzaisLwhXZ8rVP40CxdpTEdT9ypkWntu+nQhqTRaehCDtt4fOtxQ1mBVVMurcwg7GELvXRnNM0D
        OWHWDBeYKkiR9kcMLg6cnL5nlJBht
X-Received: by 2002:a62:6542:0:b0:49f:c35f:83f8 with SMTP id z63-20020a626542000000b0049fc35f83f8mr3876154pfb.47.1638545606969;
        Fri, 03 Dec 2021 07:33:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwo2x/qdpagwLI3kVTPhJVDsCz4gB3f1riiBcD5zb+aUZCU3M2IhH4d5TGhd8XeJ7xcpCxmbQ==
X-Received: by 2002:a62:6542:0:b0:49f:c35f:83f8 with SMTP id z63-20020a626542000000b0049fc35f83f8mr3876118pfb.47.1638545606611;
        Fri, 03 Dec 2021 07:33:26 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.4.93.212])
        by smtp.gmail.com with ESMTPSA id h13sm3678811pfv.84.2021.12.03.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 07:33:26 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/gma500/cdv_intel_lvds: Fix a wild pointer dereference in cdv_intel_lvds_get_modes()
Date:   Fri,  3 Dec 2021 23:33:21 +0800
Message-Id: <20211203153321.108049-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAMeQTsazxeXgOJcuGZhEH5BX5ZzmOgM-NAjLjj9iypNgTqu-dg@mail.gmail.com>
References: <CAMeQTsazxeXgOJcuGZhEH5BX5ZzmOgM-NAjLjj9iypNgTqu-dg@mail.gmail.com>
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
Changes in v2:
  -  Use dev_err and return instead of returning error code.

 drivers/gpu/drm/gma500/cdv_intel_lvds.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index 9e1cdb11023c..581fc8315631 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -310,6 +310,11 @@ static int cdv_intel_lvds_get_modes(struct drm_connector *connector)
 	if (mode_dev->panel_fixed_mode != NULL) {
 		struct drm_display_mode *mode =
 		    drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
+		if (!mode) {
+			dev_err(dev->dev, "drm_mode_duplicate() failed.\n");
+			return 0;
+		}
+
 		drm_mode_probed_add(connector, mode);
 		return 1;
 	}
-- 
2.25.1

