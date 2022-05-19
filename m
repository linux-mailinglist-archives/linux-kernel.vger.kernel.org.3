Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0B352C927
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiESBM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiESBMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:12:55 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5A712D24;
        Wed, 18 May 2022 18:12:54 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-f1eafa567cso1538219fac.8;
        Wed, 18 May 2022 18:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dm0pT+M2kdQ8FRbmsyDYG7h2MbeTEk0HslEwcbyXupE=;
        b=q25MpA4lXiKaQDLn1qOYZNCg+hOpy6IN/gxtZRxNriV5ElMfh8TAagapewGD3LrjQg
         hjhYSbInlxWkL0iRn058Jh5n14sBPuMfq3NtpBlVkfQ5afsAPPzr/YFHR5eQLnlUdoQA
         UbhMx+d4268Zgq6Gugg2P1uZeLS2KOUhC7ajdgGtrFAE+KtHfhRxW9PobBCMB57C+Bqr
         RpprA7SMZo9Cwps2GEadqpb3AzT8846UzX+nt1B8UqfIujyWPRpjNTn6g6Eqg+nyhOje
         bOpJb4uW/LV3P8L1Npr2dajbvmG0AR+eRfLWFPmnmLBdeteh4KHwS2u9wZXydXRdAX7P
         kh/w==
X-Gm-Message-State: AOAM5333oTvhT+l7u/TZuYXKZzJMAGsYBzGHN/hdXQFcxH9pSIIvljm9
        u4A0OrlDbv87KHxmzPV6HA==
X-Google-Smtp-Source: ABdhPJxXxRG+njkKSFVY0tFBAwJuHh8x0LsBP7KO+7VZ1paiRDMleNdakKkuryEsLEYYJVNZZr8WLQ==
X-Received: by 2002:a05:6870:61cd:b0:e9:8de7:9c51 with SMTP id b13-20020a05687061cd00b000e98de79c51mr1330385oah.50.1652922773248;
        Wed, 18 May 2022 18:12:53 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id l13-20020a056870f14d00b000f169cbbb32sm1566263oac.43.2022.05.18.18.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 18:12:52 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: qcom: Drop 'maxItems' on 'wakeup-parent'
Date:   Wed, 18 May 2022 20:12:09 -0500
Message-Id: <20220519011210.170022-1-robh@kernel.org>
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

'wakeup-parent' is a single phandle and not an array, so 'maxItems' is
wrong. Drop it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml      | 3 +--
 .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml       | 3 +--
 .../devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml       | 3 +--
 .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml       | 3 +--
 .../devicetree/bindings/pinctrl/qcom,tlmm-common.yaml          | 1 -
 5 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
index 206f4f238736..3f4f1c0360b5 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
@@ -42,8 +42,7 @@ properties:
   gpio-ranges:
     maxItems: 1
 
-  wakeup-parent:
-    maxItems: 1
+  wakeup-parent: true
 
 #PIN CONFIGURATION NODES
 patternProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index 6c7c3f6a140e..2d228164357c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -42,8 +42,7 @@ properties:
   gpio-ranges:
     maxItems: 1
 
-  wakeup-parent:
-    maxItems: 1
+  wakeup-parent: true
 
 #PIN CONFIGURATION NODES
 patternProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
index cfcde405d30a..a7a2bb8bff46 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
@@ -49,8 +49,7 @@ properties:
   gpio-ranges:
     maxItems: 1
 
-  wakeup-parent:
-    maxItems: 1
+  wakeup-parent: true
 
 #PIN CONFIGURATION NODES
 patternProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index cfa2c50fdb93..15bb1018cf21 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -49,8 +49,7 @@ properties:
   gpio-ranges:
     maxItems: 1
 
-  wakeup-parent:
-    maxItems: 1
+  wakeup-parent: true
 
 #PIN CONFIGURATION NODES
 patternProperties:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
index 780f15bb5e40..c88c8dcb69d9 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
@@ -42,7 +42,6 @@ properties:
     description:
       Specifying the interrupt-controller used to wake up the system when the
       TLMM block has been powered down.
-    maxItems: 1
 
   gpio-reserved-ranges:
     description:
-- 
2.34.1

