Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CF851F0D4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiEHTs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiEHTsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:48:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B8B849;
        Sun,  8 May 2022 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652039032;
        bh=STTQoU0Sy8AHWtV5pttLaup41ExmdLj7vMbHpMMcIaI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YX/rOCUpfUos0952/SYCVcW3WeHHLmrfMa+TpEoqiKWo/5gghjBsirvjryF8uyO1k
         hl221DfyokbMxUUhatWD2Ur8TSkSgJlYWCqXP6y3TU59UUVvbfBPv6fRqjKQ/Jeogw
         2GSuQzWAi/PAgh7bZwFOmVxnIOMFWPe7X4+b/u+s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1nrZRd2Fif-017jSc; Sun, 08
 May 2022 21:43:52 +0200
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
Subject: [PATCH v3 5/7] ARM: dts: wpcm450: Add clock controller node
Date:   Sun,  8 May 2022 21:43:30 +0200
Message-Id: <20220508194333.2170161-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
References: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ezSuU0zJBwh/ZGu333EDA+hPHK33sk6Mj8LKS926qLuWkkV0Lr
 dlWJ34pFrBPMP+BubdQlge6s8v05g/+Pw8q/DkOblN8fJZJXz6/G+h55hNbBSRoVg5QhuME
 c96yu2NoB9ByjKLcIk9UWVAlf3xUNrZdS+U7kt13w8l9lH6rxbylF9SfU8+ygCu1iIR94GN
 EeW6+i0WdHMcl83YXieiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hBfIvakNOYo=:mxNjkROiVYonEK1pOMv76V
 AV7jo26iOQybtrajPGVaCxGrHTPgAyZsyu50/u9Mmv4K1driDuNWXBaowvw1FtK8/mzmpBhoD
 ek9Nq6pzPavd+mUnYrSTtbMQV1ScIKduBP28Fy4Qu4GpS9JPoV/m/hxGwn1wEZ1KTyj9gYO2t
 mavKGYhY3MnbowCvFso/PyyHDGjChrTjPwl9pnXIpZ4Pwh/e4TG7od9X3Hs0MWrOdZZJ8x6Hp
 H7CXRX74gqZp4XW/WFCBGjdxKGKS74Qvm1l3qa/yKWjjI14j2saDfR8Y84/OVbmPiexWIhhis
 hf3djXzT1jG6d5ngB/nQsdoj1Z9rKa73s+AGAjdkYHU7XvaGMvmXMOEZ97dDM6bfQrGn93jv+
 gpUkNpSWVMygGr55tm8k64U63O0SvECs8O1K5wXu+b5b/jEDKrLIc+mn9+uMA/SU0EnKW49Zk
 EqVHNPAmRUVVzAxC8HbChhxIIitk3lQq6rfvYgtuZAnhPbIwEQzAxN2Ib5ZPebbqTJ4LHmC4d
 dLOJi8sRBEFuP1X6S9zVIVrATxtzeFJHG6mH2xUrmXAf5x2pPBaSjzU9McfoF+lOAnSROtxoC
 P9BGHAuiHW4iyEtnapDrDCE8M5ThGPAo7qNrHh2grPwhTgsYDPB7zma97V0qzfpmo1wxAtT4M
 v32a5Cwa+QgGbCo1J5pID+cFDXj40XRQVxvJsZb5e9Xw1tMQLu/DlLWJ0+M30Lv9UlLnW6ys1
 dzK0ZpBoYa0jSJgcNhItaXBjEhSAFDv8ZY6wfgkpvz1vvtwPCFoYnMm6/w+GxrTYOq6+cT2SX
 LNdE3V2AGtV+XiupBIGJBFtSahNzuCCFybs5TjiIF70sBN2bXq2Km3a1sTTkCvhiq2B6aRqo0
 vM2YkBjGuGAbW4XbYuQjAfITGIPYxnd/v7Hf3VnWP02TZVRj10k+KQgYqc8Ppn388JlW+N80P
 nnaKS+A2SWH/82N9jMiGR9DrnMLF1RnSwACB0szJuQ7jIFfeGs38LqQ2sUs7h9T7K7zZaTcJD
 8+KITAnYZQ5ck33U0ABcd6j+skb4e+u6zUOurQT7nJoTu/haYTONEYx3WXf3nPdEzW+0ynB9e
 XadG9D6dDllPFc=
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
index 1c63ab14c4383..515e943787416 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -39,6 +39,14 @@ clk24m: clock-24mhz {
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
@@ -51,6 +59,15 @@ gcr: syscon@b0000000 {
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

