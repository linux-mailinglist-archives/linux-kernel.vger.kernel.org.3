Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D7256FF82
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiGKKvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGKKvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:51:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E42B5209
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:57:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w185so4348877pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fY/cD5RyDbPMC16zL/4fjstRGOrtcZDiECJwfvZbXo=;
        b=m/z4oAXPcVCiAj03EYjCD7HgTnrAcQcfMT5Tu7oYB1Lb0CyjF/1GzJDYCblblGRIvs
         XrRZpCLRkefOfXzdhNdJ9mnOdl5U5jdc4HAHi3uMzTj9WOE2dBztlGDe9Pa9NFx9OojJ
         cLo7jbARrZH5/SJjoSWZRpZo54LuEX8oagi8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fY/cD5RyDbPMC16zL/4fjstRGOrtcZDiECJwfvZbXo=;
        b=GH9WFRg6V/j40V7VB4cxChzTq1Xk3580OBlbrTpUgXdK5vHGAvKfOUEPnpA0juREAp
         y5M+7OQ1BrZcko35JoST4aXqCyGgxWwh5qpY3PrWogJPM9beezZcFnDU1GlXCKFCdyo4
         +ZrnbjCmGWOiWGy8JMVp3izynESQiTGvjxr5s2N+qkdLGG+zfH7x8oCJ2WNqUAOqd++x
         kqbKemdpqvvt6jpWfSVfHiscl2AejEE/C/+NDN6rJj+Iqbc/m/jbftgR8DlggOpgcl2C
         vL8vGUNIvQr/qJn/g2yy3IZhLG2wVLX2+U8/rFUN8R587ngtTwfsObqTq4aFCpPxDDi7
         dcqA==
X-Gm-Message-State: AJIora8C9X88xyn+uICLnwqAwo9wnT32kBl4k/i5dWMO1GfYlTkzcfOw
        SCQz8lS7Z7DabJpMa7i+gf1K0g==
X-Google-Smtp-Source: AGRyM1u7q92IK+OSS1YolOtVcQvJjMLfup+akgRA/a14mGGcYqsDkd4e5+gLPuID5zltApnZq7LgYg==
X-Received: by 2002:a63:b443:0:b0:40c:fbf9:8366 with SMTP id n3-20020a63b443000000b0040cfbf98366mr15206295pgu.308.1657533461057;
        Mon, 11 Jul 2022 02:57:41 -0700 (PDT)
Received: from localhost.localdomain ([183.83.136.224])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a390300b001ef81bac701sm6560814pjb.42.2022.07.11.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 02:57:40 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Christopher Vollo <chris@renewoutreach.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-amarula@amarulasolutions.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: sunxi: Add binding for RenewWorldOutReach R16-Vista-E board
Date:   Mon, 11 Jul 2022 15:27:20 +0530
Message-Id: <20220711095721.1935377-2-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711095721.1935377-1-sunil@amarulasolutions.com>
References: <20220711095721.1935377-1-sunil@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the RenewWorldOutReach R16-Vista-E board based on
allwinner R16.

Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Christopher Vollo <chris@renewoutreach.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
- As suggested by Samuel Holland:
- vendor prefix documented
- primary author of the commit should be the first signer

Changes for v2:
- Add missing compatible string
- insert missing signatures of contributors
---
 Documentation/devicetree/bindings/arm/sunxi.yaml       | 6 ++++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 95278a6a9a8e..52b8c9aba6f3 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -787,6 +787,12 @@ properties:
           - const: allwinner,r7-tv-dongle
           - const: allwinner,sun5i-a10s
 
+      - description: RenewWorldOutreach R16-Vista-E
+        items:
+          - const: renewworldoutreach,r16-vista-e
+          - const: allwinner,sun8i-r16
+          - const: allwinner,sun8i-a33
+
       - description: RerVision H3-DVK
         items:
           - const: rervision,h3-dvk
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6bb20b4554d7..f5cd0acb1036 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1030,6 +1030,8 @@ patternProperties:
     description: reMarkable AS
   "^renesas,.*":
     description: Renesas Electronics Corporation
+  "^renewworldoutreach,.*":
+    description: RENEW WORLD OUTREACH
   "^rex,.*":
     description: iMX6 Rex Project
   "^rervision,.*":
-- 
2.25.1

