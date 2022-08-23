Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4859E946
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiHWRXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242224AbiHWRVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:21 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB82753B8;
        Tue, 23 Aug 2022 07:57:35 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so635538oth.10;
        Tue, 23 Aug 2022 07:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SoxR8vPzLaBakuJXKDdianHW1mSlEURniSqJ7NDAlUg=;
        b=vEC9XB7LPFGWWtwVJBlVoGtQ8ysJWKOvKUXOC62xnCSCbs4PIXAEKW1hbNpMqmjdWy
         AIIQiEmdJ1/cyectG26rUckgKWj5A3OHHwjhI4+mpu1luEuPjMICpLrDNZQHGbFmTgVp
         YEMga5V8HXXpqOSLtwUfjkHLztFikISj/GCwb7n9YVbbJp9GAR0Awh+HiWxlyZ8Isrzb
         dZZTr9HT9M/YchzrJVBfPHNtfXylu4ULE8fOeVM4sCBppHSelXN3vEZHFBGMeVTxTJCn
         dxZ7lCeOlo+5mRNHn6+TwcMWwLcZOGWDAKkWAqwIiESCUBwRj6fHys5FEU9ZCRwdNdyV
         H+7w==
X-Gm-Message-State: ACgBeo1INKM1xkr+k43eBoP302Vz2vhTFOU8i5o1Yn+a/H7KpDUR8qyD
        8cmqeNNv+WqkKe1KTFdfUA==
X-Google-Smtp-Source: AA6agR5N7GHMyhg7l4FvWbI4JGFC1eej18e7AwJEywr4KeELvJ0Jqd/978BcWS1D2O0v3c+0E/EU2w==
X-Received: by 2002:a05:6830:2646:b0:638:b172:92d5 with SMTP id f6-20020a056830264600b00638b17292d5mr9226824otu.75.1661266654515;
        Tue, 23 Aug 2022 07:57:34 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: adi,adv75xx: Add missing graph schema references
Date:   Tue, 23 Aug 2022 09:56:43 -0500
Message-Id: <20220823145649.3118479-12-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings using the graph binding must have references to the graph
binding schema. These are missing from the adi,adv7511 and adi,adv7533
bindings, so add them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/bridge/adi,adv7511.yaml       | 14 ++++++--------
 .../bindings/display/bridge/adi,adv7533.yaml       | 14 ++++++--------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.yaml b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.yaml
index f08a01dfedf3..5bbe81862c8f 100644
--- a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.yaml
@@ -117,23 +117,21 @@ properties:
 
   ports:
     description:
-      The ADV7511(W)/13 has two video ports and one audio port. This node
-      models their connections as documented in
-      Documentation/devicetree/bindings/media/video-interfaces.txt
-      Documentation/devicetree/bindings/graph.txt
-    type: object
+      The ADV7511(W)/13 has two video ports and one audio port.
+    $ref: /schemas/graph.yaml#/properties/ports
+
     properties:
       port@0:
         description: Video port for the RGB or YUV input.
-        type: object
+        $ref: /schemas/graph.yaml#/properties/port
 
       port@1:
         description: Video port for the HDMI output.
-        type: object
+        $ref: /schemas/graph.yaml#/properties/port
 
       port@2:
         description: Audio port for the HDMI output.
-        type: object
+        $ref: /schemas/graph.yaml#/properties/port
 
 # adi,input-colorspace and adi,input-clock are required except in
 # "rgb 1x" and "yuv444 1x" modes, in which case they must not be
diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml b/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml
index f36209137c8a..987aa83c2649 100644
--- a/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml
@@ -91,25 +91,23 @@ properties:
 
   ports:
     description:
-      The ADV7533/35 has two video ports and one audio port. This node
-      models their connections as documented in
-      Documentation/devicetree/bindings/media/video-interfaces.txt
-      Documentation/devicetree/bindings/graph.txt
-    type: object
+      The ADV7533/35 has two video ports and one audio port.
+    $ref: /schemas/graph.yaml#/properties/ports
+
     properties:
       port@0:
         description:
           Video port for the DSI input. The remote endpoint phandle
           should be a reference to a valid mipi_dsi_host_device.
-        type: object
+        $ref: /schemas/graph.yaml#/properties/port
 
       port@1:
         description: Video port for the HDMI output.
-        type: object
+        $ref: /schemas/graph.yaml#/properties/port
 
       port@2:
         description: Audio port for the HDMI output.
-        type: object
+        $ref: /schemas/graph.yaml#/properties/port
 
 required:
   - compatible
-- 
2.34.1

