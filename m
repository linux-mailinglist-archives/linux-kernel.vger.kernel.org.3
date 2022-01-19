Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859D2493748
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353125AbiASJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353091AbiASJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:28:50 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC60C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:28:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id x83so1893926pgx.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AEMYWaSEel8Cp4M82ZW85fUPHW8FXC9jvw93/++Wovk=;
        b=ezn/qJM7sxbIkM29eOAixvkIHUFcHSL+GXFG8F5i0B4NlzOAQ3nNurzh43WyO1Q8Z7
         2LP/B9CWpDPCGL1iVN8vr+JpTwRbsSrbjWhwnflX34ph08iMbWRPaam63hSGgc7bA4OJ
         eDBMvjSoBo8kBDrtTEdy2inGeaFAWcKnty1zrhcpzbm9XBMsbWJYAePXr7f7bXYxN/gi
         ecSbdEpEelkaENONBeR7cBqwwyCkNtPOtBOC0MCfm1spfL78WRFd3EfMwvCaJ7/xCCFx
         /mfD+XvxvpRqyXWGmLHJYyoeU14XgF6uW+/YNMQTFYPXEL+dP+FfFOjeDsignik7Eo8e
         6xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AEMYWaSEel8Cp4M82ZW85fUPHW8FXC9jvw93/++Wovk=;
        b=yGyFqPhDZIcyvrl+r/Bozp5oXNrzVp/+n2W+3SV1BW0woZk5ZcdfsP5ouAo9Yh8S6z
         y1DIT4QCqxKNI4rkqHlacqnHUVgU3E0vxQrsg97J9tw80SO0SiN/XcrAmVV5abyOjkWz
         NyqzDQXf+Um74ujAIYBRNJzRgzAj2M8CVHi+oSO+1YZ07FtwQmng+/ylX3rVyeWQvqL0
         CQu3dJ1Nq4vvmw5YKSfIF551MC9ZIbLwKmuCgq3iRjNYFq1n0b9g0n/6DCxyOXoJcBez
         C+NJZ2J8oKQdybjapz0KQktjmR2Rz8s2dv6qNlWR8+/ETG0G8+Ef/ZZCky5+cs05LzHg
         Jk4A==
X-Gm-Message-State: AOAM530qv7LNB6F4TNoIDBcneYbMfq/FpiZq/EZhcUMH6UzKRVy/rlV8
        e+ioy5uIMYVi9CSxkBcjOODk7Q==
X-Google-Smtp-Source: ABdhPJyoYH6hpuE6wwoRFycNZ0mY/1V2rBlplF2VQiYHcx/nwAScjQ89HomKMDFJA0dt7UXy6/o71A==
X-Received: by 2002:a65:690a:: with SMTP id s10mr23376522pgq.48.1642584529158;
        Wed, 19 Jan 2022 01:28:49 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id y8sm1415894pfl.207.2022.01.19.01.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 01:28:48 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 1/4] dt-bindings: change the macro name of prci in header files and example
Date:   Wed, 19 Jan 2022 17:28:38 +0800
Message-Id: <81d9a152e65374117b633f953aa31f378412acb5.1642582832.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642582832.git.zong.li@sifive.com>
References: <cover.1642582832.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently change the macro name for fu540 and fu740 by adding the
prefix respectively, the dt-bindings should be modified as well.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 .../devicetree/bindings/gpio/sifive,gpio.yaml  |  2 +-
 .../bindings/pci/sifive,fu740-pcie.yaml        |  2 +-
 .../bindings/serial/sifive-serial.yaml         |  2 +-
 include/dt-bindings/clock/sifive-fu540-prci.h  |  8 ++++----
 include/dt-bindings/clock/sifive-fu740-prci.h  | 18 +++++++++---------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
index c2902aac2514..eaf3210fa90c 100644
--- a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
@@ -79,7 +79,7 @@ examples:
         interrupt-parent = <&plic>;
         interrupts = <7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22>;
         reg = <0x10060000 0x1000>;
