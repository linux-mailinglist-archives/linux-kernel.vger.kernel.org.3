Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543984721AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhLMHYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhLMHYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:24:04 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6BBC06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:24:03 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 133so13763256pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fy5k8yE8yDlwkb+GY6CCP2a+YUXQgrQJLC8KuHhbb2Q=;
        b=DATYj17TVReiGSi4E29etVtdvTL/LgWXzBXg+QQgShCOhPUYB77ldyy8p5LzNDxF2K
         8oRNL4xse4F227LB5gF/9BfX3d6B8fvMpUEVMgBiAK3l4fW5EDzi143o6fcAlvKQiZYE
         RENrt1OUbvId/MiH0ZZXZIeZT9KrtTUqeK6gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fy5k8yE8yDlwkb+GY6CCP2a+YUXQgrQJLC8KuHhbb2Q=;
        b=q2cWhLOiENCKXn7Pnuyeiu7tY+oXhO3UEEnfcr0hCaVjSQcEKZn5lmpZNkv59HLlHV
         EaNUUvLoQiIRbxuAbY8525khEyuXsHC/NvvqLbxx62bYaColeXvL7kbYMzYWsR36rHot
         p6EMyQIQXiSal6qQNu4iF9VMjQe3wosh1Yq+DB8Gy0ZfXnA585Wc2pjY28h6m4E844XF
         oDIASBLUiD2jS1ibcrqJiyRXwPw0CzM/bvQb77/s/idpYOT0RGgLOk6LKUyMpm4ZaNLQ
         vw5ksyX0gm9Tz2bbKGrOfXLhAgXxmEQqMUqbRuFU8E82o7SR/GplIomzoiU0dAaJC+Uq
         VBmQ==
X-Gm-Message-State: AOAM5306lZFmJuMF223V/ZV4wIX+7YyJoG1zxL3VLAP931FaR1iFC4Mt
        +9NHtEbbNcTO6XR11CQE2SlrZA==
X-Google-Smtp-Source: ABdhPJz40B9wP5DLwEiavy0VCRvmROM6fMzQxHUEU08Oufmu9UTIfPTBQ0tHm+7PtOf51RtDCwz7wg==
X-Received: by 2002:a63:102:: with SMTP id 2mr304265pgb.311.1639380243478;
        Sun, 12 Dec 2021 23:24:03 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9447:edff:ad23:1bfc])
        by smtp.gmail.com with ESMTPSA id e7sm11747562pfv.156.2021.12.12.23.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 23:24:03 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-makomo
Date:   Mon, 13 Dec 2021 15:23:55 +0800
Message-Id: <20211213072355.4079568-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211213072355.4079568-1-hsinyi@chromium.org>
References: <20211213072355.4079568-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makomo is known as Lenovo 100e Gen 2 Chromebook.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../devicetree/bindings/arm/mediatek.yaml          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 75bb06d1802a08..49e008faaa68a6 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -191,6 +191,20 @@ properties:
               - google,kodama-sku32
           - const: google,kodama
           - const: mediatek,mt8183
+      - description: Google Makomo (Lenovo 100e Gen 2)
+        items:
+          - enum:
+              - const: google,makomo-rev4-sku0
+              - const: google,makomo-rev5-sku0
+              - const: google,makomo
+              - const: mediatek,mt8183
+      - description: Google Makomo (Lenovo 100e Gen 2)
+        items:
+          - enum:
+              - const: google,makomo-rev4-sku1
+              - const: google,makomo-rev5-sku1
+              - const: google,makomo
+              - const: mediatek,mt8183
       - description: Google Willow (Acer Chromebook 311 C722/C722T)
         items:
           - enum:
-- 
2.34.1.173.g76aa8bc2d0-goog

