Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9414636AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbhK3OeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:34:07 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:60498 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhK3Od5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:33:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3PlJ6ty7z9w6GY
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:30:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8GmLO12XnArV for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 08:30:36 -0600 (CST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3PlJ56Wrz9w6GR
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:30:36 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3PlJ56Wrz9w6GR
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3PlJ56Wrz9w6GR
Received: by mail-pf1-f197.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so12900431pfx.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZULR1F8PiluLDq0yfX4xdKKhgM6tyga9J4hvDhRIDI=;
        b=j98sbNp4aGJYzZQgx7/157yo3SgUnI/mMvJ0sMqD6xBYraYZ/VnSyRscyGTn1mZca0
         LnZErg2no+D58Bx5NnS5WYws9ygKRfBUJsrlHzoV/ViYsCnwhaZgB85ElPWaBNfUpe4V
         V0uC103ZW8xaFVYHWB96eff4zdXKuTIQvcX+WZXtO1+2tu58tNprNj99DOQod31ofnRz
         YBQjahbHXcA5cnNi0x2UWfo+HHu4hHiCUOTzsqYGe4tTkZApaTbrTw7XtVTn4j2R7hZL
         XI/LL44uanBqjlyUCjov1JQaJuAl+hm555ofGNNwY0mvzZD5PsAEsWH79U9IjOsdJGAE
         CEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZULR1F8PiluLDq0yfX4xdKKhgM6tyga9J4hvDhRIDI=;
        b=Gk3BJ5nHW8ro8vvCNJi9PqkUvX1Mk1RD29dHH8oNK4Wdi8+P0VwPrkAmWoxDYSQp9E
         a4mqPLppptwI9BJj4O+TtZoeSDdgeeXFRcC3Ibo7aZIe/wcupdhLsh6zj+tOrLGgaFUQ
         HNyVsCgp4nCVYHw/oXv6kpoHzGY2cd4svekgvpsPM6cBEd+zrKv7YYlaHZQ95bzQ8QjR
         pdBRChVDHL06lpV5W12jT865bjknmeklE0rjJlv35RYEDW3tdTnx+UuvCzrdl2/D3E/r
         KeLeEst7HzrqKq0lwoyJZDyJcv5O7kJiBPbOKv4JRvql/3M6fK5bcXpcerO9I0hjkc4i
         BPTA==
X-Gm-Message-State: AOAM530vZB2v3+d+nq5SH1i62HjXZVLv1N/bgIWfnDg0/R3zoB4vxPEb
        bom2Qj84nEXpe2vPAzIRreYItborIG8TP1+jjPw73yQDPB8AKX6UJ2iFWn3X/rSrhgVkMg8H/gq
        wDRZK/Qa7G40wF7kfenxYukybWr01
X-Received: by 2002:a63:a1a:: with SMTP id 26mr2298312pgk.350.1638282635545;
        Tue, 30 Nov 2021 06:30:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvVF8wTLFjolACqw+b3KkKUeaJ7DTif2YLF7D+bFqP/PZCqaQ+P5pB9IlYEV7eNa7sL2MV8g==
X-Received: by 2002:a63:a1a:: with SMTP id 26mr2298269pgk.350.1638282635156;
        Tue, 30 Nov 2021 06:30:35 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id b8sm2974809pfr.213.2021.11.30.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:30:34 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Fix a wild pointer dereference in nouveau_connector_get_modes()
Date:   Tue, 30 Nov 2021 22:30:29 +0800
Message-Id: <20211130143030.157754-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nouveau_connector_get_modes(), the return value of
drm_mode_duplicate()is assigned to mode and used in
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

Builds with CONFIG_DRM_NOUVEAU=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 22b83a6577eb..d960b42724de 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -977,6 +977,9 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 		struct drm_display_mode *mode;
 
 		mode = drm_mode_duplicate(dev, nv_connector->native_mode);
+		if (!mode)
+			return -ENOMEM;
+
 		drm_mode_probed_add(connector, mode);
 		ret = 1;
 	}
-- 
2.25.1

