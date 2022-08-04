Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43C58A022
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbiHDSCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHDSCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:02:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F71EC4B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:02:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z17so656018wrq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/C+hKhyGa8Z8FqlEwwzUM2g+6zJUxH3CoGD+BmNpkRU=;
        b=R8+tjsNc1/Im1xglpXDPLenvKjzuwlsNixpILoBBmgw1sfowInHxLfXcsUxBYDCPqe
         BT0FbPwYmxRogJJkTHEWDG9cuc6pw4fni2WFcQ1bHrQDsMmEWDf7mUGRFtKfQ1BZzYk3
         7R4XAhochon4AtoWTnt32GOF3r5207wHw2Sfu8eR0RWFknb4QFrg32JZawvESIn4Vpjw
         zI+Oy82c5uBFxWD8obCGqB1qwzab8ZbyTu9W15RiyYXGUxMg0C44+SiJzpmxJjj71M8z
         dsdCNlaUcILZ501DtzJB2AWnBMuDOaoBPenga+h78WHT+qH9stUufLiZ9TdsRU8wF5GC
         G4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/C+hKhyGa8Z8FqlEwwzUM2g+6zJUxH3CoGD+BmNpkRU=;
        b=TS1XZ5OeJsSwAQjTxv4owQ5RrC+jmwAmfh0BK/U2wadHTU3dg7e+Def1s+L2JHidhG
         vRknxf++qt8F/fCyOBnNPYKG1EHbNDNea1xBCJlsuNGNCp4n/iat6ww7oGrHoxObwZHh
         nEQKKkPLEZZjXy/p8MoL+uWquzLs/5v6jfBkFimAps+PzywHaCMHqwrI7ssdJJiy/Th3
         mvdy1izPdcz4zcu4/QOsczqRR+KNPqzNKWhJIn6y3g6ISoXpKNDo21pz37RFbteiWWhT
         ZhY/4y1sYrCMwBG0dSmh2Sks5icHFuQ5+sv2SMsYtB96RF2wfpXfyR1sJAvkmxWtv905
         JHsw==
X-Gm-Message-State: ACgBeo19ojcMwwB/ICaqNlu3Tk291JkoANjJ/uDhCB3jxSI6yQjCkyac
        EVfXK+jGCQO0jJKDGdct41c=
X-Google-Smtp-Source: AA6agR7MZ6Eh57nonDd1sdO5SezOu2y7/MW7ivmV4BitL7fH4HYDy4P9YkvpltcjsrHf+7Vev7SsRQ==
X-Received: by 2002:a05:6000:186f:b0:21d:96af:31ea with SMTP id d15-20020a056000186f00b0021d96af31eamr2145172wri.646.1659636131906;
        Thu, 04 Aug 2022 11:02:11 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id n32-20020a05600c3ba000b003a2e27fc275sm2411299wms.12.2022.08.04.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:02:11 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] drm/amd/amdgpu: fix build failure due to implicit declaration
Date:   Thu,  4 Aug 2022 19:01:46 +0100
Message-Id: <20220804180146.63184-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The builds for alpha and mips allmodconfig fails with the error:

drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:534:23:
  error: implicit declaration of function 'vmalloc'; did you mean
  'kvmalloc'? [-Werror=implicit-function-declaration]

drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:534:21:
  error: assignment to 'void *' from 'int' makes pointer from integer
  without a cast [-Werror=int-conversion]

drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:545:33: error: implicit declaration
  of function 'vfree'; did you mean 'kvfree'?
  [-Werror=implicit-function-declaration]

Add the header file for vmalloc and vfree.

Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 63b2d32545cc..726a5bba40b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -22,6 +22,7 @@
  */
 #include <linux/dev_printk.h>
 #include <drm/drm_drv.h>
+#include <linux/vmalloc.h>
 #include "amdgpu.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_ucode.h"
-- 
2.30.2

