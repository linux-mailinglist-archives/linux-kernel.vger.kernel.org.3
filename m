Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B149346C657
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbhLGVMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:12:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:48733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241754AbhLGVMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638911339;
        bh=aJK3aYkTjoNYFomlmBvcJiDYDAbn3yEMMH9PnGcwh0Q=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V+apZi5Z0+zV19MkjBbX4/XYTOQl0U/cArYg5ZMl2USooSis7W1dZIM6t29q3PxaU
         3nsKTqAyfc7vmRwQla2ZFPhL/fu/1a25QQRUxjpku3eC8D7hBQurPrZFXvD47dY1zG
         1ClI7t3t80QPe1TUohZ5J+ZtN9eRTG3iidqlZjnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsYx-1mmDeH3JKp-00HQoC; Tue, 07
 Dec 2021 22:08:58 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 6/8] ARM: dts: wpcm450: Add pinctrl and GPIO nodes
Date:   Tue,  7 Dec 2021 22:08:21 +0100
Message-Id: <20211207210823.1975632-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:usq2/YSpx5wQW1MyCXV07rtFXO7Ivj8A7enhBPFJxzJs5IuTmaR
 ckAN38qm7/pxxiUpvfjpUuJCr9f46BPCSem0daz6ogwZy+o8mQsbHPabpmodHB6/3gHFrlj
 Cbhkc4cqWlOFsg2VLaQ8Ts1Sl00St4JleGysUjV4QoO7B2EArNlhdgc4Fp6onvhPewpa58C
 BfZEppyS9BkFrmPrDwGAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MeXJvmA2qww=:tZZ1gd1d8hrBvKOxGmsN9d
 utbwS06se01yGQaIQ960mOinzwa7be0TWDBaN3Hrv8U7u6xjRNBy40V3Aa0df3It5Ebs76HNR
 PW1307ibCHkhxRIRyIuHquZ4MU7jPU2aW2fFcLbUPIEtf8a7+TaVzknR+oRw9lbAn+/iUwlYl
 gn+VVC6x5xFy3Je1x9JpKToY6ruyyLw1net/TWVpiqMSQf2coX8NWDwJxJeShLvqGUGe0tCnd
 2dO63p6qGaP6yyd1tU0nDKNygRl+3lHxMF4i3HfkkVoyIQx//H6FMY3LehtuJEMpwrcsA/t6r
 32BrA7BEEyD4sLP7fKMkwDBTwL6onoQOXtJnZxoFEZykOmWnU2o+XX32jEogr2sYXTcu1PUsZ
 BVwd7PfLGA9/tlCnv5cssGMRo8xE4OBCSboeffWq0yn4LOoDd4rIabYjKbPGIdDHVn85E3MSb
 inFBL+jDBzT75p+49eZmyCLcW0BKu/K3XM2CV9w/mEm56R9CDn/P0J3G//PIINDeewuS+Y9kN
 L4rhYoqboW+1MVLG1XwrZb3RfmnSZxR8gq55pFk51wJ4iI+kZO0NDm7Dwf3cTTVHh2ODQpgst
 e3frKGKXXRbo+/YUjGSbm+P5RJkxNw6pQSt9OpZHcP9s+rpq6zu0PJfLmgtNy78Jdcgf8EWf6
 h+oesDOR4XBFBtJgcvlOJbx9EZU6pjFLWDVukBEuXLPDBQzzHOQVJNDDW3TME00AT4HKWXiK2
 Oe2ojapzSCb1IGSEvhog8p+k5Swm45Ts5lx74KKqoFottJW5BHZORCqk4iIkg3uBsk5ph6bnm
 kXrDm2OsjUC7jZwSUmmwbJIs4XDi6WL9Wj6F0q4giJgx4jM2LuJ1NflsSgae6p2oUjH46YR0N
 hq9UHL4guNP55X11K0munVngAoS6qCx4C4FxtLRijTBJ3A5sf3fgk3YUOCdF9fLHfb9fb4CK/
 o7fLQcsGXavKITDUeWxo2cfeCHf19Ag3K0+83XMQW2r7sfhomA5xh8AImjILM9F52mNdbJ17L
 eHbBHJvd8IR0bVyakxOP7wdXV0ruEwWv+EOFIYs6zLtIBfwl9sigGjKJ062eMNCcZwp5jaaFr
 ys8YtwUJKcgV8c=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the pin controller and GPIO banks to the devicetree for th=
e
WPCM450 SoC.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


=2D--
v2:
- Move GPIO banks into subnodes
- Add /alias/gpio*

v1:
- https://lore.kernel.org/lkml/20210602120329.2444672-7-j.neuschaefer@gmx.=
net/
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 74 ++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index a17ee70085dd0..a795cc4128654 100644
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
@@ -77,5 +88,68 @@ aic: interrupt-controller@b8002000 {
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
+				interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH
+					      3 IRQ_TYPE_LEVEL_HIGH
+					      4 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				nuvoton,interrupt-map =3D <0 16 0>;
+			};
+
+			gpio1: gpio@1 {
+				reg =3D <1>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+				interrupts =3D <5 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				nuvoton,interrupt-map =3D <16 2 8>;
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

