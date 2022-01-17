Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A245F490807
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiAQL7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:59:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:59441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232540AbiAQL71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642420743;
        bh=gujjjYS9qrwNcyKQ6e9KHDoy6rimz86Y6K0Rz+RmDUc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a7TR8vfa60Twe9sfDtxzobLLBC1WGSWSQq6+QehAaAKkAb3ur6o+U9nJhvIQaAvYv
         GFYyyxXC6WXdwLRWdn3R/YAUpBnDfhdDHb1oyvq2/e2bYphp74qqZCM44pTI6LFZ9X
         C37PQnrI+uCSIhAc1Hlkab9B+d6HEybmsoBW6B6c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.156.53] ([217.61.156.53]) by web-mail.gmx.net
 (3c-app-gmx-bap64.server.lan [172.19.172.134]) (via HTTP); Mon, 17 Jan 2022
 12:59:03 +0100
MIME-Version: 1.0
Message-ID: <trinity-5a2f356e-2777-4624-b921-f8f56ce282c7-1642420742957@3c-app-gmx-bap64>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH v1 1/3] dts64: rk3568: drop pclk_xpcs from gmac0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jan 2022 12:59:03 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <8285bea7-559c-5834-78c7-5a062b7d8269@gmail.com>
References: <20220116124911.65203-1-linux@fw-web.de>
 <20220116124911.65203-2-linux@fw-web.de>
 <8285bea7-559c-5834-78c7-5a062b7d8269@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:cHO62E7Ya9rRWKPr0L0VrCY6B+yBe1mHhOfKgW+7v9Hi1JVHqgeaRwf2dbX14RlQr0bQS
 EaLgvi6Or8euWn98c6UjX+7pWk8eqTZy9t6P0XrUdQOhQ42xpzISY9KjjbMblE1OeK3bgJ/VIUlV
 0vP3/KvslZqn2qRoBHn0FVjlBaMw7Uv7heU+l7PCUPPxXcD739+eTt45Tiq9ATZnJbwRT+ohyZq7
 pJ6/eKvZiJ+LH9sOaXw0UmTO+PYxYdhQVBsabvBXMxGOQ2g0bw7hAkybXpltlfujGGjdfbeNyhZc
 3Y=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L5kvOgyIvyc=:rgDGofe8CM8AvpBjMrXbOl
 GuHBAUFt2+k+8H9y0OHogGT/4Fudq7RfZcPkA7WrtGEPoW9+EM/X04qQVmFIM0GMOUubqVXdX
 Wk8EPuPONlKFrbFuXT+bKhOHuFX4woH5PGzmGnp0SYLXVyo3qdBv+vOVItB1uj/rN0O5a2xAp
 vOYnEVPFE9wbuULn2UcCoze2e/n32jKEWeFRh127O5y0wDoExGmASf6QM49H4tqDCioLYT3zg
 L2nOebMdO+FGRD6yK9tnO9rh1fKE1hCDxzBv2hZsY97yxQ3MAzpxGS5lgj794zeuxq00wc39Q
 AJ9wNxg5nNELhK6eaH9cmL3t+jBsJB00/2nDBIzZHcfzr1bPD1jBuXDG6E7dOgJWHmPbySxl1
 EbzlxhoybuubsUN2WzXE59AvOUn2zxOkYiKYNTzquRDJapJFKedDmxv+TaZK4Xi0Zbery4659
 jBsJRpFrYJLyomSyD+i1CwFuNpqundlA+99xTC3KFfcJkcooKQRecf/QWzJ7ALh0bdZLVomle
 a4rUe2kzEGLnRoso0K4gqcq47mU9DiIkw8toOXCqpKQYXgYGM0Qv/qHRjWvVvbQveiyMCa7Kp
 sSOja7cW63bQEDqXWiAWeUHE9fMB5Bb3eCXE1M+wIvkIJ9cmLXH3u3HIM/8Cm0XJX42BoeweT
 knWIa91iHp4r/GxQfVOCL472l5fQ+X4kkG0vSEfXnu2fv3bmjaL7sKeMHvuaPCL96aoZQ9Nju
 LIoy25fZ5dhnmbvcmHrZ1/IrDuGQkU7qvBHR5uczZOso/1PDebtR7bAQQ9cQhFzCq17baNd/F
 N5nV3gJ
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Montag, 17. Januar 2022 um 11:47 Uhr
> Von: "Johan Jonker" <jbx6244@gmail.com>
> Hi Frank,
>
> Despite that the DT is hosted in the kernel tree
> DT and mainline kernel driver support are 2 separate things.
> PCLK_XPCS might be in use elsewhere.
>
> Given the link below pclk_xpcs is only needed for rk3568.
> Maybe gmac1 should have a PCLK_XPCS too, because one can select between
> them.
>
> ethernet: stmicro: stmmac: Add SGMII/QSGMII support for RK3568
> https://github.com/rockchip-linux/kernel/commit/1fc7cbfe9e227c700c692f1d=
e3137914b3ea6ca6
>
> The original dtsi did have PCLK_XPCS in both nodes.
> https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/bo=
ot/dts/rockchip/rk3568.dtsi#L2121
> https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/bo=
ot/dts/rockchip/rk3568.dtsi#L1492
>
> Maybe fix the document or leave it as it is for now as long the driver
> isn't updated and someone has tested it.
> That's up to the DT maintainer.
>
> Johan

as far as i understand, the PCLK_XPCS is part of the naneng combphy, which=
 is not yet available in mainline.
Naneng driver needs some changes and imho this should be part of it (inclu=
ding change documentation). That also makes it clear why this clock is add=
ed.
But leaving an unused property with sideeffects is imho no good choice.

So this was the easiest way to fix the dtbs_check. Else i got no usable re=
sult for it. Maybe adding it to Documentation is also easy, but have not y=
et looked into it as it currently unused from my POV.

But i leave it as decision for Maintainer to drop this patch as it is not =
needed for my Board DTS.

> =3D=3D=3D
>
> XPCS is also part of PD_PIPE.
> See Rockchip RK3568 TRM Part1 V1.0-20210111.pdf page 475.
> Please advise if the power-domain@RK3568_PD_PIPE does need a PCLK_XPCS
> fix or is PCLK_PIPE enough in combination with a PHY driver?
>
> PD_PIPE:
>
> BIU_PIPE
> USB3OTG
> PCIE20
> PCIE30
> SATA
> XPCS
>
>
> 	power-domain@RK3568_PD_PIPE {
> 		reg =3D <RK3568_PD_PIPE>;
> 		clocks =3D <&cru PCLK_PIPE>;
> 		pm_qos =3D <&qos_pcie2x1>,
> 			 <&qos_pcie3x1>,
> 			 <&qos_pcie3x2>,
> 			 <&qos_sata0>,
> 			 <&qos_sata1>,
> 			 <&qos_sata2>,
> 			 <&qos_usb3_0>,
> 			 <&qos_usb3_1>;
> 		#power-domain-cells =3D <0>;
> 	};

PD_PIPE is imho also part of Naneng. But more for usage as USB3/SATA/... p=
hy. This is not part of Mainline too.

But thanks for pointing.

regards Frank
