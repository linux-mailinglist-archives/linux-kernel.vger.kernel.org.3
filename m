Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE4588550
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiHCBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHCBQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:16:31 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310A5509D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:16:29 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 08D872C0302;
        Wed,  3 Aug 2022 01:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1659489386;
        bh=RHb6z3FlisRbkOdYvmYzCDevXzAM2e8f7oJpOTfus7s=;
        h=From:To:Cc:Subject:Date:From;
        b=MKVJ1eeSOQGM+HPjKp/ksSmTeFKXY17Fz5Ee613XtBLsjL19KJx3Ew7IfFvAztMCu
         1x+EuOeeVM6fOh7m6rE9Z8xsqm7F04WjCxDpUEvz/tZog+lOT3a4M9qqFbMCvlM6j4
         UhCsm6qbI+1AQMfF65s1WSTDiJqDRb0vvFtEz4Jb8BpXfrZj7aCSMbSO8SdXgzhnCp
         GiWwfNUfvuPX2QDIc5S9oJBEkPA+GrWTTAeauGJi/3jsVba0k5lhzRpDyIT0mZu6ji
         yzdsXb2eRPXt1PbWoOVlinbeFBcK+Y16yAWrzfwmfXc6Y8r9v7rXKolduZxfhfxfjk
         mbDCdnmxiaQSg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62e9cc690000>; Wed, 03 Aug 2022 13:16:25 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id D54BA13ED0C;
        Wed,  3 Aug 2022 13:16:25 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id D1EEB2A0090; Wed,  3 Aug 2022 13:16:25 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vadym.kochan@plvision.eu, gregory.clement@bootlin.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] arm64: dts: marvell: Add UART1-3 for AC5/AC5X
Date:   Wed,  3 Aug 2022 13:16:23 +1200
Message-Id: <20220803011623.3607642-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=F5opiZpN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=biHskzXt2R4A:10 a=ngK7aFzLhKCcFdMQWeYA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AC5/AC5X SoC has 4 UART blocks. Add the additional UART1-3 blocks to
the base dtsi file.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    This applies on top of the series adding the AC5/AC5X SoC which is in
    Gregory's mvebu/dt64 tree but hasn't made it to Linus's (yet).

 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/b=
oot/dts/marvell/ac5-98dx25xx.dtsi
index 80b44c7df56a..914fcf9e2c24 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -95,6 +95,36 @@ uart0: serial@12000 {
 				status =3D "okay";
 			};
=20
+			uart1: serial@12100 {
+				compatible =3D "snps,dw-apb-uart";
+				reg =3D <0x11000 0x100>;
+				reg-shift =3D <2>;
+				interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width =3D <1>;
+				clocks =3D <&cnm_clock>;
+				status =3D "disabled";
+			};
+
+			uart2: serial@12200 {
+				compatible =3D "snps,dw-apb-uart";
+				reg =3D <0x12200 0x100>;
+				reg-shift =3D <2>;
+				interrupts =3D <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width =3D <1>;
+				clocks =3D <&cnm_clock>;
+				status =3D "disabled";
+			};
+
+			uart3: serial@12300 {
+				compatible =3D "snps,dw-apb-uart";
+				reg =3D <0x12300 0x100>;
+				reg-shift =3D <2>;
+				interrupts =3D <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width =3D <1>;
+				clocks =3D <&cnm_clock>;
+				status =3D "disabled";
+			};
+
 			mdio: mdio@22004 {
 				#address-cells =3D <1>;
 				#size-cells =3D <0>;
--=20
2.37.1

