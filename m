Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8799646520E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351307AbhLAPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:52:31 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:54518 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351134AbhLAPuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:50:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J43NP1kl6z9vmpb
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AESHyGydDtCz for <linux-kernel@vger.kernel.org>;
        Wed,  1 Dec 2021 09:46:29 -0600 (CST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J43NN6pY2z9vmpV
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:46:28 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J43NN6pY2z9vmpV
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J43NN6pY2z9vmpV
Received: by mail-pf1-f199.google.com with SMTP id x9-20020a056a00188900b0049fd22b9a27so15347633pfh.18
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9Nr51s8c+BNl5wfym5W4j50QPfmoIbsoX7lEYb7NO0=;
        b=hP54uOcAmEh8MaVfUzwmRsDFY2HD2rcZO3WGs28smCqTHW7LRClfCaHFOR0hRYxUfY
         7/zRxZ4eYQFeucFfvEB6q4ZcneYRseHvkCnbLsO6u1G4FsxLDg8zuMMK6ewW+qdzPWth
         UHJ6Ni6dZ8BncvQcacc23wg6SCavkH2ppNsDImdLk/GYTOkFm3UZzGkWBGBnVDGDYzgQ
         s8btnpP1BnuhNHsQzSFX/VAPM3xfhMy1tkQzHa8x9d1P8PdeXEPtF5Qk1Y+FN+gwNfk+
         5oMorQ4lM3U+r4NwmaUSVOK8V4z/wc6cj5ym3SnHzOSCWzapzfBDeq2Hedzyjtp6XSLl
         EVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9Nr51s8c+BNl5wfym5W4j50QPfmoIbsoX7lEYb7NO0=;
        b=UMwXnKtN34I1xq6r6qu67DNMtIpdPc/9HNR/EbJsJcPDuox9Hmi+Dzzg7DyRJUVhi3
         CI9HMmIsylMuVOJJBjZnyMW6ho+7NQldn58wESTHloXEOJohKn2J0nZ16uV3QBT0DQGi
         huW9Atm0iV0zRpY4TApcEw5pcixi8eO5lsBMfgypaEbK3SrwyDzKY0FWWs7XAXuxvpzy
         dQ9wRIxi4+erkc9LQ70Z6/4X8yt9bpbe0Ly1hFElKElnp3Tio0JFIQwd8+ItBSjvMcmu
         WMDUoPxc0cMlwU1iZRTR5Po6qK+1j5LPv9e1a2Zcf/KPenQ0eba+cqqQF1XJP+RCDYv8
         h6HQ==
X-Gm-Message-State: AOAM530HAM/tm7BKJVbw0B8NjF5gfQBgkS3R6HKKJCFCdIvAn9wXyjfP
        jN15HY3nLeYtNocBR7PQsLeMbTgezs9uoza7GFh6zxFdM2zGjhP1AFjgYTWsgdU7c/8/Kj3fkIN
        MrmfpGqPtGQgdURtAH1Rqy9iL6KLm
X-Received: by 2002:a17:90b:4a0f:: with SMTP id kk15mr8370555pjb.223.1638373588228;
        Wed, 01 Dec 2021 07:46:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4Jj3XUHz6YZqjUjnp03PD0GdE83Yhf0dfQDMWddCbTcxhLg/hZmT7i3Kv1K9nJpdhtmqEpQ==
X-Received: by 2002:a17:90b:4a0f:: with SMTP id kk15mr8370511pjb.223.1638373587982;
        Wed, 01 Dec 2021 07:46:27 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.22])
        by smtp.gmail.com with ESMTPSA id l13sm213390pfu.149.2021.12.01.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 07:46:27 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francisco Jerez <currojerez@riseup.net>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/dispnv04: Fix a NULL pointer dereference in nv17_tv_get_ld_modes()
Date:   Wed,  1 Dec 2021 23:45:48 +0800
Message-Id: <20211201154550.186374-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nv17_tv_get_ld_modes(), drm_mode_duplicate() is assigned to mode
and there is a dereference of it in nv17_tv_get_ld_modes(). which could
lead to a NULL pointer dereference on failure of
drm_mode_duplicate().

Fix this bug by adding a check of mode.

As the return value of .get_modes() can not be negative, this patch
does not directly return error code, but uses NV_INFO to report and
returns n.

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

Fixes: f24342375927 ("drm/nouveau: Break some long lines in the TV-out code.")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 6fe103fd60e9..598180a403ab 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -208,6 +208,11 @@ static int nv17_tv_get_ld_modes(struct drm_encoder *encoder,
 		struct drm_display_mode *mode;

 		mode = drm_mode_duplicate(encoder->dev, tv_mode);
+		if (!mode) {
+			NV_INFO(nouveau_drm(encoder->dev),
+				"failure in drm_mode_duplicate\n");
+			return n;
+		}

 		mode->clock = tv_norm->tv_enc_mode.vrefresh *
 			mode->htotal / 1000 *
-- 
2.25.1

