Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4B24DA504
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352136AbiCOWHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352115AbiCOWHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:07:08 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8014745AFC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:05:54 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A900B2C0ACC;
        Tue, 15 Mar 2022 22:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647381952;
        bh=aI3QLwybL+R3Ug9pWHEKAZLgHlnzepQBa1pvlTSVses=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMyQx1mIIYFHu6gkbosx638jI6UaI3yMlYEXriyzeynkx7Q1t0feys6kyJmURA9kM
         kT5QVenxH3NAthXBLxujvCgZRvx/NO+4F72KvXw42k2uV2DqBWRStp1sbwH2RqvTj8
         cxoB2qISm8N+HQ9iieXB5LS45+sGXp+WV5KMV2YT4d8gbDKRef1gmVO8WdEqgH1Wyc
         fQddECsy9Sgzkp8o3wFHMiZzsKAhrrsrYVuiPPm3cg4UNz6KkBR2KLJriMPmNeWlEt
         lQCeRwtGTDM0nxbcy8may6Tk7HDy5dvAryg6x6SLrxPtBBY/nawunj/hEilGk4Fczk
         N4bwQeYG6DxOg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62310dc00001>; Wed, 16 Mar 2022 11:05:52 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 5984713EE37;
        Wed, 16 Mar 2022 11:05:52 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 416AC2A2677; Wed, 16 Mar 2022 11:05:51 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     huziji@marvell.com, ulf.hansson@linaro.org, robh+dt@kernel.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/2] dt-bindings: mmc: xenon: add AC5 compatible string
Date:   Wed, 16 Mar 2022 11:05:48 +1300
Message-Id: <20220315220549.2749328-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315220549.2749328-1-chris.packham@alliedtelesis.co.nz>
References: <20220315220549.2749328-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=TYgE4sUc-WweND1bkCEA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Import binding documentation from the Marvell SDK which adds
marvell,ac5-sdhci compatible string and documents the requirements for
the for the Xenon SDHCI controller on the 98DX2530.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    Changes in v3:
    - Split from larger series
    - Add review from Andrew
    Changes in v2:
    - New

 .../bindings/mmc/marvell,xenon-sdhci.txt      | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.tx=
t b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
index c51a62d751dc..43df466f0cb3 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
@@ -14,6 +14,7 @@ Required Properties:
   - "marvell,armada-ap806-sdhci": For controllers on Armada AP806.
   - "marvell,armada-ap807-sdhci": For controllers on Armada AP807.
   - "marvell,armada-cp110-sdhci": For controllers on Armada CP110.
+  - "marvell,ac5-sdhci": For CnM on AC5, AC5X and derived.
=20
 - clocks:
   Array of clocks required for SDHC.
@@ -33,6 +34,13 @@ Required Properties:
     in below.
     Please also check property marvell,pad-type in below.
=20
+  * For "marvell,ac5-sdhci", one or two register areas.
+    (reg-names "ctrl" & "decoder").
+    The first one is mandatory for the Xenon IP registers.
+    The second one is for systems where DMA mapping is required and is t=
he
+    related address decoder register (the value to configure is derived =
from
+    the parent "dma-ranges").
+
   * For other compatible strings, one register area for Xenon IP.
=20
 Optional Properties:
@@ -171,3 +179,47 @@ Example:
=20
 		marvell,pad-type =3D "sd";
 	};
+
+
+- For eMMC with compatible "marvell,ac5-sdhci" with one reg range (no dm=
a):
+	sdhci0: sdhci@805c0000 {
+		compatible =3D "marvell,ac5-sdhci";
+		reg =3D <0x0 0x805c0000 0x0 0x300>;
+		reg-names =3D "ctrl", "decoder";
+		interrupts =3D <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+		clocks =3D <&core_clock>;
+		clock-names =3D "core";
+		status =3D "okay";
+		bus-width =3D <8>;
+		/*marvell,xenon-phy-slow-mode;*/
+		non-removable;
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		mmc-hs400-1_8v;
+	};
+
+- For eMMC with compatible "marvell,ac5-sdhci" with two reg ranges (with=
 dma):
+	mmc_dma: mmc-dma-peripherals@80500000 {
+		compatible =3D "simple-bus";
+		#address-cells =3D <0x2>;
+		#size-cells =3D <0x2>;
+		ranges;
+		dma-ranges =3D <0x2 0x0 0x2 0x80000000 0x1 0x0>;
+		dma-coherent;
+
+		sdhci0: sdhci@805c0000 {
+			compatible =3D "marvell,ac5-sdhci", "marvell,armada-ap806-sdhci";
+			reg =3D <0x0 0x805c0000 0x0 0x300>, <0x0 0x80440230 0x0 0x4>;
+			reg-names =3D "ctrl", "decoder";
+			interrupts =3D <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&core_clock>;
+			clock-names =3D "core";
+			status =3D "okay";
+			bus-width =3D <8>;
+			/*marvell,xenon-phy-slow-mode;*/
+			non-removable;
+			mmc-ddr-1_8v;
+			mmc-hs200-1_8v;
+			mmc-hs400-1_8v;
+		};
+	};
--=20
2.35.1

