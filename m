Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3650B4C20B4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiBXAfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiBXAfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:35:13 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12C89EB92
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:34:39 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 132so318390pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vG/5kA9N04CwQy4bX0Kb6i3wWo0eXRHeMpuwd4x5Q/c=;
        b=jiBcPWY52X9e/uzNvYV2TiVy3I2p7YH1Aio3N86LL3F6hY5MTAQMANosqFD3oDYCbm
         pgoTOF75+LpesRgDwHVx00c6vatB+Z2rNe1WdvV0OHVVZbQb/7k6LvYYt0J9mWxi5Ezv
         iovAxNryPBhK2YpLzNMuk11LODuxTMATgAerI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vG/5kA9N04CwQy4bX0Kb6i3wWo0eXRHeMpuwd4x5Q/c=;
        b=reTy+Os+F4DATZr90xh+KvG1GdzPM6haKJ2ema3yRPkukCeCAV9F4HUeqjqR6YEuSb
         mDK6BXgEJum5pesN6LvB0wmFWgQ3Lmlt57pj4niEkriTheMlOxsdmQ2Bt9EgjdI6VyLo
         a6vU6NdBSIKYgGc6X4i+Wd0vwp12yoqLKyZs2d7ot5Ss1hJkxIHTNSWnsHZ7gYQyA1vl
         uwefTb7rOXIWh5Hxy+zNarQUEK9ZeWRgDKBQs9reB5QhCt2/O4gJ5//+lyyJdPUAKcIJ
         /+0f4aaXMQT5bFZWy82URrnoiNMMxd8PWPQvcky6H5CVK89GLCjgc4VBH6etcovGWrkW
         VN6Q==
X-Gm-Message-State: AOAM533ghT7GwztjUA9KQIfQpMsyF/BSbGteT9K84DuXp5GUQHlOz/tj
        Wi/yaM5WjtLvTLYX00uQti/q9JuSoAxoSw==
X-Google-Smtp-Source: ABdhPJzB30yXUg/ww0v2ftOzZv01+PA4tr9dDxl1M4WmeEwfAF4LbeQR2yIc+HYO7spA6z9bda51cQ==
X-Received: by 2002:a63:4d52:0:b0:343:8d41:eb12 with SMTP id n18-20020a634d52000000b003438d41eb12mr267178pgl.527.1645662879182;
        Wed, 23 Feb 2022 16:34:39 -0800 (PST)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:e321:1e1b:f71e:33c])
        by smtp.gmail.com with ESMTPSA id ms7-20020a17090b234700b001bc7e6fc01csm4100344pjb.40.2022.02.23.16.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:34:38 -0800 (PST)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH v3 1/3] dt-bindings: memory: lpddr2: Adjust revision ID property to match lpddr3
Date:   Wed, 23 Feb 2022 16:34:19 -0800
Message-Id: <20220224003421.3440124-2-jwerner@chromium.org>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
In-Reply-To: <20220224003421.3440124-1-jwerner@chromium.org>
References: <20220224003421.3440124-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3539a2 (dt-bindings: memory: lpddr2: Add revision-id properties)
added the properties `revision-id1` and `revision-id2` to the
"jedec,lpddr2" binding. The "jedec,lpddr3" binding already had a single
array property `revision-id` for the same purpose. For consistency
between related memory types, this patch deprecates the LPDDR2
properties and instead adds a property in the same style as for LPDDR3
to that binding.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 .../memory-controllers/ddr/jedec,lpddr2.yaml    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

Changelog:

- v2:
  - Updated commit message to fill in commit reference to earlier patch
- v3:
  - Added `items` specification with `minimum` and `maximum` values to
    `revision-id` binding
  - Updated binding example to preserve previous revision ID values

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index 25ed0266f6dd3d..e9d0936861b779 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
@@ -30,12 +30,26 @@ properties:
     maximum: 255
     description: |
       Revision 1 value of SDRAM chip. Obtained from device datasheet.
+      Property is deprecated, use revision-id instead.
+    deprecated: true
 
   revision-id2:
     $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 255
     description: |
       Revision 2 value of SDRAM chip. Obtained from device datasheet.
+      Property is deprecated, use revision-id instead.
+    deprecated: true
+
+  revision-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
+    minItems: 2
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 255
 
   density:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -164,8 +178,7 @@ examples:
         compatible = "elpida,ECB240ABACN", "jedec,lpddr2-s4";
         density = <2048>;
         io-width = <32>;
-        revision-id1 = <1>;
-        revision-id2 = <0>;
+        revision-id = <1 0>;
 
         tRPab-min-tck = <3>;
         tRCD-min-tck = <3>;
-- 
2.31.0

