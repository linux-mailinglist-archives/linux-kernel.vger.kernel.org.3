Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADCE4716D0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhLKViJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhLKViH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:38:07 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C4EC061751;
        Sat, 11 Dec 2021 13:38:07 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m6so12369452lfu.1;
        Sat, 11 Dec 2021 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8C2Ox9mLAi+48xHMMaxUeraFYeN7fBArVOxNr3R0I8=;
        b=QaE2nnf/2Ogb8IBsN2aGR8hcuFjn0C/bwIbtDK1cUUTuEY5/wc1Iz6l6z7uz9laLd+
         Tlt3ezJN1y3dbA05wlBAHptRCt4J4uBd30PJtIdG3Sk1B3mzlEoAEeg9EI9r8KtJ5k/7
         y1SbuRSUc9ppr7NLH33eq75WmPCffemZ5Ad0pbK9ZNBM838m/rUWtspvYCmGBta8z0wf
         aAEFg+8YxnRUllhNcQ7Bu6Usgk9D+OHcDCyHudYHpvIkXMgyuaSgt25azzVe16k+Q6xF
         jeZ4j6H0xYEKRXmCJK0Tuug9KZO3GjX887WSAh5TP7TYIzLdh2m0ffyqG15OlUFBMK1o
         UBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8C2Ox9mLAi+48xHMMaxUeraFYeN7fBArVOxNr3R0I8=;
        b=uH9GnxfAipr0g2AECuIkJGS9W1BJvWTnu8wwOqnM8ItKhv+UXNYel09CkQI8tmAvJD
         mn/S6sJm3imloRAG+I8shr2Yf1xWqMnV96PkFGTF+uguWsuxjVug9Tti838MnLra05uS
         vy8kaSAsoiKuKOW2TxqZQRDfbJINSPtgoaSMirU9IDxMQz5UXAHIsa6xRH/HTH5P1LzC
         vkrKPDvBf1fbXwJpZKKMWoellQ+8VdIWPLmMQFITMYhQz1gbIZhjh9tEtqbRwM1OF8J1
         yLzags2+Ct+vuTLgdgUSLC5gw0T/i6fB1A7PJW8ZZU7Bxmp0D4CTBzuVdbIp6D+8VFvm
         qleg==
X-Gm-Message-State: AOAM533R790KPdi6mwTwtLXonMDVlKa963L6ly8rl74g9mMHzbxiWfH/
        abzJgb1p3mVOSWn88Gi9PEI=
X-Google-Smtp-Source: ABdhPJzzQaET53q/FDFQJ9CyBQfgCK/ECu+LJ6oDv/04jXNG6kWMXPjoDGISTC/hUXs0JaRT+NWkGA==
X-Received: by 2002:a05:6512:3185:: with SMTP id i5mr18737901lfe.341.1639258685583;
        Sat, 11 Dec 2021 13:38:05 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id w14sm786844ljj.7.2021.12.11.13.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:38:05 -0800 (PST)
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
Subject: [PATCH v2 1/3] dt-bindings: sharp,lq101r1sx01: Add compatible for LQ101R1SX03
Date:   Sun, 12 Dec 2021 00:36:51 +0300
Message-Id: <20211211213653.17700-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211213653.17700-1-digetx@gmail.com>
References: <20211211213653.17700-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Bambura <jenneron@protonmail.com>

LQ101R1SX03 is compatible with LQ101R1SX01 from software perspective,
document it. The LQ101R1SX03 is a newer revision of LQ101R1SX01, it has
minor differences in hardware pins in comparison to the older version.
The newer version of the panel can be found on Android tablets, like
ASUS TF701T.

Signed-off-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/display/panel/sharp,lq101r1sx01.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
index a679d3647dbd..9ec0e8aae4c6 100644
--- a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
@@ -30,7 +30,12 @@ allOf:
 
 properties:
   compatible:
-    const: sharp,lq101r1sx01
+    oneOf:
+      - items:
+          - const: sharp,lq101r1sx03
+          - const: sharp,lq101r1sx01
+      - items:
+          - const: sharp,lq101r1sx01
 
   reg: true
   power-supply: true
-- 
2.33.1

