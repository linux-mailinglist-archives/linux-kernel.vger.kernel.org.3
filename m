Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AEC4ED56D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiCaIZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiCaIZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:25:11 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F38C6EDB;
        Thu, 31 Mar 2022 01:23:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648714997; bh=iDBMY197GWWnst83wC1Tob2jp5vtx/AimRG78sGrwlo=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=aG0KI2SM/9+gcA9rLrq8QIXI2anoy0jX6J85T+T90QPChe8pYkTo6507F3c4NbXFX
         mjhD3ALdyV2JWKsmjfeKZQn5xUIARb4+0z5OaiidzmrkK1gDHSCjuLU2uIKh5o+9Uv
         QV4iq+0uzG8XMkXYQMLTqsntTuJyRkyugd8ynOMU=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH 1/5] dt-bindings: sound: Add Apple Macs sound system
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <0f7677ba-bffa-7ec6-7c74-3fad84a1d2c5@linaro.org>
Date:   Thu, 31 Mar 2022 10:23:17 +0200
Cc:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5F73642-DF9A-46ED-B310-7D69CAE22C82@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-2-povik+lin@cutebit.org>
 <9e3ba11c-d179-c229-fb7c-bf5611a15b1b@linaro.org>
 <DAFA4249-4B0A-4D1F-A36A-4352FE783488@cutebit.org>
 <0f7677ba-bffa-7ec6-7c74-3fad84a1d2c5@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31. 3. 2022, at 10:17, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 31/03/2022 08:57, Martin Povi=C5=A1er wrote:
>>=20
>>> On 31. 3. 2022, at 8:43, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>>>=20
>>> On 31/03/2022 02:04, Martin Povi=C5=A1er wrote:
>>>> Add binding for Apple Silicon Macs' machine-level sound system.
>>>>=20
>>>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>>>> ---
>>>> .../bindings/sound/apple,macaudio.yaml        | 103 =
++++++++++++++++++
>>>> 1 file changed, 103 insertions(+)
>>>> create mode 100644 =
Documentation/devicetree/bindings/sound/apple,macaudio.yaml
>>>>=20
>>>=20
>>> Commit title does not match subsystem.
>>=20
>> Tell more please. I don=E2=80=99t see it.
>=20
> git log --oneline  -- Documentation/devicetree/bindings/sound/
>=20
>=20
> Mark expects "ASoC: dt-bindings:"

Aha! Thanks.

>>>> diff --git =
a/Documentation/devicetree/bindings/sound/apple,macaudio.yaml =
b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
>>>> new file mode 100644
>>>> index 000000000000..a6380e4bdd1a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
>>>> @@ -0,0 +1,103 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/sound/apple,macaudio.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Apple Silicon Macs integrated sound system
>>>> +
>>>> +maintainers:
>>>> +  - Martin Povi=C5=A1er <povik+lin@cutebit.org>
>>>> +
>>>=20
>>> Add description.
>>>=20
>>>> +definitions:
>>>=20
>>> This does not make code more readable.
>>=20
>> Are you sure? It prevents duplication later on for =E2=80=98codec' =
and =E2=80=98cpu=E2=80=99.
>=20
> That's true, but duplication is small, unless you think this will be
> extended. I guess it is a trade-off, but so far for few lines and just
> two users of such definition, I would prefer to duplicate. I don't =
have
> strong opinion, though.

OK

>>=20
>>>=20
>>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>>> +      link-name:
>>>> +        description: Name for the DAI link to present to users.
>>>> +        $ref: /schemas/types.yaml#/definitions/string
>>>> +      cpu:
>>>> +        $ref: "#/definitions/dai"
>>>> +      codec:
>>>> +        $ref: "#/definitions/dai"
>>>=20
>>> missing maxItems for DAI phandles.
>>=20
>> Well there=E2=80=99s not a maximum.
>=20
> There should be some maximum of supported codecs. Hardware might have
> such constraints. If really unsure, choose some reasonable (small)
> amount. It could be later raised, if needed.

There are some constraints but technically not in the driver that binds
on this binding. I thought no limit is better than an arbitrary one, but
if the preference is to have one, I will add it, no problem.

> Best regards,
> Krzysztof

Best,
Martin

