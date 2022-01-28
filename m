Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D4849F64B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347596AbiA1J1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbiA1J1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:27:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFF8C061714;
        Fri, 28 Jan 2022 01:27:53 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c190-20020a1c9ac7000000b0035081bc722dso3613286wme.5;
        Fri, 28 Jan 2022 01:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CS091XzEzoAHOCH+W/UyduhGkZsqrIdDMgBdSqoCcpo=;
        b=hshMphxIhDJjd8wz/XCTf9sG1j4yjdSB5F3LG3yO0jyaupBJR9xz+YQaV765Y5kH6O
         uz5mgvD8j47gpIVvoRpH7ovVglDn7Ncc66JJVNkLmKAjW71m6FQKOeqWiIh5PNIotr3q
         FAYKNaoDMyGsNNziHp5CYfK1YIxfFbUs2RQGs+1MDDvrKpmbxOejL37g/n8f15zYy9Fd
         St6LLugKQvRb2b4eFPJo5TcbP37FfK8WTVwS3j9WaVCyoW8KyQy23ER0Wzz5Y/AzfpCF
         ST7gQrkd8u5n0EEWQYOUgvMxA855sPAG27WKmmxLZBvoD+T0caZLk0EdPt3F+FGi7EOQ
         7+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CS091XzEzoAHOCH+W/UyduhGkZsqrIdDMgBdSqoCcpo=;
        b=FWFV51zK4CgVKwc1K7NI4KzBlxESFU7WTD+ANM4bL3yU5JsFeRjKRqU1UnKB0ZMKj3
         hPe/HIfZI6BjdZNh0VCKFt8o3ERR5aNsRArYqjUoCkcqaUl7UyFZZHAHIu2xr4lKVhN2
         gzyts7YjoMkvamcEEgzxY4Yjd+aMkLn6ZX5JW8HrDxPp2YNi1CB83GwcmOi28kamtae9
         iBI1p94iak1rXzQjYaqfJpsBC5/UFRqF2q4306ZgBzIEooM7Lf1F05g9Jdoyl5kNuUYA
         Y5jlhZbPDAsJLBpf/omiLzmq5xjw1AYHs++AlUMD05mYwZnirNOTY5vPQfAhq9qLimo6
         nZ9g==
X-Gm-Message-State: AOAM532Jz/q5frOMqhFO3N5mRvuzlbE9DRL3pjhaYpAXxk5k5l6rg0yb
        b3dvpz61ZDsHxSm3cJ5siY4=
X-Google-Smtp-Source: ABdhPJw8D66rjld6L8qeoS5ngWtmYyTWjMRJEykBje9p8zqY/V3QSAo1ErhTpM6Cu2jVvnr1tT1U9A==
X-Received: by 2002:a05:600c:6028:: with SMTP id az40mr15217262wmb.33.1643362072333;
        Fri, 28 Jan 2022 01:27:52 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c8sm1605684wmq.34.2022.01.28.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 01:27:51 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: Fix a couple of spelling mistakes
Date:   Fri, 28 Jan 2022 09:27:51 +0000
Message-Id: <20220128092751.7679-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 80c25176c993..06d3336a1c84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -919,14 +919,14 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 						"wrong operation type, rlcg failed to program reg: 0x%05x\n", offset);
 				} else if (tmp & AMDGPU_RLCG_REG_NOT_IN_RANGE) {
 					dev_err(adev->dev,
-						"regiser is not in range, rlcg failed to program reg: 0x%05x\n", offset);
+						"register is not in range, rlcg failed to program reg: 0x%05x\n", offset);
 				} else {
 					dev_err(adev->dev,
 						"unknown error type, rlcg failed to program reg: 0x%05x\n", offset);
 				}
 			} else {
 				dev_err(adev->dev,
-					"timeout: rlcg faled to program reg: 0x%05x\n", offset);
+					"timeout: rlcg failed to program reg: 0x%05x\n", offset);
 			}
 		}
 	}
-- 
2.34.1

