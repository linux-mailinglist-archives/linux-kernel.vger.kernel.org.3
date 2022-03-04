Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364724CCDA8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbiCDGUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbiCDGUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:20:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F9910B3;
        Thu,  3 Mar 2022 22:19:59 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z2so6875979plg.8;
        Thu, 03 Mar 2022 22:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=89MifMU0Ot4dTmhI3/IsCdtBEOKYEkgi+gaBnBmqzL4=;
        b=YgQE2G/VJQX96ByH2mpuOBUHKn50OFS5JIqnEdkDsge4dICpYb1eOUUeYD5BcXfSzr
         bMkTUK6+GLi4l0EuJl/gn36ws+SojFdZl8Wfl9q+VM6jBnzmHG1EAjIs2ZvJNej6vaM0
         sGMKeYDvRnoh9XncUBj+DRlqnefWVkmAqHQialFnt/OwjGlw2+QpuXRbDy3SjPLidjfA
         9MsxaLCq/ZR3t9IAHNXIjti65zdhz6+1UEcZO6R55TPbdNPjMRQTE7F4rTXOfagFM8TE
         d+69oc6nwTfDPHv/HBS2EYVPMwb0v5UyB662QVsuxLWQXlZbNbbPUKQZe1oY+uju0bhu
         B+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=89MifMU0Ot4dTmhI3/IsCdtBEOKYEkgi+gaBnBmqzL4=;
        b=Vh42p6lt87exWAlsyhPznb4+iKmDCXEhm/4ILgLcG4wTMGvG0o1rpjnEJkYnVqRG75
         P1ch/Idd2Ew6F0efXV/mM8BmiqoQqSyAXcav+4uH+c7hJfsClOCLS1IuxaoyiXkTTtXF
         8FkF7l+25QEBbKpJuSa3iItj7drxZ2AM+oYYE2Ocu1u9B1F0RyBjAzY5rLEvETtszMXV
         MOw0E9z1fhjWCXQXBXCd3wGOleeEZ8ozCWS2ab3yNU5KSlEtajX+FB1C14KN37d6yXHE
         urKRHElORTnRX0xM+TBMA7Kgmkaza5pcJtROwlKPF2FdfJSubTrFBtvLCVGajNbvIbza
         5GRQ==
X-Gm-Message-State: AOAM530BSHqqqBHKCIWWhehlD+HUo77HY57VrPavsUtEYq3c0r0p734W
        TwweyOHyomIv90vtW0WfQ9o=
X-Google-Smtp-Source: ABdhPJx4Yibqr8sKCQ1Pb/Pur7fdDqovWoLLdzeNoIkCK8laaj8XVScQRLHasF8D6PX2Zwv30em0NA==
X-Received: by 2002:a17:902:c94f:b0:151:3cd8:efe3 with SMTP id i15-20020a170902c94f00b001513cd8efe3mr33133780pla.117.1646374799135;
        Thu, 03 Mar 2022 22:19:59 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id kb6-20020a17090ae7c600b001bee8664d82sm8749471pjb.35.2022.03.03.22.19.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2022 22:19:58 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings:pwm:Add bindings doc for Sunplus SoC PWM Driver
Date:   Fri,  4 Mar 2022 14:20:11 +0800
Message-Id: <1646374812-2988-2-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
References: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus SoC PWM Driver

Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
Changes in v2:
 - Addressed all comments from Rob Herring.
   modify author's mail match Signed-off-by.
 - rebase kernel to 5.17 rc5

 .../devicetree/bindings/pwm/pwm-sunplus.yaml       | 40 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
new file mode 100644
index 0000000..19fe5d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-sunplus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SoC PWM Controller
+
+maintainers:
+  - Hammer Hsieh <hammerh0314@gmail.com>
+
+properties:
+  '#pwm-cells':
+    const: 2
+
+  compatible:
+    items:
+      - const: sunplus,sp7021-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm: pwm@9c007a00 {
+      #pwm-cells = <2>;
+      compatible = "sunplus,sp7021-pwm";
+      reg = <0x9c007a00 0x80>;
+      clocks = <&clkc 0xa2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2524b75..825b714 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18531,6 +18531,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS PWM DRIVER
+M:	Hammer Hsieh <hammerh0314@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
+
 SUNPLUS RTC DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-rtc@vger.kernel.org
-- 
2.7.4

