Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB146322A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbhK3LWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:22:01 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:52696 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbhK3LWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:22:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3KTs0Mnpz9w6RS
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2mAgZOKHw_7x for <linux-kernel@vger.kernel.org>;
        Tue, 30 Nov 2021 05:18:40 -0600 (CST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3KTr5Jt1z9w6RG
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:18:40 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3KTr5Jt1z9w6RG
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3KTr5Jt1z9w6RG
Received: by mail-pf1-f198.google.com with SMTP id p1-20020aa79e81000000b004a82ea1b82bso2307779pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fcDXlkwYy3RGfIkoC7nwMHwkoGJwFkeLToaTBjqpVz0=;
        b=IZFo2LaVF/UDFGHVpkS6dD5TA6dpvZiDSB/3rKX1VSVjqxWP/lhMO39QYI3NPLoRgq
         cRXSmh8e41mhZP6Z6pASFNZgCl2xPwfVgz6CBJ4rCuCZ5ixas3pK71sx3cvXjwkJTop+
         3T/yiRiF1QWYne/jINn7ouKO7OjCe6gsRwokRuSedKnx6jzsAq8pHSJdN03f8AET5TzU
         a3BC2bkGlVrwO6yuzbS4R4Uw0sjIcFhIuR8RmeSA1Od8jCr3Qr3cmM751Tht6hvFkmqk
         ZRyDmDTDs5KOn9FrJ5pzFxU474Na5c2560b3P8n5J2SDV8k/mizEVWFX2R0RVU+iUKxp
         O0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fcDXlkwYy3RGfIkoC7nwMHwkoGJwFkeLToaTBjqpVz0=;
        b=Hil4oS4proVe3i21VSd66z1GpFK9LMp6ZGykOuymQO+CrYqgYUUsiHBCj5glaKlNLY
         8d5e1D9Cv+bPC3IIs8Kub34uleMlhg3Nv5FfljHskiIjCfEL7VVE3e7rrBb1azLAJcv9
         JboU6b4vcjMIXfDU67dsKfsSMPs2THGhierc2lku4hoUROZmitp8h4xG4Lacxu4HVLwq
         fIEQZ0dSC1qBUA4pOmBe/L0XiDqPPhh1wRYOeoRji4t0XUsRX4tDYEKxR1ue6aZsGBLa
         Mtr4Fd5hL8q9nPXnaRnULjBD6uWc6NXUA9L+xUHFeZKy0BPy1IQBx6yH0eU7+Gtut+eF
         bLrQ==
X-Gm-Message-State: AOAM531qMZSc8RfiEV3TNVfj8gf4Zn+7+NarUdjM4lEdDUyi22ZXZ47s
        0iSHc4TkU+s9B4uN911o9c19XGjrhw3Up07GxTd0mTgXm30VG63NCELIHpj3KQ+gzGcVIpNRQbT
        ofJ2NWoRtcwb8fCkMl8kitGp8YofF
X-Received: by 2002:a63:4815:: with SMTP id v21mr33476636pga.204.1638271119978;
        Tue, 30 Nov 2021 03:18:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz86b37XtXDhaWTJbzxcPVwFldWszd3ZgCjYlChRIfA1Lxm91iK1IJ9p5k5TxfqRc7ZaUDHCg==
X-Received: by 2002:a63:4815:: with SMTP id v21mr33476628pga.204.1638271119786;
        Tue, 30 Nov 2021 03:18:39 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
        by smtp.gmail.com with ESMTPSA id q18sm19100280pfn.83.2021.11.30.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:18:39 -0800 (PST)
From:   Zhou Qingyang <zhou1615@umn.edu>
To:     zhou1615@umn.edu
Cc:     kjlu@umn.edu, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, hongao <hongao@uniontech.com>,
        Jammy Zhou <Jammy.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix a NULL pointer dereference in amdgpu_connector_lcd_native_mode()
Date:   Tue, 30 Nov 2021 19:18:30 +0800
Message-Id: <20211130111832.113821-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amdgpu_connector_lcd_native_mode(), the return value of
drm_mode_duplicate() is assigned to mode, and there is a dereference
of it in amdgpu_connector_lcd_native_mode(), which will lead to a NULL
pointer dereference on failure of drm_mode_duplicate().

Fix this bug add a check of mode.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_AMDGPU=m show no new warnings, and
our static analyzer no longer warns about this code.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 0de66f59adb8..0170aa84c5e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -387,6 +387,9 @@ amdgpu_connector_lcd_native_mode(struct drm_encoder *encoder)
 	    native_mode->vdisplay != 0 &&
 	    native_mode->clock != 0) {
 		mode = drm_mode_duplicate(dev, native_mode);
+		if (!mode)
+			return NULL;
+
 		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
 		drm_mode_set_name(mode);
 
-- 
2.25.1

