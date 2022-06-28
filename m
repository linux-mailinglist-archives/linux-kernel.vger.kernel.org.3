Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0489455E3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbiF1Mpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbiF1MpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DA11D0FE;
        Tue, 28 Jun 2022 05:45:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ej4so17395557edb.7;
        Tue, 28 Jun 2022 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnf6pcj5vpCMbTgtadV2bK80NwflBsx3RadXRu/q84M=;
        b=B+j85IdQS+Xntj9SF6zbCBxyVHzt4nedW5mC16gCblDiLxqEwiEKaGjBWnJxNbbxza
         WRQlNzQSy1+kmCH2Mao/5NdE5KOWsSMSQM5COm2vNU25odKJ17pCD+mW/MLQkVTPx3ZL
         ELDxzTSrWCbKZvdjGL3Igh0lMSffAp6M8J6cIBVsaQpd8Yg4APdkUH39sbEP3qRecjOe
         Ev0Ag1R6uY6KX3MS49lehzdzuU+SMTY3kyMBDd1v32FavGke7XXu89oKCXW4+ybqeaj3
         yUoAimTthTjprexnZ0sntVrw/LKYm0xQmRrPstdQn7ApzHnlsm2HPMm3FJ7y//POtGN2
         i6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnf6pcj5vpCMbTgtadV2bK80NwflBsx3RadXRu/q84M=;
        b=rzIryrI09O8PkCL1gyo26XAOjw0lDdQRAHZ8Ywek4gRRaBBb/xXeIZjDAIf1I3CJzv
         J4i0EPBOm61aJQXBsdyXlUTpAl4vfBg8EtsVQCaQtOPiFPEuD3Nxuk5LaIoFbnNEtvre
         rZFW4JhuzG8BV6pDTcQJ/XYbAW78O3fF8T7T9c1R1RCn3w04ZVaWBVOZaYBiwJfGQtNs
         7QsP91RaejSIiQXfKPqGhBnX1FUUks7jfdvld5aqCpJ9EztMDAxfpQQItOk3Nz+7ZCFI
         mkGF7kaOZgNWH2uFR6m+FzVwK+TBfm2jNJ99QXcJSCSokFgxz9rUXJB8XTg4MYeo2OmW
         Y56A==
X-Gm-Message-State: AJIora9wSuTQUzbR+1Z9CDLfid/Q9ub+DqMaxEi8qsJ9r+eEvhj8bAmj
        ekJBZ1x3e4Rvub3XJYpIy/I=
X-Google-Smtp-Source: AGRyM1uwTe6v4t4C+Cj8uTSAWOl21YQ49mX5FGF++g1vgFNyOS/JkYzaDrYYbPLO26Eiax2DA4KF1g==
X-Received: by 2002:a05:6402:27c8:b0:435:d40e:c648 with SMTP id c8-20020a05640227c800b00435d40ec648mr23155962ede.200.1656420319512;
        Tue, 28 Jun 2022 05:45:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm622871ejx.173.2022.06.28.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:45:19 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 3/9] dt-bindings: reset: intel,rcu-gw: Update bindings for "legacy" SoCs
Date:   Tue, 28 Jun 2022 14:44:35 +0200
Message-Id: <20220628124441.2385023-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lantiq Amazon-SE, Danube, xRX100 and xRX200 SoCs have up to two USB2
PHYs which are part of the RCU register space. The RCU registers on
these SoCs are using big endian. Update the binding for these SoCs to
properly describe this IP:
- Add compatible strings for Amazon-SE, Danube and xRX100
- Rename the xRX200 compatible string (which is not used anywhere) and
  switch to the one previously documented in mips/lantiq/rcu.txt
- Allow usage of "simple-mfd" and "syscon" in the compatible string so the
  child devices (USB2 PHYs) can be described
- Allow #address-cells and #size-cells to be set to 1 for describing the
  child devices (USB2 PHYs)
- #reset-cells must always be 3 (offset, reset bit and status bit) on the
  legacy SoCs while LGM uses a fixed value of 2 (offset and reset bit -
  status bit is always identical to the reset bit).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/reset/intel,rcu-gw.yaml          | 84 +++++++++++++++++--
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
index be64f8597710..b90913c7b7d3 100644
--- a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
+++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
@@ -11,9 +11,16 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - intel,rcu-lgm
-      - intel,rcu-xrx200
+    oneOf:
+      - items:
+          - enum:
+              - lantiq,ase-rcu
+              - lantiq,danube-rcu
+              - lantiq,xrx100-rcu
+              - lantiq,xrx200-rcu
+          - const: simple-mfd
+          - const: syscon
+      - const: intel,rcu-lgm
 
   reg:
     description: Reset controller registers.
@@ -33,8 +40,6 @@ properties:
         maximum: 31
 
   "#reset-cells":
-    minimum: 2
-    maximum: 3
     description: |
       First cell is reset request register offset.
       Second cell is bit offset in reset request register.
@@ -43,6 +48,43 @@ properties:
       reset request and reset status registers is same. Whereas
       3 for legacy SoCs as bit offset differs.
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  big-endian: true
+
+patternProperties:
+  "^usb2-phy@[0-9a-f]+$":
+    type: object
+    $ref: "../phy/lantiq,xway-rcu-usb2-phy.yaml"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: intel,rcu-lgm
+    then:
+      properties:
+        "#reset-cells":
+          const: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - lantiq,ase-rcu
+              - lantiq,danube-rcu
+              - lantiq,xrx100-rcu
+              - lantiq,xrx200-rcu
+    then:
+      properties:
+        "#reset-cells":
+          const: 3
+
 required:
   - compatible
   - reg
@@ -67,3 +109,35 @@ examples:
         #pwm-cells = <2>;
         resets = <&rcu0 0x30 21>;
     };
+  - |
+    rcu_xrx200: rcu@203000 {
+        compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
+        reg = <0x203000 0x100>;
+        big-endian;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        #reset-cells = <3>;
+        intel,global-reset = <0x10 30 29>;
+
+        usb_phy0: usb2-phy@18 {
+            compatible = "lantiq,xrx200-usb2-phy";
+            reg = <0x18 4>, <0x38 4>;
+            status = "disabled";
+
+            resets = <&rcu_xrx200 0x48 4 4>, <&rcu_xrx200 0x10 4 4>;
+            reset-names = "phy", "ctrl";
+            #phy-cells = <0>;
+        };
+
+        usb_phy1: usb2-phy@34 {
+            compatible = "lantiq,xrx200-usb2-phy";
+            reg = <0x34 4>, <0x3c 4>;
+            status = "disabled";
+
+            resets = <&rcu_xrx200 0x48 5 5>, <&rcu_xrx200 0x10 4 4>;
+            reset-names = "phy", "ctrl";
+            #phy-cells = <0>;
+        };
+    };
-- 
2.36.1

