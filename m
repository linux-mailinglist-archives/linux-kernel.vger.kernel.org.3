Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81991545997
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244629AbiFJBb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242631AbiFJBbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:31:22 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21B32DE7DF;
        Thu,  9 Jun 2022 18:31:21 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y188so15176682ybe.11;
        Thu, 09 Jun 2022 18:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ElqxuDCNQXRCZG67xnOLz5NHyRlQc3DQ9LW5Dv5Hebk=;
        b=iMzRXrgSodgWp0762d490bUYJpIWUGUsCVl7vfzAvJkeRMYZCSgOjD6G85NoIpoQw0
         qaTCFblqm2xa7C24UfXJRwWkfyECUVOApGiSiYftPhL+7EEZUYPDlssZGWto84lKHnGy
         W9l64RI0Z801FRJ2bnoeEZYg6YbjKUABly23dsTQTVFGJaljqYhPlytpr9QoVQQESvgd
         I9tSLKZC4h3MKu0T3TnTd0bFZvkdFhzwFYGf6x1DlUSks9FNR3rRfM+14a8Z2VWmNBHU
         wqGzUpq9/HmcS9Lu3cLHISEEAr9+ZGcBX/M/xrCfrNIeGmDSpJn/ig+B9kK0QZVSaBmR
         Ubyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ElqxuDCNQXRCZG67xnOLz5NHyRlQc3DQ9LW5Dv5Hebk=;
        b=EuP0hXbTTN5JFaSiqRwsO9WSN0lCw0se0DS4eE3h+BeCgL9HznI6IchAOjmn544Gdj
         tGHjNPRbVuM2vNXr8i/Juf07rkdN0fnjOXzTPZ5rKGAQodfjIMmw9haKtRgDr3jloDlc
         xbLE0ObX7NfR3UU5kU4ycDffF+KRUbxSkc62ywylgItt6QI1T4x/rhMRXPy48RMo47Ir
         DO8OthKHYQTAfxKhfsUuINl8rdRuVXbG03Vz+RmNznfo3fyVVGP4s7tFfe2HG+EvWNpy
         qdSgT8zEb2m3ih+6lFHcjz74Mk0JbYWvgaL6DgFtj7n2Fbj/bJKtNDR313nrbtiGeZiH
         rOhQ==
X-Gm-Message-State: AOAM532GbGqodbr5fc+fnWjXtZVO8SOQ/9QNmh87CLe7kQpLSYOkNyz1
        j5/dyIdyoROB0htH9xTXBoVJYQUByRGo/L+xtV4=
X-Google-Smtp-Source: ABdhPJxw0bWcPAFN3JvEWRyHkkJ9uMk0vNG3VXVIPDi5hPrsPr8C0inUhy0ywjoRwCJ018yHsiW2e59XxePNuJk0jw0=
X-Received: by 2002:a05:6902:114b:b0:663:95f6:93d0 with SMTP id
 p11-20020a056902114b00b0066395f693d0mr24845804ybu.537.1654824681051; Thu, 09
 Jun 2022 18:31:21 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>
Date:   Fri, 10 Jun 2022 09:32:17 +0800
Message-ID: <CAGcXWkzSrEPPT2m=2trWN-BV-ix9TcHCvZYya5i54ei=EWGTZw@mail.gmail.com>
Subject: [PATCH v9 2/2] dt-bindings:thermal: Add Sunplus schema
To:     krzk@kernel.org, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "lh.kuo" <lh.kuo@sunplus.com>,
        =?UTF-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Sunplus thermal driver

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v9:
 - Change the setting of compatible
 - Mosdify the setting of remove funciton.

 .../bindings/thermal/sunplus,thermal.yaml          | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
b/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
new file mode 100644
index 0000000..52094da
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sunplus,thermal.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sunplus,thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus Thermal controller
+
+maintainers:
+  - Li-hao Kuo <lhjeff911@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-thermal
+
+  reg:
+    maxItems: 1
+
+  nvmem-cells:
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: calib
+
+required:
+  - compatible
+  - reg
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal@9c000280 {
+        compatible = "sunplus,sp7021-thermal";
+        reg = <0x9c000280 0xc>;
+        nvmem-cells = <&calib>;
+        nvmem-cell-names = "calib";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 23bde07..a8c44eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19107,6 +19107,7 @@ SUNPLUS THERMAL DRIVER
 M: Li-hao Kuo <lhjeff911@gmail.com>
 L: linux-pm@vger.kernel.org
 S: Maintained
+F: Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 F: drivers/thermal/sunplus_thermal.c

 SUNPLUS UART DRIVER
-- 
2.7.4
