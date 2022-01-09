Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFCD488B5B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiAIRfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:35:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:44859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236352AbiAIRee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641749667;
        bh=ETxQ+T/X/+6s3tPz9+APQpnz3DH8sFghpJZtkB4Iu9c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XFlZt9ZQj9dssMb/CLRHxUFXq+uzA+XQhspAHTcxvLa+3OpbAXnyZzozViCLxboxj
         LiLVEAgsp/Gf6yFL3c3TQ6ZAGHTEFhRzUtV2ZGUryFH+7/+c4fP3DXdhD8tboVJ+3v
         Ey7aHzbZBJA2NdI4jsoYhR88wKC+TxMqdYsx5ojM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.222.244]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1mC9aP0ENC-00wzfJ; Sun, 09
 Jan 2022 18:34:27 +0100
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
Subject: [PATCH v4 8/9] ARM: dts: wpcm450-supermicro-x9sci-ln4f: Add GPIO LEDs and buttons
Date:   Sun,  9 Jan 2022 18:29:59 +0100
Message-Id: <20220109173000.1242703-9-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
References: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lkSwl2UrCD7/dlt1TWC5XCxvrHKCbWfQJIE5ySD7ONxUaHyrcB3
 wQsdRRjXXm6IdjNWh4qYGsiWaLc+jqoKQVukZidoN9wB3cx4DtSJV9/dzqRfm4VR1TMARBD
 4cHMemMUkt/+aLXqudtQOvt+WmAX1MFzsLCJt8qmly4B8z6W+sxePdvSYuw+DluKR97IYzv
 dAr1fa1aI70qdQV7ND9gg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ynMmLROqad4=:LjDKKVAaC8UVbzqpjgz16f
 VJ0Jy/fPalAGPn2OjAstco4Y8yGiesSogrTqntoB3zRlIIOZaxkCFtKmrpbcicWWJmrpxUaCf
 Blo302wyEIThOBR3Vx7M++tYekq9b65xdeiFC9ovgX8c0YM3KIkW7b7x8AKKWq0nchyC75aLx
 mDUoQf/8P4RMoHETukwnq6UX+k8jGoXUgQtDcYWnSGHCa3xlk7rUwf02Kc5U4mGwjyeJBNxx+
 5rTY1zmCRysGEqLMyQFNX7p5NchGPts7nyUwhI9skur7YS1XW0TK4F4OGgbibdDqL96BZNABq
 rmglCBhGTV2J5yI/icvayKOOddMAKPEF7Vu6KtDeSFZSnmH6YwyuTFcra0t+prB8iFj/fPZeX
 NhG+10Yi6ZVdIuvpHZlKXpOjRgxEBDP2BeWzIMMdwmydIAEHQvMHyVBySx7YeVURkF3pT2jfm
 +ReqwdY/KzqdYKoTgljCWERhSF5TwXmC8OM4+FLTScDsd47/H7MqvT6GJ2VkoHijCDJlAIleU
 ohVHlDFm0AOb7itZa15XaTserYe8CWDPgAJIeQAQMTS4H1uy0zukCDcZ4h9KqCwvooKQjl+T0
 8YFIRXdMgJLvYqPDhK3DDH5OPQQ2ZhVnzujqYkVLEiDuWJAD0XrEzScgtzlSWSAU4ACGg6dJQ
 KHVW1saouykGKq36j3OTdMLEa0S2Fkq7YJVFMVL8z43s4JsEA1UV8eFvLiM/9Q03sOtbSmGa1
 9allqybtPW8tQforXDJo5msOBGJHNbU7BO5oeQu/njlpp4Zas/AQBLJCR5cvOZ3/q1ildxKac
 sYXiMpKgkjlYNGk4eVYgcSK9sdZkJ3rvm6NxHAcSBEK6SmUizjbQBioX7SgbdCyBW+cBEypp4
 pWOvAPxEhtzYv0BP60P5h2rhopnky0dtDKTMgK8UaOzu5ihh3V97IR5SLg6Dm42278Ci1Y5at
 aqGliLFOW1InG2kg6VTMl7qlk+7deo0i/biapmciv0w7lz1DvjziSBQHP111NYEru0LEMsJ5V
 5YXHTUpBRN2MCrk+fibg2eq7fauk5KYRiFdgB6yBv/qeVnP2wT7ff5pZtzXNeckzksyOuDzdz
 8CCrPkNnHBPQ50=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Supermicro X9SCi-LN4F server mainboard has a two LEDs and a button
under the control of the BMC. This patch makes them accessible under
Linux running on the BMC.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


=2D--
v4:
- no changes

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

