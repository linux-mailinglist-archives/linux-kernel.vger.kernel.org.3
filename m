Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D99046A072
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388277AbhLFQEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442880AbhLFP4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:56:20 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30141C08E847;
        Mon,  6 Dec 2021 07:40:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso10707231wmr.4;
        Mon, 06 Dec 2021 07:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IFFwKnk3cbAW8jNrxL+vFBZxoatRvN6SQuYnsDGyFVg=;
        b=RPtBn2mfNXoGjx1ojHeBAnLO1qVUSVt60HBdLecCMRKrHAqjM9GVSFYjinL9lWiLaq
         4rK1gjllQ07iaXREVS0oT3bUlViUpM8UTUlvjeeF7w/dlqhW6nfQS8q4i1HFNU8SScSf
         i1a7+jP8rB7SiCAfyJLrvwHE7UfRCnaHZmVkGra3o9pUotIYfmaoS2SMwfvGgREGNbB0
         /IKUC8NqxE9ayTwn6B8bsipozMJRhj1xdSpw1zd0UQgJReAE3jVskGDKXO5vNZLwmFXE
         nkEY8Wfd4NT0CSGiQtA1NiIULZfrJKzAtODVwIwUsoZxSdsmHzIQqG7Z2iFQlZlFC7Jk
         SpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IFFwKnk3cbAW8jNrxL+vFBZxoatRvN6SQuYnsDGyFVg=;
        b=WYdNW/Ar9nSdBZaef2NLNz5JYBi/885VbgjA6fKOsDAvL+9037+6rRj7KBtG9ZTMXw
         XEmiRFfxCWBMYNeei2Ezmv/apLCZhtALDPNp6GwzenkNc35aBfkBzmfT43SJZQ/H4lsr
         7GDAY0NQdfRtAun2dn2ZONj+qyYvbn8Cgw9YUdhsz+MGt1U9rp3NoRa0u/QOCPZRn9kE
         FuWiYK95HslbjwH2Qsne2vjxuyF6VVBUYD4CByrwqGynCn4ydUVqaXG7JnJhZEd/f9Vf
         7A/YtK7hK7wuxc62zmzbIOBBBVbIlSePXy9+2KeIMa2ZYyKf+SdY1UwiQbwsDwoBNMb6
         4Rvw==
X-Gm-Message-State: AOAM533yOZOB4X4Y8leWBE2iPPI0Ixzrzdtw/d6poP0hsiky5YibgwGJ
        0UfPXn3cHQnrFHJNE1kGfGM=
X-Google-Smtp-Source: ABdhPJwIK1sZU+XX7uJLcxtVSFOv7RHxMzHCbd/T22a1Vi+8Lo/paQlu7PYjqZSC8rSBYq+OerekTw==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr39332252wmg.86.1638805233630;
        Mon, 06 Dec 2021 07:40:33 -0800 (PST)
Received: from localhost (pd9e51d39.dip0.t-ipconnect.de. [217.229.29.57])
        by smtp.gmail.com with ESMTPSA id u15sm10643561wmq.13.2021.12.06.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:40:33 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: regulators: Document Tegra regulator coupling in json-schema
Date:   Mon,  6 Dec 2021 16:40:32 +0100
Message-Id: <20211206154032.227938-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Move the NVIDIA Tegra regulator coupling bindings from the free-form
text format into the existing json-schema file for regulators.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../nvidia,tegra-regulators-coupling.txt      | 65 -------------------
 .../bindings/regulator/regulator.yaml         | 22 +++++++
 2 files changed, 22 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt

diff --git a/Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt b/Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
deleted file mode 100644
index 4bf2dbf7c6cc..000000000000
--- a/Documentation/devicetree/bindings/regulator/nvidia,tegra-regulators-coupling.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-NVIDIA Tegra Regulators Coupling
-================================
-
-NVIDIA Tegra SoC's have a mandatory voltage-coupling between regulators.
-Thus on Tegra20 there are 3 coupled regulators and on NVIDIA Tegra30
-there are 2.
-
-Tegra20 voltage coupling
-------------------------
-
-On Tegra20 SoC's there are 3 coupled regulators: CORE, RTC and CPU.
-The CORE and RTC voltages shall be in a range of 170mV from each other
-and they both shall be higher than the CPU voltage by at least 120mV.
-
-Tegra30 voltage coupling
-------------------------
-
-On Tegra30 SoC's there are 2 coupled regulators: CORE and CPU. The CORE
-and CPU voltages shall be in a range of 300mV from each other and CORE
-voltage shall be higher than the CPU by N mV, where N depends on the CPU
-voltage.
-
-Required properties:
-- nvidia,tegra-core-regulator: Boolean property that designates regulator
-  as the "Core domain" voltage regulator.
-- nvidia,tegra-rtc-regulator: Boolean property that designates regulator
-  as the "RTC domain" voltage regulator.
-- nvidia,tegra-cpu-regulator: Boolean property that designates regulator
-  as the "CPU domain" voltage regulator.
-
-Example:
-
-	pmic {
-		regulators {
-			core_vdd_reg: core {
-				regulator-name = "vdd_core";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-coupled-with = <&rtc_vdd_reg &cpu_vdd_reg>;
-				regulator-coupled-max-spread = <170000 550000>;
-
-				nvidia,tegra-core-regulator;
-			};
-
-			rtc_vdd_reg: rtc {
-				regulator-name = "vdd_rtc";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-coupled-with = <&core_vdd_reg &cpu_vdd_reg>;
-				regulator-coupled-max-spread = <170000 550000>;
-
-				nvidia,tegra-rtc-regulator;
-			};
-
-			cpu_vdd_reg: cpu {
-				regulator-name = "vdd_cpu";
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1125000>;
-				regulator-coupled-with = <&core_vdd_reg &rtc_vdd_reg>;
-				regulator-coupled-max-spread = <550000 550000>;
-
-				nvidia,tegra-cpu-regulator;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml b/Documentation/devicetree/bindings/regulator/regulator.yaml
index ed560ee8714e..14f269f1e877 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/regulator.yaml
@@ -224,6 +224,28 @@ properties:
     description: Maximum difference between current and target voltages
       that can be changed safely in a single step.
 
+  # NVIDIA Tegra SoC's have a mandatory voltage-coupling between regulators. Thus on Tegra20 there
+  # are 3 coupled regulators and on NVIDIA Tegra30 there are 2.
+  #
+  # The 3 coupled regulators on Tegra20 are: CORE, RTC and CPU. The CORE and RTC voltages shall be
+  # in a range of 170 mV of each other and they both shall be higher than the CPU voltage by at
+  # least 120 mV.
+  #
+  # The 2 coupled regulators on Tegra30 are: CORE and CPU. The CORE and CPU voltages shall be in
+  # a range of 300 mV of each other and CORE voltage shall be higher than the CPU by N mV, where
+  # N depends on the CPU voltage.
+  nvidia,tegra-core-regulator:
+    $ref: "/schemas/types.yaml#/definitions/flag"
+    description: if present, designates the regulator as the "CORE domain" voltage regulator
+
+  nvidia,tegra-rtc-regulator:
+    $ref: "/schemas/types.yaml#/definitions/flag"
+    description: if present, designates the regulator as the "RTC domain" voltage regulator
+
+  nvidia,tegra-cpu-regulator:
+    $ref: "/schemas/types.yaml#/definitions/flag"
+    description: if present, designates the regulator as the "CPU domain" voltage regulator
+
 patternProperties:
   ".*-supply$":
     description: Input supply phandle(s) for this node
-- 
2.33.1

