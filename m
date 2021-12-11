Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8F4716D6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhLKViQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhLKViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:38:08 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C1C061714;
        Sat, 11 Dec 2021 13:38:08 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b40so24137947lfv.10;
        Sat, 11 Dec 2021 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9cbSD0n7UkiGS9/Kt4+Mg/mlrW7rIQ8OPKpNN0HsBs0=;
        b=mUIzrz+TnolWe2p3gaMz28V5YhGUucp69yNWFSAVRz/SeSyGbV/EZRawLZTmoy/Lha
         5Mv0+nINyKcTogdjnEJZvO+8/nR5k4E3Fe5w5vXounCCgsYWZlH4LjLmHPQUmu/dNg59
         /zZFy6Pij/F8jEks7duf4VAim3VZ8zYg5+/lh9lLsTSqYK82YatFP0NcgLBtzBHKzxUd
         qvYciCyC8RESc92gNAO7XfGZnlS1QtyZISwSEW7slibt4qaZ7xG/Px3/rU+H38v9QCMF
         D4FygNxIsSRdLjKa6g4yIcZjVIvOCAmKFNkj88Ro35spUBBsy9vPSotTQpTzOKDd4Iqd
         2T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9cbSD0n7UkiGS9/Kt4+Mg/mlrW7rIQ8OPKpNN0HsBs0=;
        b=zdXk57knPyIFZfwmZV5vPgTzFduyvipnAh0EDRmNdolkydht1jLEjPL4eEAz1Ye3vd
         DufAGwKzzGqK/QH8is9zGlvTkRLsz1jogkjkVz7NfyfVdFMtHnXGN7lyNtyinMgqSJTs
         ayEVUjRHpJ5sxKbgGBZMuCMwA1Hh20wNhIQls1X3CRXKDcdQdd85zPWMdNcobxshj6Y6
         ujOPEJt+2Afk4KXSg0H/Coxyokkj1SGRFwQ8VEeiSEUfhuT9cs4c+cy+dLi+ZWgqh5Ee
         lQD1h8nAah6lANniSvIisOxskaTVTcvnk6KeH/pTRlQIONVQ6LJXqEs6mkuyWaqXgv/y
         vNjA==
X-Gm-Message-State: AOAM532sn5dxiXz4viOeYKwIlhVatp5jLVC8llxSBSEU3i7XgZ6kWL6v
        RgmB5+iAYMsNjdYPBvsm1kg=
X-Google-Smtp-Source: ABdhPJykkoZWZcLnXR5dIqNSNBzj40yRLsyWVWz5Fj+XnDeWPuf7zB7DeJQXztOK9DtJIQ+NyJN5Lg==
X-Received: by 2002:a05:6512:3213:: with SMTP id d19mr20107074lfe.519.1639258686323;
        Sat, 11 Dec 2021 13:38:06 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id w14sm786844ljj.7.2021.12.11.13.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:38:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: display: simple: Add HannStar HSD101PWW2
Date:   Sun, 12 Dec 2021 00:36:52 +0300
Message-Id: <20211211213653.17700-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211213653.17700-1-digetx@gmail.com>
References: <20211211213653.17700-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Svyatoslav Ryhel <clamor95@gmail.com>

Add HannStar HSD101PWW2 10.1" WXGA (1280x800) TFT-LCD LVDS panel
to the list of compatibles.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index f3c9395d23b6..ecb9a79c2e78 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -156,6 +156,8 @@ properties:
       - hannstar,hsd070pww1
         # HannStar Display Corp. HSD100PXN1 10.1" XGA LVDS panel
       - hannstar,hsd100pxn1
+        # HannStar Display Corp. HSD101PWW2 10.1" WXGA (1280x800) LVDS panel
+      - hannstar,hsd101pww2
         # Hitachi Ltd. Corporation 9" WVGA (800x480) TFT LCD panel
       - hit,tx23d38vm0caa
         # InfoVision Optoelectronics M133NWF4 R0 13.3" FHD (1920x1080) TFT LCD panel
-- 
2.33.1

