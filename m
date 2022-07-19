Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1676579477
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiGSHpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiGSHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:45:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158C77667
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:45:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u13so23376619lfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wh0dgiKmSiILClmOpbIfSiljIy7KFxVZW+Mg5DvdEm4=;
        b=iOBmtlwR2YHnnMd4hQU4t995VjKvc70SYAH5Bxg96bAAoubB4j2x71LZALgXuoXXbg
         Oy6+1EC3Gh4Jnx0hCOP+Exm5pKPBVLJljRENg0rzBQi7nPdCbhpr8NVDBJPJKQ6HhfMy
         mgQH2/OqK7RRbYnZau06KVgzDrZGuEbVGiXIuxsqOxl3guTX2j9kUPpCt7heGqg2Rft4
         yy656IRVOtK3EKeAtxAq4AtWVN69vWVPbO7BIzPKepQqVztGZGFndHqwMjvdQdbSSDj5
         eMf2GGnoHtpf5J2d4fwpTd0bztUowowNpkDtpCSCBOsCUlgtd8leOAA2fo+MHNwAHf8Q
         9Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wh0dgiKmSiILClmOpbIfSiljIy7KFxVZW+Mg5DvdEm4=;
        b=FHgOtB8BfkognhszQp0r8JU3IzgwObELXQRvR/8iC6iSPf+wSYZX+hGnLmV8UaFxES
         jjF5RFNynZTBTW9ShodP1OZg2I3wosWJO0+xwE7p5+KRG6ECUTMbSnpkHzjVgUad8RRG
         6879XNelp4wLKs873SAOYY+/VR0rI0B8x1GgSGnRBPOyL4XFAED+G9LedtLjeigCR4TA
         YdjKpu8Q9t6vriwizF1c+5kuUSya9dmfooairCT1D7lfXAftCORZJkf+iIOyPJNJpXFe
         OYqu2c5A2/EJFhfudKccdOcyISTSzVQC2B1ShVLzgtze1TrUrtU89alAaOSVamXP0GRB
         CQEg==
X-Gm-Message-State: AJIora/254+QCatT/LaHihG534hzBjQFZtFKCsqjr0L+N+2eyxPLAIu6
        U9UWeLg1C2bUBLda3TmGhmQ1jQ==
X-Google-Smtp-Source: AGRyM1ui8UUtjT+BR0tutTilm3Q52rq8nnNUwsiME5hBr5XnCxp4ScxwagX3WCuj6dfULdtSJj2ZoA==
X-Received: by 2002:a05:6512:13a4:b0:479:3b9f:f13c with SMTP id p36-20020a05651213a400b004793b9ff13cmr16529483lfa.380.1658216745492;
        Tue, 19 Jul 2022 00:45:45 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9257000000b0025a7338317esm2449669ljg.64.2022.07.19.00.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 00:45:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: leds: pwm-multicolor: document max-brigthness
Date:   Tue, 19 Jul 2022 09:45:42 +0200
Message-Id: <20220719074542.24581-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Multicolor PWM LED uses max-brigthness property (in the example and
in the driver), so document it to fixi dt_binding_check warning like:

  leds/leds-pwm-multicolor.example.dtb:
    led-controller: multi-led: Unevaluated properties are not allowed ('max-brightness' was unexpected)

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/leds/leds-pwm-multicolor.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
index d0f846cd019d..bd6ec04a8727 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -22,6 +22,12 @@ properties:
     $ref: leds-class-multicolor.yaml#
     unevaluatedProperties: false
 
+    properties:
+      max-brightness:
+        description:
+          Maximum brightness possible for the LED
+        $ref: /schemas/types.yaml#/definitions/uint32
+
     patternProperties:
       "^led-[0-9a-z]+$":
         type: object
-- 
2.34.1

