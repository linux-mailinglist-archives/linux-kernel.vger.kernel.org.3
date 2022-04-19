Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0EA50624A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbiDSCtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345222AbiDSCtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:49:02 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344B7222A7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:46:19 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 218962C0659;
        Tue, 19 Apr 2022 02:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1650336376;
        bh=i5eYgMZr5aLbRHOJjcNjJVc/0nEpd8scqbB42mFDDSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1mnjeUij2DmYMkGh6cL0kvqs8z+H1/eAqMYKwwbXt4RrjctdcC0h1rQ4BzT5LuRA/
         4ls0b2jsYjoy8cCUuhf7zO76h9BY7RsYUKrBsxBBsYDh7zvp+itaDQkR/CTgUX9M3n
         jJp5rGBLcicO0ubugxct0u6Nmi3S1f9IdAirtCYT4BzFNppKNf90Rz/oMi5fOgCD1T
         TzmFTlyg0t9xODzDJOIQA4fPitXbAp4CevLZfGgWkz8WGQAXHnl3JTg/Nn/aWTeddM
         It1ECM/Ls4Y/l47sYg//dpQVtXQrhZxN/wpCuPZpnHONHLQS4DTUBTdy9x1I1hshFT
         CnpLOXJCKIpUA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B625e22770001>; Tue, 19 Apr 2022 14:46:15 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id E47C713EE37;
        Tue, 19 Apr 2022 14:46:15 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4A6E12A2679; Tue, 19 Apr 2022 14:46:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, adrian.hunter@intel.com,
        nico@fluxnic.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/4] ARM: dts: mvebu: Update mvsdio node names to match schema
Date:   Tue, 19 Apr 2022 14:46:08 +1200
Message-Id: <20220419024611.1327525-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=RL7N4Lq+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=z0gMJWrwH1QA:10 a=AgHtZ1O-xYyxAwoHFCcA:9
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

Update the node names of the mvsdio@ interfaces to be mmc@ to match the
node name enforced by the mmc-controller.yaml schema.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - None

 arch/arm/boot/dts/armada-370-xp.dtsi | 2 +-
 arch/arm/boot/dts/armada-375.dtsi    | 2 +-
 arch/arm/boot/dts/kirkwood-6192.dtsi | 2 +-
 arch/arm/boot/dts/kirkwood-6281.dtsi | 2 +-
 arch/arm/boot/dts/kirkwood-6282.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/arm=
ada-370-xp.dtsi
index 0b8c2a64b36f..c611166b6dc5 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -252,7 +252,7 @@ nand_controller: nand-controller@d0000 {
 				status =3D "disabled";
 			};
=20
-			sdio: mvsdio@d4000 {
+			sdio: mmc@d4000 {
 				compatible =3D "marvell,orion-sdio";
 				reg =3D <0xd4000 0x200>;
 				interrupts =3D <54>;
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada=
-375.dtsi
index 7f2f24a29e6c..802cabb8dd8a 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -510,7 +510,7 @@ nand_controller: nand-controller@d0000 {
 				status =3D "disabled";
 			};
=20
-			sdio: mvsdio@d4000 {
+			sdio: mmc@d4000 {
 				compatible =3D "marvell,orion-sdio";
 				reg =3D <0xd4000 0x200>;
 				interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kir=
kwood-6192.dtsi
index 396bcba08adb..d558980af67b 100644
--- a/arch/arm/boot/dts/kirkwood-6192.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
@@ -73,7 +73,7 @@ sata: sata@80000 {
 			status =3D "disabled";
 		};
=20
-		sdio: mvsdio@90000 {
+		sdio: mmc@90000 {
 			compatible =3D "marvell,orion-sdio";
 			reg =3D <0x90000 0x200>;
 			interrupts =3D <28>;
diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kir=
kwood-6281.dtsi
index faa05849a40d..e09dbbf35078 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -73,7 +73,7 @@ sata: sata@80000 {
 			status =3D "disabled";
 		};
=20
-		sdio: mvsdio@90000 {
+		sdio: mmc@90000 {
 			compatible =3D "marvell,orion-sdio";
 			reg =3D <0x90000 0x200>;
 			interrupts =3D <28>;
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kir=
kwood-6282.dtsi
index e84c54b77dea..bc372f48a1af 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -124,7 +124,7 @@ sata: sata@80000 {
 			status =3D "disabled";
 		};
=20
-		sdio: mvsdio@90000 {
+		sdio: mmc@90000 {
 			compatible =3D "marvell,orion-sdio";
 			reg =3D <0x90000 0x200>;
 			interrupts =3D <28>;
--=20
2.35.1

