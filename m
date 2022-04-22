Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6450C439
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiDVWj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiDVWiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E67C200389;
        Fri, 22 Apr 2022 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650663022;
        bh=BHUkq4qIz1dh922+/iqR/+zEXRIaC4ZyZF4Bphn8Po8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EXay7kgGE8SkMAk7JaTrpqsmjmE+KTqTL3U60OahfcTP4a0uhZGt1TALutDYVF3im
         M/dCpgzDLEepZkFvF89gCdMzhB7ac4NIR/nuWleWMud/8uWT2N1OdDKDdZ24UdzTND
         Agi3x+W+yvHXOI3DRqZbvc1rgIezKKwRa4KtuWPs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.78.190.74]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1nvSO519eg-015ujL; Fri, 22
 Apr 2022 20:31:55 +0200
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
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5/7] ARM: dts: wpcm450: Add clock controller node
Date:   Fri, 22 Apr 2022 20:30:10 +0200
Message-Id: <20220422183012.444674-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422183012.444674-1-j.neuschaefer@gmx.net>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fag6c+9a1Pz3T5xG3Pe4SmIRM1zshVKs/bhtGtFRhEqmEKmvImL
 mQiew5bwtAn5jmH7DaPyUusvR9/woaryKVpQFAXUKgw39r3F9k9/a1u2LQItUrXdsy7diry
 CBT1J59AfeqO/3Z6yii0UgOL51/2BFCdmCC74iM+zjFRl7g/SRd0Lu5Q5I0YJ4tANpkLGDo
 PYSdA+hdkEp96fsM9/7sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IHgVYjueDIk=:s19Olf0VBPcmGPERNqaAVP
 TIOWAFRCJ8h1zX3LmbH8ZStBHDP6P9A5eQhP0ofSiugsP6jIVRCLO8XSlS6TkrTZNKvhaLg+Y
 l3o2Uw5FF+BiEH4ITCaIkibSAAw3yYvsmBeEVhI968R+qU+j9jemDR8uiXPckM6NFLlFG3MAA
 //3Vkn/yzDI+S/DuzZwc4m/fSRP+2u+UhapM3X/x049NPxHSkiKu7Fh0mueR1t73aFB3MqSeU
 GJMIl3QD9eYoPieeluQDBN3OK/0o5YTLLeJyOrFJLmOGPVANCkGgqyuiY8kxs0yUAo3CYH310
 YISle7JZrIyFsKumD7yMJwq1DCcT9+BKojeTsB1kLGIfNIrhpEj9bJAEYZrMi4yFhfIr+MuuI
 oGC7OW38CccejsUeblq3l6NtVKZZGEAk3UXxla3VXvcEOrzM816Y/3YHc18+YQFLVwfym/Rs6
 HpfcVHsbxMIRnekokDxudI2DP2FZbSsMA7xtr7SkkFrZowFAwaTQ8p2TOBmk0zC/iq5KbO5Y2
 B91g/xGxfwmhLJJlfHpUjcoIij9CJrmWE0jOPVVktEgdGEoXFbA1ac67XnVeR/SrX/4uFZrob
 M199YNDpY5+S2cDOf0LRmhL6spD/JnMzvcfaEu2Sg3Fp8Fa+uul9rFFDhAeaNT/23jcmtjwMW
 Zo1zEe9o8swvO7N3pQTF1PZ2R6K4gxjYouhqdV7DJLsyauGhM7Mq+wdRH8rTk610Aso3QbTiQ
 HwSYs628upNHfP0XUwISxTcddajIdD53mgG8fgFZBKzt21QSfEDTI9swvdN2Oz4WWaElbqF6E
 L9fbql54Lgwr8/NXZiYsyHbZDTRoY4Bv1c7TE7ZvHo1RSPL5/Pfp1Y25wggRhQ8r+J3i26fe9
 Vv+YrLmcvWdfZrrSlui3Z1+SOYosJuorgnTGoBDmJLf2J6TVA8hXRNBVx7L0dWxh0yyGqKvhD
 QDvvT0otLfKlDfcTjrwYS9Nm73804oL+q7n4v+JhNmqdDbG2O1rdGJj+qDuyTokLdmwVCoi9S
 RSWbkjlIiwj7PvZR83cBPpgFFVTjIFdAVO36ZXoSfQbHbtQJeMDAM+IwJ/uSrTbWysAcEpG4d
 J+80VCwdWTBYn4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index 1c63ab14c4383..62d70fda7b520 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -39,6 +39,14 @@ clk24m: clock-24mhz {
 		#clock-cells =3D <0>;
 	};

+	refclk: clock-48mhz {
+		/* 48 MHz reference oscillator */
+		compatible =3D "fixed-clock";
+		clock-output-names =3D "refclk";
+		clock-frequency =3D <48000000>;
+		#clock-cells =3D <0>;
+	};
+
 	soc {
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
@@ -51,6 +59,15 @@ gcr: syscon@b0000000 {
 			reg =3D <0xb0000000 0x200>;
 		};

+		clk: clock-controller@b0000200 {
+			compatible =3D "nuvoton,wpcm450-clk";
+			reg =3D <0xb0000200 0x100>;
+			clocks =3D <&refclk>;
+			clock-names =3D "refclk";
+			#clock-cells =3D <1>;
+			#reset-cells =3D <1>;
+		};
+
 		serial0: serial@b8000000 {
 			compatible =3D "nuvoton,wpcm450-uart";
 			reg =3D <0xb8000000 0x20>;
=2D-
2.35.1

