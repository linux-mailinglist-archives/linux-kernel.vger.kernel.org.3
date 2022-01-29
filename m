Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8C4A2E90
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245403AbiA2L6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:58:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:35961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243899AbiA2L5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643457462;
        bh=MIZniDk7N3TE6mLngidszvMWT882CR9454iU1vgKDkc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kMOipAilKUmfEYxUql4wqpAfSzZ7MpPmyGV2ylyQo1qPdO/i+FWOB4yqgOn6uizaR
         aF8ENdDRIn1/YZYOErpmQSoLeLkMT2yCmTiWPRUVQxjnCjoTRle1nnrZxEYxixTMiN
         F/Gd3Dy3jmr9NlsVXPvTgmzi28AB61VSKcyBinC8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7Jza-1nAUZO0toa-007kN3; Sat, 29
 Jan 2022 12:57:42 +0100
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
Subject: [PATCH v5 9/9] ARM: dts: wpcm450: Add pinmux information to UART0
Date:   Sat, 29 Jan 2022 12:52:28 +0100
Message-Id: <20220129115228.2257310-10-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3bVTXRnROyXZVzPKl7qIEkaP/8dvzuXs4tsFKVYR2kReylPAjQx
 IdPq+BudCcnjrXwgWpAV60xaz7miSSx4zSNmwonOzXBxN2soWp9xEgyW5ZJhg9UrdSa9bYF
 DLJBhca5KeIgyTQryy2W4G+0YzphPQ1n84VHj9CmNL7RsKZSyJkCdyPz9lg1Na6rgmHCqnT
 QnTorlsoJZauacYUqlAlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bxz1Igg1nTo=:f+n1hQy+WqXL3elrynr614
 /EQPXsgfSugkS9ctx/JpP6nppqOwyEbGl4m5lI0pySPW1x+1YF5b+aGx9Lq770uC47RpVQ4QG
 XbHlJtUNUJnY0mzQWqE2DBbaOJ6VrCXTUafZsWoT3J0c1CpmdryU36GiInVnnlEp0LsNa1KYe
 u4i3k2/oY9yRUfZUknUja7IcM0dSvF1hW3avbouqrBOg2O1mY6zxOtTaHUTdrHxsos+ixOhCE
 MJKEc4266S3PH4X0vtgXWxPcpWEFlN2702wEMKCx0O72tvodtmu8zWP6+3nOPsY8EB1CHivGn
 k5HZ3OlY8WFyJ5hsAWFJV5Ihnp192fP4nEmzxdalaxqC8IkNKMjGJvDitzeuf2txxeki25msw
 LBf9xQ7QmDvlo/8IrLr8j197rTt6LM2qy99TkG08OxUPFso0SF98ZW+jvDVWa7je+667F4bas
 g06OfTE3oOsL73Pf2Gj2ex8MGuHJVbFDzpqnjG+HoWVKNQb8dH1+0RJFslDb1xbUaXFy5wRsR
 L07jLdsSvu/A8fESPGrnSlHwfz3C3VbF5USw7y0ZO+Ll7dGz2c3wabYbSXRvPHOsxUEJqq0UH
 MauOkL6kAzPJAWjl6mQ+30GSnvCNzRxd8rgjp5giIzCz2YXNaQF18Ak0pH/M8yaJULXIaASNR
 B6oXLkORCpfnmmey0z46MFZJ9qJ0xlEAniPbz1jMe3FG8xlDRdLywUiTQraOz7vliyqL+NcEo
 LXPsjFpN2RmCF+vsj7l9QuKv9KRdQWw/o5HdYw1w7jjuHaj/qE2UEHOorl1YQbVGJ6qV0RU6q
 HHYE9yWK2/WQx72oSUqXWwmxWfhx2TdqsFlfzYJVMOOL6pYVPKJx/13mVkD0vtF5scD615/Ed
 nwd/0+VH6RzpO7PZuXOjiG9mRcCGiyYEkAGzxz2+BbM3gAsOsyROMb0p9CtCDeBK96HvYZSd/
 AvMbWDUkd8Lh8U4gYK1EQf9NKKKP/jhaQHvgAsqYS7BAYuxrDjjchRAacNCd2ha8NN9BqQbfh
 w5sHSyQ7ksrWNo8tfdYKCqD6YHJki6XDiInfHQpo1WNnqceW/e1TxjQ8GC/1Hk5rxqhq3RYkG
 EaSHekQo6VCDF8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART0 always uses the same pins, so lets add the pinctrl information to
the common devicetree for WPCM450.

UART1 has different connection options, so I'm not adding the pinctrl
properties there.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v4-v5:
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
2.34.1