-        clocks = <&tlclk PRCI_CLK_TLCLK>;
+        clocks = <&tlclk FU540_PRCI_CLK_TLCLK>;
         gpio-controller;
         #gpio-cells = <2>;
         interrupt-controller;
diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
index 2b9d1d6fc661..6e6860551d33 100644
--- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -105,7 +105,7 @@ examples:
                             <0x0 0x0 0x0 0x3 &plic0 59>,
                             <0x0 0x0 0x0 0x4 &plic0 60>;
             clock-names = "pcie_aux";
-            clocks = <&prci PRCI_CLK_PCIE_AUX>;
+            clocks = <&prci FU740_PRCI_CLK_PCIE_AUX>;
             resets = <&prci 4>;
             pwren-gpios = <&gpio 5 0>;
             reset-gpios = <&gpio 8 0>;
diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
index 09aae43f65a7..b0a8871e3641 100644
--- a/Documentation/devicetree/bindings/serial/sifive-serial.yaml
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
@@ -59,7 +59,7 @@ examples:
         interrupt-parent = <&plic0>;
         interrupts = <80>;
         reg = <0x10010000 0x1000>;
-        clocks = <&prci PRCI_CLK_TLCLK>;
+        clocks = <&prci FU540_PRCI_CLK_TLCLK>;
       };
 
 ...
diff --git a/include/dt-bindings/clock/sifive-fu540-prci.h b/include/dt-bindings/clock/sifive-fu540-prci.h
index 3b21d0522c91..5af372e8385f 100644
--- a/include/dt-bindings/clock/sifive-fu540-prci.h
+++ b/include/dt-bindings/clock/sifive-fu540-prci.h
@@ -10,9 +10,9 @@
 
 /* Clock indexes for use by Device Tree data and the PRCI driver */
 
-#define PRCI_CLK_COREPLL	       0
-#define PRCI_CLK_DDRPLL		       1
-#define PRCI_CLK_GEMGXLPLL	       2
-#define PRCI_CLK_TLCLK		       3
+#define FU540_PRCI_CLK_COREPLL		0
+#define FU540_PRCI_CLK_DDRPLL		1
+#define FU540_PRCI_CLK_GEMGXLPLL	2
+#define FU540_PRCI_CLK_TLCLK		3
 
 #endif
diff --git a/include/dt-bindings/clock/sifive-fu740-prci.h b/include/dt-bindings/clock/sifive-fu740-prci.h
index 7899b7fee7db..672bdadbf6c0 100644
--- a/include/dt-bindings/clock/sifive-fu740-prci.h
+++ b/include/dt-bindings/clock/sifive-fu740-prci.h
@@ -11,14 +11,14 @@
 
 /* Clock indexes for use by Device Tree data and the PRCI driver */
 
-#define PRCI_CLK_COREPLL	       0
-#define PRCI_CLK_DDRPLL		       1
-#define PRCI_CLK_GEMGXLPLL	       2
-#define PRCI_CLK_DVFSCOREPLL	       3
-#define PRCI_CLK_HFPCLKPLL	       4
-#define PRCI_CLK_CLTXPLL	       5
-#define PRCI_CLK_TLCLK		       6
-#define PRCI_CLK_PCLK		       7
-#define PRCI_CLK_PCIE_AUX	       8
+#define FU740_PRCI_CLK_COREPLL		0
+#define FU740_PRCI_CLK_DDRPLL		1
+#define FU740_PRCI_CLK_GEMGXLPLL	2
+#define FU740_PRCI_CLK_DVFSCOREPLL	3
+#define FU740_PRCI_CLK_HFPCLKPLL	4
+#define FU740_PRCI_CLK_CLTXPLL		5
+#define FU740_PRCI_CLK_TLCLK		6
+#define FU740_PRCI_CLK_PCLK		7
+#define FU740_PRCI_CLK_PCIE_AUX		8
 
 #endif	/* __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H */
-- 
2.31.1

