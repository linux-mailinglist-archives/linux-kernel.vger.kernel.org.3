Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C704956BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378211AbiATXUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378158AbiATXUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A921C06173F;
        Thu, 20 Jan 2022 15:20:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso17640157wms.4;
        Thu, 20 Jan 2022 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+A0y4CdRvgUX+GrCK344T8r/tQN4874ehIU8J3A6Bjo=;
        b=cM2seonXSM/uOv5mpKdenKOcBAiT5HDQ6IMdrmr22+BzojXZWv+FMQ9mt5SZXVODq1
         YQbHDXy8foy3GSt0m+zWsAOm10LDPLSTU/at3epvKDp4GaJteuNmESO5duviY42duQvJ
         2s+Ol76rqFpBzLWVKtayrqdvg+uj7oeRovOGCCQDHiHTjA88+Tg0F63w79Q0X9KByyp/
         X4AkKV2Ykg13PxQwXq6VMrjjzF9fBfh/qPZrO1gaEXrzrPbG+Hv+23PLoDtIvehvzuRg
         haJI+1mUnGkoPILtKJrhWhiuv5bflGpazHeYRJ39p2mifbbBKEck6eLO6WY0WPo5J8D2
         hshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+A0y4CdRvgUX+GrCK344T8r/tQN4874ehIU8J3A6Bjo=;
        b=dOZQ/b+PW6tIZZvWG2KM784e9X/J4VdgIygBq+g33fKMj8ss6Iu7V9U9P+2SJUGo8e
         E9my8HJZAeDOa2Ak6c/Qi9B8Rz/ynMGockHlF17Su52XJPjaLPOFT1j3rnOWDjhb7MhB
         70NGnrhcYnsYf4DAbEjGG8pdF2L03nj0bsriiV3ejHWKmdDvggtWWiyHz0FXGrpdHieQ
         dIumKSfA1pKdOswjL4jz28v3iS6izxoDiVtI4tjqZVRUoCnS0JnmGym4mMK1b+YtHWWS
         e4izwgBMO1KMwIZXXnu99F4NDAGx5JvO0Rtx1/pg1J9toNY+OWwD5HEmz9C2Fa+Mztok
         0Dvw==
X-Gm-Message-State: AOAM532WOccSDZuCVsyYbzxRgQnAtyreZJY+RPHuLtu6K2y1qhL8R8iU
        zCvX0bM5xaEBIAyyeaVN0ck=
X-Google-Smtp-Source: ABdhPJyfT4FvBvOtlgUA25/6rhE+tF2ZpQFbPoXIg1yLWTU0828YNECy33l6fnzQ8+wsS5JY8ExquQ==
X-Received: by 2002:adf:e48c:: with SMTP id i12mr1199753wrm.43.1642720834530;
        Thu, 20 Jan 2022 15:20:34 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:34 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/15] dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
Date:   Fri, 21 Jan 2022 00:20:15 +0100
Message-Id: <20220120232028.6738-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc.yaml as a
template.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-apq8064.yaml      | 27 +++----------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
index 8e2eac6cbfb9..d65b3fc5bfa1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
@@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Global Clock & Reset Controller Binding for APQ8064
 
+allOf:
+  - $ref: qcom,gcc.yaml#
+
 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
   - Taniya Das <tdas@codeaurora.org>
@@ -19,21 +22,6 @@ description: |
   - dt-bindings/reset/qcom,gcc-msm8960.h
 
 properties:
-  compatible:
-    const: qcom,gcc-apq8064
-
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
   nvmem-cells:
     minItems: 1
     maxItems: 2
@@ -53,16 +41,7 @@ properties:
   '#thermal-sensor-cells':
     const: 1
 
-  protected-clocks:
-    description:
-      Protected clock specifier list as per common clock binding.
-
 required:
-  - compatible
-  - reg
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
   - nvmem-cells
   - nvmem-cell-names
   - '#thermal-sensor-cells'
-- 
2.33.1

