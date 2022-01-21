Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02DE4966D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiAUVD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiAUVDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:03:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E22C06173B;
        Fri, 21 Jan 2022 13:03:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f21so44762052eds.11;
        Fri, 21 Jan 2022 13:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zSRi+sptDHDdpKtMiU5ynYEoZ3D8GDmOibc3f30U53Y=;
        b=Eh81jKWllMSAv5CzFq/8KXOnhrynb4JOan0QI0YD1bOajydAbADlR6J9EU5YSu3uvU
         L2fK/yt1adLBCS78ldtwxaO37HW3Mp1TXatFYeboNEDPKUoKtBHaLCGb301thUkDbXLp
         eGXvjl+rtNDPJAz7RYPn7XdZVA95IlJbVaBbD+m5+VdTcdK//VePyuA7fZY0h+NUclnp
         qwmGMYWmvi7Rjj8OcS2MMedo/BwmEEYnzpVldcPGHTWCJIofk+sqNRsTCf3ELDJeHNyV
         5+zqmFBaw09BEuJm4aeSnc+0pd0TXIHtpCSte2bl8bnXgj89znRDBbZY+S3ywN3rys5V
         DiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSRi+sptDHDdpKtMiU5ynYEoZ3D8GDmOibc3f30U53Y=;
        b=tVs+dSXaGEq7C+vCN0QpIwQ9sVRU8dcBTYgGFBrByeeSlruAkXcmTuIwku1qOSuLvh
         rm628Xpxsf5lxACLUdtOrGPsZBivzgz+Edfd3RQQvZW6LEE16xKmA320q9Sertj2V2l0
         yxKkX079I7rUaJdydzjxqF9O0JebPYSQNch69YDdoNvdepL7aVl1hKaDalwoYkWXHlgD
         g1ZFQoFzMzi74RWNiNjV9odmpF6wjvF6IPUFMieEz9gkvTl5sl7tO2VvuHoWzd8lEW8l
         u45RMk8ov8Bk9XcyaSMsal3xeIwvSoOu8xopUOIJbCJeyDsswtgtUW9VotDnl0ARD9q0
         avoQ==
X-Gm-Message-State: AOAM530GOrhgp7uAGFzoTOm4+KhOpjbms0wo8UBj166c/jIylk4HQg0X
        HAq447LgXwhBevNA66V6B7c=
X-Google-Smtp-Source: ABdhPJzcTkh71gDClWRQQycUPwSRYMInppED3WJRcMRPkd471+kJZ4pvacNuRsS+RUen/Y+0/aLYtw==
X-Received: by 2002:aa7:d1d2:: with SMTP id g18mr5600645edp.357.1642799032698;
        Fri, 21 Jan 2022 13:03:52 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:03:52 -0800 (PST)
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
Subject: [PATCH v3 02/15] dt-bindings: clock: simplify qcom,gcc-apq8064 Documentation
Date:   Fri, 21 Jan 2022 22:03:27 +0100
Message-Id: <20220121210340.32362-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc-common.yaml as a
template and remove the compatible from qcom,gcc.yaml

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-apq8064.yaml      | 29 +++++--------------
 .../devicetree/bindings/clock/qcom,gcc.yaml   |  3 --
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
index 8e2eac6cbfb9..f31a260176e5 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
@@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Global Clock & Reset Controller Binding for APQ8064
 
+allOf:
+  - $ref: qcom,gcc-common.yaml#
+
 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
   - Taniya Das <tdas@codeaurora.org>
@@ -17,22 +20,12 @@ description: |
   See also:
   - dt-bindings/clock/qcom,gcc-msm8960.h
   - dt-bindings/reset/qcom,gcc-msm8960.h
+  - dt-bindings/clock/qcom,gcc-apq8084.h
+  - dt-bindings/reset/qcom,gcc-apq8084.h
 
 properties:
   compatible:
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
+    const: qcom,gcc-apq8084
 
   nvmem-cells:
     minItems: 1
@@ -53,21 +46,13 @@ properties:
   '#thermal-sensor-cells':
     const: 1
 
-  protected-clocks:
-    description:
-      Protected clock specifier list as per common clock binding.
-
 required:
   - compatible
-  - reg
-  - '#clock-cells'
-  - '#reset-cells'
-  - '#power-domain-cells'
   - nvmem-cells
   - nvmem-cell-names
   - '#thermal-sensor-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index 73e3ff4979c6..04745bb407be 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -15,8 +15,6 @@ description: |
   power domains.
 
   See also:
-  - dt-bindings/clock/qcom,gcc-apq8084.h
-  - dt-bindings/reset/qcom,gcc-apq8084.h
   - dt-bindings/clock/qcom,gcc-ipq4019.h
   - dt-bindings/clock/qcom,gcc-ipq6018.h
   - dt-bindings/reset/qcom,gcc-ipq6018.h
@@ -40,7 +38,6 @@ allOf:
 properties:
   compatible:
     enum:
-      - qcom,gcc-apq8084
       - qcom,gcc-ipq4019
       - qcom,gcc-ipq6018
       - qcom,gcc-ipq8064
-- 
2.33.1

