Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA1D46C64F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbhLGVMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:12:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:36175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241635AbhLGVM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638911330;
        bh=1dtTDXD/Lvi01K4UbWYjNJTZ/ggnPgZ9xGaEukkWfB0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V9lovWgdCch7Uwa7Yur4HhZe67zRs2d/jd5aGtEF6j/jtMXwdljffV47p8JjEkV1E
         gMAjPcyoD5aH+dWGHWQElC6w7osrretjuErJt9kUOyK8WZliTi4V6/vRNl3Ig1/PL6
         3+vAYz1FiP+EhrHfBhtiZvOKSTGXJsAT7VDyAvZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatVh-1mIKwz1GcV-00cU1b; Tue, 07
 Dec 2021 22:08:50 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 3/8] ARM: dts: wpcm450: Add global control registers (GCR) node
Date:   Tue,  7 Dec 2021 22:08:18 +0100
Message-Id: <20211207210823.1975632-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/AEDgg1Hsm8PKkviv0rCSL50+S5ZpzOGhxAK9NCh4rQtu+koWJT
 dBq0cdOjqi5t/zBU3S/lXxYlVtZZigPP+W/xrO1VKumlqEUd313XNSlV5VKYOFtyIdlJjG7
 VYjsRt5BWbwFmQV9OLiV5PUAwAeHRdqLCi4MuipcN656Y1kHELEdhd0eKJDQlT0bFWerW1J
 MJUl6wglsJuzzRaqUtNQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tnd+BuRe4f8=:yASc0zKfgfnnATWaT7symi
 6GFAvsbRe7rInR0lrzfOsy/VFremHTp42/lNqzcVgUj6vzIJVA/tSRZmJ2kIboFDtWMeS4vlE
 JlyGJXaQ1yAZeD6pcH3TR+W+N2lLMMx6fB6ZV13a1BX4DHtdsETLO5dGtGmh6cEYjutoqiyL7
 mt++bB9zhctFCJICtXlqy8vTjOvW4pG/FzQmmMl3T0S7mCXFlzZbWFxaEBNItmPUub4JC4CUQ
 rQ/dKz/p8adTazkUnfAFXuepb40MhKAnTj6rv0iFcjbs4EzHJTDFnm/+/iQjxxwWi1We7JrWR
 WX3swBB9aMpOaeFHvgn8nwNBtebx1/gilk2GD6Ic8Btxq+4k6QJT7Nm9xpZOAJg47QuR378Gk
 xsAruGvaXEfnDAKMSjIfde+Ec5A/7RyIVHC4G0OIC6bYkWOvPaKgGH0F+KjQFsU73hr22g0/v
 fVZXpBol+54u9bF+TjDFFDnCEZfpHXSOUicVoXJMlo9QGv+ngQ8gas8G2qhC/y1FEhkALxXND
 zP+nM2oc8fbzlIVGdSN33uhvPNuAWJQ9TD7360+3uhr8WVTVPs+vn8RF/LWZ8VAvaWGRL5YiR
 /8nGpaFE5VnZ/aAMefzVMp40SD+7Q7IPoOZXLg7vD0RiBWByrpVLXBicGBy4pdKXz+IEgmjRG
 4Hm1NQfagX1/EUPUKhStq2R0Vw1npOL+YyQpRgC9xQ4gjXEbFgqtvU8UD3ftbBOl/U9/+azUg
 T9D9lmdezq5G6nu3vyYgvImjx7aaB+FWeIIKrEMB/11hk7lDptYEgulOmfLbKswVQxQMEdO2u
 9Bca4JJpvG1J2XlHZFzWmROpg7A1DYidqkwTICwFnWN13MgMAUSFcltshNzzHh/XsjNfmnCcZ
 yM89qL5n99knO8m2MZI8ghwpmLMc20JwmKfYKGa0WOWADCBurM+Q3VklasLq9EfSUbereT3v8
 nAfjwVi4oenRkz+xCB9f030dzZ/FAfOSAQdaP3kbLY7Psis8OSAKLmgrwvYT1RiifDV7EL8uq
 xRZg6E9D5N+8CWmVf5y/VG6SOpgEdFRdC9bHV+K7TLla+YFZALjeFCSn7hbtTfga94mhSFBwB
 IyUHRkRzfxK1Pg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Global Control Registers (GCR) are a block of registers in Nuvoton
SoCs that expose misc functionality such as chip model and version
information or pinmux settings.

This patch adds a GCR node to nuvoton-wpcm450.dtsi in preparation for
enabling pinctrl on this SoC.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


=2D--
v2:
- Rename node to syscon@b0000000

v1:
- https://lore.kernel.org/lkml/20210602120329.2444672-4-j.neuschaefer@gmx.=
net/
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index d7cbeb1874840..a17ee70085dd0 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -33,6 +33,11 @@ soc {
 		interrupt-parent =3D <&aic>;
 		ranges;

+		gcr: syscon@b0000000 {
+			compatible =3D "nuvoton,wpcm450-gcr", "syscon", "simple-mfd";
+			reg =3D <0xb0000000 0x200>;
+		};
+
 		serial0: serial@b8000000 {
 			compatible =3D "nuvoton,wpcm450-uart";
 			reg =3D <0xb8000000 0x20>;
=2D-
2.30.2

