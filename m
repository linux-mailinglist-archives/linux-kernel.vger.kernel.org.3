Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB11E463542
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbhK3NXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:23:20 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:53560 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhK3NXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:23:18 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3N9q0xhFz9vKMQ
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:19:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XjQWYHh8ExMU for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 07:19:59 -0600 (CST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3N9p6Brjz9vKMP
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:19:58 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3N9p6Brjz9vKMP
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3N9p6Brjz9vKMP
Received: by mail-pl1-f199.google.com with SMTP id e10-20020a17090301ca00b00141fbe2569dso8194706plh.14
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9giINlR+BSpEr7zhBf6fuBq1XcC7WnNkJGxwTieVCFQ=;
        b=mbHNzOpxzuTTFSShX9vTuvlmR/XgchvH5bqJff9kswR3aO+taZYihdcpOWBUUcHiJC
         4i/BLeveoAjoLv4NWluQuE089j1cGcc8CDdhWTXMqu4RcIkIrQnF5P7d6Be4oAfgN3dA
         Xl0cyxQFJaiNN4ZHXlt5GRg0OzHYT+XaBRt+knm41feUQ0zN1nF9+pMPt+kQF39gk6KA
         KmjNnkLb9KinMwttErKiU8xK+erTVdxi1vzZ2ZcOaikWYJAPpRkX17YIxl6cNEUmwnQI
         8c+pL8ySmD6J/Ud84LTj2EhGG5W+mbNPddR2t7N9GblSCFa+71Vm/ey9n4rpWYywO94W
         Q2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9giINlR+BSpEr7zhBf6fuBq1XcC7WnNkJGxwTieVCFQ=;
        b=MEaxCQJV6LROyL4N1xUFXnxNzkIQFVgvaE/0F8xxefH9rk/s0llgMFxUOqgVFuJd8O
         tHCqh+Q5mv2pN4DiFZtBYCtuU9Mt0MxSQJSb+RrxNqUdODVEt7pullylqlt+fFp1y/cv
         By8kmlcoJS2TRahHNV1yagtJXrPVluDydy1NDRc3EKKwWm7d6+mIafbXH/7ro1IjsavB
         /0CYPTJqUdSuyQ8/PhFJnrHKb/uD1+TnczKzyJEBHZlfS2+DQT2LsYXNTiajb06Jh+Rm
         rIiDOEX5JPGL01xo7qkjyLawQU3uvfP4fgs+gNGkm6+GErpNVmMjEW5Qum6QOzkx1b1b
         SIYQ==
X-Gm-Message-State: AOAM5335uT62JXhcJAEHpEEH82KcrpnINYfsqdmla2IinR/JbWzttwXB
        2gh8kZ9h0YS8kZaiiDXDKWVhUV4hsQjn2YXAz9YROxpubLeBd+LvGjEZgkRqahBsiWZP4jCFFTe
        Haxi1B97gePydFIi3yHIFq9cK97SX
X-Received: by 2002:a17:90b:3447:: with SMTP id lj7mr5978397pjb.112.1638278397893;
        Tue, 30 Nov 2021 05:19:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQUuDVaf1z7tmlheKJGKSEuBfRA5pRLyuHo6Xi3d8PJ3AzMI6GWMe56NIODcYFd58IYrRvRg==
X-Received: by 2002:a17:90b:3447:: with SMTP id lj7mr5978362pjb.112.1638278397658;
        Tue, 30 Nov 2021 05:19:57 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id rm10sm3104834pjb.29.2021.11.30.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 05:19:57 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ch7006: Fix a wild pointer dereference in ch7006_encoder_get_modes()
Date:   Tue, 30 Nov 2021 21:19:15 +0800
Message-Id: <20211130131917.127897-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ch7006_encoder_get_modes(), the return value of drm_mode_duplicate()
is directly used in drm_mode_probed_add(). drm_mode_probed_add() will
pass &mode->head to list_add_tail(). list_add_tail() will further
call __list_add() and there is a dereference of mode->head in
__list_add(), which could case a wild pointer dereference on failure
of drm_mode_duplicate().

Fix this bug by separating drm_mode_duplicate() from
drm_mode_probed_add() and adding a check of it.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_I2C_CH7006=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/i2c/ch7006_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
index b91e48d2190d..1207646562eb 100644
--- a/drivers/gpu/drm/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/i2c/ch7006_drv.c
@@ -227,6 +227,7 @@ static int ch7006_encoder_get_modes(struct drm_encoder *encoder,
 {
 	struct ch7006_priv *priv = to_ch7006_priv(encoder);
 	const struct ch7006_mode *mode;
+	struct drm_display_mode *dup_mode;
 	int n = 0;
 
 	for (mode = ch7006_modes; mode->mode.clock; mode++) {
@@ -234,8 +235,11 @@ static int ch7006_encoder_get_modes(struct drm_encoder *encoder,
 		    ~mode->valid_norms & 1<<priv->norm)
 			continue;
 
-		drm_mode_probed_add(connector,
-				drm_mode_duplicate(encoder->dev, &mode->mode));
+		dup_mode = drm_mode_duplicate(encoder->dev, &mode->mode);
+		if (!dup_mode)
+			return -ENOMEM;
+
+		drm_mode_probed_add(connector, dup_mode);
 
 		n++;
 	}
-- 
2.25.1

