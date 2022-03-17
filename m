Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E784DC94D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiCQOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiCQOyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:54:39 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A970D4458;
        Thu, 17 Mar 2022 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1647528799; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYfYDYIQFfoWNGhKwXIbrjye+EKia8c1ukrhWtjT/ek=;
        b=OatruVl52eASm2VlXjarCVS80LTDmPf3nNaadkkKlsDgKdUvUvkPUaDPVUWpetT0PWqLjZ
        mo7CyXaZH0jA01RiG3bbpDpbCocea4BEjw43XO4LirZ4rN89TSUQpROLGWDReVh3J35JP1
        S8Va2xeffO12lgVNwh3PFuwz7EFG5RY=
Date:   Thu, 17 Mar 2022 14:53:10 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] MIPS: ingenic: correct unit node address
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <MC9W8R.BUBMZ3NYL78N2@crapouillou.net>
In-Reply-To: <20220317115259.448868-1-krzysztof.kozlowski@canonical.com>
References: <20220317115259.448868-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu., mars 17 2022 at 12:52:59 +0100, Krzysztof Kozlowski=20
<krzysztof.kozlowski@canonical.com> a =E9crit :
> Unit node addresses should not have leading 0x:
>=20
>   Warning (unit_address_format):=20
> /nemc@13410000/efuse@d0/eth-mac-addr@0x22: unit name should not have=20
> leading "0x"
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi=20
> b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index 3f9ea47a10cd..b998301f179c 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -510,7 +510,7 @@ efuse: efuse@d0 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
>=20
> -			eth0_addr: eth-mac-addr@0x22 {
> +			eth0_addr: eth-mac-addr@22 {
>  				reg =3D <0x22 0x6>;
>  			};
>  		};
> --
> 2.32.0
>=20


