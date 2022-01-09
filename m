Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58330488B5C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiAIRfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:35:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:52993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236371AbiAIReg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641749668;
        bh=S1fDqY5q+XGp/bgY2KQrdz7thakciuLQ5dGsQoNlbO4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CPqGVT15EFOpj9u08dtBtRBHOvVEjJwFqcw5bGrpM4eeDuZ165zummrEyFqXYbg0p
         xPJJ4nbLrFYD4iodkTyyEhDfNaF9VuIS1Lpn+uCHBhbkqvJaoy/nNQ9+wuI/eu/25g
         bZ6PjYHBn883M4ahlabhX4VcQmblW2udhlNBIL8Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.222.244]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbkM-1mnyEy1Uei-00L0S2; Sun, 09
 Jan 2022 18:34:28 +0100
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
Subject: [PATCH v4 9/9] ARM: dts: wpcm450: Add pinmux information to UART0
Date:   Sun,  9 Jan 2022 18:30:00 +0100
Message-Id: <20220109173000.1242703-10-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
References: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rs88HzjXBFon7hKlwn5tVomiUujPMURZRAOwPrWWZco4Fi8tdW3
 hlGEEbmkb9LKOKRTsNmx37bwxyMB3ZNTaDIEyEsUSboNPkrIDfjpKByUAxL6/qKgNUoKIa0
 kHPCTwBgeHQJkKQMif32lsWVxelncZz///cZkyEx/6kX+XQaCZbWkRe1qv4Z+MFo9LBDsKK
 kf4RroCLg7cpw1Umvlegg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v29Us6KVIio=:Vy+ZjY87tB4vHKxuCABjtF
 n6F5QwOIJwo2wtWsSLMJq3x5/qAwtyOptEnyNjZnX5tbsaffK+DPedTpyo9aukNPUcoK0i4RU
 MYmMZkZlPZ1NEQFhvBUGq/kcnJh9EnvnUvkmmWl92W9bEf9w7WRcB0XpmtbT1cdO96f4efsGO
 8dDt5rBqar2HIIyeF29MnUQe26mH87CRlgOSi3EsxHiRz/ZzVLnqnFoq9O1//QZKSnT3KNk21
 9FIQmG5W49olEn3rmJOmbHPHkQhLFnL281ASZTq5J/4tk7MX9SMGd7waYbI0BYmNuoYpg2pPY
 2887oO6ZoapeYt9A/3Kphk04hXtNUIS0Y1W5399gjQKAhFxsQAWs7SdpR9ppkJk52CEPd9Tsy
 3rLSCAMxzCtNiinsvAWVVWi+2fQFybycrhH7SYdBgeQV2W7nWvtAagz9KAAse876TOE21fkZh
 Y411nd6v35RB42WqyHzyecZIXnhUcuQbOU/Aaa0H1JY1HarZcdv5nRxvZLJs7AddN1DZUeJ5w
 JHBfFdiD57916Ew+rVpcPySyRUp/1ksL5915t/hG3NNxNuJsuyixT6b2sEPcj81DQ7uRIPFdC
 +R+6k3+8YZ4iDXoRIvs+JDCNCmqyxrtoSKJcDgEnhW58CZHuyIb4BebFFqrFIDL7GGCrG/DAz
 sUcV9TK78vakJJOB36Os41xLjdtn6UNfrUH6ZLxCRETq4ENCzP5XmMniW/1N3+yjgNAu/2wFS
 R/dH82zQmdnSo8YXXnYhRWG0xh0I9wt6B8xgQSm9sTDWlEOPRT8ApWHHwMt6MkMfBvlVD1HtA
 GmvVL3Z0iKwAT2MUFaL5jsapIHvCpWH8nXIBu4lnsDC1mZSg7T0rFmLiUA5p4OsrIsiuAWpBd
 ywFvYF2x+U2uWI2yWRWvW3HTb5bz2RHpsswaJvd8LSmAz8NIDV4LdEgC6UQNxYFnoUFqzhxdK
 HY949zte99FDkrgMJnjG9wyhGIaMEgy8ENYGaVH+I3UEwcPv0psHc0OptnAr+LyD3uHV5letK
 GkXxdgc9jel68OK/YP+v36+vXqVlWqTSZtjrHGm5v1vBpldj62ClgwTseMMwOFvdSzUsqy5ez
 5bcYwFYXVV9aL0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART0 always uses the same pins, so lets add the pinctrl information to
the common devicetree for WPCM450.

UART1 has different connection options, so I'm not adding the pinctrl
properties there.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v4:
- no changes

v3:
- New patch
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index 0c547bd88bdbd..93595850a4c3c 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -55,6 +55,8 @@ serial0: serial@b8000000 {
 			reg-shift =3D <2>;
 			interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&clk24m>;
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&bsp_pins>;
 			status =3D "disabled";
 		};

=2D-
2.30.2

