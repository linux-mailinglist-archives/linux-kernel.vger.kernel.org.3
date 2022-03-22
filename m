Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1514E4E3CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiCVKo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiCVKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:44:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE281491;
        Tue, 22 Mar 2022 03:42:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g19so17790331pfc.9;
        Tue, 22 Mar 2022 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Gttik6DAPko7SlbVcNht0UxM+4SmfM9425wk43Thfg=;
        b=LxQ1BOpl+Ecu1cULmapUOe6dnw1b0DA2zJ9x0YJFVjFo93B3HoiXw0xIr3DeYOSVh0
         FMMwgkGhRb1FhjzhGjn6TKSNq2IdNzU182+p4f0HC1M0Ptp3SrEAU6dOkii1jWW+i6Cp
         oRz9CWjcpMwIrnqmWs0M4N/VqDLI6gOhxoCjpk5JmkL9ukevRaTd2P2qV6ls8QPTTFuA
         CBrz0bl7s6fmnDuYX43M8ETljAkVmwiUkvVNufzPKALVbJ8WR75L+RUHLOUQyD+Cvwn2
         N9hbMDSRA9fBf1bu6fK+N4IAix46Ngb3hFdxbq6wtxNNfulxtmhg41JmsK6oV834fQ43
         SlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Gttik6DAPko7SlbVcNht0UxM+4SmfM9425wk43Thfg=;
        b=VUlxmCaXY/6Ibk0oJXCUO5e4Np/Du+o/duen9JiO6DwCm/GMQXIblbbiMmWRJnn6pX
         M8szs0H6TESWnzV9X/NlrKBEjttThp3/37i7u2BqXdmlahkY1HbP+ggSVKE9BbjsHMwh
         tNfjc/SffXg1PJT+7A9Hkbva6SINxNGk9TZfdW7pq+XkE24gqmMfvlkV20+jZm2bVGkN
         PHREMk3SB03QLIE1H3kJnWcH77b9C7xBAnUh+r5BEjmEHTTIuAzXnRxSG7IzvrsVnelM
         R8+OefHfTk4BlpW1v1yjL1U1PxyvWN0rDapyjLestqAQgzzCPi+izdsKN3NB6vT3ROjU
         L4IQ==
X-Gm-Message-State: AOAM530PcqbIShjnYWU5BNCWrC7MlfvLLxryv6YbN/WQHxQf6YtlSqzp
        c7mKLSIMu0dTYxI/76B/BrM=
X-Google-Smtp-Source: ABdhPJwoaValgjhqyTSexjYCmFYTLl7A1kx7i7LcQssrohXyaQVDVBUpnScXRKJlnW1aHHWbZUW0BQ==
X-Received: by 2002:a05:6a00:a0c:b0:4f6:661e:8dda with SMTP id p12-20020a056a000a0c00b004f6661e8ddamr28529112pfh.66.1647945765759;
        Tue, 22 Mar 2022 03:42:45 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id r26-20020a63a01a000000b00385fe08c264sm78113pge.1.2022.03.22.03.42.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Mar 2022 03:42:45 -0700 (PDT)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: pwm: Add bindings doc for Sunplus SoC SP7021 PWM Driver
Date:   Tue, 22 Mar 2022 18:43:00 +0800
Message-Id: <1647945781-10191-2-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com>
References: <1647945781-10191-1-git-send-email-hammerh0314@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus SoC SP7021 PWM Driver

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
Changes in v4:
 - no change

 .../bindings/pwm/sunplus,sp7021-pwm.yaml           | 42 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml b/Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml
new file mode 100644
index 0000000..d4fc9e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/sunplus,sp7021-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SoC SP7021 PWM Controller
+
+maintainers:
+  - Hammer Hsieh <hammerh0314@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: sunplus,sp7021-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 2
+
+unevaluatedProperties: false
+
+required:
+  - reg
+  - clocks
+
+examples:
+  - |
+    pwm: pwm@9c007a00 {
+      compatible = "sunplus,sp7021-pwm";
+      reg = <0x9c007a00 0x80>;
+      clocks = <&clkc 0xa2>;
+      #pwm-cells = <2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2524b75..e1cb7eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18531,6 +18531,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS PWM DRIVER
+M:	Hammer Hsieh <hammerh0314@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml
+
 SUNPLUS RTC DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-rtc@vger.kernel.org
-- 
2.7.4

