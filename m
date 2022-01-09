Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20774488B55
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiAIRfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:35:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:55337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236330AbiAIRec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641749664;
        bh=OpCM3vZ70EiANIdlG1jlqbtkhqwAbU91v+KSwrK4vJE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=crJSj1H5B77UWngtLFAxPVnVVyOjhoJ2kZL0Gl8/+bWfJtjC/AUuwk9EbrES1mBUa
         pkHLpSE1Mc8JGiYFE6DG+6vcE6UTKczTZ3Sn56T+UUUm61GbYyrYSmsqcNXZf+VRJ8
         LNGQZule/v0O3R9jb1y6GT/U1hbyJ+Qc1UMu4xwA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.222.244]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCKC-1mllJs1oIu-00N6vg; Sun, 09
 Jan 2022 18:34:24 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v4 6/9] ARM: dts: wpcm450: Add pinctrl and GPIO nodes
Date:   Sun,  9 Jan 2022 18:29:57 +0100
Message-Id: <20220109173000.1242703-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
References: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cVf+Eg1icknpyn503zLpSH4nbx7uuCiucRyGheDjBmLOnQwLVTy
 O4iSM7mSiWhxhG88ej7GEPsr+fdUv2rUXlR3ovM8LsqTkZ2Htj9sG8/Xl/6BLrU3QgksN4u
 M8FFEkSAtIapFUlhwh6iJoXq//EsrN9EyQR0wcycbat2cla8QpwMx2Meymd2iYEOM4xJ6BZ
 AmSjyNk+actVvLb4p5ODQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:35ivKYmuKqI=:aMXxvoealo5TqFtOKUXiNg
 lmLgmb6N49HuqRBy0/8tLJzWVMHnVZj6ZeQ3QxfdnYEtTm6xmQnTIQsNjVEw+dMK/OLAW7AqW
 ReBpc9HbU9hXna8gzOPeR9WjvWp65ixkc/Oj1Ho4jhAFnxkeloQJq5soJy5xeG4g+e5XXv9q0
 9aoWALqKjCWasDXZP805zggUNhryNUoF98lzi+p4v7JZtzrHW9aQOl7Z8rzO6vdUOMynhZ+vV
 xEo7GKYwVmcu4SCG/QwKLTFWnXmuqYWA+zuF9uPRJ6J2BziiIPAhKbeFYcd/YxLRRPwc9E9k9
 xnU5n3k2cc4yOOF812kgb0KcQIivzoV1iS1o8UmBbpXy9ZZKJLhVODjoXfqGPuPHJhLO3yHN5
 ChiRIuvB+GFoEmjBo2EpI0jv18becGsrCPkQwsghvPtxzTsVHmAy5OeiZtw/hv/LyRfmotw9L
 pKZGEPIRoW6tajzdg4JhMHNz1c5Af5dbI06Lh7PF4QjGZPOxzVLWSS5pc1Nix6t8VsdBamKfW
 gAeP8rQeRbvZlgx8eDQCqSIJzgotoumeRkjAryHTwLNXi1y0h8iAMfeK0fNGUujqWKhoKNQac
 QXaV87y3SaO0C7tlm7QxKt0vjMh3cF3sTjudINTwaGQKs55zuXN1Sti0UfbgDQJ/HE4sO81RI
 iXicMAkQ1gnfWHhNmVSbF8LWyrVFa+hTziulr6y9PXbjwGNENorYNRL+zMYPeiDTVGUW980fX
 +mICz5WnTHD96xX/zvBQNuURDkumqS9WNHHoiiGGJR11rIHDGLC6zO3+XW44/KRzJ3CVsfDYl
 sLVxc66mbyVL9R13aVhGVLZs8rqoWs53UUkFNMIuGk3QWqO0k1JYnKQ3YgAkEvXi3NvjvyUoe
 bsyJVd/OaPVHAR2XrgHeuILucBsMoNSz+PZ1GcZ9z9+CnRj+Orto32My2tu4mzp6sgJfcxaq9
 Si3gTV35UOrR1z5QVegZrJbgU5o2n4xq+fjvO+tEIM5qqDCVy6cuv7RoSnoPhAxkaZsE8P4N0
 8VT/xh+2t/vm4HicI5daeOr7M7LQmfiGJH9fBkryQ9yMCMMQ2nV/pQezyMx4bSHectdxS+z5a
 B2e0iIsdln+9JI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the pin controller and GPIO banks to the devicetree for th=
e
WPCM450 SoC.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

=2D--
v4:
- no changes

v3:
- Add Linus' R-b tag
- Remove nuvoton,interrupt-map again, to simplify the binding
- Make tuples clearer

v2:
- https://lore.kernel.org/lkml/20211207210823.1975632-7-j.neuschaefer@gmx.=
net/
- Move GPIO banks into subnodes
- Add /alias/gpio*

v1:
- https://lore.kernel.org/lkml/20210602120329.2444672-7-j.neuschaefer@gmx.=
net/
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 72 ++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index a17ee70085dd0..66c35626c80a6 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -8,6 +8,17 @@ / {
 	#address-cells =3D <1>;
 	#size-cells =3D <1>;

+	aliases {
+		gpio0 =3D &gpio0;
+		gpio1 =3D &gpio1;
+		gpio2 =3D &gpio2;
+		gpio3 =3D &gpio3;
+		gpio4 =3D &gpio4;
+		gpio5 =3D &gpio5;
+		gpio6 =3D &gpio6;
+		gpio7 =3D &gpio7;
+	};
+
 	cpus {
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
@@ -77,5 +88,66 @@ aic: interrupt-controller@b8002000 {
 			interrupt-controller;
 			#interrupt-cells =3D <2>;
 		};
+
+		pinctrl: pinctrl@b8003000 {
+			compatible =3D "nuvoton,wpcm450-pinctrl";
+			reg =3D <0xb8003000 0x1000>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			gpio0: gpio@0 {
+				reg =3D <0>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+				interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH>,
+					     <3 IRQ_TYPE_LEVEL_HIGH>,
+					     <4 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+			};
+
+			gpio1: gpio@1 {
+				reg =3D <1>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+				interrupts =3D <5 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+			};
+
+			gpio2: gpio@2 {
+				reg =3D <2>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+			};
+
+			gpio3: gpio@3 {
+				reg =3D <3>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+			};
+
+			gpio4: gpio@4 {
+				reg =3D <4>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+			};
+
+			gpio5: gpio@5 {
+				reg =3D <5>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+			};
+
+			gpio6: gpio@6 {
+				reg =3D <6>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+			};
+
+			gpio7: gpio@7 {
+				reg =3D <7>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+			};
+		};
 	};
 };
=2D-
2.30.2

