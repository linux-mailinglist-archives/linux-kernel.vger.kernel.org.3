Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4F4A4DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbiAaSND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbiAaSMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:12:34 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2ACC061714;
        Mon, 31 Jan 2022 10:12:33 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z4so28620761lft.3;
        Mon, 31 Jan 2022 10:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gt6NZg0usi9i7zJRlo1gTWfjjBJm3GJXgR2jsJ1DWWg=;
        b=SKEqQkZtjM0lR8JE2205G7bt/hRClfuW6lv+1OJKnLaWnKjeNjNRXf5O7Pt94GCSus
         dAq0W2rCxEgflTsDhNa3PK2W+6Z48HCEqA1ucgwqFkiLafzVskaOYMASdXqzxT6Ep00U
         WLNwN1AwCEUuK/o3eTzE6J4jBUtArHA4H7Dw8uIkX1ZxDBQDxyBDZGxePJE8ESPs94Hr
         ljpVNKjKpJsPfpE3hpPIdTTCogkZPlCpAqsqiwJZWXMWo/4bOoyJ1HlCMbtigaYPC8oE
         XHvUVXwLIjCsJikqGgWqMM0lLloOuf/o+VsI3gkWex1NNvJ8zWMKdj9NGRnFrA0P22Ko
         +Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gt6NZg0usi9i7zJRlo1gTWfjjBJm3GJXgR2jsJ1DWWg=;
        b=luuSUGxQVE2BuWbLVPmOGJF7NroELHDeFqCk+4+lLDd8rf3/cBcdvhEPFKWwPp/lhf
         IuXWAt4ZU4oeBu6EbeUQsAbSr8UU+/lRkZP57hv1jht3fslB8ishJHxHAwkjCMY9HnPb
         o4PuM8HuAsjuJRxTH8FuHfI1aqjbw7mg4CT6j9oU8pLGGlwxznC3i7YbzFy4AzKeTap2
         QeEuCsQggXIwyxKAlC7ik8g0DovFhjQWVe2A2tq0y2h1yYR0qr/EbyV6UIfVyH12nTmS
         F/GNimq6lvuEo4LEmxWOmk1wAvsw7T8pNsmwGf1ZgSMeG4Cgd4RYhIxQ7sUkU19bjBTM
         Dkmw==
X-Gm-Message-State: AOAM532VjIywfcHsIzwA0T9+J43FteTX85Gz0ZSdP1cA4o/5rIlFrt6u
        yzBWi++Om7EaWhkYf9uij9w=
X-Google-Smtp-Source: ABdhPJxdagDD2HAb/bonm5f9mLZ2tjBJ/Hfhyz4zbxL6HgiHVkINrt4nt0EC65a7cyKJI3rmqyCCuA==
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr16913417lfu.115.1643652752185;
        Mon, 31 Jan 2022 10:12:32 -0800 (PST)
Received: from localhost.localdomain (109-252-138-136.dynamic.spd-mgts.ru. [109.252.138.136])
        by smtp.gmail.com with ESMTPSA id r17sm3391297lfg.237.2022.01.31.10.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:12:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: display: simple: Add HannStar HSD101PWW2
Date:   Mon, 31 Jan 2022 21:12:07 +0300
Message-Id: <20220131181208.27101-3-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131181208.27101-1-digetx@gmail.com>
References: <20220131181208.27101-1-digetx@gmail.com>
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

