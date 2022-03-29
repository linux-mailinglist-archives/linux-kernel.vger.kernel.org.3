Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2479D4EA40F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiC2AEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiC2AEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:04:24 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7ADFD03
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:02:41 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C1D402C0A4C;
        Tue, 29 Mar 2022 00:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648512159;
        bh=Wm7ZrsbohwxyPXzOAcMh/4fpLkArv/rUjr/HHU89ikw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZf+fuBINh8I9vi4RpSVoaBRFH7agRn7JpmMYLM6pxL54S5toDCPUg8+cnx5LxnIG
         ZaJP5dDCLMq6rPxP6iWmdHCIWuPO1ZW/TEc4MdgWHylEkBSIIloi42qOTgn/vr8+1N
         gWoR+KvfBhLo0Qzr1eqdijx45b23WmF7+gLhy0QMf+/rG4EPBTH6wxmEh/nlvaSiDl
         eJ2fgOlyIVkTPZMutWxQtRh1YeGF97XtgKvAiSSmL6mDlIHKqNBjRovSCBJVlwfQkb
         88GGMHV1JwDono8xmwXMSlbI9M9H90eb9vZiluTf/ypeGqrM4N7H+Zn37mDEFn2ZiP
         bKOoadtSxmWVw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62424c9f0001>; Tue, 29 Mar 2022 13:02:39 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 7103F13EE82;
        Tue, 29 Mar 2022 13:02:39 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id CAD142A2678; Tue, 29 Mar 2022 13:02:35 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        huziji@marvell.com, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 1/2] arm64: dts: marvell: Update sdhci node names to match schema
Date:   Tue, 29 Mar 2022 13:02:30 +1300
Message-Id: <20220329000231.3544810-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329000231.3544810-1-chris.packham@alliedtelesis.co.nz>
References: <20220329000231.3544810-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=AgHtZ1O-xYyxAwoHFCcA:9 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the node names of the sdhci@ interfaces to be mmc@ to match the
node name enforced by the mmc-controller.yaml schema.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Notes:
    This has been sent separately [1] but on Krzysztof's advice I've
    included it in v3 of this series.
   =20
    [1] -  https://lore.kernel.org/linux-arm-kernel/20220321212007.296158=
1-1-chris.packham@alliedtelesis.co.nz/
    Changes in v4:
    - None
    Changes in v3:
    - New

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  | 4 ++--
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-37xx.dtsi
index 30233de58bb3..78adb803df26 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -434,7 +434,7 @@ rwtm: mailbox@b0000 {
 				#mbox-cells =3D <1>;
 			};
=20
-			sdhci1: sdhci@d0000 {
+			sdhci1: mmc@d0000 {
 				compatible =3D "marvell,armada-3700-sdhci",
 					     "marvell,sdhci-xenon";
 				reg =3D <0xd0000 0x300>,
@@ -445,7 +445,7 @@ sdhci1: sdhci@d0000 {
 				status =3D "disabled";
 			};
=20
-			sdhci0: sdhci@d8000 {
+			sdhci0: mmc@d8000 {
 				compatible =3D "marvell,armada-3700-sdhci",
 					     "marvell,sdhci-xenon";
 				reg =3D <0xd8000 0x300>,
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/b=
oot/dts/marvell/armada-ap80x.dtsi
index 6614472100c2..a06a0a889c43 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -250,7 +250,7 @@ watchdog: watchdog@610000 {
 				interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			};
=20
-			ap_sdhci0: sdhci@6e0000 {
+			ap_sdhci0: mmc@6e0000 {
 				compatible =3D "marvell,armada-ap806-sdhci";
 				reg =3D <0x6e0000 0x300>;
 				interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/b=
oot/dts/marvell/armada-cp11x.dtsi
index 3bd2182817fb..d6c0990a267d 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -493,7 +493,7 @@ CP11X_LABEL(trng): trng@760000 {
 			status =3D "okay";
 		};
=20
-		CP11X_LABEL(sdhci0): sdhci@780000 {
+		CP11X_LABEL(sdhci0): mmc@780000 {
 			compatible =3D "marvell,armada-cp110-sdhci";
 			reg =3D <0x780000 0x300>;
 			interrupts =3D <27 IRQ_TYPE_LEVEL_HIGH>;
--=20
2.35.1

