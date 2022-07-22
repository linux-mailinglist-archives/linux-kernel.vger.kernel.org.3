Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BD657E70F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiGVTJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiGVTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:09:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F554A8758
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:09:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w15so1009741lft.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=agwqNyhPe1FeeyYaMTDHEC3Ht61jYjxP8kET6Q9I/XI=;
        b=p+2pB5PP+KgyPEcCIY1TAcSiDWDHn0nKDspRXpW5tnGMyasTYkH5W0FzLoBMi8z8W3
         q5ZLCIV10fBuUN2h3UfsShR3uasMeNNQ+mp5LzjLxEE6qLzQ+LSaSaj0OBtN5GdADbFA
         mmmzCKVxed2beqy3svpPUCphmDRAcUezEh/cm8n/R43G5l3WUeBIO/4rEnmBhS+hFOmO
         nT2aB85U/6Ceoj/moQNpZoC62NbwN/Zpvy47tvPnsiMLkH4H1X+gBXM6M5NKm2sMoI5w
         HMX60zZsbqYA5oOsKkGGVBU6c1fkReH4E8EJb+AhBoYy3VuuDJTvMnDtgWZVnEFtOK/S
         414g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=agwqNyhPe1FeeyYaMTDHEC3Ht61jYjxP8kET6Q9I/XI=;
        b=VS4D1QtPiH3gIkQHBne+8iIylxXtiQzsfElbo2GpHiUq5Dj7keV1Gavz+w3v66djKS
         X6QubUKCFM9i2C+I8kfmOHTzhec243GQOrOx9WvMocNMYq5VomXZwSuR2iwEBmPyWyY8
         B01Xl21igPo9VdtNrblfSEIFyyVHPU0YdBUb2lJ61S2ANFguaAjqSvdwsQ4+PnL6cuFw
         zrr4N/YS5lRbLqcWGRrGx/VhaMPkvpWOy8OqQX3mZd32D0w75AQSlryo4R1ipvTjb/d0
         xeVwicPxgPhZF6v7hiQ8dsGKMFetYQ/fI4BqejGnDvT87SbaNs0LT10mbd2Xj89VLI/Z
         wKCg==
X-Gm-Message-State: AJIora8JpLY/vRMaQvxAGGQRcu4yZWJeXte0721tu6yK3GNogy2BXj0+
        4uiIpyW5CgqsEEseC/JVR3Axug==
X-Google-Smtp-Source: AGRyM1vrJb5gr0c+TaBQHWdyH6KSvy36h8k9Zss3iTOI5ZP89fCdFS2ZhtGeeudzCrXoW6iEGA6zBg==
X-Received: by 2002:a19:ca5d:0:b0:48a:74a6:2f10 with SMTP id h29-20020a19ca5d000000b0048a74a62f10mr546514lfj.153.1658516953879;
        Fri, 22 Jul 2022 12:09:13 -0700 (PDT)
Received: from krzk-bin.home (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id p14-20020a2ea4ce000000b0025de944cc84sm1050189ljm.93.2022.07.22.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:09:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] spi: dt-bindings: spi-controller: correct example indentation
Date:   Fri, 22 Jul 2022 21:09:10 +0200
Message-Id: <20220722190910.76865-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example DTS mixed two with four-space indentation.  Preferred is four
spaces, for readability.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index e105faec937d..655713fba7e2 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -150,9 +150,9 @@ examples:
         };
 
         flash@2 {
-          compatible = "jedec,spi-nor";
-          spi-max-frequency = <50000000>;
-          reg = <2>, <3>;
-          stacked-memories = /bits/ 64 <0x10000000 0x10000000>;
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <50000000>;
+            reg = <2>, <3>;
+            stacked-memories = /bits/ 64 <0x10000000 0x10000000>;
         };
     };
-- 
2.34.1

