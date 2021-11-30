Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9684636D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbhK3Oin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:38:43 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:49388 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242258AbhK3Oi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:38:26 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3PrP5bsQz9yT9d
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fd_-OsgqjF97 for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 08:35:01 -0600 (CST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3PrP3WSCz9yT9T
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:35:01 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3PrP3WSCz9yT9T
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3PrP3WSCz9yT9T
Received: by mail-pj1-f69.google.com with SMTP id x3-20020a17090a1f8300b001a285b9f2cbso6873299pja.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v45QaW2rM4Je/A8eu9T3JFXlWztdvqd9VNNeErMwc18=;
        b=ZoJ7bm62EGw7ET4F1X20dpTU7jOwszuY9Bf8pk2ZQQylLCvULZZChhV65/9zTL8s3f
         hNlp0ysjfaFVeSzUpTo+vjdJQlYwrEVHbbqCYmvLUn4A7lpiHK/SVIoJeqvFCBJANZCw
         6I/83GucUnXu7bRLNHWKTqrWxdVNTlH05T8nHO76x6idj5YKgCSOnkg1XtOhAK4mXkq6
         +1oYirp7q5sbg7cLxLAWPWzZXSS76mWWWHbZF9DneEeDnTx2Eqm+3Y/IICIODVT/HDqi
         HZ9pOp3tfkqltDdRs7fS0JlVHLh48MwjjzjjOCpVfGt44YJcYlqOEfTpUcKHaQUplA4H
         uM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v45QaW2rM4Je/A8eu9T3JFXlWztdvqd9VNNeErMwc18=;
        b=ImOngtkSTd203dlBaf53sSDpGSceMS84ebO4xYf0LwHq5nZiIWqDm7JdcpKj9m75gT
         I1nrmBAd5JpHx7u6EQkAMYJsLq1NE9iuC55simIncSGzwhY6gWqhh1NQdVUkgbQUzcQn
         aPYwIpyyvV5cu4ariIvslTQpLuPIsyYAAyCC/kY566iwSYvCQClnPuYslIpGbapQ1bK4
         TI7H4weeDT2n9PMaU6U5vxt8hq5E0rUP2ZkslSfoVG6kTDYdFKQ4tFs/uB244byC6Jji
         hqPXbXgPLWkdGS9hqxlY3sN8FR84Pe2r44cGHTTSHUMQADSnT82jiKAvDW/NGx+EYF1X
         pyPw==
X-Gm-Message-State: AOAM531DI4Us6WhIC0gvmrsphTtHP4xlFHz5lLmqUl89/c/GemeNsBaj
        Lc5QxUbfR7QeCdtfHdP2sVLXyeoLHv0frposCFvrPkT+vKufBqlaOFT12TOil4I4psurBtdXZkJ
        G6lrIzdDtPC90K4AqjR/YJ8j61GKy
X-Received: by 2002:a17:90b:4a89:: with SMTP id lp9mr6673745pjb.6.1638282900692;
        Tue, 30 Nov 2021 06:35:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCRXgemJPjRW9A0gvP1wh5yNn/WdhCWBlFTQZi+PCntn4wzo5i7noyETqEeeoY0emTtll64g==
X-Received: by 2002:a17:90b:4a89:: with SMTP id lp9mr6673719pjb.6.1638282900508;
        Tue, 30 Nov 2021 06:35:00 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id s28sm22292818pfg.147.2021.11.30.06.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:35:00 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/dispnv04: Fix a NULL pointer dereference in nv17_tv_get_hd_modes()
Date:   Tue, 30 Nov 2021 22:34:53 +0800
Message-Id: <20211130143454.159221-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nv17_tv_get_hd_modes(), the return value of drm_mode_duplicate() is
assigned to mode and there is a dereference of it in
nv17_tv_get_hd_modes(), which could lead to a NULL pointer dereference
on failure of drm_mode_duplicate().

Fix this bug add a check of mode.

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
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index be28e7bd7490..6fe103fd60e9 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -257,6 +257,9 @@ static int nv17_tv_get_hd_modes(struct drm_encoder *encoder,
 		if (modes[i].hdisplay == output_mode->hdisplay &&
 		    modes[i].vdisplay == output_mode->vdisplay) {
 			mode = drm_mode_duplicate(encoder->dev, output_mode);
+			if (!mode)
+				return -ENOMEM;
+
 			mode->type |= DRM_MODE_TYPE_PREFERRED;
 
 		} else {
-- 
2.25.1

