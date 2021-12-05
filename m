Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0D468DC7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbhLEW77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:59:59 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50509 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbhLEW76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:59:58 -0500
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3A687891AF;
        Mon,  6 Dec 2021 11:56:29 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1638744989;
        bh=MVisqBM5OMHeZcS9nt8ypOu3pIyl4x3UFULfFDc//8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RxQRd69gZ9vPnFwzpNPdjsOyaNzEG2KXRMq2Xk1sRysPCLeBI9dLl7K9ILnqh+vbj
         VTCPAqdedAA/adZz3PYR8lkIL74Y8L31ssC+ttytJbQaSwBR6215d2U81obIeSmC9z
         IxOex93xJ5xUgPy/XHd4B14/yv+5kXkPNYPfTn0YVKkYSDer+ntS1wYb6BefYAK1P6
         ZMHcIiGQSw4Nn8xCUlzlmkJfMrwp7xYTrT78xjBso+p4bJwySuVobN0Y/Zx0JDQpuM
         Av+pQc1XhaiCsxnlYO9ZW3MHrvx0hgEMTkUeDzmIXueZdRZrfpq3AHQvDarOlxkyQ9
         yXNfDyuP5xlvw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61ad439c0001>; Mon, 06 Dec 2021 11:56:29 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id EBB5C13ECA6;
        Mon,  6 Dec 2021 11:56:28 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E83FB2A02A6; Mon,  6 Dec 2021 11:56:28 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        kabel@kernel.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/2] arm/arm64: dts: Enable CP0 GPIOs for CN9130-CRB
Date:   Mon,  6 Dec 2021 11:56:17 +1300
Message-Id: <20211205225618.1565909-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205225618.1565909-1-chris.packham@alliedtelesis.co.nz>
References: <20211205225618.1565909-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=XOZOtjpE c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IOMw9HtfNCkA:10 a=6oF1C17gH3cd1FedgN0A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the CP0 GPIO devices for the CN9130-CRB. This is needed for a
number of the peripheral devices to function.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v3:
- None

Changes in v2:
- New

 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boo=
t/dts/marvell/cn9130-crb.dtsi
index e7918f325646..0885c6339d1b 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -17,6 +17,8 @@ aliases {
 		ethernet0 =3D &cp0_eth0;
 		ethernet1 =3D &cp0_eth1;
 		ethernet2 =3D &cp0_eth2;
+		gpio1 =3D &cp0_gpio1;
+		gpio2 =3D &cp0_gpio2;
 	};
=20
 	memory@0 {
@@ -114,6 +116,14 @@ cp0_spi0_pins: cp0-spi-pins-0 {
 	};
 };
=20
+&cp0_gpio1 {
+	status =3D "okay";
+};
+
+&cp0_gpio2 {
+	status =3D "okay";
+};
+
 &cp0_i2c0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&cp0_i2c0_pins>;
--=20
2.34.1

