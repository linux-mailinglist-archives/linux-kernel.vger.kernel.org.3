Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6358D5CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241291AbiHIIzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiHIIzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:55:38 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CED21270;
        Tue,  9 Aug 2022 01:55:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1660035335; bh=gC4GNArn5L/+qSmbqUbjWxF4hXj6UbOzOdSVGC9cgDE=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=ZajEXVjp7mPMMG2eOn3wmWnNtyDDnBp6T+mh3Lh7LDgJkT00oLqeXkpQkzqJk4Tdb
         Q31ajC+zOqJEr6HgWWNNIXqDtjUn5onK4CiWqrqUJ4ukSUOYk6AkOziyznRr5ywn31
         qQTwzcFLfOLG5AFWJHC4utUEbbWrT1nIUfpjjz58=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 1/3] dt-bindings: sound: Add Apple MCA I2S transceiver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <cbe80ae1-3ae8-eccf-89f7-4506e3f44ca7@linaro.org>
Date:   Tue, 9 Aug 2022 10:55:35 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C55ADB0F-0894-4A3B-BDD2-6A20BB1F4A4F@cutebit.org>
References: <20220808224153.3634-1-povik+lin@cutebit.org>
 <20220808224153.3634-2-povik+lin@cutebit.org>
 <8ce59940-f559-35cb-5f86-37399da166a1@linaro.org>
 <DCBCB694-F5A3-4E76-9518-89E9A1A4AB55@cutebit.org>
 <cbe80ae1-3ae8-eccf-89f7-4506e3f44ca7@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 9. 8. 2022, at 10:47, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 09/08/2022 11:40, Martin Povi=C5=A1er wrote:
>>> Describe the items because otherwise you allow any order. The list =
will
>>> be unfortunately quite long, but still readable enough.
>>=20
>> Well, I would assume the =E2=80=98dmas=E2=80=99 property as described =
above has an implicit
>> natural order, and the dma-names are tied to it. You order it like =
the other
>> per-cluster properties, and then within the cluster the order is =
fixed to
>> 'TXA, RXA, TXB, RXB=E2=80=99 (maybe the word =E2=80=98respectively=E2=80=
=99 thrown into the description
>> would have made it clearer).
>>=20
>> Anyway that=E2=80=99s just discussing my assumptions. I can roll out =
the items list
>> for =E2=80=98dma-names=E2=80=99, if that=E2=80=99s what you mean. Or =
do you mean explicitly describing
>> the items in =E2=80=98dmas=E2=80=99 too?
>=20
> The text description of 'dmas' does not mean it will be followed by =
DTS
> author. In current bindings DTS author can therefore put any order of
> dmas/dma-names. Unrolling the dma-names forces this order to be fixed
> and validated by dtschema.

OK

>>=20
>>>> +    description: |
>>>> +      Names for the DMA channels: 'tx'/'rx', then cluster number, =
then 'a'/'b'
>>>> +      based on the associated SERDES unit.
>>>> +
>>=20
>> (...)
>>=20
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    mca: mca@9b600000 {
>>>=20
>>> You called it I2S transceiver but isn't it also actually I2S =
controller?
>>> If yes, then the node name should be probably "i2s".
>>=20
>> It=E2=80=99s a peripheral you use to transmit and receive samples =
over I2S, frankly
>> I don't know the nomenclature.
>=20
> Looking at other devices, it's i2s.

OK, thanks.

> Best regards,
> Krzysztof

Best,
Martin

