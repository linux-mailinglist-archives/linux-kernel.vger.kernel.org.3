Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8013749F109
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345415AbiA1Cek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbiA1Cej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:34:39 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2269C061714;
        Thu, 27 Jan 2022 18:34:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id v74so4797995pfc.1;
        Thu, 27 Jan 2022 18:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4VbGD7GwEeU/hWWctPt0+3UDwgyVueZAUB+e23LIpg4=;
        b=otaEjQdlKsHpWdpMmKTwrR7HYnUnVaX9Oqpeg/WVZJWTLhJpebgrm3OeNWMBUcd6HX
         XV8ZhHpXInJwH4yi28DiKUKNDPtGay9jLfDXDWQLvFWZDpDSMiC908s5CzewZgsosR89
         cE2rLTcNMEoRfjdU7D1O0lB+r8UHqeE4jptEMfDhNCHqp1u/9RXnhmvTBmO3ZE/EzV9d
         nHMWgljVl5dUdvmtzMdyYzmZ98Y4W2iMXC11hEIUaEJ+hjjTSMkOi0DPYj2CE8anB+oH
         oB2EBdqZRjghQJw4O7oFfmeGH4ABqMDuuqGsdXZq8UjhJXGa5FX0IgPwLYDMo+MIKP0x
         cQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4VbGD7GwEeU/hWWctPt0+3UDwgyVueZAUB+e23LIpg4=;
        b=TApnPz/bMGEq5zwIxla/3DbF/WCevCUA49yE8mUXavCE5jleXoiL6Cw2vrgo0YRh1e
         EN9sc9JNiH7EC+pSWPzHTCMfJuxSNjQsoYmiZ3cw9ghHXHzBAP8Y/4T4jSz9x9K4/Ag0
         94rwrAqG8qmSI0NN4Kv+j3JxQ4n6/+QIQ6eKdmoOFoNW1swisivIaB9vfkuWnDqgKra3
         7fAascwya89tE50A530VfnduGyXJ6dw9lagVDam6FVrmUQQxi8NUSD+P9AgvKIxZOEZl
         UL7f+NWKhDXXkatJj5NMaz9uKlEYbnADXfMvie7me6M9iGT6wCOGzYRysaQa5a2BJiRQ
         YSEA==
X-Gm-Message-State: AOAM532GhpRs5v98snIMbzrZURnacoRSN9bN2KdbOxh6ZBLz9wkmQFSZ
        4IaZd8GpPoL6YcdosMWBhV62Lf15bkyoOw==
X-Google-Smtp-Source: ABdhPJwwRePuM8LgX0EvNNzuNj4KZaT1Ju3pKnqgVGUlbuOqFqaOHFMy83rCCIX+nlzpmBxPlTbBlg==
X-Received: by 2002:a63:5455:: with SMTP id e21mr4840096pgm.9.1643337278234;
        Thu, 27 Jan 2022 18:34:38 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id u19sm7270683pfi.150.2022.01.27.18.34.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jan 2022 18:34:38 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH -next] dt-bindings:spi: Fix error for test.
Date:   Fri, 28 Jan 2022 10:34:50 +0800
Message-Id: <1643337290-1376-1-git-send-email-lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error for test remove the include path and modify parameters
---
 Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
index 24382cd..3dd164d 100644
--- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
@@ -20,8 +20,7 @@ properties:
 
   reg:
     items:
-      - the SPI master registers
-      - the SPI slave registers
+    minItems: 2
 
   reg-names:
     items:
@@ -59,8 +58,6 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/sp-sp7021.h>
-    #include <dt-bindings/reset/sp-sp7021.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     spi@9C002D80 {
         compatible = "sunplus,sp7021-spi";
@@ -73,8 +70,8 @@ examples:
         interrupts = <144 IRQ_TYPE_LEVEL_HIGH>,
                      <146 IRQ_TYPE_LEVEL_HIGH>,
                      <145 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&clkc SPI_COMBO_0>;
-        resets = <&rstc RST_SPI_COMBO_0>;
+        clocks = <&clkc 0x32>;
+        resets = <&rstc 0x22>;
         pinctrl-names = "default";
         pinctrl-0 = <&pins_spi0>;
     };
-- 
2.7.4

