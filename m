Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB95A3617
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 10:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiH0Iui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 04:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiH0Iue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:50:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6CD2A435;
        Sat, 27 Aug 2022 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661590200;
        bh=sLqA9Nhv1LxIrayZxnMdcIGoDvAaLN5XDUzwmP9YimQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EdR/oW4bV7hX9TXH3hCs1b8ae02GLGT8/zQXzlH33lbg2FD7EK5m+etim2qbck7Lo
         KX46ga/l4XBAVynrKpj7gZqYlvgfEw0jKA707w0FqjIumz+4siXiW5elrQ8P/Pr3sz
         DnDH3mOSIdBFfvuU833dhdLFKth5dbjzKQ9PkuCE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.78.141] ([80.245.78.141]) by web-mail.gmx.net
 (3c-app-gmx-bs16.server.lan [172.19.170.68]) (via HTTP); Sat, 27 Aug 2022
 10:50:00 +0200
MIME-Version: 1.0
Message-ID: <trinity-88fbbdbe-de76-4479-9580-70edc34a4181-1661590200169@3c-app-gmx-bs16>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH v5 5/5] arm64: dts: rockchip: Add PCIe v3 nodes to
 BPI-R2-Pro
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Aug 2022 10:50:00 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <cae915f6-c951-ba97-346d-00922c85067d@linaro.org>
References: <20220825193836.54262-1-linux@fw-web.de>
 <20220825193836.54262-6-linux@fw-web.de>
 <cae915f6-c951-ba97-346d-00922c85067d@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ymlk8MTehRHvDLV/NMrQKgASYE/0aSiP2iwFAlrEWCCttBVnPTYScFUExZcU50B+XqKmI
 BuXBhJkCJj+2+/eoNz7ggJl2WQsoY705NyEf1FfXeY6RoQRbpXbEhBcjGEgshMvFE1b/kzeklzyz
 Jc+/8hiL2Y17nZT3O8suJSkmPFwGr0/x8ClhHdnHuXhW8+f/AtXrnSC0ajepwD78P6b2Wi5iFTRu
 gZMdH2cYUDUn7qoiKoSAr5SVtZCbW0Yzw4xk9lH9dbzVhilPFBKfkY6PPotFi6k0Y4A/KyPx9UB5
 ak=
X-UI-Out-Filterresults: notjunk:1;V03:K0:14K1gCFI7Lg=:IESHyz8gkpbbCdxNp9VwOq
 g91zU7UP3wl4gBf5hwPu1Kt/Ci46gU1S5IePgbdx27d4rk+8XLkZZkTbe4lwX+bOQXhBdC9AR
 FpG19k2DcAhUm3pDO5Cao94DPHxIasUiUjs5+TjmYes7jAfNiZeAEdiqqHVeu1m+EN4XU+Bxq
 CxYPS63stl1VPJxrUVO5aAlOeiWVJMpHx39GTls0vFHhTsNp2VyKd1Qm+rkIATDq7NuwMk2Wr
 PyroUfSCVp4LucSYsVvpjRhCn/OKjFR7ZTBNejGRVei+Q7qM22t3UI5zBj7e4fe9e0uY2K2j0
 a2lzJQrhy0bcptY4+HdG2EbkQwGouZRiHTxqHF7NCf+cKg/E8i4ibWIaFilmNjL0eWj9YAewG
 a+C7+3ejYYjoX9Y181gr2SuHQ8ATaVS8DaQfN/trfJnJH+MlfALu0IjXAWY4WPJeM+Fhx2Fqb
 rW9GucSJyWptQaz8Fv9HvM0xundhAFv79C0boRusyZQ7ZxCL2ZW3cfiqJsn5I+N5BXAXldxwW
 dLxaNx66xtaSb4VDHIPUjVFrfl/8TFf/Zy44PmjFq5m4VZJ62iF7dF5K1dvh4s+bvm7g8ly9n
 C35AmnZ2vbGAOQ6RDuuCcaZuhMQT3ZB6arKVCfYBG469OZ4HatS/HHnnWudZyvYv/SE0/HZkg
 ptCNpN7LXjFAZJK6V9fG0wXfFH0mJ4Vo0m4j3gsJc9FulmhYpPVUxYxO5HZRTRpMzDoNN8Lw2
 idg2jRqNtU72VknArJFbOHJG4CX0CYNV1TbgpJ2XTQgJQRKWTcYcrt70zam6gq9hpKV5oHSXA
 +Ho6+gE
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Freitag, 26. August 2022 um 08:50 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> On 25/08/2022 22:38, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>

> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch=
/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> > index 93d383b8be87..40b90c052634 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> > @@ -86,6 +86,66 @@ vcc5v0_sys: vcc5v0-sys {
> >  		vin-supply =3D <&dc_12v>;
> >  	};
> >
> > +	pcie30_avdd0v9: pcie30-avdd0v9 {
>
> Use consistent naming, so if other nodes have "regulator" suffix, use it
> here as well.

only these 3 new have the suffix:

vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator
vcc3v3_minipcie: vcc3v3-minipcie-regulator
vcc3v3_ngff: vcc3v3-ngff-regulator

so i would drop it there...

so i end up with (including existing ones to compare):

vcc3v3_sys: vcc3v3-sys
vcc5v0_sys: vcc5v0-sys
pcie30_avdd0v9: pcie30-avdd0v9
pcie30_avdd1v8: pcie30-avdd1v8
vcc3v3_pi6c_05: vcc3v3-pi6c-05
vcc3v3_minipcie: vcc3v3-minipcie
vcc3v3_ngff: vcc3v3-ngff
vcc5v0_usb: vcc5v0_usb
vcc5v0_usb_host: vcc5v0-usb-host
vcc5v0_usb_otg: vcc5v0-usb-otg

is this ok?

maybe swap avdd* and pcie30 part to have voltage in front of function.

> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "pcie30_avdd0v9";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt =3D <900000>;
> > +		regulator-max-microvolt =3D <900000>;
> > +		vin-supply =3D <&vcc3v3_sys>;
> > +	};
> > +
> > +	pcie30_avdd1v8: pcie30-avdd1v8 {
>
> Ditto.
>
>
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "pcie30_avdd1v8";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt =3D <1800000>;
> > +		regulator-max-microvolt =3D <1800000>;
> > +		vin-supply =3D <&vcc3v3_sys>;
> > +	};
> > +
> > +	/* pi6c pcie clock generator feeds both ports */
> > +	vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "vcc3v3_pcie";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		enable-active-high;
> > +		gpios =3D <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
> > +		startup-delay-us =3D <200000>;
> > +		vin-supply =3D <&vcc5v0_sys>;
> > +	};
> > +
>
> Best regards,
> Krzysztof
>
