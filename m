Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2BA51E61A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446191AbiEGJdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245217AbiEGJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:33:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC66579AF;
        Sat,  7 May 2022 02:30:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d17so9628577plg.0;
        Sat, 07 May 2022 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SnDKaV6m5uTO8WyMT8BJL1DnEFJFIcp+zXxhePoxeC8=;
        b=HN6ms2lvs/dAEmDMSXqE67J41q5tLy20zKG4DXhd+FvIvDSIWPFdGlRGr4fuqOQpBv
         cyG9V9GxFT/FZHUZxudiuI6VHmAREL1/hBBlOTjnhUgPdc+QXSpz+US3zrTg4iLb3WIL
         /ZcQtNWkXk3KzH8Bbxez9U0RvsR3eJ+udbfdtxPWlzd3Rn0Yp+JndOPsge+3NN/Wd9eV
         0p5FepQlUP+CcPxb/AMNdUiTcIQdIYNfiedjlVzQcYkGQCve9JUmR2ecU2FBP8byda4v
         AEaz3cKzn+iZIUUIsIxTFZj3oDs0bklD0VzZZi1H9coSwqgTHKoocALYKbvLcLBqi0P9
         hJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnDKaV6m5uTO8WyMT8BJL1DnEFJFIcp+zXxhePoxeC8=;
        b=RS4hh/MKoX0w5S7lCn8HjkrWJdzpqzND1/zcFtn8WG2Z4QM7xo74Ho3+SD3gnmVsIs
         QmGHE1MTReFfCVw/d6xnmz31Haz6JJOCZrHwDUr2X5NGXRH7qtM1iBNx8PB6sQbzoUd2
         9I8OEldJNJLhOjJB7neM6Gg5NRkGC9yySQL7bqBdgxwFTCmLpIadBPuNXoaZTA3Ar93P
         /XiiELFkhA3pNAwHCynObVhC25/eS4HzJCDQq5tbL6F3lo1RAefh1jH/nna7724pWLoP
         D0oj6+Xb2mTxghjhHoz40JVxgEwanoT4Leej4NcCtf5hUDlE4qh6u/IiA740xg+mpU/u
         s6Lw==
X-Gm-Message-State: AOAM530RBqbr/VhV3RvasCPCiRgaELkOkevhMfJnN0cPe4acpz+Fr8sT
        Pyn+V6Y68QR7sPPeZdqUznQ=
X-Google-Smtp-Source: ABdhPJzmNrbx03kRnV4mCIIK+VYEimHvzCXVvKi1uOPCdOZFURep2XXlOTypo0Ae7S+OjHZbIz7WpQ==
X-Received: by 2002:a17:902:a501:b0:153:f956:29f0 with SMTP id s1-20020a170902a50100b00153f95629f0mr7764712plq.120.1651915803404;
        Sat, 07 May 2022 02:30:03 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b0015ee24acf38sm3212300plr.212.2022.05.07.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 02:30:02 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        heikki.krogerus@linux.intel.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: usb: Add documentation for sc27xx typec controller
Date:   Sat,  7 May 2022 17:29:52 +0800
Message-Id: <20220507092953.2273879-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507092953.2273879-1-gengcixi@gmail.com>
References: <20220507092953.2273879-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

The Spreadtrum PMIC SC27xx integrated typec port controller.
add the bindings to describe sc27xx typec controller.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 .../bindings/usb/sprd,sc27xx-typec.yaml       | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sprd,sc27xx-typec.yaml

diff --git a/Documentation/devicetree/bindings/usb/sprd,sc27xx-typec.yaml b/Documentation/devicetree/bindings/usb/sprd,sc27xx-typec.yaml
new file mode 100644
index 000000000000..6e49198c88da
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/sprd,sc27xx-typec.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Unisoc Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/sprd,sc27xx-typec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SC27XX Type-C port controller
+
+description:
+  The UNISOC, also know as Spreadtrum, SC27XX is a USB Type-C port controller which
+  supports role and plug orientation detection using the CC pins. It is
+  compatible with the USB Type-C Cable and Connector Specification v1.2.
+
+maintainers:
+  - Cixi Geng <gengcixi@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc2730-typec
+      - sprd,sc2721-typec
+      - sprd,ump96xx-typec
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  sprd,mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The Type-C port mode type
+
+  nvmem-cells:
+    maxItems: 2
+    description:
+      Reference to an nvmem node for the calibration data.
+
+  nvmem-cell-names:
+    items:
+      - const: typec_cc1_cal
+      - const: typec_cc2_cal
+
+required:
+  - compatible
+  - reg
+  - sprd,mode
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic_typec: typec@380 {
+                compatible = "sprd,sc2730-typec";
+                interrupt-parent = <&sc2730_pmic>;
+                interrupts = <8>;
+                reg = <0x380>;
+                sprd,mode = <2>;
+                nvmem-cells = <&typec_cc1_cal>, <&typec_cc2_cal>;
+                nvmem-cell-names = "typec_cc1_cal", "typec_cc2_cal";
+                status = "okay";
+        };
+    };
+...
-- 
2.25.1

