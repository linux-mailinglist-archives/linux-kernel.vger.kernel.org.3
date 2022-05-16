Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B1528D29
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344952AbiEPSfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbiEPSe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:34:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82363D4B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:34:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i8so1329848plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbcqJhLKUQMd1zX04qmN/h9JWdXhbynT494ZfNvmvHI=;
        b=JHvd/4EDPlvORXuvcnRpxz6E8Dl2ao3R74+2vUHVT0fFbmyaXiotuFAJZGrp0gBMQu
         t5Ll7s6BV8CemJhL7bdyBnaK9cnr0Mc8HpZpfiLuAJ/hMdBGR18vlsRrFEj8ryJKreos
         cC7fC0jrlpoxvSb0jaiP92UbHzS087j0Fdn2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbcqJhLKUQMd1zX04qmN/h9JWdXhbynT494ZfNvmvHI=;
        b=tt1+K8Agci9r3PTDKmNg9YRrHEI73ihYtYN/8l/u9Im/IWORHe6ShO/Z6b3NHHElzM
         gibAenw03imIdgDTIwSNoF9ceC7nUVUIItpGsqXlOCHMsGMBumlLe1yZC8TTDvZyHPad
         DUtmiGqb/dXj+bwgGfmaeyREOmCdNRUtCOaX5sKgfbXkvW0kJNkV98tpT+yDbADUNPYT
         UV/JhBIHAOc3P2J1LU/oPUHlD9b8AB29N4NJ6OZEtz8OYjRy/LR1IrCCn/Jisdx4xciW
         CI7ZDRZpuSfMMWGhAMCMiGBOGOT35B7MuFeZ7UPzeycxo+ZJOR3DTCoFAWAZDaGGXRHQ
         FU9g==
X-Gm-Message-State: AOAM531tF180Y3DXKquY9G+/oIeMjbDl1SyN6n6qMTFplgSVeM9mA88a
        J6sbc1Xw5uRqf0p9q9mBxw9SQQ==
X-Google-Smtp-Source: ABdhPJz0h+6zKGZV/rzsCGCMdySv9MJKFdvWDnQDZvyT8Gv4027IxHavHCWz43+IXk9kloPYIEckaw==
X-Received: by 2002:a17:902:e353:b0:161:5096:3038 with SMTP id p19-20020a170902e35300b0016150963038mr12192424plc.24.1652726095223;
        Mon, 16 May 2022 11:34:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7d0d:b8ac:a3e3:757a])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709026f1000b0015e8d4eb24fsm7331090plk.153.2022.05.16.11.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:34:54 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: [PATCH v5 1/2] dt-bindings: google,cros-ec-keyb: Introduce switches only compatible
Date:   Mon, 16 May 2022 11:34:51 -0700
Message-Id: <20220516183452.942008-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220516183452.942008-1-swboyd@chromium.org>
References: <20220516183452.942008-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the ChromeOS board is a detachable, this cros-ec-keyb device won't
have a matrix keyboard but it may have some button switches, e.g. volume
buttons and power buttons. The driver still registers a keyboard though
and that leads to userspace confusion around where the keyboard is.

