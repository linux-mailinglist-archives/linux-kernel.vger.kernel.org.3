Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9494FA7FE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbiDINHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241864AbiDINHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:07:48 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD013A1CA;
        Sat,  9 Apr 2022 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649509538;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=kK5SosoKedoT08w+RcxcGb22+/utk0Nmj6iZL8hHvw4=;
    b=OC1epgoCR+q+/JBQ1PyD2v1uzt/nJpQwv/NoW5OC+aLjjYPPz00fUzx5Fu2IrW1Sxl
    EP6VbJby+IcfnVObe7iN6fEvsFgfP7I0bMBj7utz7x9yjF4uBVhLS2YGd5gygcH7LFNj
    zwaMcu2ma3pG90Kvz4Qp6H7B0hjR2TyKwd7mhbrjCOe/gFs0GMhtAB5d+fWHh2ZkYhHH
    PPdBxVlId8N2lGVFyD2kBP/I3t8qeisCNkMqGDcxw3PlGOS51bCURTN7EYqvrRZguLWP
    +/vGYDEPVAg347CYwkp2HgSF3HSwC9Lc+4JEIVEGOWzKK+2oW1HmJufDu+NdWpQUD0J5
    I9lQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39D5cuUE
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:05:38 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
Date:   Sat, 9 Apr 2022 15:05:37 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <822182F3-5429-4731-9FA1-8F18C5D95DEC@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
 <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.04.2022 um 13:15 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>> arch/mips/boot/dts/ingenic/ci20.dtb: usb@13500000: compatible: =
'oneOf' conditional failed, one must be fixed:
>> 	['ingenic,jz4780-otg', 'snps,dwc2'] is too long
>> 	['ingenic,jz4780-otg', 'snps,dwc2'] is too short
>> 	'brcm,bcm2835-usb' was expected
>> 	'hisilicon,hi6220-usb' was expected
>> 	'rockchip,rk3066-usb' was expected
>> 	'ingenic,jz4780-otg' is not one of ['rockchip,px30-usb', =
'rockchip,rk3036-usb', 'rockchip,rk3188-usb', 'rockchip,rk3228-usb', =
'rockchip,rk3288-usb', 'rockchip,rk3308-usb', 'rockchip,rk3328-usb', =
'rockchip,rk3368-usb', 'rockchip,rv1108-usb']
>> 	'lantiq,arx100-usb' was expected
>> 	'lantiq,xrx200-usb' was expected
>> 	'ingenic,jz4780-otg' is not one of ['amlogic,meson8-usb', =
'amlogic,meson8b-usb', 'amlogic,meson-gxbb-usb', =
'amlogic,meson-g12a-usb', 'intel,socfpga-agilex-hsotg']
>> 	'amcc,dwc-otg' was expected
>> 	'apm,apm82181-dwc-otg' was expected
>> 	'snps,dwc2' was expected
>> 	'st,stm32f4x9-fsotg' was expected
>> 	'st,stm32f4x9-hsotg' was expected
>> 	'st,stm32f7-hsotg' was expected
>> 	'st,stm32mp15-fsotg' was expected
>> 	'st,stm32mp15-hsotg' was expected
>> 	'samsung,s3c6400-hsotg' was expected
>> 	'intel,socfpga-agilex-hsotg' was expected
>=20
> You really don't need to paste entire warning.
>=20
>=20
>> 	=46rom schema: Documentation/devicetree/bindings/usb/dwc2.yaml
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi =
b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> index 2021836983c96..c5124459678b7 100644
>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> @@ -576,7 +576,7 @@ bch: bch@134d0000 {
>> 	};
>>=20
>> 	otg: usb@13500000 {
>> -		compatible =3D "ingenic,jz4780-otg", "snps,dwc2";
>> +		compatible =3D "snps,dwc2";
>=20
> This looks wrong, the block usually should have a specific compatible.
> Please mention why it does not.

Well, I did not even have that idea that it could need an explanation.

There is no "ingenic,jz4780-otg" and none is needed here to make it =
work.

Therefore the generic "snps,dwc2" is sufficient.

