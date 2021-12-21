Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB5747BDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhLUKNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhLUKN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:13:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0712C061574;
        Tue, 21 Dec 2021 02:13:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so1277764wmj.5;
        Tue, 21 Dec 2021 02:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiEdSYmJyAKWAqc7ui3XIZTznDZvFBWaDk4WF2mm3yA=;
        b=pBXL5mIQQqrE1sWVIayqcv1+QL5wyX/RH88FEO/rknbs31q5lPo7Gc1vsNLcyk0aeN
         GuQyqQB6ckAM/UMXeqF1shw9N22mmOkGalFRHuT+sytdWtPUY6l7oo5EMLPSC9rjEBV9
         21LHQ2WLsLqRROwJubFBoMUkkb+f2Mpgjv1O/Ong1dxmOUlcsz23vfcjqJD2j++ltWGb
         peffVNVGts7WXOfgJi/2dptWzKdsMGvyg+itPpnhRpO0/hj/T1dXFnSDVMWoyycHht3+
         GFC1s6NEkiwfR0QXZ9Es+IKcEhWteFlyreBY4mGdFzuw81AT1JVQ9BVWyEvFcTHkgWVa
         kz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiEdSYmJyAKWAqc7ui3XIZTznDZvFBWaDk4WF2mm3yA=;
        b=tEL8wZVJr9aDccRdYZScwm76wL5dUyI2XItj3oMlKKhBGCYSUgzOIIcuNeczoTDyzI
         hNEA8p8MZ2tA6xbDE/9HiUDAgNNZmrjn3Gmd3Febz/isqIuZ+tFk87QHxe+rOdrtVwR1
         1llGWL+jsAXOtLv9z8eLSgTTbZU07rR1KKTYrH96eYkF9YEIJ6WcleEw58+Vz7pxsqSa
         0nEuND5uhNM1HG+ioA0Fi5MLxtPaV0uZvIu4h3ThRhj5WX9RPNXQkLziJuak7uzPIA7J
         0M/QJpdJM6qiBEwOQA5W6B4sOH4Q1V5MJW5vZryAnz+cw6UFPSJKY0UQN+4jKsiqbeC7
         0rqw==
X-Gm-Message-State: AOAM531mSD+QYjBY+qrkvLbgMDwzQ33sa9dRfJ5JE1Y54ey3bg9S61fI
        7YaBkAzcQ8ZbLAG5JKURozI=
X-Google-Smtp-Source: ABdhPJxsRp72r/sEXZushQwODicy6txDdNbXADlfasQ0YwZfEqd1nrA21efVDrckpVqgvVS1sVerog==
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr2105184wmc.62.1640081607375;
        Tue, 21 Dec 2021 02:13:27 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id m21sm18012267wrb.2.2021.12.21.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 02:13:26 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     robdclark@gmail.com
Cc:     maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        maxime@cerno.tech, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/3] Add missing format_mod_supported functions
Date:   Tue, 21 Dec 2021 11:13:16 +0100
Message-Id: <20211221101319.7980-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When setting IN_FORMATS, implementing the
"drm_plane_funcs.format_mod_supported" function is mandatory to avoid
exposing a bogus blob.

This patchset adds a bit of documentation and fixes the issue in a
couple of drivers affected by the bug.

I reviewed all the other drivers and I didn't find more instances of
the issue.

Jose

José Expósito (3):
  drm/plane: Mention format_mod_supported in IN_FORMATS docs
  drm/msm/mdp4: Add format_mod_supported function
  drm/sun4i: Add format_mod_supported function

 drivers/gpu/drm/drm_plane.c                | 7 +++++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c | 8 ++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c     | 7 +++++++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c     | 7 +++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.25.1

