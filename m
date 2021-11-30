Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A1463526
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbhK3NPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:15:18 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50090 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbhK3NPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:15:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3N0W5nvCz9vYdd
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZCcktm2I7CH1 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 07:11:55 -0600 (CST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3N0W3lSLz9vYdN
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:11:55 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3N0W3lSLz9vYdN
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3N0W3lSLz9vYdN
Received: by mail-pg1-f200.google.com with SMTP id t18-20020a632252000000b003252b088f26so6679222pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zP2V3v73TH3YI7ufMMJbNxUkEcjQUni5BsrXUcho/a8=;
        b=YkFSDBRcVydtQTX6o8vZyQMx/S8RDL6ju53POTTjGGSacBb5sUabaTM1oRX4Y0bWVU
         wpBGtby56+bWja18Q1TVf49o3fAsogXfkXb80zVAwbIW4Ff3+nakMzIAE9oiR47CeTQO
         y1seMLn6woU+LwT4nFqapEz8BvOp8sa4LouTfzyWHva541eIbi0evSMM6J3MbCJzzlYN
         MGdt6+XaOoVdzOPpSbgkeUzL4WR1ZdVhwHx1oDpS98fkoOFuZkwZVzxkya3o7Y9sC25Z
         I7ohaEJxkkteHjLUCf+kSy5fVKagAu6+gzbC7GYqJN2+bJA5q6UFAfiNleMA3WYnsxXw
         KLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zP2V3v73TH3YI7ufMMJbNxUkEcjQUni5BsrXUcho/a8=;
        b=EDulYLXp89EYacejBv5QF7g3vVlQ6lpBHZ15F/iDILm3I3OYUDcjuYvYbqezCr2PYI
         lWLTgf/dcf3IYUxavHXY9prCHE2Q9Dgu7o1uRG2IpYOXByGLPgHgmotBOD28V0cXuqPq
         3u5leUikiWGo6M1CPeOC9d1zXoRWhjNvPZjBn7GNMO/65LDZS9cesd11cJjGiYkK8mtr
         NxH43PCJxbzZZ1Nacd7Bh6ASX+9XVJDCs88FbkEXsn/y3A4sS/ApTyzZGfnUxxpfhZxQ
         b9WMdtSIMIosC1xvWlgZn1UlhTP6h+GFq55l7OEOz8mSiT/CD9MPmKAngW43TwSf5C5Z
         1Ldg==
X-Gm-Message-State: AOAM530oHEwIripruppfQFS4HTwUILGMJwPJKss3g5cQBVPHO6jsb83Z
        idadOX7k1IHY72iNitZ1Yn0INZvt6vOaI4hIq893fPd/m7Yb+4QZvRXQ6dGSkSnq4K3LAsTnU7X
        1F5Rnz5ywbhMYxMyZb+VF6azmGeMO
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr6005296pjb.236.1638277914562;
        Tue, 30 Nov 2021 05:11:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDAkyZLWvvoJdW2VIMQ+7cqEEnERC++JVHd62eGGU6w2A9FkL534V2oubJjtc7oPYV0SHOuQ==
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr6005236pjb.236.1638277914216;
        Tue, 30 Nov 2021 05:11:54 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id j7sm2622428pjf.41.2021.11.30.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 05:11:53 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: bridge: cdns-mhdp8546: Fix a NULL pointer dereference in cdns_mhdp_atomic_enable()
Date:   Tue, 30 Nov 2021 21:11:12 +0800
Message-Id: <20211130131113.126261-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cdns_mhdp_atomic_enable(), the return value of drm_mode_duplicate()
is assigned to mhdp_state->current_mode and used in drm_mode_set_name().
There is a dereference of it in drm_mode_set_name(), which could lead
to a NULL pointer dereference on failure of drm_mode_duplicate().

Fix this bug by adding a check of mhdp_state->current_mode.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_CDNS_MHDP8546=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 5530fbf64f1e..347fbecf76a4 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2040,6 +2040,11 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
+	if (!mhdp_state->current_mode) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	drm_mode_set_name(mhdp_state->current_mode);
 
 	dev_dbg(mhdp->dev, "%s: Enabling mode %s\n", __func__, mode->name);
-- 
2.25.1

