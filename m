Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E6A4A2E88
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiA2L5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:57:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:49025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243275AbiA2L5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643457459;
        bh=5zpIRyxX/X4OnfxZHDwl8CdG/XrYX94rU1ODRUhYvYQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bA4rch5jU9FTaZFXZpLzqtPbUmosXUVARTv6c71AxxfvIxk5aipFRzFEMPURudQ6P
         hZm9c14XnPS1Yc1ncNaqzlJgWdolnn2y44n/y2Ep8qfE9YA0T3uFeqKDOWdPuybj/z
         34++QTi4uQaOxNU2NncMRx10ufSra9IBnzmwiZks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1musSt3SvV-00J2Ez; Sat, 29
 Jan 2022 12:57:38 +0100
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
Subject: [PATCH v5 6/9] ARM: dts: wpcm450: Add pinctrl and GPIO nodes
Date:   Sat, 29 Jan 2022 12:52:25 +0100
Message-Id: <20220129115228.2257310-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hdq0ewIGxSCLS3ghJS+jy1k/VAVyI9rqDa7LnKCj6xQ+9ciPvEe
 KUIezE4IHGC8l6NbmOurd20GQ6Wjp3TOBgsO9a0VFbkzvVv6W9tWMBOZJeau+2XiRYCsBs+
 epRrsK+HrFsP9bpS0coh5Jo32BWbJx8/EsNaakbZw3mkGeGx9JIRQUEUHrQGxaI96oTr/cV
 YGqe5+lpFo5DWJFjfXkaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xE78CPYNCgQ=:RqFo+uzzsvkepnPcCNCxo/
 5jJN0XffJ4EBiur5vI2dD2UwbEMxa+lUV/A5aKDAwGpQ0fC1bf96WQs+QOL8/g7LMYiLWOuAj
 +XQWbdjZTMCDxnaIjoFSE8ID8Rn4Fa4cvr8IC1CjGJhlY0TjseDr2pZbfKSJHpQig/0mp4U5e
 QSj2EHl7ugAyBKKvc/WAv71PgNH3xHHxjkQ7rvNoVQhoUc0tI4T28bhMHaAB2EcsF8iwoUa1Y
 YS3IWmvFYGzcrvH3JviGnogXMjrJhgW7yD6vJtMnpOcP8m0buymHDm1qaxffsgAkf4jIhXN2P
 OBKalsGJvWmhw46cFORxNp5Mw+sUK/TzFlQo0D85eJMaDvQwOgo8ZVMxA/omQjw9kK4YtAeWG
 Cb8Fkqt2ROx2Iz75oRgxHlBvESh1Q91VyIouGWtClWQ9u0u6bKmK4doA7tbPWTTBHbxnpFn3W
 Wf4SHzMAWirLsMmlbd8dVGpBg3UsKRNQTRRRwrjiL6xuwxPC8jjj/eyoMLHpo9cF0t46D4tPH
 lUMd+MUSJgJlWYn9zt8eb5OJ4QwGop/8zZNWhaQ7JiRkOqtQcqVc1CHhFyOHTRIpAj2e8Q01L
 k80/HwyuwtV/6Ac29uOLJ6YUSMD+pjWJlvhhJLzvCnOZ3urznPhHH40jGXlyd2UzHQqhsAas6
 w8pDZqQgQLHE4yDYMoDrbvmP4b1+4epKQmUcUkySaCFnZwEjK9/3EO2t7mztUjoaZVxUbWUfc
 5npkP5XrcLjQGVfSIHlTHP0DiXmNlEvMYDQHVYgsq6eTHZfq4nEVg0i63qwJqAqsyUZ+NZ7O/
 pKACL4wWfyYXH0VpsWIWel9NPgAbPvW5FtKJzcwT9neoC+WZgrCkQNO+uLV9XBe7cC0ztNSlR
 1h83IBb6uOk50VJNcdVNwPbLHdZvSMWRGlmRsM27yx0s33DvL8zfmwx13cYT4M90hPeN/xCpe
 c/fv6FCqBRWhnLaMwAN8OObJ2FDQHN5FYJKBFqAfdnjqi1qJxbS5IgrbfPfG8UMuxE7c6ihPz
 Ku9CNEdR7SjMnj3SXUYLNRK4/MupUnjuV5MW/odRrRuwlwp80Zoh1g7w16umyzOF4S7Z4BmUN
 uEtohwlOUkESdo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the pin controller and GPIO banks to the devicetree for th=
e
WPCM450 SoC.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

=2D--
v4-v5:
- no changes

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
2.34.1

