Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D617D5151B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379632AbiD2RZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379574AbiD2RYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:24:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B1556204;
        Fri, 29 Apr 2022 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651252848;
        bh=u1M/i9igpl+WBs+JkHblfLdEsbqQNT/jtX7Z1ECNMVg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f4s3nLQVht81EXZKXWS2VdgtAVMpMAc1XmcH7oiWWaaauitDNU1ZbOuH4lwZfweTL
         Rz8sLZsT6DOIEsorPEqd/V7DJlGehs9VRCuN9EiILVZzO5/8XzWB0tlY1HLw0n7dYc
         06tYhsvrGqqXZsSKm/Jf2hU8QvjRqv5XlGy8Jbqo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysW2-1o7DuM0bgI-00vwLW; Fri, 29
 Apr 2022 19:20:48 +0200
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
Subject: [PATCH v2 5/7] ARM: dts: wpcm450: Add clock controller node
Date:   Fri, 29 Apr 2022 19:20:28 +0200
Message-Id: <20220429172030.398011-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429172030.398011-1-j.neuschaefer@gmx.net>
References: <20220429172030.398011-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5w8WTRIP7F+Bno5d3r/iMNvZAr/pydK7Dnl1ZI+EUCtsm6H7QTd
 FFO3kj1TeeCaYaFHYu6u3dQGvdEtTnDnZkEPCp9rbbzLEfZVXzpoUiQEpp8LxbZmequ1CN4
 WERVz3FqRB4OFmPreLckTbkuynhDS4lHf35vOuqRhnLA59nUtRnECtacpKpK+WtuwtN8Uf0
 A3VhM2iEV6p9cRgFhGPUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yLsn5BD1VVY=:cXqMcFYjp6NL4zbtrRSrmb
 RMG0H/ZVas9mOrE5yxIVkDc7oNoH2VGYlo/EzhH82kl9xg9ff+jAYB/eWZHc9OCX0+ktdHOOh
 0V6opfDjBClj0Wj3bgpcsCr/oJQ/9vqOie8ZXyJGc6C9OYe5zWD/N7yVYCOBNHVtVpwktkDgH
 kuszmjWvnkTaRz53UEbMfT7TUgv6FoBoJPQm5huAYNF9g5i8Qf8mxNGF4rYDyQaD5JzMwZPhJ
 IqVFoLKI3g3kOLMKDjU/HpR3ac/VUaOBN0KtvcwzJhVec91LwYz8rcE4CEnIfcEgupLtNuRnq
 CV14ns80l90CySn7w6xR49a/jmdkaWu982oDGNF+umDeaA1JkH/NRDDaWXaUbulmMS98vmQFG
 0S7KYz6emeh4VNZaNExUfz2WY9JR2jnJPO9nxTFNPw770ieHmRFg3Up5RCRDVRRz7Tbj9Rdgn
 LZ44yma0EC4UddTWtKP9YI9ee0RiUVoLTvz4DVM2FR2CoWEKZ+gErTobFRh8pownNHAacKI52
 VYrP9exys9IGdp87LlNqTYL3o2t5PxknR8rN/6uVA8q68GO+5ySvszbd/RnbL4U0bF8WjLY91
 07FbYK8Y9lqzgSgFSiZ31gaITOxYIfUMO2gdA2ltKLO7ikyrQr5k/h5Efw8vrDVhlkZvVxrhF
 feQ/QZm1mBQVkEJlbsjYhHloqe6acoSbgzJYuqhIBAFbvKWfOiJhl0yEsDW3epsgLf1SpJ9rN
 EtIfJLhZaACnlOGicRq3DyRHO7Z/NjbhOubgpLhYx1f3/kcnxYlWjG3tTOPc5a2Cr+JS9U3MW
 Vms7ooQO9QtwEpboR68/IS1R1vc8OFYqYwjUzMMKWjuynouWyhDI63YFYwEkui9c6xfyKI8og
 TMpoZUWauAWc6R/YvP1F+qDlNXv0WCX84rkJuN6QtbfnbYZ+RQOEpyYG1ZnLWomy6wScJkZ6J
 eQ3vj7vwqwcDFuUGC4AoLy8e7NEvJTcrccviLaBavOx4+iLDKpam3AYloXxMY4hpLx06mEVY2
 nLx17jLWA+wF2U6l+8vrP8355yd8DjNX84rnBEospHpxck9xHqsNpFNa3sRmfOuBujGpUNMR1
 hWUAWdN1QPbEGo=
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

v2:
- no changes
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

