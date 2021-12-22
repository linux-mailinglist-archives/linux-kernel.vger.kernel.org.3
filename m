Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DAA47CB18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbhLVBxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbhLVBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:52:53 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C1C061574;
        Tue, 21 Dec 2021 17:52:53 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id j17so633381qtx.2;
        Tue, 21 Dec 2021 17:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKI+im9qbJm1wftqrnhY+yP4QLsNjLsFVh65bGMKGCE=;
        b=gKm10mL8zoDzKnrrdn/QFeOqUYtZRCioDiCt6bsztszQ1L8plMCslCjPFqSxmr2AVR
         uDW/kjAgoizIyw+1VOyQjjgnPLOgcujwhbz4VO21lNeVvSzE38P2g3QLPnrB9cab1Lkc
         L9T+tSE7m6fcp6YcRsGm3PJf747E3P562BPB8Xr6anGCXN+P3HerDRe5ksk5bo5YKMQc
         q+nt8A0Y3+xGnPXqIUXU8yzAOdjcjAzKK7wd/KPI5nau02cCdHsjkaksdhiBwUPwfFfE
         RE2XY6hI+AWLYKMqGpa8Kiyptpl80xwidQnFPVpgKm0xocm7VqPvFv1fvcWU0zNbW636
         QG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKI+im9qbJm1wftqrnhY+yP4QLsNjLsFVh65bGMKGCE=;
        b=YW1A+gUwU1u5YTnhH9t1IUK+ghVlTiQ0YgXYpAwPvd4p0hy6XX4d4DNEX6cmCTX1Dn
         htD44I0poFhxF1Mvf2JdgoyV4sN2+kI57wTMfX21NH78cichO3wzOqAlzfOAlxudQtJb
         UngWum6iH736eYzIS4hWP0V8QQqCe/UbYSrePApJuFHgiATrnAipXw2OPPwvmjAusRyV
         TwkIyywp0xE6YF5Bxi8Stq1EP5eIrwKAmrfas3XSYf+85Qvb7iJuM/2zqNOX73ZvxYm6
         UIviw4qOgIShuwXzsVsTrYa8ayNsq+F/UQTihgBNKnkY+pORE18HKGgbwawixJp/9EEX
         K9sA==
X-Gm-Message-State: AOAM531DpffnyenA5fNHvwO0jIQsi0TdFWBJb7U1a3impfneGU4GdSvw
        1FBLX8kYtW1/c8LLS1JWJzI=
X-Google-Smtp-Source: ABdhPJwqPvr/P/+cDZAx9gJuJNEv9SpEKDa08meJhy3WTz73hW0byac4EOkME2m9ArRJaX7ynbP83g==
X-Received: by 2002:a05:622a:1cd:: with SMTP id t13mr736105qtw.487.1640137972623;
        Tue, 21 Dec 2021 17:52:52 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id d4sm658161qkn.79.2021.12.21.17.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 17:52:52 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v6 4/7] dt-bindings: clock: imx: Add documentation for i.MXRT1050 clock
Date:   Tue, 21 Dec 2021 20:52:41 -0500
Message-Id: <20211222015244.2464671-5-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222015244.2464671-1-Mr.Bossman075@gmail.com>
References: <20211222015244.2464671-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Taube <mr.bossman075@gmail.com>

Add DT binding documentation for i.MXRT1050 clock driver.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1->V2:
* Replace macros with values
V2->V3:
* Remove anatop
* Use lpuart not gpt
* include imxrt1050-clock.h
* 2 space tabs to 4
* Remove oneOf enum
* Change maxItems to 2
V3->V4:
* Nothing done
V4->V5:
* Remove extra newline
* Rename ccm to clock-controller
* Change minItems to const
* Change minItems to description
* Rename file to add 1050
* Change commit description to just 1050
V5->V6:
* Add maxItems for clocks description
---
 .../bindings/clock/imxrt1050-clock.yaml       | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml b/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
new file mode 100644
index 000000000000..35fd08c143f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imxrt1050-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MXRT
+
+maintainers:
+  - Giulio Benetti <giulio.benetti@benettiengineering.com>
+  - Jesse Taube <Mr.Bossman075@gmail.com>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. See include/dt-bindings/clock/imxrt*-clock.h
+  for the full list of i.MXRT clock IDs.
+
+properties:
+  compatible:
+    const: fsl,imxrt1050-ccm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  clocks:
+    description: 24m osc
+    maxItems: 1
+
+  clock-names:
+    const: osc
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imxrt1050-clock.h>
+
+    clks: clock-controller@400fc000 {
+        compatible = "fsl,imxrt1050-ccm";
+        reg = <0x400fc000 0x4000>;
+        interrupts = <95>, <96>;
+        clocks = <&osc>;
+        clock-names = "osc";
+        #clock-cells = <1>;
+    };
+
+    lpuart1: serial@40184000 {
+        compatible = "fsl,imxrt1050-lpuart";
+        reg = <0x40184000 0x4000>;
+        interrupts = <20>;
+        clocks = <&clks IMXRT1050_CLK_LPUART1>;
+        clock-names = "ipg";
+    };
-- 
2.34.1