We tried to work around this in commit 4352e23a7ff2 ("Input:
cros-ec-keyb - only register keyboard if rows/columns exist") but that
led to another problem where removing the rows/columns properties breaks
the binding[1]. Technically before that commit the rows/columns
properties were required, otherwise the driver would fail to probe.
Removing the properties from devicetrees makes the driver fail to probe
unless the corresponding driver patch is present. Furthermore, this
makes requiring matrix keyboard properties for devices that really have
a keyboard impossible because the compatible drives the schema and now
the properties are optional.

Add a more specific compatible for this type of device that indicates to
the OS that there are only switches and no matrix keyboard present. If
only the switches compatible is present, then the matrix keyboard
properties are denied. Otherwise, as long as the "google,cros-ec-keyb"
copmatible is present, the matrix keyboard properties are required.
This more clearly describes what the driver was expecting, i.e. that the
kernel driver would fail to probe if the linux,{rows,cols,keymap}
properties are missing and the "google,cros-ec-keyb" compatible is
present. If the new "google,cros-ec-keyb-switches" compatible is present
then the matrix keyboard properties are likely to be ignored by any
modern driver, but they're still allowed per the binding if
"google,cros-ec-keyb" is present to conform to the original binding and
to keep the driver probing when used with newer DTBs.

This lets us gracefully migrate devices that only have switches over to
the new compatible string and properly enforce the "google,cros-ec-keyb"
binding at the same time. Eventually we'll be able to use only
"google,cros-ec-keyb-switches" or "google,cros-ec-keyb" when the driver
support has baked for a release or two, but we'll always support the
combined compatible list so that DTBs can be mixed and matched with
kernels, no dependency between the two binaries is required.

Link: https://lore.kernel.org/r/CAD=FV=Wey2P_=3Lp6M8GEaoyCn1XcYFhfJwfx43a5f_8H0obwg@mail.gmail.com [1]
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Joseph S. Barrera III" <joebar@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/input/google,cros-ec-keyb.yaml   | 91 +++++++++++++++++--
 1 file changed, 85 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
index e8f137abb03c..e1fb68ca00fc 100644
--- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
+++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
@@ -15,14 +15,23 @@ description: |
   Google's ChromeOS EC Keyboard is a simple matrix keyboard
   implemented on a separate EC (Embedded Controller) device. It provides
   a message for reading key scans from the EC. These are then converted
-  into keycodes for processing by the kernel.
-
-allOf:
-  - $ref: "/schemas/input/matrix-keymap.yaml#"
+  into keycodes for processing by the kernel. This device also supports
+  switches/buttons like power and volume buttons.
 
 properties:
   compatible:
-    const: google,cros-ec-keyb
+    anyOf:
+      - description: ChromeOS EC with only buttons/switches
+      - items:
+          - const: google,cros-ec-keyb-switches
+      - description: |
+          (Deprecated) ChromeOS EC with only buttons/switches; optional matrix properties
+      - items:
+          - const: google,cros-ec-keyb-switches
+          - const: google,cros-ec-keyb
+      - description: ChromeOS EC with keyboard and possibly buttons/switches
+      - items:
+          - const: google,cros-ec-keyb
 
   google,needs-ghost-filter:
     description:
@@ -41,15 +50,32 @@ properties:
       where the lower 16 bits are reserved. This property is specified only
       when the keyboard has a custom design for the top row keys.
 
+dependencies:
+  function-row-phsymap: [ 'linux,keymap' ]
+  google,needs-ghost-filter: [ 'linux,keymap' ]
+
 required:
   - compatible
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: google,cros-ec-keyb
+then:
+  allOf:
+    - $ref: "/schemas/input/matrix-keymap.yaml#"
+  required:
+    - keypad,num-rows
+    - keypad,num-columns
+    - linux,keymap
+
 unevaluatedProperties: false
 
 examples:
   - |
     #include <dt-bindings/input/input.h>
-    cros-ec-keyb {
+    keyboard-controller {
         compatible = "google,cros-ec-keyb";
         keypad,num-rows = <8>;
         keypad,num-columns = <13>;
@@ -113,3 +139,56 @@ examples:
             /* UP      LEFT    */
             0x070b0067 0x070c0069>;
     };
+
+  - |
+    keyboard-controller {
+        compatible = "google,cros-ec-keyb-switches", "google,cros-ec-keyb";
+        /* Matrix keymap properties are optional but ignored */
+        keypad,num-rows = <8>;
+        keypad,num-columns = <13>;
+        linux,keymap = <
+            /* CAPSLCK F1         B          F10     */
+            0x0001003a 0x0002003b 0x00030030 0x00040044
+            /* N       =          R_ALT      ESC     */
+            0x00060031 0x0008000d 0x000a0064 0x01010001
+            /* F4      G          F7         H       */
+            0x0102003e 0x01030022 0x01040041 0x01060023
+            /* '       F9         BKSPACE    L_CTRL  */
+            0x01080028 0x01090043 0x010b000e 0x0200001d
+            /* TAB     F3         T          F6      */
+            0x0201000f 0x0202003d 0x02030014 0x02040040
+            /* ]       Y          102ND      [       */
+            0x0205001b 0x02060015 0x02070056 0x0208001a
+            /* F8      GRAVE      F2         5       */
+            0x02090042 0x03010029 0x0302003c 0x03030006
+            /* F5      6          -          \       */
+            0x0304003f 0x03060007 0x0308000c 0x030b002b
+            /* R_CTRL  A          D          F       */
+            0x04000061 0x0401001e 0x04020020 0x04030021
+            /* S       K          J          ;       */
+            0x0404001f 0x04050025 0x04060024 0x04080027
+            /* L       ENTER      Z          C       */
+            0x04090026 0x040b001c 0x0501002c 0x0502002e
+            /* V       X          ,          M       */
+            0x0503002f 0x0504002d 0x05050033 0x05060032
+            /* L_SHIFT /          .          SPACE   */
+            0x0507002a 0x05080035 0x05090034 0x050B0039
+            /* 1       3          4          2       */
+            0x06010002 0x06020004 0x06030005 0x06040003
+            /* 8       7          0          9       */
+            0x06050009 0x06060008 0x0608000b 0x0609000a
+            /* L_ALT   DOWN       RIGHT      Q       */
+            0x060a0038 0x060b006c 0x060c006a 0x07010010
+            /* E       R          W          I       */
+            0x07020012 0x07030013 0x07040011 0x07050017
+            /* U       R_SHIFT    P          O       */
+            0x07060016 0x07070036 0x07080019 0x07090018
+            /* UP      LEFT    */
+            0x070b0067 0x070c0069>;
+    };
+  - |
+    /* No matrix keyboard, just buttons/switches */
+    keyboard-controller {
+        compatible = "google,cros-ec-keyb-switches";
+    };
+...
-- 
https://chromeos.dev

