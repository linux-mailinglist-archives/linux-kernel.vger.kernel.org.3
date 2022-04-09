Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423024FA80B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241896AbiDINND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbiDINMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:12:37 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D636740939;
        Sat,  9 Apr 2022 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649509824;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=De15Pn47uYxABPuGJ12C5h28oL8A7nL5Jr0tEKxummo=;
    b=co00Ouqv781jd3ZsY68soSVDXQxI8dqfbgEO4kFMQaCG6Zxr+2xKKYuTlz91ERrhJi
    BFxRXwLR1YOelLVxYea7x1U2TSgw2o0AimuRkF2INL44yJD9xaAi1PYa6Um0NYajVknX
    ocC0i5kTpQ2EmY4FldFxyubkhs2dRDlDU/D1HY5ZKdpVG3BofRof3jI5v04mG3P/gCJw
    tXVjCzsK8J2DjR6hiF+GL/FK7q8PvT7WbfH8GR/3hEEOSANcne8Btr5eOEZO7C9G2Qe0
    Ihhw62oHY8jkpNigPGcty7rf4RrEHO35UklgW6s9DYxBdPBJ43mQ+dHTn7AQKTIIA2Nc
    5XzQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39DANuUi
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:10:23 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 18/18] MIPS: DTS: CI20: fix bluetooth as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <623248f1-7ce2-7ff1-22d4-c56e0983c9bf@linaro.org>
Date:   Sat, 9 Apr 2022 15:10:23 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AF3BDE5-856B-4D85-8810-433C1591C037@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <32a2afa1a8f1f675a199d1aa9b4469bed2391069.1649443080.git.hns@goldelico.com>
 <623248f1-7ce2-7ff1-22d4-c56e0983c9bf@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.04.2022 um 13:22 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 08/04/2022 20:38, H. Nikolaus Schaller wrote:
>> arch/mips/boot/dts/ingenic/ci20.dtb: bluetooth: vcc-supply does not =
match any of the regexes: pinctrl-[0-9]+
>> 	=46rom schema: =
Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts =
b/arch/mips/boot/dts/ingenic/ci20.dts
>> index dc587b4b36009..8a120f9374331 100644
>> --- a/arch/mips/boot/dts/ingenic/ci20.dts
>> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
>> @@ -207,7 +207,7 @@ &uart2 {
>> 	bluetooth {
>> 		compatible =3D "brcm,bcm4330-bt";
>> 		reset-gpios =3D <&gpf 8 GPIO_ACTIVE_HIGH>;
>> -		vcc-supply =3D <&wlan0_power>;
>> +		vbat-supply =3D <&wlan0_power>;
>=20
> Could be also vddio...

Good hint.

Schematics has both vbat AND vddio connected.

But with that finding, there is also a wifi_io regulator
for 2.5V. It is always-on and NOT yet controlled.

So this is worth a functional addition. But not related
to dtbscheck cleanup because it even is optional.
Hence a separate topic.

>=20
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
>=20
> Best regards,
> Krzysztof

In summary for reviewing all patches: many thanks!

BR,
Nikolaus=
