Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A41C4A2E94
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbiA2L5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:57:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:60891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241967AbiA2L5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643457449;
        bh=1LZ/ihPho0RzAstq3Ynbig+sC/tEJmMzkoV4+SG+aP8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iYc/K1x3oNXbtTHcRG+wc7ydL8hNtjkUi2ek1VPwzpL9A7KWppG80xNJyB0SaXu1D
         IOGj3q0JuUbf3YN6ejvEHyDvp+AY2EXY/gRqlUZX3b5f5p1NlmWqnEaH1M6qngZbsq
         Xuhyc56jfZafKLQhJAaTlvqWYNjMxwgu+vMj4XVs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiaY9-1mZVnS0KkZ-00ficj; Sat, 29
 Jan 2022 12:57:29 +0100
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
Subject: [PATCH v5 3/9] ARM: dts: wpcm450: Add global control registers (GCR) node
Date:   Sat, 29 Jan 2022 12:52:22 +0100
Message-Id: <20220129115228.2257310-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uWHGPkJRvWxnECnfwrXV0TWggaOPv9+SSO437jFQR+JeoAS6qpD
 ASp4a549lRszU24uKv9b37j5c4114und2RPLKr29Cvru77vCIwM55+qUbhU+bUaDpxTOatv
 4ATR7t9/SoUK6eik4UOakbuJNvjUMEv+zQrxhni1LYmTRpm9GmXOvRtqR9bmZIxGlbwMjjb
 zvmjVgCeSn7D3ZMsk579A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FXr/dM8FKtM=:omSr0Jn0ejAiTskmScNVYP
 PGYq+oXKiwPz3A4lTF3zhb7K+AnGuNR3T6UamSzcx/b1fFf0tBP7Ee0u4u1dmQBWRYFB9cGxt
 K7Cvxm05hrrVQ/2IJRJblfC7GmWLEBP/2YHbNkF+6BrX9rieg1fCl0TZXK36Cy6MHZCtT76MD
 ArJ1U11cZNY7ckqtPnx3wnRlzzdDqjhITYu56NMrqygzuHcKNWYxz/y1ACzxYRyMWqBocO2KS
 kAIfPPDtcRKrgdzzvGgwpCl/cG5aquAmlfzUiHHPXhoQtDThKfRoaQTFVwpfv0U1S7ebobaQw
 lq2KAi3Uzgdm3WR375kRq6aLSA/e6S6WLTmk1HpGuWFjkl/5eodRJRK8os5hy1LbMYICRWrn4
 q45QAs5bIYbq0Tn6hsaReRlAsnK4zLasHUeEY5HplvkoTY6BpjMj2s9Ioi1QGZ1+BcSSazhbJ
 nL3xgX37aY/cuZ6SBwOt/FeM1Ps0DwRHUVu7mk35nZ6CAS/sqDRyCiLz1FeNyrlYS1bLAoDh8
 feAQ1UR38qZKB72z6OOfQootmnfw1r4x4/2rQe5Um0JohLgypS3uqMEiLlBF1MbhgH5PezOd3
 NFTHPXuIEVFnlz+FVxzYlqXiz7nqexs/bZ4UzrAPTlD92kWHR7bAMIMVuLmpgzWDHztOJ0LxD
 1IROpvHPtIfaz5CJMZh5PqEfsWxIsnWRroUOPzuq50gqKLqGd1ooQl5VNKQeHV3t7pb1EN69d
 OJbeds2OE9pME2AX7DXuzZ/e5B9I8RGZWyVePbC1SCoQc43uJIMopfU5dMOfzvHeUN8wlGl0Y
 WwALj39VCM4VGTikivcfJzXJ6DOxrT9MxWZ6rjA1UU2Uqt6shT/TiRTpgsGHJovzri4CWVyZ+
 YjiDdlYu49lpkJEiQGmiVtA4Eqq81Wx066qz1pm3gY4knAkByH2BNke6LSi1l5kPxI3x/04Ig
 mdjRFIBJKwaQywDK1ZNhTr5b0VFCMVu1oGwDyTlgbl/PRhl8A9zLaG+r0/qGa+qIwd9XBNlg2
 jhYGuFykUkvdzVKq6W6oo7y0oTVF6+Hf7za4FlZw7zRATcQDgWoENhcuG/NSt2i/gEnm+tDhC
 KWN8PtPiCxPvGk=
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
v3-v5:
- no changes

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
2.34.1

