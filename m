Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FEC47F0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 21:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353676AbhLXUKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 15:10:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:45015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353563AbhLXUKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 15:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640376604;
        bh=HvdvwRII9OzXHOV3hlj+3jLrwiFzBRUtAT+xujYMRXs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=imUjJK14h7omdvl/FpxX6RRPdCxAzwrQLVYeJKkwdoGpXApyxLYnA8j1Vk3+h5l78
         JOk8DjFuXHRggG77xv8BZ7SnWkA0jy43TmL/qkh8MGdT7HYCu6mJVSyi2UV09vFTbW
         9UcejbzUHdR394KgWUoOraGnr6p7cZsJXlvBlb18=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1mNRca2sk4-014Atr; Fri, 24
 Dec 2021 21:10:04 +0100
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
Subject: [PATCH v3 9/9] ARM: dts: wpcm450: Add pinmux information to UART0
Date:   Fri, 24 Dec 2021 21:09:35 +0100
Message-Id: <20211224200935.93817-10-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224200935.93817-1-j.neuschaefer@gmx.net>
References: <20211224200935.93817-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wviO4hpe9xe7Hm9B7ijEe07GIIOkeP970bOmna5Hn9ObsiSHwl6
 Jlh2qRGqNqlCkbNmgW2E1tHEqf4MFNc6xK7KlOW1R58HJTFF/IiglC9pU1FHtLqKJkXTJXh
 6LyzDLX+snwc0XKqluAKbY/bEbv4n/S3k4d5DDK2PsDLy6CAiIXpQy1KSRcQYJ0FycAPXjJ
 vzbNeijbgL+mrqOFuwN+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4VYM25R3hbQ=:/eUHdZCzEuu26m+033SHI/
 pnCgVvp5tcX0rT+4RStSsUtRUXikp0RgRruO8v/CVMAr6I5yGc8G7BYIFKyb1Uf8LAuU19pAs
 6+qMGkGjujpkOxKn3OhoVOdEP2Lkpm1YLQg3lAlH5kBNdtnvhG70D7WqlnvXYrTE3rMtUXvtm
 GO37tvdORtwKAgMaAEsSMhPWwldxdzVr7GBWyqRtGzrfpy2kjFbv7XcX4o1D/OsZSBWxc+kO5
 r+El0mea8Lf1fEWo/Wf/8LcHXw81RfkLh+vGYeCgs/+AhLP6wNm2DlAr81B2cweQCWATkI/GB
 ycJWERYsbrTk8s/3HOyGWPpV0FoWCWlzYD5tDG7bESVphFfjGzimHkAZLqyuC6JU68MbH8BRm
 NPGHd9Bc1YL1LZjnnx6JckUlOuU48EbW7JIsGWpQD4B5rUmuF7NmsWMai7G9pqxBOhREsYNwq
 EBIGmacYYpcOIq60NsOgahoszCdCSOj7P9dfTY+JZvfZI0FHlNtUdqMbEozJq6HGoomffAUX8
 +ecLRQksHpgxLQJzZ9h+h3AuyNTUy/oGb+FS09g6J5XBQjTGrUQkY4rUFhyL1SNSDe7OQw1ds
 dggNxGflqN82b68V3jWspZ+L0C3eAc6BgkXCXXUYh9ZgQtQDhxhGDs+nbhHFulrWaOzrbpdJQ
 zKzMHBZfbxYP8qOH4ADFblSMdWTc8mpdUk9n+xe9Fu+NYzzPRDeX+NlMoA0OXMHKxPunG3KQx
 5xuuwLA1b/hMwtZyoz2l+My3cMrAwGNwGYdyK8/Q5B+XGM+ozVB64OIsjhZ5D831OZV53N9GB
 DPDe8G+JpGckvZDxsCgjYCTthfVdY6fjzj6uWwLmJWfF+90p2rZNxYiRMJrMJ5jBYm+SOk3VT
 HitRv7q4LoJeUgXnwiuMbjdpNLgxv1j+IddjNc0+w1sJ6+PragkcFhUvAUgRGTMjcmUTKuAJn
 +p+hrw31xldN7iC43vP3eN6wPvTh2K0Xek2PSB8lm17sblTJjt9TGDA65WqdidERQnL66D589
 tuhkClmwKY24gjpV95Qtyx8Gr71+zWo6uyPZv0S2szOB2+PQ81zg/mIuKTUuGivR75QEiW+Tn
 xykOl4sCm9racA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART0 always uses the same pins, so lets add the pinctrl information to
the common devicetree for WPCM450.

UART1 has different connection options, so I'm not adding the pinctrl
properties there.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

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

