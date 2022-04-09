Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BD54FA835
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbiDINZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiDINZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:25:06 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB363F6;
        Sat,  9 Apr 2022 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649510575;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=nBDAPlKQ4YG44AbUZ5EopbugVyGZ0YIKrTGGGC/Tzuo=;
    b=bh9XxcqX+OLWtmHAXi0xPnUr4drHupjYfMjbsqt9dG53zcvtmpv0a/f/Lbv06LHDT0
    sCNKVjxc6Ym0QAQteM+6TLlK3zkuw+JY/AP6DqtLBPCVm1eTodsISiXwd5scRzq86j5D
    uy4jALntssnEEAct+LtmIUUixiL2H2lhk/TnYwkeZcKySmZR0lw5Y5VgH8uRecEslMrc
    AB5M6g7CUksbYcnQMziSm98AnbsOT8GcXN5B8zBqN6304uDOBTNxVKbgXJb0AURclVDX
    P0O0/kq0sxgOyagpktQZqAqzsNv4Fz7QNHvGvuHgsiMXr20OHQTqhGW2kys4u18bgs1d
    pOXA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDepmg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy39DMsuVv
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 9 Apr 2022 15:22:54 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 05/18] MIPS: DTS: jz4780: fix pinctrl as reported by
 dtbscheck
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <c84b5ec0-0193-ab62-1985-25bc2baa9f05@linaro.org>
Date:   Sat, 9 Apr 2022 15:22:54 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5EB5983-DA9F-4631-B737-2B1417CF9054@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
 <1941bc4ed553b27f399ad00ea61ff2b0237d14e3.1649443080.git.hns@goldelico.com>
 <e905896e-335d-a88a-1961-d17b92e46585@linaro.org>
 <530E0F7F-FC03-45DD-BF87-D049D3108AD3@goldelico.com>
 <c84b5ec0-0193-ab62-1985-25bc2baa9f05@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.04.2022 um 15:13 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>=20
> On 09/04/2022 15:04, H. Nikolaus Schaller wrote:
>>=20
>>=20
>>> Am 09.04.2022 um 13:13 schrieb Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org>:
>>>=20
>>> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>>> arch/mips/boot/dts/ingenic/ci20.dtb: pin-controller@10010000: =
$nodename:0: 'pin-controller@10010000' does not match =
'^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>>>> 	=46rom schema: =
Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
>>>>=20
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>>> arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi =
b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>>> index 5f44cf004d473..b5299eaffb84a 100644
>>>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>>> @@ -155,7 +155,7 @@ rtc_dev: rtc@10003000 {
>>>> 		clock-names =3D "rtc";
>>>> 	};
>>>>=20
>>>> -	pinctrl: pin-controller@10010000 {
>>>> +	pinctrl: pinctrl@10010000 {
>>>=20
>>> Do it once for all DTSes, not one file at a time. There are four =
more
>>> places with this.
>>=20
>> Well, automation has no notion of "similarity" in this case to
>> merge several patches.
>=20
> What does that mean? One cannot create multiple patches and apply =
them?

This patch set was created by some automatic scripts. And they produce =
one patch
per group of warnings.

But here you ask me to merge 4 unrelated topics into a single one.

Or do you mean something else?

>=20
>> And they are not related. Every one is based on a different .yaml
>> schema file.
>=20
> Which does not matter, because the name of the node does not matter. =
We
> enforce it in schema to makes things organized and easier in testing.
> This does not fix any real problem, just the problem we created by
> ourselves with schema.
>=20
>>=20
>> That in all cases the result looks similar comes from similar
>> requirements by the schemata and has no inherent connection.
>=20
> All schemas will require it, won't they? The same for arm...

We may be talking about different things here.

My understanding:
you ask me to merge 5/18, 8/18, 9/18, 12/18 because they contain =
"controller" in the node-name.

Right? If not then we must clarify that first.

For pinctrl it is not allowed to have a -controller suffix while for the =
other it is mandatory
by the schema pattern.

BR and thanks,
Nikolaus


