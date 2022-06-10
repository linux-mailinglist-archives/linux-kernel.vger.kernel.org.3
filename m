Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE80A545D12
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346718AbiFJHWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346717AbiFJHWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:22:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE1B27CEE;
        Fri, 10 Jun 2022 00:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654845734;
        bh=NbDW4XwdgK46oK2YiOWDkK6AGkXvlfDDkYk+K6FV4wk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RmpFEGmRk+oiHoUPgCkFP9znHCxEBnurmy/o+eYeEtkVLfJpsNKuW9/AbTpq+Wlle
         V7Q3Hh2ak0h3ime1UaCOiVv9pjWdx2C0j07LjMeoD3Iax7W7nneQwqDL/4Z8IcNPw0
         2KIBQb/rIpG/yvyw2RC8Vr1Iuq5RvXgnchAeYoks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1nWGtz3AdO-00gXtd; Fri, 10
 Jun 2022 09:22:13 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v4 4/6] ARM: dts: wpcm450: Add clock controller node
Date:   Fri, 10 Jun 2022 09:21:39 +0200
Message-Id: <20220610072141.347795-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610072141.347795-1-j.neuschaefer@gmx.net>
References: <20220610072141.347795-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BXn0QGc3JuUPTaSOXaj6sTF2BeHa/XxMxh/h2OaaAJOa3Q9w41S
 XaTeKudTF7JB8x0yO0Xej2toVOlo7h7XC/4bkGJq8tago4kmd9REtJPypCdliGhmTbwOGwb
 usOsY1my7tUegRcMeSv8lvJ5dy69usb3bVy5BL6O3reQIhKl1b70OtMyOI7cpSNS72u+3Nl
 2dj42D2wRoo4j6bZY3qhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vajEJH9ax24=:Pw5Pnl/rdMY3cOgPy4E2Bo
 mVMScqEXaK4KXwGkclcOzeo8mEWZG8p8Z9fLftKud2AcsSioBqASCH4j24t55R1FRQUBeOaYI
 Tp9gqyUmoawwlugMaukYO6I2mJVpdgcxwG9a/ymqJ6ZlQuqA3+Bf6X3Z+1LixQpM49Bj/TumG
 qecOoeSzR9vm0Pk3Ehe/L9ZNPEUaXWJ7ehrBIWaD+X/1QbeJlikizcsvXKk9UYKDjZNqZ18Xw
 XCvcgN3YdxXlDhyVgkBTp8JCXiy6JMpRt1oC0+m5VkFRXVQJ36Iq7lf8o05F0KOnfizKZ8HKX
 h3sURq3DlSYPuow6iWysOAErHC6fIWy35+dIz1xLgJAH5TMxPARE1opE6rYe6Z34sEAz9FjVM
 utQBgn01OpSYkMVAd+hGH/le0iV7uS7WQojNOHzKS/X9PvOCtLrLsMVT0wjwc2YXF14MxRBX1
 MehkVa7Uji6lh8+WNWHjkC/S9tD8fLndS2XqiBA8VBoqtrzLRsreCOxyGYyhC4a8XKg5gLJpF
 nOgHDKMcjHRQRGec2xKuINmBvdf51Zzput/EIwmH5r028MiLV4+YpfwQpXWNleLnI0OH5Cn9I
 AJCqSv37SoH8McFBd3CWEUQsG9bSnIMSGfb7dyvQPkJw4eq5eNBGPU6ebHiRQzHSKmsDrNdyi
 FUhpWGjWsrSJYa7ifrrbG/kPKjqWZR8EHL+0IOaBCboLYUDZwrnHhww+8K128jRiOmDt2n9z1
 CGkU8nQwaiq5j7viGhlAh5SyNkxIU7JuenIF0Twb2VTi1rAa5Mksaen/5VWU3q4ToUrClCLyV
 q3g5fgqTDs/Os7qXQ/INgHJOUMO1t+4jJc0K9zl9Omb3uGHJuP+v5yGy40nOgmT9uTcjMnPS3
 kx4GfnNTy0Ju8ORMoxBEabicyIP+6wyIKE0JChCxumx0+za9OBsHYR/QexG5q/XYnLH1cr74d
 CFsPCHt/AuHs9eImIst88kythA+zXK/LsylPtsaVeydoJnoMNwMrnSmEJ1IFhaymb5Guf+I0e
 eRm2ZQQtNmo5AqHAVOFHBary6nDLTFcFI42kFjVvbhsDN29R+TF2M5Hdc0E4pGjcn6k2Afic6
 HVFXVky79TKO2n/NoXp01nrvOOatoh04lEuHr6/SGKgLt+IcdCCCKFDig==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This declares the clock controller and the necessary 48 Mhz reference
clock in the WPCM450 device. Switching devices over to the clock
controller is intentionally done in a separate patch to give time for
the clock controller driver to land.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v4:
- no changes

v3:
- Change clock-output-names and clock-names from "refclk" to "ref"

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-6-j.neuschaefer@gmx.n=
et/
- no changes
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index b9b669cd632f1..332cc222c7dc5 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -37,6 +37,14 @@ clk24m: clock-24mhz {
 		#clock-cells =3D <0>;
 	};

+	refclk: clock-48mhz {
+		/* 48 MHz reference oscillator */
+		compatible =3D "fixed-clock";
+		clock-output-names =3D "ref";
+		clock-frequency =3D <48000000>;
+		#clock-cells =3D <0>;
+	};
+
 	soc {
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
@@ -49,6 +57,15 @@ gcr: syscon@b0000000 {
 			reg =3D <0xb0000000 0x200>;
 		};

+		clk: clock-controller@b0000200 {
+			compatible =3D "nuvoton,wpcm450-clk";
+			reg =3D <0xb0000200 0x100>;
+			clocks =3D <&refclk>;
+			clock-names =3D "ref";
+			#clock-cells =3D <1>;
+			#reset-cells =3D <1>;
+		};
+
 		serial0: serial@b8000000 {
 			compatible =3D "nuvoton,wpcm450-uart";
 			reg =3D <0xb8000000 0x20>;
=2D-
2.35.1

