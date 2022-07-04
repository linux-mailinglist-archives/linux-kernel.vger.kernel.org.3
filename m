Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC60564AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiGDA1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGDA1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:27:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3306257;
        Sun,  3 Jul 2022 17:26:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r14so5371117wrg.1;
        Sun, 03 Jul 2022 17:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkcdMGU0kig+gsHzMagFBYfZudhco/uW4n7M1LjkF1o=;
        b=WlhLsARN5Ah8xD7NZ0C8MzttUfgUqmdW0p3SHYQOjaI8ynZa1onWsIKtosZy+R3XGS
         xom+9+qMCNcYpQnHFcLQBvdAgnQ27Akq7IfIwXpgBfFe+JREdnrX9qU/d4SoWfyPseGV
         +0iI7ZKkSOTq70d8qkISnMd7EmdtS6D19+781k3iF3VqX743+o7LLA6wxqDL09tMZfO7
         OWUUAaV/E4l96nKRg04Z6f1qztiHOI0ONEStU8wqF5EF1Y3C4qSiLZ2nR2yZuRuQiFb+
         87KTCiFDr4GB6YXS+i/Dcbb1rEiV9l3tOTLfdg4DRmDo+3uGxAlAiCcX5yoLrWXpJ8KW
         jW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkcdMGU0kig+gsHzMagFBYfZudhco/uW4n7M1LjkF1o=;
        b=4zTNtxkIEYIogLZRhKYC0hRw1spubREGVYQHdzwN4yIvaGAvq+0Kq679jXJDWWnq6J
         yy8Sh8zXk1IQxinrDS5MX28U8tTsHyWL5u/QepJa5shqjtDAI+u5lQ8RfgOV5mvVizHY
         O0UHkqTZ+UtYHcmVawAwW8Eu4jZBAxMFiGajtDUr6oGdfMefIUDNurBcFeT4wMadWc3C
         rLbHh87sYNccoCD/6t2vQV9iWKRUrKm+sV3cDxg6lwhLXMOy+bpdwNkQTnDB/EB4+A5A
         JAplUC/+5K46u6v9tQeXgNwINs4LJgR03Y04sDurTnWLq0l54O9odnPAbNlRbklNX5AD
         sf0g==
X-Gm-Message-State: AJIora9k9NbW96bJwpbibsfd6q6q5fAtADO+CpXhLHRXihWKiYSSDz/n
        vCEnMUSGp2LkOVmsqZjIonKk5+dFsVY=
X-Google-Smtp-Source: AGRyM1uw09AFRC0KaQ5ziWVcLEicUBQ2W9BgH2JIknPXfmgH8Q1RbiYu5+89GqFbSothY7MvzLhPcw==
X-Received: by 2002:a05:6000:1c0d:b0:21b:a62e:5760 with SMTP id ba13-20020a0560001c0d00b0021ba62e5760mr24492463wrb.112.1656894418059;
        Sun, 03 Jul 2022 17:26:58 -0700 (PDT)
Received: from xps-work.lan (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b003a03ae64f57sm18649180wma.8.2022.07.03.17.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 17:26:57 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
Date:   Mon,  4 Jul 2022 02:26:39 +0200
Message-Id: <20220704002641.207169-1-ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Add bosch,bmp380 compatible string for the new family of sensors.
This family includes the BMP380, BMP384 and BMP388. The register map
in this family changes substantially and introduces new features
but core concepts and operations carryover from the previous iterations

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 49257f9251e8..72cd2c2d3f17 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/pressure/bmp085.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: BMP085/BMP180/BMP280/BME280 pressure iio sensors
+title: BMP085/BMP180/BMP280/BME280/BMP380 pressure iio sensors
 
 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
@@ -16,6 +16,7 @@ description: |
     https://www.bosch-sensortec.com/bst/products/all_products/bmp180
     https://www.bosch-sensortec.com/bst/products/all_products/bmp280
     https://www.bosch-sensortec.com/bst/products/all_products/bme280
+    https://www.bosch-sensortec.com/bst/products/all_products/bmp380
 
 properties:
   compatible:
@@ -24,6 +25,7 @@ properties:
       - bosch,bmp180
       - bosch,bmp280
       - bosch,bme280
+      - bosch,bmp380
 
   reg:
     maxItems: 1
-- 
2.36.1

