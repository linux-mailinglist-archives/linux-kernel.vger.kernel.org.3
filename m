Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507B04A7CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348626AbiBCAkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiBCAkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:40:03 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E5C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 16:40:03 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r27so1591488oiw.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 16:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=JtgYLUmjGjXwnUIDY0NrvHIpDAIdltMK/6ylaob6joM=;
        b=W2xAuzt01oQIDd8B8zkISKfjjEbAwjTpwrFjWW7RBCjQJGcYJjS4LvaFOZ8PsFirH8
         Lwtl9Ly8amHcqBYkt9FKBtrSHVfr1AxZ5neX9jqadCdBjtCE+nhwFk1fA0SBHgYwJc2Z
         NI3++jrfTchLnuPivDCgTYyUL3MVptISHZqZHnbZcVjedzdJ6q0o4anZEWxomn2k6Zkw
         aLEqTMssUeh5RqBA7Teg2uGzWWirHYHqH8AUCo7u1FG+3QuHhy4N66sKJu93XgoxtoY+
         x4Imtbmpypu6kde8gcIdm1/i6I9RdvIqljMJJcCMJNIC6XFkH3DMPuwJdBevplEicxtI
         v19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=JtgYLUmjGjXwnUIDY0NrvHIpDAIdltMK/6ylaob6joM=;
        b=jNN+/2TYEUVUpA+nI93Clwbp4dE95NSA827ByOukOblj38s2hxavGcT8p9dwkIQ1eV
         d68PjY3eDbk8QWxi3UP+fSgg3X4hfsAbRMycdHfjy2Np9Y+w3IbPxs5r95lbQ5EG7QxM
         4mmcx8iWymnmB6gQ6Ir1XREeh3f6zEQA6jc/uwOuhp9a9Ar+yqsqTuWYWh6Kcxi6rNgq
         PPa1NzAHr8E20ryNoe0clBk57EXD+ghZK3BHa7cPR602HeW6kJBNbHShZqkp5yGfhfX2
         +ApgYv3z9kFQrF9pN8ZwlWQzLxHUSPpNvTDmWc7i33ildW7SVDjmz67R6amdpKkuM9dd
         p2lw==
X-Gm-Message-State: AOAM531+YlIqJAYQWNPCvaPMKY9UvxoKMbAwfJ+k9tvlh1ZVxDluwFYK
        IdwMhMET9U9kXOKPTU/eh0hmGA==
X-Google-Smtp-Source: ABdhPJzud8fgkUET74j2i9qXN9D5nXRf4eLBUEUdRcxNnLj4cIJqe4LurJS/a1Q5CEP+cqQ+GVLvtg==
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr6351565oic.116.1643848802563;
        Wed, 02 Feb 2022 16:40:02 -0800 (PST)
Received: from fedora ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id n9sm8463545otf.9.2022.02.02.16.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 16:40:02 -0800 (PST)
Date:   Wed, 2 Feb 2022 21:39:54 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        lijo.lazar@amd.com, luben.tuikov@amd.com, guchun.chen@amd.com,
        Hawking.Zhang@amd.com, jiapeng.chong@linux.alibaba.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: add missing prototypes to amdgpu_dpm_internal
Message-ID: <YfskWvNqt81rZZpQ@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the header with the prototype to silence the following clang
warnings:

drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:6: warning: no
previous prototype for function 'amdgpu_dpm_get_active_displays'
[-Wmissing-prototypes]
void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
     ^
drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:29:1: note: declare
'static' if the function is not intended to be used outside of this
translation unit
void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
^
static
drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:76:5: warning: no
previous prototype for function 'amdgpu_dpm_get_vrefresh'
[-Wmissing-prototypes]
u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
    ^
drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_dpm_internal.c:76:1: note: declare
'static' if the function is not intended to be used outside of this
translation unit
u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
^
static
2 warnings generated.

Besides that, remove the duplicated prototype of the function
amdgpu_dpm_get_vblank_time in order to keep the consistency of the
headers.

fixes: 6ddbd37f ("drm/amd/pm: optimize the amdgpu_pm_compute_clocks()
implementations")

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c | 1 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h      | 1 -
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c   | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
index ba5f6413412d..42efe838fa85 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
@@ -25,6 +25,7 @@
 #include "amdgpu_display.h"
 #include "hwmgr.h"
 #include "amdgpu_smu.h"
+#include "amdgpu_dpm_internal.h"
 
 void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 5cc05110cdae..09790413cbc4 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -343,7 +343,6 @@ struct amdgpu_pm {
 	struct amdgpu_ctx       *stable_pstate_ctx;
 };
 
-u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 7427c50409d4..caae54487f9c 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -28,6 +28,7 @@
 #include "amdgpu_pm.h"
 #include "amdgpu_dpm.h"
 #include "amdgpu_atombios.h"
+#include "amdgpu_dpm_internal.h"
 #include "amd_pcie.h"
 #include "sid.h"
 #include "r600_dpm.h"
-- 
2.34.1

