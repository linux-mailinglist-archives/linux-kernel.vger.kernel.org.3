Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FD547F682
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhLZLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhLZLMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:12:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2334C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:12:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t26so26453405wrb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w27CKQZ8fZfwfzK3N8SKjXWwePWrkxb0ejgWzbzGC9g=;
        b=BHAxm//76OpzciHvg1EntaNOSuB691GvrQvOpTXIJyiidFNRGn3IueByZHXuMhzp8P
         MYYUwMbnmTUCzQItyblE+XluKbYpqJYMjWU46EP1tQv9sLhpaSlPvD+XYt5wageuROs4
         C2kYQqLYZIo/qC/twpnXrhXyrLs7V+l8q/xPHW5PM3YnmUV/69UqbBOB9ePfr8k8CejK
         EdrFdap+NPdgnAHjkWardIVHw3UxadFHCmTpoB7pwRXiiyGBpRI+3XJWSkHEoAoz4nZ2
         /ts8sj8R3ElC9wwEVpjCbQn+hedtlHZ8UeJlzROI/Oo9rbI0kKq3QEmtDsiLcj31NdzX
         LuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w27CKQZ8fZfwfzK3N8SKjXWwePWrkxb0ejgWzbzGC9g=;
        b=FZDQ1Ya9ROCBSGokcYRvjCXL1LM8sNFdHalRRkxmox7754PqycxKihiO9d3gepjVqq
         aa3EUAc5kVWl1GZvFFmeDa7ZlQ+/4Pc3+UnCo62FVXUjWIDyuqukWwGO1JqELHONjgS3
         4NAylYtrJLuOIsypEB4i6EJL1xXCs4pngE5CsszsU0kXMCMsVyEsEXIn1Nm0peRbb9Vg
         ESJsypU8+EFPHj6GV+apqkFyeTVUXhM4paGnyGOv6HfXJAc5Cv6dO0C/WcnkeM2Z+4Zl
         qBF+mqJ/bNS9LWfA4QoVnFKcVwWlyjYln0Kh0UroFLLbDv8UatA7rpT7Wpr8LiW4IOgE
         9NRg==
X-Gm-Message-State: AOAM531Ev3+ezZow7k7DfmaQB2oTqZ8NiPK1w6VjTZTJCqoF25LwjpT9
        au+LpUMP5TNHK2PcsLxFCqQ=
X-Google-Smtp-Source: ABdhPJy0pdQxFcCPxQLjqqSDI2TTp5sPgVsZOv1dWNImuKZqSvfxW7Ske/KAju6W43T0+poWiKMLIQ==
X-Received: by 2002:a5d:47aa:: with SMTP id 10mr9460610wrb.455.1640517170166;
        Sun, 26 Dec 2021 03:12:50 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id q14sm12156970wro.58.2021.12.26.03.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:12:49 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     melissa.srw@gmail.com
Cc:     mwen@igalia.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 0/1] drm/vkms: zpos
Date:   Sun, 26 Dec 2021 12:12:18 +0100
Message-Id: <20211226111219.27616-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch adds support for the zpos plane prop in the VKMS driver.

It should be applied after the "drm/vkms: add support for multiple
overlay planes" series [1] because this new patch takes advantage of
the new constant "NUM_OVERLAY_PLANES" to set the maximum overlay
plane zpos.

Notice that, as explained in the commit message, there is one test
failling (plane-immutable-zpos) because of the timeout capturing CRC.

This is a known bug [2] that needs to be fixed in a different series.
It happens when the primary plane is disabled. The vkms_composer.c
vkms_composer_worker() function is not able to find the
"primary_composer" variable and the test fails.

As a quick fix, commenting the line:

  if (act_plane->base.base.plane->type == DRM_PLANE_TYPE_PRIMARY)

Fixes the issue. However, more work is required to properly clear the
background and blend the first active plane. I'll look into it,
feedback from someone that already investigated the issue is welcome :)

Thanks in advance,
José Expósito

[1] https://lore.kernel.org/dri-devel/20211226104059.11265-1-jose.exposito89@gmail.com/T/
[2] https://www.kernel.org/doc/html/latest/gpu/vkms.html#igt-better-support

José Expósito (1):
  drm/vkms: add zpos plane property

 drivers/gpu/drm/vkms/vkms_crtc.c  |  3 +--
 drivers/gpu/drm/vkms/vkms_drv.c   |  1 +
 drivers/gpu/drm/vkms/vkms_plane.c | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.25.1

