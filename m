Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71F74BC484
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiBSBU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:20:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiBSBU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:20:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBE31451CD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:20:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so13802147pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Lj6YX7FRkv3bs+GJXuZJxzDwnOwlM3IinhEgHw4XZw=;
        b=HrTqeMzkOeddI4nLvtfvWYkYVZH7pUGm2Y3tDGKpvNGtyvKgK7N9WiuUKu7FRu3Vkz
         pNh/6/PHWCo9zDjdo/VyhkCzGS+Q+tnVYX8W8OdXkCyCrVR1yeUWCxRXkQU2U4jkoDlc
         NWnxUVaCHwDlP//jkVd3s/AJmtET4MjgKUfO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Lj6YX7FRkv3bs+GJXuZJxzDwnOwlM3IinhEgHw4XZw=;
        b=oyEGY59Zwi3sPoB5HI9owEPqUPNc0tUi3WrkLLICccLfkRHapDSPnEFjxNaw6fPHqg
         un7aB6uqGPgDtONf+RT5RXL2e9d3fYHGi2dsfNKo5gkGc0NhfEkZfo18s3M9zBQQvxd5
         aCqz3e73g5J/ceMMiM0xuBuJ5m8D3V1UElM0zcS8aErP3HPwaTCeI7CErWPmlqKwxku5
         ONtZ1L6MzP4v0T3W9zTIxqMiIGcGrlPNsSAf1K7tYQGbzM/HYYD5mUpQmBt+Firm4LNZ
         LVvfNDmMmVRiJJz96VD0DvFQJsUcuFCW3pKZf3dD8ktXhOIEbk7g1Kh586+ZRj1FCoOc
         Y9bg==
X-Gm-Message-State: AOAM53013kuQSyh7OkGOoukGKaR+dZlpQQ7nwf8lWSVNURNZtGDSJ1FG
        zyjFjv9GzxFDWN30Gt86aWPHKw==
X-Google-Smtp-Source: ABdhPJy6xXRVgXghCn/2tizJ4qCsDOqDWj7clCWwB2FkX/Hh0jpyIgWEaLNnLb/o7oqWsdRq1D9kkw==
X-Received: by 2002:a17:90b:3ec2:b0:1b9:fbeb:942b with SMTP id rm2-20020a17090b3ec200b001b9fbeb942bmr15026530pjb.55.1645233637899;
        Fri, 18 Feb 2022 17:20:37 -0800 (PST)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:90c7:ea9e:6907:5ea9])
        by smtp.gmail.com with ESMTPSA id gk11-20020a17090b118b00b001b8c8cfdca2sm494549pjb.20.2022.02.18.17.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 17:20:37 -0800 (PST)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH] dt-bindings: memory: lpddr2: Adjust revision ID property to match lpddr3
Date:   Fri, 18 Feb 2022 17:20:25 -0800
Message-Id: <20220219012025.2887724-1-jwerner@chromium.org>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit XXXXXX (dt-bindings: memory: lpddr2: Add revision-id properties)
added the properties `revision-id1` and `revision-id2` to the
"jedec,lpddr2" binding. The "jedec,lpddr3" binding already had a single
array property `revision-id` for the same purpose. For consistency
between related memory types, this patch deprecates the LPDDR2
properties and instead adds a property in the same style as for LPDDR3
to that binding.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 .../memory-controllers/ddr/jedec,lpddr2.yaml       | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index 25ed0266f6dd3d..37229738f47271 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
@@ -30,12 +30,23 @@ properties:
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
+    minItems: 2
+    maxItems: 2
+    description: |
+      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
 
   density:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -164,8 +175,7 @@ examples:
         compatible = "elpida,ECB240ABACN", "jedec,lpddr2-s4";
         density = <2048>;
         io-width = <32>;
-        revision-id1 = <1>;
-        revision-id2 = <0>;
+        revision-id = <123 234>;
 
         tRPab-min-tck = <3>;
         tRCD-min-tck = <3>;
-- 
2.31.0

