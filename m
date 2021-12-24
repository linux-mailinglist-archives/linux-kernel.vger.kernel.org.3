Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490D147F0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 21:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353595AbhLXUKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 15:10:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:56575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353632AbhLXUKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 15:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640376603;
        bh=ioyqoECzjazCO83CSWUIhVqq20vlSqTOeOiY1fHZDDc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QFPB10VSGA4oPPtloU1iqT3Fha4jE2tSY+a4qQ18t11D0uzzb2VSrMmCxTWMX+Fsr
         Yd3+AbRkqzfIK4FapUzrg7yh1JVTpT3ytq7cfm5LKJS/ZLVDCZah4uB1w0xbjNMPsp
         lCXXHZPmPKw8G2V4D8WYOZvcrCIhPBDD+sOD/yWY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1meQVV2X9G-00n6zV; Fri, 24
 Dec 2021 21:10:03 +0100
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
Subject: [PATCH v3 8/9] ARM: dts: wpcm450-supermicro-x9sci-ln4f: Add GPIO LEDs and buttons
Date:   Fri, 24 Dec 2021 21:09:34 +0100
Message-Id: <20211224200935.93817-9-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224200935.93817-1-j.neuschaefer@gmx.net>
References: <20211224200935.93817-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3s7C8XnUn19UpYnnllvb7NVPYGh+2jrN9Gqnt8ZG4jv9MR4kI98
 44TVBGTv+L7tkZaQFWXNKQ284m2idVXAiKQhFzj4UWVyYNlToIajD+dvbmidK0PFm9yxSFa
 j9j4WPhuBDGWXS5x9lizljGiGTV1uZIzjT0P1kNHg0DG09PZVn4ocicKDfSyRJ6zg1FVc8t
 9/oL4s9NwIrl7hGy1ocGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tBuloCzQbdE=:obzLrunqcWb+k/T4Xw+bAb
 ydl2N+ycEgkDdPy5ECjr26GQJbXRRioMBJ46ZJKc3TjRV3lGoBpoSMH8/AmUFBzg6m1E6H8fk
 ofA1E9U45yhWZpF1exHrvqrHx32SBlf4DTQpD8g0o94JtoipN55Y0r0+ti8Z46C4iYZCIsBlJ
 1n/AUbWXeREvDRbQl59R96fYCbQ9p1D9O3w23Rv3Cfzyd8gGHXILSsYw8S0fZ5oKK/OYO5Yvi
 WH7gtOlvdJCp0/qK1FsADVbzovDSvfvkyjixSHLANR5GItkrIxL0sFNGg0O5hRue7Wth06SML
 cfKMoEKE2I+stp8uei+ti4RwtTH5ikuqEZyVtaCJoqi/WX/Vl5Qv8HlU6ni+CwIXdS7hfVwH7
 QPWuLqnJHNSZn/8VHqibqNgbOSFvtFUkqPwYTH7tMKYdN4r8i0dKDo/+45naPc5F3Ph8WZiUd
 ffFIKkc7k9NEpb5s+oFxylYQq/8xWxbJNi1kHMP7oeZQRoeV6sOteeAl36PSPpyJYHfHGfm6p
 iAsTiqoZSPGqi9UcONbqnu5+loyGEPXGcPPxhJynAuc1opYziCFBNktpeLXUtEZjdLW4iOPIH
 tUBbnJ7gYO9Qwzk9cmRNr6PmDh97BuslWyrCoiFJe6XJS8XELGaTF4PeNk7XuXHUnCaXhqAOm
 +r32BkQePrSe6DRJcQeM1rNjvSenUbU1y4FSj2Y5h57my8hf3buT3MuGa6OH4lXN2X4rJYhc2
 XhQTtsDOGMW9A7JQZ6MWyyCux6TArDN1ac6bC3qnnq73ep3LU0E0k2zhxHIkttYyzcC1rMJPC
 1ZpAVF0RwJ0v6+xYrF/RWdnIwZDioZ09Tazs5apHpxWsM+1XcGufk+mYruayCs11dYybg+SB4
 UshwD0wOjip3GcgZE62+cxSgZ1Qi1kjmERd83CcQmCCMDmS/NrDyXPGSrIyyPli5e9+gACZ8N
 4p3TN4bMgwKxeVSRtxMSUnDPL587NYmsgXJRjTp19xhWyyfntAcz7pgTt01OQbBdWSl/DnJLI
 fGfGU7pm5OB8fz+6puJaOOxfr69Kbhw8bm/4R1k/8TvmloxtzQdGdLq20wL7Ypc9zrRZfwVmy
 iHXBlEXJ1f7BXU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Supermicro X9SCi-LN4F server mainboard has a two LEDs and a button
under the control of the BMC. This patch makes them accessible under
Linux running on the BMC.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


=2D--
v3:
- Adjust to schema changes

v2:
- https://lore.kernel.org/lkml/20211207210823.1975632-9-j.neuschaefer@gmx.=
net/
- Adjust to new GPIO controller names
- Explicitly set pinmux to GPIO for GPIO keys and LEDs

v1:
- https://lore.kernel.org/lkml/20210602120329.2444672-9-j.neuschaefer@gmx.=
net/
=2D--
 .../nuvoton-wpcm450-supermicro-x9sci-ln4f.dts | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts b=
/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
index 83f27fbf4e939..3ee61251a16d0 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
+++ b/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
@@ -8,6 +8,9 @@

 #include "nuvoton-wpcm450.dtsi"

+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model =3D "Supermicro X9SCi-LN4F BMC";
 	compatible =3D "supermicro,x9sci-ln4f-bmc", "nuvoton,wpcm450";
@@ -20,6 +23,46 @@ memory@0 {
 		device_type =3D "memory";
 		reg =3D <0 0x08000000>; /* 128 MiB */
 	};
+
+	gpio-keys {
+		compatible =3D "gpio-keys";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&key_pins>;
+
+		uid {
+			label =3D "UID button";
+			linux,code =3D <KEY_HOME>;
+			gpios =3D <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-leds {
+		compatible =3D "gpio-leds";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&led_pins>;
+
+		uid {
+			label =3D "UID";
+			gpios =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		heartbeat {
+			label =3D "heartbeat";
+			gpios =3D <&gpio1 4 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&pinctrl {
+	key_pins: mux-keys {
+		groups =3D "gspi", "sspi";
+		function =3D "gpio";
+	};
+
+	led_pins: mux-leds {
+		groups =3D "hg3", "hg0", "pwm4";
+		function =3D "gpio";
+	};
 };

 &serial0 {
=2D-
2.30.2

