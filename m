Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4184A3C04
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347877AbiAaAAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244160AbiAaAAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:00:03 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A0DC06173D;
        Sun, 30 Jan 2022 16:00:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id n8so23367239lfq.4;
        Sun, 30 Jan 2022 16:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gt6NZg0usi9i7zJRlo1gTWfjjBJm3GJXgR2jsJ1DWWg=;
        b=IwMIj11XRdyOZVoWV2D7URI46/yngh8kyxEDc+0Hs+tZcFTsE1oxq6aZP2dhOA7GPP
         q0iGMRWPnDHSJajhDy0O5sym2zcmOdUkLqPZsPvFoalQGnGz2+r9BungeDTZgTaIBAJe
         xGeQzbAX1nGmaKuqHdgV+F8HcWxTMpyfwjIjfaCyYPMDv3UM7PdzuZds2mTlcQYBwo29
         FuCR2MvVyKuzJuqyahWolGMT4XUJNOpml7AnvUz3hsYFzrTmX/a8ttQb7dFZtugNAWxC
         h/jlO+yksLgEc8sZDEwd7V+HUJpETZqdTGkzve6JXshIbGzsxfo2SCsAIbGCjCp5EqBd
         5ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gt6NZg0usi9i7zJRlo1gTWfjjBJm3GJXgR2jsJ1DWWg=;
        b=ne5qADVn5EDiisRlHT5Pmw9lYV3s8K6ubdSdBqj4m2+9MuPyGbcPU7aFvRoMQTzVRd
         OoWGPzbSKgA23Jab6iFoEQdlJ+Ii9R3cFeYA8g4UDSlKeILbasM0k48saRdUTqxYvM9d
         DmBcwuiFGXaa6p0VIhCogDJHOwzRyExuj9qfE2bqp3d/G0ESJ+paEr3C3OlzUWXOdXEu
         X9Dwij8RG3YsuP8TpbbC1j/ISBsx0BV1FbVsJyPm8kQQ/dgArSCCczhRQZZdlFPQGe9t
         Nomg4zN83AeYJgdxWe6lZ4jS8nos74Sw8vTontqKARp26cSq7EXbCwyGARz9TeSSZUlk
         ZqMA==
X-Gm-Message-State: AOAM530PF8N4cNZtuDt2Glqb3tYN0i5MXoRQADT2dv6mSimQkI4/7uYP
        7WemGXd503XjbETogxDDD6I=
X-Google-Smtp-Source: ABdhPJzjeQq0P/qp8/N27QAvzEUtfO6JllRIy0CzH2UyXMTJNF2yY2qDKxJvCMqm7orweoljFITfUA==
X-Received: by 2002:a05:6512:2612:: with SMTP id bt18mr13504520lfb.255.1643587201377;
        Sun, 30 Jan 2022 16:00:01 -0800 (PST)
Received: from localhost.localdomain (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id e7sm3443193lfb.17.2022.01.30.16.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 16:00:01 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: display: simple: Add HannStar HSD101PWW2
Date:   Mon, 31 Jan 2022 02:59:44 +0300
Message-Id: <20220130235945.22746-3-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130235945.22746-1-digetx@gmail.com>
References: <20220130235945.22746-1-digetx@gmail.com>
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
index 62f5f050c1bc..fe49c4df65fa 100644
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
2.34.1

