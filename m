Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65854636FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbhK3Ost (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:48:49 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43680 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242333AbhK3Oss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:48:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3Q4S48JVz9w0Z7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kKdoGZLZUuiP for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 08:45:28 -0600 (CST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3Q4S25X9z9w0Z2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:45:28 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3Q4S25X9z9w0Z2
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3Q4S25X9z9w0Z2
Received: by mail-pf1-f197.google.com with SMTP id c131-20020a621c89000000b004a343484969so12963907pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6LNCzubAvM1UAFro6OAu5q4vc79ycy1gcnZHWEZqRg=;
        b=QGu9G8DNB3JtXxMeVuLaeVUC5ZHalORVRodgIEuZm54ot4jgPTStUETLOOnXnDbjAz
         Uf1CRBp7h6uB323QQZ2vX/yExi7zKEvrxc22B/BxTYRT/5I2EHBwuPhLnYVt+gAm5bHB
         Uoz07+wDNQ1picLCT1XnAhRXDgWRO6Jzq0N124hRRFGg+LCmxOJCV54Cn7FeIPGM8S8C
         nMpEKI6d7i4Vk448HiLsQl9ZWhwZmhzQT56bNRRZARPwjdw9TgXEr2FrxqeF7I3q2TW6
         qRG4FLZ2xqDfpeoZ5Ov9BX992rw5KQWWsGGQ12FxZknX0Jrgk9Ru8YmSQ+i7OSZSXOnH
         ia5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6LNCzubAvM1UAFro6OAu5q4vc79ycy1gcnZHWEZqRg=;
        b=dYIUWutpGrgwoUtztdk8s4Dl7UARCcDe+8+wF2KXho6vvsKx4kWLjp9w9F/goX13Df
         p/lKWUn/rqRTelwU8JtKWQYSefiVMo1QRYJOS/qgFbktmrUZGpr+TaLf+Ijy0D97Xic6
         U+77ffqXd0tjsRjp9RvUHjvCPRceeTciI9m87s+/ZccRBDktXhS126NJMJqtrPG1jYuw
         69V9XRc4yEoO3mE+lQqyG5E1voU0Yo2Os8prgU68w151D+5l917H22aDOw7S1oXL/gbD
         A6skuMcNomZip0EvUQHzLs2yJcRG7CDc06lLxGxBy00hMFYk2hrF1TvO6FIit2Ns/M/+
         0l/A==
X-Gm-Message-State: AOAM530w6PtbXTvZdEx3+LUI+MlYECYitVRMUVCYJjlsVYrVFpoPzcBU
        ioYlDMyc2Xc2NkVK5DRJVsfa4lHjyBFQv15ix5qwSY5b+Lp5tNLRQX1x8pBXxNJsyR6tClqZAYj
        M1SaVRbKoW0OWmzBh32R270suETGR
X-Received: by 2002:a63:81c1:: with SMTP id t184mr40045776pgd.26.1638283527468;
        Tue, 30 Nov 2021 06:45:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8+3UCv1VwdzMjRJfnSg9Zq7bxFF6U71MKKHXfNkC6U9FcxX7fm3QSgTG6F27ZPHGtBA2QTw==
X-Received: by 2002:a63:81c1:: with SMTP id t184mr40045755pgd.26.1638283527262;
        Tue, 30 Nov 2021 06:45:27 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id u32sm23701235pfg.220.2021.11.30.06.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:45:27 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel/panel-tpo-tpg110: Fix a NULL pointer dereference in tpg110_get_modes()
Date:   Tue, 30 Nov 2021 22:45:22 +0800
Message-Id: <20211130144522.162262-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tpg110_get_modes(), the return value of drm_mode_duplicate() is
assigned to mode and there is a dereference of it in tpg110_get_modes(),
which could lead to a NULL pointer dereference on failure of
drm_mode_duplicate().

Fix this bug by adding a check of mode.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_PANEL_TPO_TPG110=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: aa6c43644bc5 ("drm/panel: drop drm_device from drm_panel")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/panel/panel-tpo-tpg110.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-tpo-tpg110.c b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
index e3791dad6830..ab4b84c1e243 100644
--- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
+++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
@@ -379,6 +379,9 @@ static int tpg110_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = tpg->panel_mode->bus_flags;
 
 	mode = drm_mode_duplicate(connector->dev, &tpg->panel_mode->mode);
+	if (!mode)
+		return -ENOMEM;
+
 	drm_mode_set_name(mode);
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 
-- 
2.25.1

