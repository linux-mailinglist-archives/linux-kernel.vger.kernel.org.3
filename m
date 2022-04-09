Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384CA4FA7A8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbiDIM3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiDIM3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:29:20 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E215F220E8;
        Sat,  9 Apr 2022 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1649507232; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=478IFZued4oNBPDmGp+btGm6eYtQE8dPZoXkBmis6gQ=;
        b=viYpyu+kDgbHjbFamX1kCuIvqRlxUU85RxCf4dEQRVd6cqAOV0pG5KEc5Ij+2yX5dwKTC5
        0M1t4z+4pkhmXtW+ycbKg/xC7PG2rampBEug2RI77ObfVK0R+HrQW1xSmn3E03UNr5bLiJ
        tXShHsCnN9ebbx6rt8w4i2i3Cyj3yjM=
Date:   Sat, 09 Apr 2022 13:27:03 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Message-Id: <3XN2AR.4ZAYNTAI4XBT3@crapouillou.net>
In-Reply-To: <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
References: <cover.1649443080.git.hns@goldelico.com>
        <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
        <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
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

Le sam., avril 9 2022 at 13:15:37 +0200, Krzysztof Kozlowski=20
<krzysztof.kozlowski@linaro.org> a =E9crit :
> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>  arch/mips/boot/dts/ingenic/ci20.dtb: usb@13500000: compatible:=20
>> 'oneOf' conditional failed, one must be fixed:
>>  	['ingenic,jz4780-otg', 'snps,dwc2'] is too long
>>  	['ingenic,jz4780-otg', 'snps,dwc2'] is too short
>>  	'brcm,bcm2835-usb' was expected
>>  	'hisilicon,hi6220-usb' was expected
>>  	'rockchip,rk3066-usb' was expected
>>  	'ingenic,jz4780-otg' is not one of ['rockchip,px30-usb',=20
>> 'rockchip,rk3036-usb', 'rockchip,rk3188-usb', 'rockchip,rk3228-usb',=20
>> 'rockchip,rk3288-usb', 'rockchip,rk3308-usb', 'rockchip,rk3328-usb',=20
>> 'rockchip,rk3368-usb', 'rockchip,rv1108-usb']
>>  	'lantiq,arx100-usb' was expected
>>  	'lantiq,xrx200-usb' was expected
>>  	'ingenic,jz4780-otg' is not one of ['amlogic,meson8-usb',=20
>> 'amlogic,meson8b-usb', 'amlogic,meson-gxbb-usb',=20
>> 'amlogic,meson-g12a-usb', 'intel,socfpga-agilex-hsotg']
>>  	'amcc,dwc-otg' was expected
>>  	'apm,apm82181-dwc-otg' was expected
>>  	'snps,dwc2' was expected
>>  	'st,stm32f4x9-fsotg' was expected
>>  	'st,stm32f4x9-hsotg' was expected
>>  	'st,stm32f7-hsotg' was expected
>>  	'st,stm32mp15-fsotg' was expected
>>  	'st,stm32mp15-hsotg' was expected
>>  	'samsung,s3c6400-hsotg' was expected
>>  	'intel,socfpga-agilex-hsotg' was expected
>=20
> You really don't need to paste entire warning.
>=20
>=20
>>  	From schema: Documentation/devicetree/bindings/usb/dwc2.yaml
>>=20
>>  Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>  ---
>>   arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>>  diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi=20
>> b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>  index 2021836983c96..c5124459678b7 100644
>>  --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>  +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>  @@ -576,7 +576,7 @@ bch: bch@134d0000 {
>>   	};
>>=20
>>   	otg: usb@13500000 {
>>  -		compatible =3D "ingenic,jz4780-otg", "snps,dwc2";
>>  +		compatible =3D "snps,dwc2";
>=20
> This looks wrong, the block usually should have a specific compatible.
> Please mention why it does not.

Agreed. The "snps,dwc2" should be a fallback string, otherwise there is=20
no way to uniquely identify the JZ4780 implementation of the IP.

Cheers,
-Paul


