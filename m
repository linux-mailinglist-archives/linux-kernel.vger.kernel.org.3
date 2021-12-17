Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4E9479239
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbhLQQ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbhLQQ7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:59:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FB5C061746;
        Fri, 17 Dec 2021 08:59:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o29so2065512wms.2;
        Fri, 17 Dec 2021 08:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFHoQPOrbV6E0S61sp0iENhRWxLWfzEEYHIRAwtb27w=;
        b=LTRIldyNB62poDhP4+555c0Gp8yEd3nIJemwakeK+eB1hYwlAey3xvYAej6umEpWlY
         /2rhUFYfz6uXMOEKxC0R67Khu+1qYbsK/JThPIu9blSmwI07Kd6nWPH5ZCSp6xvNcCKX
         npoV3oBxrWhYT7lV3C7UwRV0EaNayGnp89H000YhFfZu++9dn7h3VKjgzFSes5OYMOu6
         BWHobu1/VuzCyvwMxcsshtg4ivfNGQGrG276SJUelvfYclajV64YBdsOtdBd67ds9dc3
         6cJUev8j7uq8r9jofX2q+FJf8v7X1+fwUKB7pDmdKkyYCa6/4mD9DDFu2juhhkjTSdec
         rqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFHoQPOrbV6E0S61sp0iENhRWxLWfzEEYHIRAwtb27w=;
        b=VhwndRUNr9yfQqxQ0USToTLCFNMiuD/snXfcIgvoXEdYGI7Kz/QPMTztBOeEp4IWWD
         zDzqSvaSADRMmEAinfRnYKbbxF5jdpf9XIdxXobNzit4JNUoB2BdGXQf84VSzpWGab1s
         xI9WnOKyO+BRQPEloXA4in2th7UEecWRzSnkjjdf0vvO9rhQLHlIY3sd2bHsV8RQ93Do
         Bqw3e3OVvWefuOpu7eieJ6QsDSQXh87bwcYYh3kfN1AuY6G2FS/eiE17vUY0hxjh2eUe
         DtXM/5MXxQ/n4+kX2r/oq01JCsg1uF97M+F3vTH5zV/COH2bQC8R8mXMCbshiMCpTcsX
         LgGw==
X-Gm-Message-State: AOAM532mHoMmJBFkdFyPqWQ0tvcsXPeteNBHc2qmqBeOF32JOLXW38v0
        dUyAJfp3HiixiEnIywCP09w=
X-Google-Smtp-Source: ABdhPJzXXneTut0iRLJDi7+nLqEKV8Tl49rdcNwK7q3KKgYJK3L0zJ2sXWk7DiolnQr+N/9dh2DV1A==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr3457837wmq.111.1639760371336;
        Fri, 17 Dec 2021 08:59:31 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id t11sm7543851wrz.97.2021.12.17.08.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:59:30 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] dt-bindings: memory: tegra210: Mark EMC as cooling device
Date:   Fri, 17 Dec 2021 17:59:19 +0100
Message-Id: <20211217165919.2700920-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217165919.2700920-1-thierry.reding@gmail.com>
References: <20211217165919.2700920-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The external memory controller found on Tegra210 can use throttling of
the EMC frequency in order to reduce the memory chip temperature. Mark
the memory controller as a cooling device to take advantage of this
functionality.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/memory-controllers/nvidia,tegra210-emc.yaml  | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
index bc8477e7ab19..95c14deb8941 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
@@ -44,6 +44,11 @@ properties:
     description:
       phandle of the memory controller node
 
+allOf:
+  - $ref: ../thermal/thermal-cooling-devices.yaml
+
+unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -51,8 +56,6 @@ required:
   - clock-names
   - nvidia,memory-controller
 
-additionalProperties: false
-
 examples:
   - |
     #include <dt-bindings/clock/tegra210-car.h>
@@ -79,4 +82,5 @@ examples:
         interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
         memory-region = <&emc_table>;
         nvidia,memory-controller = <&mc>;
+        #cooling-cells = <2>;
     };
-- 
2.34.1

