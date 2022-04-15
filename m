Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6325502C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354848AbiDOPKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354841AbiDOPJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:09:50 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E9CF4B0;
        Fri, 15 Apr 2022 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650035240; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NRTmVUFKuE8CMESQAm4DH0fvEVp7eM4RIJTXRaTSSI=;
        b=dbSqEuCyvoj2avoBIOZeoZYeD+m6qVjmB80MGk1eLm/4t3/fU5GFQR8WuXRw7lD2s6WQy/
        wAZEF5D4gXqpcsazI8DHZ6rVHCCAP8B36cybPL8cS0/1dQPRuAfZxSlFRY/u9V6iCTDexR
        eyRWsGoDHy22VKQHGyZmYhESb3boylQ=
Date:   Fri, 15 Apr 2022 16:07:08 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 3/3] MIPS: Ingenic: Refresh USB nodes to match driver
 changes.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dragancecavac@yahoo.com, hns@goldelico.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Message-Id: <WBZDAR.1ZU7BOCJE9S11@crapouillou.net>
In-Reply-To: <1649964337-114337-4-git-send-email-zhouyanjie@wanyeetech.com>
References: <1649964337-114337-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1649964337-114337-4-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,


Le ven., avril 15 2022 at 03:25:37 +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou=
 Yanjie)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Refresh USB nodes in the jz4780.dtsi, x1000.dtsi, and x1830.dtsi=20
> files.
>=20
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> ---
>=20
> Notes:
>     v3:
>     New patch.
>=20
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
>  arch/mips/boot/dts/ingenic/x1000.dtsi  | 2 +-
>  arch/mips/boot/dts/ingenic/x1830.dtsi  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi=20
> b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index b998301..c182a65 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -577,7 +577,7 @@
>  	};
>=20
>  	otg: usb@13500000 {
> -		compatible =3D "ingenic,jz4780-otg", "snps,dwc2";
> +		compatible =3D "ingenic,jz4780-otg";

Could you refresh my memory - why are the "snps,dwc2" fallback strings=20
removed?

To me it seems like they should be here, since the OTG IP in Ingenic=20
SoCs is derived from the DWC2 IP.

Cheers,
-Paul

>  		reg =3D <0x13500000 0x40000>;
>=20
>  		interrupt-parent =3D <&intc>;
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi=20
> b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index 8bd27ede..343818a2 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -366,7 +366,7 @@
>  	};
>=20
>  	otg: usb@13500000 {
> -		compatible =3D "ingenic,x1000-otg", "snps,dwc2";
> +		compatible =3D "ingenic,x1000-otg";
>  		reg =3D <0x13500000 0x40000>;
>=20
>  		interrupt-parent =3D <&intc>;
> diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi=20
> b/arch/mips/boot/dts/ingenic/x1830.dtsi
> index 2595df8..6aff19f 100644
> --- a/arch/mips/boot/dts/ingenic/x1830.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
> @@ -355,7 +355,7 @@
>  	};
>=20
>  	otg: usb@13500000 {
> -		compatible =3D "ingenic,x1830-otg", "snps,dwc2";
> +		compatible =3D "ingenic,x1830-otg";
>  		reg =3D <0x13500000 0x40000>;
>=20
>  		interrupt-parent =3D <&intc>;
> --
> 2.7.4
>=20


