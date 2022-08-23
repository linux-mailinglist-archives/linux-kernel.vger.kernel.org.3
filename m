Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2F59E9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiHWRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbiHWRUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:20:43 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B2F48C85;
        Tue, 23 Aug 2022 07:57:10 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id r124so767423oig.11;
        Tue, 23 Aug 2022 07:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4YuS4HI68dpdCocwhLeIeeGS4ftqZiziN5EXiO7crA0=;
        b=tDyXzN1+v55nD7xSXwVFQB2PVhjT45q8RiCIieSqCyCPMm9SO7lDTD0F9J+VS1q1JW
         uS2ox8ArzMTbGpd9OZaenxIIOK2XnYQrcoqhmqW2DQurAzryYtcTJje5HKd3PqU9NYcF
         XewvG9xDo6wSmS1qjnMCFprVstb9B6VXKe+H0Sj4Zt+D459bfYyq05vZI97GJFgG4Npu
         9qBEjRyfhIx1CbLqV42GjvA6NKwBifaseXUDdYtvPnLZM5lqOvMJoeJ1F8KXNogERnUx
         oFZEQ4ymZRhDMNkw4VR08qHkA/aoiT+vWAx1D8dL9cNGd5BZtkO2R92WwWxHMnGyOrOp
         fxGg==
X-Gm-Message-State: ACgBeo20xpvEW6Tsc+7cNzpNWcKRqMcuRz0PnY8hFJpzGoykZ06sscB+
        tlH4363jm4msIa8Dq2w9XQ==
X-Google-Smtp-Source: AA6agR6aV+kVQQS+QoS0wLg0mn5D1XAbCDSdtcW45YblNWzO71PigaVr4fBZd/f7/NyH9C0q+MQ7AA==
X-Received: by 2002:aca:a8c5:0:b0:343:8774:d82 with SMTP id r188-20020acaa8c5000000b0034387740d82mr1563122oie.249.1661266630078;
        Tue, 23 Aug 2022 07:57:10 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:09 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Del Regno <angelogioacchino.delregno@collabora.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] media: dt-bindings: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:34 -0500
Message-Id: <20220823145649.3118479-3-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/microchip,csi2dc.yaml   | 2 ++
 Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml | 1 +
 Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml | 1 +
 Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml  | 1 +
 Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml  | 1 +
 Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml  | 1 +
 .../devicetree/bindings/media/qcom,sdm845-venus-v2.yaml         | 1 +
 Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml  | 1 +
 Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml  | 1 +
 9 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml b/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
index e8544fb2d034..b3a345fc6464 100644
--- a/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
+++ b/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
@@ -75,6 +75,7 @@ properties:
     properties:
       port@0:
         $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
         description:
           Input port node, single endpoint describing the input port.
 
@@ -103,6 +104,7 @@ properties:
 
       port@1:
         $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
         description:
           Output port node, single endpoint describing the output port.
 
diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
index 59ab16ad12f1..2abb7d21c0d1 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
@@ -68,6 +68,7 @@ properties:
 
   video-firmware:
     type: object
+    additionalProperties: false
 
     description: |
       Firmware subnode is needed when the platform does not
diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
index 199f45217b4a..29d0cb6c6ebe 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
@@ -95,6 +95,7 @@ properties:
 
   video-firmware:
     type: object
+    additionalProperties: false
 
     description: |
       Firmware subnode is needed when the platform does not
diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
index 90b4af2c9724..42ee3f06c6be 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
@@ -86,6 +86,7 @@ properties:
 
   video-firmware:
     type: object
+    additionalProperties: false
 
     description: |
       Firmware subnode is needed when the platform does not
diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
index e2874683b4d5..cf361dd9de08 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
@@ -86,6 +86,7 @@ properties:
 
   video-firmware:
     type: object
+    additionalProperties: false
 
     description: |
       Firmware subnode is needed when the platform does not
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
index 33da7d3cfd38..45e3f58f52bd 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
@@ -104,6 +104,7 @@ properties:
 
   video-firmware:
     type: object
+    additionalProperties: false
 
     description: |
       Firmware subnode is needed when the platform does not
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
index 177bf81544b1..8edc8a2f43a5 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
@@ -81,6 +81,7 @@ properties:
 
   video-firmware:
     type: object
+    additionalProperties: false
 
     description: |
       Firmware subnode is needed when the platform does not
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
index 680f37726fdf..57d503373efe 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
@@ -96,6 +96,7 @@ properties:
 
   video-firmware:
     type: object
+    additionalProperties: false
 
     description: |
       Firmware subnode is needed when the platform does not
diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
index ebf8f3d866a5..4b7a12523dcf 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
@@ -92,6 +92,7 @@ properties:
 
   video-firmware:
     type: object
+    additionalProperties: false
 
     description: |
       Firmware subnode is needed when the platform does not
-- 
2.34.1

