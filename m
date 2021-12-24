Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC53247F0F2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 21:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353592AbhLXUKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 15:10:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:59029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353606AbhLXUKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 15:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640376601;
        bh=uCU4WScJHVUxlsEOqBn3UTIKUZe4k1mrK8GC9hWSR/4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JYNhAuDVTYYslQQ0FcWkfibQ/J4NHCBDv0bgyFS7hYueTUxkgXYAMFYSnx/ay0tLr
         0JQCdokTIKFQK5edsPKUMlud6sh0MXeCQD9sYTxjgJPHRtE2aNxYEJz9SdIkd6LyCp
         QVgR5B0UiQoLdnIpL2af6c/FXjlp4LpNHQRcM54g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma24y-1mvPOX1DYC-00VxCv; Fri, 24
 Dec 2021 21:10:01 +0100
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
Subject: [PATCH v3 6/9] ARM: dts: wpcm450: Add pinctrl and GPIO nodes
Date:   Fri, 24 Dec 2021 21:09:32 +0100
Message-Id: <20211224200935.93817-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224200935.93817-1-j.neuschaefer@gmx.net>
References: <20211224200935.93817-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QwwPzIh6AfwnFWJ3JODbacJDi9/Y8M9tp0rFd84RF82EP/+RFgQ
 80FvxQ+8nqjHZTYX4BNpcAFq3vl8GRZhc+wfDVWvL9sZjHFNh60GU1Ml/BBr+zjAKU8xAn2
 plZIzrh1xM5yN3hxUI3S3gcbhkV41WOBJFmBuD4koXa4Y/dNClduK2Xk3s4WZzrDP/+5Y/Y
 TVJQkKLldzLZspBLWSziw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iGrDbB7wE74=:/kjfEZKTi56F2zQ+PrhGeJ
 Q15rqlmFM0uyLn9JsV17zK92tWDXNwh3NdtAOpPeKGQc1eQ92FBZT0DVGy8auHYJvRbpqETZU
 8w6W0MzmMQUG7DD+v4EOdTz7G4T0eHMjSHEBf+DYpQcEs5nwsi2fNk0RxFxuBcOx2XErcIfoc
 Frs07VqL6UdHbGb6ZcNXMw/bPCwUfcyS9kylswgi/KQ6JN7hlIRFFXkEJR0CJXG3XSJl8VNzd
 vZlIwgn7wsmAlUNc1xX+X/zDB271k9aGDEfJfTG1zRe6bheDY4Qv5U3i+jMVD8ETpl0XrGXbJ
 lHHnOCdw7lC+K/8TdUBoCrWy/XmW3mKsXiOmnJLJA96+T4+555dC8INsdF6XWlAbo0ee2k0Vc
 Cp0UU/nJf7wyZ93LCkGQlYuek7h1qe5VJQ/LW637BMPaM+8AHrRKoe6xtZK63Xxie0cWbdePC
 EWbS82T7Z1jkGGoBNRGcmPPuVfnA4SQGxmRq7NLnKJvrLhPXL/zoc9hRWs+vBCQr+evSeua1V
 IGvWvuieWapnekYxx8dAtdACenVDjs0hl8jtBJZsxqDqJAzT9J72qYr3nljgUZ9hfU5ulBnTw
 1K32yPiqqyi0L45iHqWZXgbbPPzBeCPwmAUpb6L7j3CXXy4s2C6hg7k+AMHHslAgpVWrPfFFa
 ddp6hpZgDPyGYlJWz806DBcmtcSk+jMR5iysRgWjNdchnPkJE6dy+lMB8MC2eOmxWMx8cDUwv
 TFaGD/tk25pVaRarn+AhEI2b6k84VyNqGS5tdpE8jNj8kski/B94glhadmx3POPSTgznc3heg
 FL/jfRfwP+6FHNnj5oE887BUotBjIcPiHpgLh5RHM/l9FnS0CpNO/bBIyaXEmfiapcp+Yrn33
 6D+wJkayOK0PG9UMLd5OgxLvzXi+FSWIMTwdl50fp+RoqWAoZYOLrb0u8LXna0Vz66zzIW8dp
 WoCIswLAaMfrp+XZ9Jd/+9pk69soHomrZgJ478oikiIhRfXWYRmPwhFGhfEfIRubjIL1duE1k
 BuRBAB8hspO8N6FsR+Vur6ss9CZCkHWog0osrxpntdX1VPTZnbMMLBd1aeIqWLZxBP4ZIANPO
 RWUN1gVL00FLcE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the pin controller and GPIO banks to the devicetree for th=
e
WPCM450 SoC.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

=2D--
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

