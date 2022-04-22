Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E214850C381
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiDVW3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiDVW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:28:22 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D851A5DFB;
        Fri, 22 Apr 2022 14:22:32 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-e5c42b6e31so9898082fac.12;
        Fri, 22 Apr 2022 14:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GD2I3shbaNSD6vzQaqySalLolH0HoMXjX9mtXC2rw4=;
        b=sXr5RL4oeQnDemv7SUBJqZpeW8ycJ21NDj+WVr0AFBejSJWrcqlcIm/LMygCueLhek
         2bP2SbwCE+sj8YuJTI6fOmbzgFfNSxpUkcATEvRewnC7lHNzBJ5wIMeN2mtzvjDF9jJl
         juGv2IfNmYDIDG69B+r0Lwc5uSh2GbBV34LPuUcCQoyqO8NVKRB5llp4ClGxUlEsyMVA
         PGj4FIS4mchsNnTgI/ACo0tqpDqskSNMsfs9Xeso5MsDXbLRpNjlVZEcxEuFtCMJPxux
         EibMIbGshrzIfeH3LByyH81LbNYwuNQW6dUvkE1ZbBrbYeB9YNg9JON9dnTlPEVOVH0u
         VRWw==
X-Gm-Message-State: AOAM532SlAsaYb3sV7TqNNa5mcxuA3auofi02eWOf6CGCIqDOxgpSL7/
        AVq9AOOlpot4uVZz1ansYq2Zo4ngHg==
X-Google-Smtp-Source: ABdhPJyCWTYuNLp/3p34tuoYQ+xy+uv7oNPjk1V39wjfw8QoXlE0QZYEd64pt6rvSAhL5vt/xJJkTA==
X-Received: by 2002:a05:6808:11c3:b0:2f9:62e0:ebe with SMTP id p3-20020a05680811c300b002f962e00ebemr3061171oiv.22.1650655251553;
        Fri, 22 Apr 2022 12:20:51 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id q203-20020acad9d4000000b002f8ee3f69e2sm1086501oig.52.2022.04.22.12.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:20:51 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Slawomir Stepien <sst@poczta.fm>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: Fix incorrect compatible strings in examples
Date:   Fri, 22 Apr 2022 14:20:39 -0500
Message-Id: <20220422192039.2590548-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of examples using incorrect compatible strings.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml     | 2 +-
 .../bindings/iio/potentiometer/microchip,mcp4131.yaml           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
index edf804d0aca2..b1eb77335d05 100644
--- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
@@ -68,7 +68,7 @@ examples:
       #size-cells = <0>;
 
       dac@0 {
-        compatible = "lltc,ltc2632";
+        compatible = "lltc,ltc2632-l12";
         reg = <0>;    /* CS0 */
         spi-max-frequency = <1000000>;
         vref-supply = <&vref>;
diff --git a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
index 945a2d644ddc..32e92bced81f 100644
--- a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
+++ b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
@@ -95,7 +95,7 @@ examples:
         #size-cells = <0>;
 
         potentiometer@0 {
-            compatible = "mcp4131-502";
+            compatible = "microchip,mcp4131-502";
             reg = <0>;
             spi-max-frequency = <500000>;
         };
-- 
2.32.0

