Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8D9557515
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiFWIMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiFWIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:12:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D02647ACD;
        Thu, 23 Jun 2022 01:12:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id a10so10541459wmj.5;
        Thu, 23 Jun 2022 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rOv49GBzhOqyqE7eLHSt+Ik1Az34mqfqR6ns844eLbg=;
        b=AarHKbfnWn9yENZcAOcAjTKDQx3odHlfbz9G+O50Z9l1Xa1JlLDzpuxQ7NwRttr6k3
         w17rFjhVSm3hcsCYwR6AW/W0M9BasonEx6kjhrTsLIOiTBfZCTXnrz4ghbsNz/mDGLtu
         X5lnUfFRYbpNJds7DU6PzgcCJrUU+FnUGDl099SSAXFoQJjqrqBV/U7HUE/yRH5Wg/wn
         DGGAzOdR8+hjt+2o7z6zc8xO/st5IT7Elbc2Dvou0wF17wzuO9cozT49sm7/PAJwn7pD
         8Y+xRjMaGjPDzhajPq+bya+mtXp1XmpXrShidZOl7KtHrG/ptbO2sBePVbIhpnuHSKfy
         r4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rOv49GBzhOqyqE7eLHSt+Ik1Az34mqfqR6ns844eLbg=;
        b=0rchqmgLCZsizJtb/PWEcrxaZnncxJuRnGn92eZ2aAu1ZrCjyz39yGxy3XMugiNieX
         w9oxHXLK7dcLU7P0s10lZnq/UrFxsiJMCj7QRpfFkounHHIBhinnsR9eGJE8hSUQR0L7
         Lo+nZ4PPMGIx0raPzai8GmbkiHZ3hxk6D/smyhVU2qBs52BiG3cwgy2gsWlKJWuQzlB+
         pXkzcdPxXAFGzzNhjeY5bK9vMtgXbW5OjfRiw5K+qI178TA0Ur/TR/y3Cixk0y7OheQo
         oYt0nsLg7jZXAmp8Oa/OO3bEjvks68mhalag7R5JF6CoS4LiKOvvHTJyFnuuZ/JwDOoL
         mgBA==
X-Gm-Message-State: AJIora9ygmQ+I37u1Buuo8T7HIizsiHVEf5Qoz2O+BdWY2yEf9DFYb7n
        QUW+jovM1eRxNYHLxG8cYec=
X-Google-Smtp-Source: AGRyM1uOoiFLDolTe62S7PLYbIbjstwYERsSlBMWvOkw05h1A1/QD5ahYbsxQSu5AHST8hcNEmPFWQ==
X-Received: by 2002:a05:600c:4fc4:b0:3a0:334e:241d with SMTP id o4-20020a05600c4fc400b003a0334e241dmr593760wmq.62.1655971940214;
        Thu, 23 Jun 2022 01:12:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b0039db500714fsm2291638wml.6.2022.06.23.01.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 01:12:19 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdkfd: Fix spelling mistake "mechanim" -> "mechanism"
Date:   Thu, 23 Jun 2022 09:12:19 +0100
Message-Id: <20220623081219.19291-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a pr_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8805bd1eed37..f5f1368c0c54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -914,7 +914,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			ret = kfd_mem_attach_dmabuf(adev, mem, &bo[i]);
 			if (ret)
 				goto unwind;
-			pr_debug("Employ DMABUF mechanim to enable peer GPU access\n");
+			pr_debug("Employ DMABUF mechanism to enable peer GPU access\n");
 		} else {
 			WARN_ONCE(true, "Handling invalid ATTACH request");
 			ret = -EINVAL;
-- 
2.35.3

