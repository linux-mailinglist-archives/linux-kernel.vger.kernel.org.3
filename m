Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B385478A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhLQLqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhLQLqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:46:06 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57764C061574;
        Fri, 17 Dec 2021 03:46:06 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id y9so1845467pgj.5;
        Fri, 17 Dec 2021 03:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NeabA99WFW7MqI88OwEli7p5Eii1CpqvzDH2hHk3FdA=;
        b=XlAiVXPB3cegN82KShPyUBx9mMtd6KwzEOpqBbr3EmSayTLbD6ZWz4EobFhhePZxpS
         Kh1iZHLdo82NYlOGF5d4F1oZ9Ki9bnnJHTM8IeaPPR11Ygz91fTxde7xrYLTLfgme901
         v31tTzVebynary0FY7dwM06F2995RyNt07zBO7hGkljjFktfSS9bg4Qv4+TQPUfa6ry2
         fxbKLm5kAtxJD1pQF59Hr+/+SsQ/xRbBaRNZBjv6pvYfbZ7KtNTuJ9a0u4hYkaMnFwq5
         710InWCqL6lXjv9ovwX7sRMnnNzYtEaa+EFLfaU4le/wuvQnvboxr9fauk4d8DGctQgI
         P5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NeabA99WFW7MqI88OwEli7p5Eii1CpqvzDH2hHk3FdA=;
        b=RCJkwhJSB/KDLMkdvsJWrT3UnD7taAYhdWvHTtdvQx1R93aIKxhL2o0rjUgjWLiWMV
         Vm77kX1sMBXW9G5/NXLXHe8w66k+/sJTH6Q9mkounfpZwh0XcKqSEgeY655aKhUdNrbk
         jsMWu/qlsZaPK94qTzPq3GX+RKX9gj48J7TJ8Iza3QCokUHwlAca/oxU22q/8rCzhUHJ
         gVTkEy5hP9aA9nN6y97B48o7n1Jz9bwOPE9+IEWe3wd1vHgCAK22TPabdVq52ioyLW9C
         8/om4kvCuL8WBSqaywVKyD/8Ml+Or6PmfG2V9lLtc4LA25J6wPXqMmgpvJstGrQ83KT5
         lenA==
X-Gm-Message-State: AOAM533qEDlfh5gJtBG3aVCFVAAiKSHv9pbJe4Pvkc3JzQniWuQESgXH
        ygdH8Yq35qFW7TPRQVCrUrc=
X-Google-Smtp-Source: ABdhPJxP/r+YHFVcwDOSyLoVF2ywtZH0hW0yvgO4AaiwbTPMQr3t9gT/ReAIRxblEldURcrsb1qGuw==
X-Received: by 2002:a63:175c:: with SMTP id 28mr2589481pgx.66.1639741565927;
        Fri, 17 Dec 2021 03:46:05 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id kb1sm1663225pjb.56.2021.12.17.03.46.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 03:46:05 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v1 1/2] dt-bindings:pwm:Add bindings doc for Sunplus SoC PWM Driver
Date:   Fri, 17 Dec 2021 19:46:07 +0800
Message-Id: <1639741568-5846-2-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639741568-5846-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1639741568-5846-1-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus SoC PWM Driver

Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
---
 .../devicetree/bindings/pwm/pwm-sunplus.yaml       | 45 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
new file mode 100644
index 0000000..9af19df
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
@@ -0,0 +1,45 @@
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
+  - Hammer Hsieh <hammer.hsieh@sunplus.com>
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
+  resets:
+    maxItems: 1
+
+required:
+  - '#pwm-cells'
+  - compatible
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
index 13f9a84..721ed79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS PWM DRIVER
+M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

