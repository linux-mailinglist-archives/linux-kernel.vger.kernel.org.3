Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50673490400
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiAQIid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiAQIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:38:31 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E77C061574;
        Mon, 17 Jan 2022 00:38:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id c5so10242922pgk.12;
        Mon, 17 Jan 2022 00:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/T33RHWOQc5pzbPE0ffvrM3mXshEH5+43Yne4cdEAaE=;
        b=qK4qFlrU11uCBM7/cT9juSnIpKrxZB16E9Pb85F473qDlnIP/oqadcjQbeugZnuCcq
         5GiHBmxFu7HhwrkEg6dJOeOuN0elj/wo21Ep2a4k5uDyIYdhoIymvUsIfxYHq28lHBMA
         5xAcGfALj8p0WY52FiC67n9jNQ3+1LB8cuhz9MOcRqTZ2UaOPIBAHCG1ZUDAuZ4OdEJW
         TmzJpFqkQ8DgBAwqMaQXdDK5vG2QSK3uNy0Zihf8Y20mVszZBGPMH4oATVzh63ZEA6+W
         9VHJc6soo90e76Imv/OBX0pP2REIIPOqU8wYBibjU4adaA+nDJeopMw4HbchDHoES61L
         q11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/T33RHWOQc5pzbPE0ffvrM3mXshEH5+43Yne4cdEAaE=;
        b=Ipoc9paKpu8WGBVEAh4ahZ/sP3uCkfUll/sOh3bRL85sQXYWsetFWIHVg4HoTBLhpx
         cUb/nNXgDv6Zw9Bu3y+jEcubQBHDx+t6Ll6/pNyjOiVrwn/2daxbv5LoENH6INYuDo2F
         HMN7pDYONkDZfER+OlfXRsuPbpPo94ujrXfha27H96lwSTlD/WMT8+jUCaOqcy3bDa87
         xMowqErAr9PUvFIbmdKtzROMbjZovkp4elJrd2Z/+nxzyfYKGDwx6+liuzi4pKk69dp8
         +nBzAg+KvuSgql+YpTOzCf0Fn6qlLLcZzKbd1UKRUfui9WfkTjSlLjSGPvdmTQsJ5Uan
         H01Q==
X-Gm-Message-State: AOAM532ZQ4qN3kScuqlG3rFpuCKSiuswgF6FdpkaGN6oR3OCXWf49Tof
        ERln2slxavJUlsVAYFvi+IY=
X-Google-Smtp-Source: ABdhPJxLpvslHwTJ0OknxPpRG7dW67M4XmqAj4vIfiB7do+vHK9KfGfw6xQpiJxoD2v44WiCSHT4Pg==
X-Received: by 2002:a63:350c:: with SMTP id c12mr18258702pga.568.1642408711173;
        Mon, 17 Jan 2022 00:38:31 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([103.6.5.6])
        by smtp.gmail.com with ESMTPSA id pg9sm7260181pjb.44.2022.01.17.00.38.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:38:30 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        javierm@redhat.com, tzimmermann@suse.de, lukas.bulwahn@gmail.com
Cc:     zou_wei@huawei.com, kevin3.tang@gmail.com, pony1.wu@gmail.com,
        orsonzhai@gmail.com, dan.carpenter@oracle.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] sprd drm cover letter
Date:   Mon, 17 Jan 2022 16:38:17 +0800
Message-Id: <20220117083820.6893-1-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1:
  remove the selected DRM_KMS_CMA_HELPER in kconfig
  drm-sprd-fix-potential-NULL-dereference

v2:
  fix commit comments long lines issue and drop "On linux-next" comments
  Split checking platform_get_resource() return value to a separate patch
  Use dev_warn() instead of removing the warning log

Kevin Tang (3):
  drm/sprd: remove the selected DRM_KMS_CMA_HELPER in kconfig
  drm/sprd: fix potential NULL dereference
  drm/sprd: check the platform_get_resource() return value

 drivers/gpu/drm/sprd/Kconfig    | 1 -
 drivers/gpu/drm/sprd/sprd_dpu.c | 5 +++++
 drivers/gpu/drm/sprd/sprd_drm.c | 2 +-
 drivers/gpu/drm/sprd/sprd_dsi.c | 5 +++++
 4 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.29.0

