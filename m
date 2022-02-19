Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8256B4BC48A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbiBSBZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:25:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiBSBZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:25:21 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652DE1DE90A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:25:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s16so9249968pgs.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CclG3ETfwpMiafnLAC+C/g4F0uYLllqSLmjIX1kNOrY=;
        b=HhKeDGkzTdMv9cvBWKHL5Vw+bO6sTag+TZ5lJgaK8HmmqzGse0As/UN5csfPzjBoiL
         NOD9d/+VCQ85dYbGDGSzcTIGl2ZNxgt74Emmvn6+8bSxYpSvHoD+X09f6H2XS4MdexJZ
         xB/FNQhaC/Dnlaw88AiBiUXl8yOok7JBaajVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CclG3ETfwpMiafnLAC+C/g4F0uYLllqSLmjIX1kNOrY=;
        b=2jenGNfcy2XR86YNS9YMAbWxxBjsXEEzr/7gzBMMKg8Bb0qb6OG6603ARfDhYGqmwa
         K5pTrBDdLuCw/F8wUI4RwzSYhZZ2iyNBLA4LgbGWy4fLuSXdTVvPPx0kn4cpgDE8ITSG
         ExppgIla5YulA240v7UxOVJiG38dTEtMZ67I9JK28CuHzCR0OMunzM+RrJ1Z16iVu54p
         cokyJlPASlfM+Jf5SsLOY1KFl9ffjeUNRAhwPdwzWjwiqYn+WT5n/cEPtiMQU/5RMvdr
         W7JAEGwN9DIi3P7/SwBLlxA57g64U466NP7vltYRDPat30i1umXSX0m62XLIrsfa9NhP
         IVWA==
X-Gm-Message-State: AOAM5335jSt5Cd1/VLVv5zyE+XbeeJeOtF5U8jjuz2Rujov8eny6+3MQ
        AyZSf1qtT10F3PCVoEZ/24c7/w==
X-Google-Smtp-Source: ABdhPJwVXKoa3iVfulrG1u4OWGPwFpo9GQJy63j7ET4K2+sD/0DMxFduREoulHsjdf33dILTI40Orw==
X-Received: by 2002:a63:4a63:0:b0:373:a03a:8a1d with SMTP id j35-20020a634a63000000b00373a03a8a1dmr8120313pgl.460.1645233902910;
        Fri, 18 Feb 2022 17:25:02 -0800 (PST)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:90c7:ea9e:6907:5ea9])
        by smtp.gmail.com with ESMTPSA id j5sm357074pfu.185.2022.02.18.17.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 17:25:02 -0800 (PST)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH v2] dt-bindings: memory: lpddr2: Adjust revision ID property to match lpddr3
Date:   Fri, 18 Feb 2022 17:24:57 -0800
Message-Id: <20220219012457.2889385-1-jwerner@chromium.org>
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

Commit 3539a2 (dt-bindings: memory: lpddr2: Add revision-id properties)
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

