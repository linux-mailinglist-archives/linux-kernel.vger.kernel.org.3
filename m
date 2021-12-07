Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5B46C65F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbhLGVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:12:54 -0500
Received: from mout.gmx.net ([212.227.17.21]:33043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241706AbhLGVMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638911341;
        bh=n/IMLw8RlRNMl11ZPwUHyr0pgPADtPhByeB9Tw0skmg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FNRyavxNkzUybVYlqRDiUBF4KqPm+OMZ0TK9Q76YZWrZ9TS/zwjSQA3TJ28xp4wkU
         ZUjZXZqX+VWJv+xzSLgZPBdMdEOzHn28a5ncFmL4tW3tsflrdfgk4cKy+1uqOE4kBZ
         uD4izYA8RmvKAIyi1IDINzq3RFEiShnmjHBezw0c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV63q-1n1ogk3gJy-00S6Qt; Tue, 07
 Dec 2021 22:09:00 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 8/8] ARM: dts: wpcm450-supermicro-x9sci-ln4f: Add GPIO LEDs and buttons
Date:   Tue,  7 Dec 2021 22:08:23 +0100
Message-Id: <20211207210823.1975632-9-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w6zd2sE7qX7biDctX7/3wm69kxDwHCnk4KmUNJeio84MbEdf15g
 Nk4DGNQcIQZwB1WFZSh9/PQx+THVkVtuSTVWUOPwXdu90s3phD3XLmM7j3Z699COuz29WVL
 Cmegvh5QaJaHEs5/Gu0uKZQDHMBVmO8vmA0V439F55aZdyJdJpT5iUq6gWiNrp2G2WviA9v
 3xVbF/GMsHJQpPfU/V+GQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bRTl+6Zn8hA=:cOkpSHY7Gl7GjEPQmOCJqG
 7B3+v1lKhy9tm0z++wILvQcoyNzdflutetAfJ+8UthJc0bvDoROUhnzTQZEGCyNmWMotgMqjf
 zR6IqqP0rwACE2ZgvuSCIdu4yGHfO83ypsWwArlQVupPUNgqZpZhZFBfkqDlmHrai0XcK7+Bl
 88YlBbmdnciBXstf3UougA7U6aAU1n7YqJsfpa1QgytE4aEjXSpbX2BP/NCWHYX9XE70R2xZD
 v9B8xdr+sysQgbWbVi+SbPylQd89Zm27Ss/xXifhtI+Zv6Ym8Vqy8mrOw45p7dd/QFJ23cIUy
 qUtLya324sAK+1BA1LIWk3DS/K+hV21ZqXQjsXguOMw90N5mldFtJye8NrGxIGi5lTGTeX/9A
 ruT5eZnDHlpfkoJVgS8Faa9snuAWJcuwXcXOw78j18UnP5JXydLkLxiv3ZUS2fHRXFq+H6ixp
 HVUb8Oc0vuhH/TDVv919SdnSfIGZNPntjcKEeZd8Affjr7BBeraZtbj2ZFa2C+XC0012qJpYF
 fgF13H78PgCU+aTBCrmiDPqhfiiipJ3rIRXf/xWSm5Kpz7krCZ0GoHTNbGMX/gOellWYg17U5
 Ouvt7PlOr3Beitp0EzQOxHPaEx+ufSxELv5wdYYJHNhZWM2I8xfvEqRJTn8XU5nL82Hof1YDl
 o4Ebxzd2mDLadUxRsMG6SOrFMMhN9pz74GmYfIAWGkJl0RlYfPSHXtkKxQ3TB41ojil8e31KZ
 XoAp3vOIxChIPynhhaWrY7uxYn/fivj34AtOIEI9hz9jl9pvusUK2d2mQ6fNTzLnYggD/jkWS
 AXHWJZ5SMMNDTlcc2HeR5y39fBmf8fOnjc/WP70R9vFHqwctQqg6Npg7RA+0xmH/RnN5rZbvl
 qj/KmdhhinGrPfvNXbYKuPPJhMyh5gNV+m5f4iuOA50TcLvyBXLKzFyFDsVeXPA49dLs7yPGx
 JNTNwhGdh1Fo3wsDEBHH4iwl5Vxc6fkYOi0XiHjxoT0e6SICMiB5dVa55Qm3Sp6fQUKjQFbEo
 SPyIs3tEHCxtwbmy2P312zYJDleF+0es0kt40jaVbSrvGhWXLcPnUauGkyXfWwfA7j8ENrPdF
 CID38zHhZk82tU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Supermicro X9SCi-LN4F server mainboard has a two LEDs and a button
under the control of the BMC. This patch makes them accessible under
Linux running on the BMC.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


=2D--
v2:
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
index 83f27fbf4e939..cd8d3a6bbf853 100644
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
+	key_pins: mux_keys {
+		groups =3D "gspi", "sspi";
+		function =3D "gpio";
+	};
+
+	led_pins: mux_leds {
+		groups =3D "hg3", "hg0", "pwm4";
+		function =3D "gpio";
+	};
 };

 &serial0 {
=2D-
2.30.2

