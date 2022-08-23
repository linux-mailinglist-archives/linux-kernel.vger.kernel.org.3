Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7359E944
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiHWRXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241803AbiHWRVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:18 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C867AC253;
        Tue, 23 Aug 2022 07:57:31 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11cb3c811d9so15414890fac.1;
        Tue, 23 Aug 2022 07:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=E/n8+ANvvCKxMrSrOzblZTP/tD99uJWGC/nHupfAwYo=;
        b=E+pfZ3tJr1FZeXPLVk1bJpMl+9N8QcPKUrE2JKh/r3ur4KVA2A/0nD09h+5QZm4UQt
         DqUkUn+WyHaTuVPESupRsiX0w3SS5kbKt+6eaHUHt4apn9h2CkqUezINQ4W0HMcD+m2v
         xLMQe6ePi7qQs9pw0RlHqvJ+H2WG7oUR9GvukuYifn40Z1HJD0HV6Pb+QbusbnRxT5sc
         5VUqXDr9ojE4nAtlrchh00ok34R3/cSDfJC4PKB7E0MNkitm0JQ/V1R6jAJYuw44/HPz
         2MMJ60f/PtCDX+3slxILen9GJM+AD2o4I7hwKZzd1sXwUSJVj+lF3k/OSDgkazps6fGA
         4jTQ==
X-Gm-Message-State: ACgBeo2IDIYaTP407r52OmdclNZO8gaSMVJmgPBEYdnVDEEkVmn//XEP
        i835zPwr6RP3+ww7B783mA==
X-Google-Smtp-Source: AA6agR5lMb2hvsauCXLU1ijbcXQY+dQlE0/NaS2H77wDnbGqI8QJsLlxfEIGjr6TYMdtd3ranumubw==
X-Received: by 2002:a05:6870:c0c8:b0:101:b3c3:abc3 with SMTP id e8-20020a056870c0c800b00101b3c3abc3mr1568061oad.144.1661266650452;
        Tue, 23 Aug 2022 07:57:30 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:29 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: remoteproc: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:41 -0500
Message-Id: <20220823145649.3118479-10-robh@kernel.org>
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

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml      | 1 +
 .../devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml      | 1 +
 .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
index e76c861165dd..e4a7da8020f4 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
@@ -140,6 +140,7 @@ properties:
 
   glink-edge:
     $ref: qcom,glink-edge.yaml#
+    unevaluatedProperties: false
     description:
       Qualcomm G-Link subnode which represents communication edge, channels
       and devices related to the DSP.
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
index da1a5de3d38b..b4de0521a89d 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
@@ -154,6 +154,7 @@ properties:
 
   glink-edge:
     $ref: qcom,glink-edge.yaml#
+    unevaluatedProperties: false
     description:
       Qualcomm G-Link subnode which represents communication edge, channels
       and devices related to the DSP.
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
index 3f06d66cbe47..b6bd33438584 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
@@ -107,6 +107,7 @@ properties:
 
   glink-edge:
     $ref: qcom,glink-edge.yaml#
+    unevaluatedProperties: false
     description:
       Qualcomm G-Link subnode which represents communication edge, channels
       and devices related to the ADSP.
-- 
2.34.1

