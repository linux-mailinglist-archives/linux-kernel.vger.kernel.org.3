Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1247D4682A7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbhLDGOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbhLDGON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:14:13 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B70C061751;
        Fri,  3 Dec 2021 22:10:48 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id n15so5718404qta.0;
        Fri, 03 Dec 2021 22:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZzll1NvlYUi9tw5UeTEbg0jqNcXl/cAUbiZhgavzag=;
        b=Q4nSugKwo/e7P4oirQJWNn4CEBMcQvnIKD3q5wttbN1uHG/J7kPCIVzzAyy83R4Jj2
         N8gARBqv5ZKnu3lepAX9Imp+Wx92Ljy5m/UK4AAmT7dsc63k6AJZa+4WgIDPlr1Y0slG
         qjT/tTVlLTWRqu/egqfgBzmIEdkyL0d894FV2lytfLMel3CoIq3xuT0dub1kNCT9Bja3
         Q7AVrRg4D00jKL4+6HbCpgmcQMdFD/Huc4c7RwQj65Uj8jd3CgaWcTSNZ8vuGO7rX0Jt
         av6Ebu2FjQL3E6K1kmDmPxO3Oil/moKaRxY3u5ZgIOQDpZkWUvQxrtmVuE5Gy6KzfXYu
         auTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZzll1NvlYUi9tw5UeTEbg0jqNcXl/cAUbiZhgavzag=;
        b=e/OEMxaNv0AcNUZOfx/+hqead2q5t2TwDaenbIgvZ0fTpQQkGwtd6LFGbSAjRVFdf3
         owPFDcF770eG7kJb178xBWwXgA1VeXEvirzXdTz9g9DPfMfpaKGrvCo5sgbWg+1E+WiP
         uFxldgaI8Qm27r1CSMquzGjhij61N+S8S2ArHg5ge7Wo6RFItISGWda8o/tws6MSd3G5
         +JyizPOQYE1M2CUkFdr5ukSFrldYiS7wXh1KWO8ZTsNUpI6Uk5+b5NZ748EJVpRZlbVU
         yFe+pRQXnvmgNJF/G7oh+tc9t541EsSKOld2gI+uYiv4YzANL7twkllIDes9Mbah56Ok
         ulKA==
X-Gm-Message-State: AOAM532/mdbWUAp/gzezRvd3gazOvKfsYU9Bh9O+1ZjwgoGaWbGUhwyc
        2z38B3ql1GuxHX81EkAYldE=
X-Google-Smtp-Source: ABdhPJwBe+Bo01JmYoEZJB0UR+he5xjzJib62CqZBZJG4oBKSdY6RlYb5BGngvmTZF7xMc1zlMWRlw==
X-Received: by 2002:a05:622a:148:: with SMTP id v8mr25636973qtw.459.1638598247653;
        Fri, 03 Dec 2021 22:10:47 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l1sm3500913qkp.125.2021.12.03.22.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 22:10:47 -0800 (PST)
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
        linux-serial@vger.kernel.org,
        Jesse Taube <mr.bossman075@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 02/13] dt-bindings: pinctrl: add i.MXRT1050 pinctrl binding doc
Date:   Sat,  4 Dec 2021 01:10:31 -0500
Message-Id: <20211204061042.1248028-3-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Taube <mr.bossman075@gmail.com>

Add i.MXRT1050 pinctrl binding doc

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V1->V2:
* Replace macros with values
* Add tab for last pinctrl value
V2->V3:
* Remove imxrt1050-evk container
* Remove unnecessary handles
* 2 space tabs to 4
V3->V4:
* Nothing done
---
 .../bindings/pinctrl/fsl,imxrt1050.yaml       | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml
new file mode 100644
index 000000000000..1278f7293560
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,imxrt1050.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale IMXRT1050 IOMUX Controller
+
+maintainers:
+  - Giulio Benetti <giulio.benetti@benettiengineering.com>
+  - Jesse Taube <Mr.Bossman075@gmail.com>
+
+description:
+  Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
+  for common binding part and usage.
+
+properties:
+  compatible:
+    const: fsl,imxrt1050-iomuxc
+
+  reg:
+    maxItems: 1
+
+# Client device subnode's properties
+patternProperties:
+  'grp$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+
+    properties:
+      fsl,pins:
+        description:
+          each entry consists of 6 integers and represents the mux and config
+          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
+          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
+          be found in <include/dt-bindings/pinctrl/pins-imxrt1050.h>. The last
+          integer CONFIG is the pad setting value like pull-up on this pin. Please
+          refer to i.MXRT1050 Reference Manual for detailed CONFIG settings.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        items:
+          items:
+            - description: |
+                "mux_reg" indicates the offset of mux register.
+            - description: |
+                "conf_reg" indicates the offset of pad configuration register.
+            - description: |
+                "input_reg" indicates the offset of select input register.
+            - description: |
+                "mux_val" indicates the mux value to be applied.
+            - description: |
+                "input_val" indicates the select input value to be applied.
+            - description: |
+                "pad_setting" indicates the pad configuration value to be applied.
+
+    required:
+      - fsl,pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    iomuxc: iomuxc@401f8000 {
+        compatible = "fsl,imxrt1050-iomuxc";
+        reg = <0x401f8000 0x4000>;
+
+        pinctrl_lpuart1: lpuart1grp {
+            fsl,pins =
+              <0x0EC 0x2DC 0x000 0x2 0x0	0xf1>,
+              <0x0F0 0x2E0 0x000 0x2 0x0	0xf1>;
+        };
+    };
-- 
2.34.0

