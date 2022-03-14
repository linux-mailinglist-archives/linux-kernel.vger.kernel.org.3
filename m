Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD064D7A87
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiCNFwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiCNFwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:52:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEBC3FBFF;
        Sun, 13 Mar 2022 22:51:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q19so12835998pgm.6;
        Sun, 13 Mar 2022 22:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ok63ibqhQr0VYYi+54LHwL4GBcWoRtMufsgDu+h2rCE=;
        b=fP36lqnEuVspDIchzbbmofPO5erDkZv3S5B8qg8QC63iDlfbzTMcM+CPtAqNJ6xmXj
         YFQcHG91odGTT8/zs/eIxkypL4z4IXpOM+7df11hEzK+BWk/sEM0TUl+Xp4KPQSYZ7DQ
         DFJLqR6LbVFQeso7yF8vWl6xjsrH5L4fMlumGcZTy7ovvY29NL0xrkru+yZUerKkcwJm
         oyn5xFoTRNsL7tvtgVXmViWN3ZbdLPanG32zZ6H3fL5ZqkG9+lZNJ9kqPy1GN3EiwrHu
         Ip0DkHAboWp2DSYTzbv6ouYsWlVvNKo9hpxH5hz+XsMMZSQuqmN9YYJPiROz4loU1aly
         H+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ok63ibqhQr0VYYi+54LHwL4GBcWoRtMufsgDu+h2rCE=;
        b=Mkfm718wQ42J1fIriRQV/N6FKctd9tDifDiWcuvuomYyGe7+n8jG9gzZ4QzwEWVm8Q
         qH5NRrr3iGE0hVHPzlVt9hHRe89GpqbrAgHS7cwD2eqse1Sa+CiDE5fiQjdxVYYVmROW
         wBCCOm3sbzdYgna3zrpOxGmMljLas4jgiZzwirdf7DT949lyy3iwVbAPAPEnT/okS2Vp
         x8JrCxUrdJkyYmlCtjYKQbqShUGP1K597kYBN7szBZZ/Vxkm63TMFkNWFP/IFDz5uGAV
         QYffElIhcGZCb1ZfS92kffbrHV4A7MJnYGNWJPoryQ0nPUPAk516+ZK2vDNjghHdm+ol
         N/Mg==
X-Gm-Message-State: AOAM533nPy/yRrdHpc6J9Wul88fh26q8WFhNq59J/lLH5FVtcwTq1vpq
        y8bWOtPU/lneG8BGE0sQaTA=
X-Google-Smtp-Source: ABdhPJw2nXmy2mg5dZf9AGWbOFePXCIY9WiNi3kvqsM9ayfpY4AIIIhi9OO76smRLHvP69PQMAk9Ow==
X-Received: by 2002:a63:d74f:0:b0:374:5bda:909d with SMTP id w15-20020a63d74f000000b003745bda909dmr18750453pgi.215.1647237082510;
        Sun, 13 Mar 2022 22:51:22 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h17-20020a63df51000000b0036b9776ae5bsm15238115pgj.85.2022.03.13.22.51.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Mar 2022 22:51:22 -0700 (PDT)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: pwm: Add bindings doc for Sunplus SoC SP7021 PWM Driver
Date:   Mon, 14 Mar 2022 13:51:36 +0800
Message-Id: <1647237097-29172-2-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647237097-29172-1-git-send-email-hammerh0314@gmail.com>
References: <1647237097-29172-1-git-send-email-hammerh0314@gmail.com>
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

Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
Changes in v3:
 - Addressed all comments from Krzysztof Kozlowski.

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

