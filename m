Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA03C582A00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiG0PwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiG0PwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:52:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349DB1CFDA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:52:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so27799463lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+ha7lhBflc460y5THF4+LjZQv3BBhWbPvt660ntV4w=;
        b=HajfvI/6l0BHtjFFyVInnth5cHgPWWwo3Mq9rUoDiz9X1M/3YvaIv8wMF0NqAPYv9E
         yOmjV8QRRUcNgLO8UwrGvft4G7GcyUjP6Y691j2KWfT+LavcKebJoLy+TDiYJwXxwuV2
         XZEN1g2vG1DUCxl1719eQXToHXh9X1q4wpIJ/uXF7iY8xN7ypE2dzJuC3oZmUE7S6z+f
         /HAikeciCEZQhnAXP4SVD/PLZ3YOWZBynQvpD0RK4WU0D96zwQv9TJWvuhVrDzi7OuWI
         Lp9lQTpV56DyqMdnfU7FaIYfnujISyLgVwnUlX3lP4n2+M9drfHz7+r+awyLXEIei0OL
         wojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+ha7lhBflc460y5THF4+LjZQv3BBhWbPvt660ntV4w=;
        b=QFi1KA4P+u82OqiuDoaoG/XprryUJAzfB+XJqQUSD0q48akwX8uWdKM8vqTJuS+LSO
         lJlRIGAQ3PjqQK1tM448AtiVbFypupATbaCNoJR9sAPeBxFPJoLdToWO8j6rIMJD7fo5
         KLfM5MBKfKzX8KEkIYuK53R8UBFsHn4PX2s7lLZn5i3RJ+Sf8CHqvu14+KEqQeX0GYrK
         hnxyKQg8L57AidSrLawWwBWXvNcNi2t55heJbpuVFfMzT0F9HYOPKXuG0iT3o7X9WWh0
         DSguuNxkRoHHRIe1lGNN5fpw6DE9fbgLAI+MHF3Kjn/kdUEOgn1NCLMU0ugSlXtG7tsL
         sMPQ==
X-Gm-Message-State: AJIora9kopVN1zgyx/MRv08DiQcI59uY/zCF6DX8F4zbatzLmb5amXkw
        MU5VT5B3x+BZn5QMcaUvvlBrkw==
X-Google-Smtp-Source: AGRyM1uFlGo+mQfFG/MD+0PotT2fpEV4uoMRX06vRFxHGoiB6r1NRZaNOdvd2pgdj6mnncVtzb3Ktg==
X-Received: by 2002:ac2:4f03:0:b0:481:5092:ec8f with SMTP id k3-20020ac24f03000000b004815092ec8fmr8817640lfr.35.1658937126228;
        Wed, 27 Jul 2022 08:52:06 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id dt9-20020a0565122a8900b0048a835a60f6sm2392163lfb.251.2022.07.27.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:52:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: adc: ti,am3359-adc: add ti,am654-adc
Date:   Wed, 27 Jul 2022 17:52:03 +0200
Message-Id: <20220727155203.320929-1-krzysztof.kozlowski@linaro.org>
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

Document the ti,am654-adc compatible already used in DTS:

  arch/arm64/boot/dts/ti/k3-am642-evm.dtb: adc: compatible:0: 'ti,am654-adc' is not one of ['ti,am3359-adc', 'ti,am4372-adc']

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/adc/ti,am3359-adc.yaml    | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
index d6f21d5cccd7..b32be24a9f98 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
@@ -11,9 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - ti,am3359-adc
-      - ti,am4372-adc
+    oneOf:
+      - enum:
+          - ti,am3359-adc
+          - ti,am4372-adc
+      - items:
+          - enum:
+              - ti,am654-adc
+          - const: ti,am3359-adc
 
   '#io-channel-cells':
     const: 1
-- 
2.34.1

