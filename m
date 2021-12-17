Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F15479234
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbhLQQ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbhLQQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:59:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF010C06173F;
        Fri, 17 Dec 2021 08:59:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso1949713wme.1;
        Fri, 17 Dec 2021 08:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAdQHmcxXJRdSaN4NZqNsTb5GeS4QMgyYMJbKis0ZM4=;
        b=MXZX7bj2HV6urtBpIAD/q393zakFtZvmE1pzmdz4NiOCOB18rJnf+KEWnyD3p2AWx5
         4HmzREIUQWCGjMbYeuZW5cbEl1SAx+oOys15lMDlREf2XZLBVRY0BqOGKbG2f8ITLwDI
         V5ktaMmXZUNZ5p2QHchSMMZ5j37xpcrD7nswbWjIidptamf8azrM1hzRu6yrSwZyWExW
         fpaOgSU0lk7JQapErC2mTOQ91ZscpNi4Y2kCEBgnHI4yRGYQCsuvlnTGo5SBz1h9u8hH
         BZYfT9vUw+c2rjQndeaiJHZI6JGnQD3eYn97eF3FJZvs08/THi7wdrpSUZ6r6+hN6cu8
         5xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAdQHmcxXJRdSaN4NZqNsTb5GeS4QMgyYMJbKis0ZM4=;
        b=vgoOyi/6/IM1ZExGTvZrItwxjNnBGtFWNJziMPbsVoiTST810vNK+IIG8+XPDorNJb
         MBb2tBkCA67wZaKhzCHG7fp1hj6gstCS8aaM8L81uWQCwwvZ9pLv9yUEQElnghSmtOOL
         21hwlK31m0mVrrIgptowp1intH/LVwhiJn447nBiQZzYB8Jo5PMnSdYIJIYB/rCfjvEo
         2Hcgd/RPGohmMjM+xiAPv23A0VWYRMO4vbv5K56r6ncTkJbQcIuxL8KbxomcJ7LeK+yh
         nZvGql8SVNXp86wUuvINlQqsjD0riD7KlkGLGjh6S7cVTGbTUJ41WhFGdV+7ZpiGuHaQ
         QJrA==
X-Gm-Message-State: AOAM531/7pWD6g72HoPIStu5/jNCAnLhR4MNq21TY5MXwdxUwbYHHJ3I
        iHoqu6zgKO/vONAZeN9iigc=
X-Google-Smtp-Source: ABdhPJwYovI0k+5flN+Sv+3NYUj+Z5Suv3NUMSNies4QrfLOejlbTPTVXYci7OCqbP8HQT9wsZpk8g==
X-Received: by 2002:a7b:cb51:: with SMTP id v17mr8705440wmj.185.1639760368390;
        Fri, 17 Dec 2021 08:59:28 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id m6sm10264243wrp.34.2021.12.17.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:59:27 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: memory: tegra: Fix Tegra132 compatible string
Date:   Fri, 17 Dec 2021 17:59:18 +0100
Message-Id: <20211217165919.2700920-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217165919.2700920-1-thierry.reding@gmail.com>
References: <20211217165919.2700920-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

While the memory controller found on Tegra132 is largely compatible with
the one found on Tegra124, there are some differences that may require
more specific matching on a Tegra132 compatible string, so add one to
the list of compatible strings.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/memory-controllers/nvidia,tegra124-emc.yaml    | 6 +++++-
 .../bindings/memory-controllers/nvidia,tegra124-mc.yaml     | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
index 9163c3f12a85..90666e8d2de7 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
@@ -16,7 +16,11 @@ description: |
 
 properties:
   compatible:
-    const: nvidia,tegra124-emc
+    oneOf:
+      - const: nvidia,tegra124-emc
+      - items:
+          - const: nvidia,tegra132-emc
+          - const: nvidia,tegra124-emc
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
index 7b18b4d11e0a..887917e02bfa 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
@@ -19,7 +19,9 @@ description: |
 
 properties:
   compatible:
-    const: nvidia,tegra124-mc
+    enum:
+      - nvidia,tegra124-mc
+      - nvidia,tegra132-mc
 
   reg:
     maxItems: 1
-- 
2.34.1

