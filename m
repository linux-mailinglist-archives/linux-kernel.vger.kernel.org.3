Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985964FA824
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbiDINUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241946AbiDINUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:20:24 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A7B21806;
        Sat,  9 Apr 2022 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649510292;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=by7DEhdcJ+ZapZX6ooZkAXQjneKu89KNMa67tuLz/hE=;
    b=M8rJ80er592csCA0aOSl1X+yoeZfjXKrppZJmErUhxBzYAkVpl8KnituLVKZrGIVhx
    ubu0+fo1sWE8D3JKcBYCYpdR+0QQvWaS7RY/tnbXwWqqwbs2ZTuUydBFhwFRfZe0ToPM
    V44Ub+PWFRvQxgfmTbREQv6JZTGCvS4KkKYVJuWA6f2N5BcoPEzEHBCMEHAMo08qJW1c
    KEs5GoUnyBnPEZJ5Do4q89zEdhOqjLHF+ul97T9VKrkilGMHApYApnjJa4DH57tkmq4G
    /fYGjUdD90fujPveVty4U6qjW9nFdVJ1fZQBaCQG8a0JUHhiZb40GPskNsXXvSU52HXR
    QfdQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39DICuVQ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:18:12 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <3XN2AR.4ZAYNTAI4XBT3@crapouillou.net>
Date:   Sat, 9 Apr 2022 15:18:11 +0200
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <36C96109-0A56-4ACF-ACD1-367DAD9E3A47@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
 <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
 <3XN2AR.4ZAYNTAI4XBT3@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 09.04.2022 um 14:27 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi,
>=20
> Le sam., avril 9 2022 at 13:15:37 +0200, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> a =C3=A9crit :
>> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>> arch/mips/boot/dts/ingenic/ci20.dtb: usb@13500000: compatible: =
'oneOf' conditional failed, one must be fixed:
>>> 	['ingenic,jz4780-otg', 'snps,dwc2'] is too long
>>> 	['ingenic,jz4780-otg', 'snps,dwc2'] is too short
>>> 	'brcm,bcm2835-usb' was expected
>>> 	'hisilicon,hi6220-usb' was expected
>>> 	'rockchip,rk3066-usb' was expected
>>> 	'ingenic,jz4780-otg' is not one of ['rockchip,px30-usb', =
'rockchip,rk3036-usb', 'rockchip,rk3188-usb', 'rockchip,rk3228-usb', =
'rockchip,rk3288-usb', 'rockchip,rk3308-usb', 'rockchip,rk3328-usb', =
'rockchip,rk3368-usb', 'rockchip,rv1108-usb']
>>> 	'lantiq,arx100-usb' was expected
>>> 	'lantiq,xrx200-usb' was expected
>>> 	'ingenic,jz4780-otg' is not one of ['amlogic,meson8-usb', =
'amlogic,meson8b-usb', 'amlogic,meson-gxbb-usb', =
'amlogic,meson-g12a-usb', 'intel,socfpga-agilex-hsotg']
>>> 	'amcc,dwc-otg' was expected
>>> 	'apm,apm82181-dwc-otg' was expected
>>> 	'snps,dwc2' was expected
>>> 	'st,stm32f4x9-fsotg' was expected
>>> 	'st,stm32f4x9-hsotg' was expected
>>> 	'st,stm32f7-hsotg' was expected
>>> 	'st,stm32mp15-fsotg' was expected
>>> 	'st,stm32mp15-hsotg' was expected
>>> 	'samsung,s3c6400-hsotg' was expected
>>> 	'intel,socfpga-agilex-hsotg' was expected
>> You really don't need to paste entire warning.
>>> 	=46rom schema: Documentation/devicetree/bindings/usb/dwc2.yaml
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi =
b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> index 2021836983c96..c5124459678b7 100644
>>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> @@ -576,7 +576,7 @@ bch: bch@134d0000 {
>>>  	};
>>>  	otg: usb@13500000 {
>>> -		compatible =3D "ingenic,jz4780-otg", "snps,dwc2";
>>> +		compatible =3D "snps,dwc2";
>> This looks wrong, the block usually should have a specific =
compatible.
>> Please mention why it does not.
>=20
> Agreed. The "snps,dwc2" should be a fallback string, otherwise there =
is no way to uniquely identify the JZ4780 implementation of the IP.

Well, there is no specifc implementation and driver for it. So no need =
to uniquely identify it.

BR and thanks,
Nikolaus

