Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EF24ED448
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiCaG7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiCaG7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:59:04 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDB9EEA60;
        Wed, 30 Mar 2022 23:57:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648709834; bh=wqSNyfEr0PfR7Nu/cSpCkDEbnShaRb16tT3cIjzE5ao=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=TATcwcWpwUO2ICDeG8JnL+mjIkFKf0kVPvJtq6SNKT6Y9/7X4oJUs/pKN3KWt8+Gb
         Yd/7vSwwE+SVM3LvsqOrPQA4tQ5ao5SpPzqFkOUkTStWkXUKTUHsD9ctdLNe4gd+0l
         33GpeYp5U99JbjYQJ/vGNNnuTbQKqojErUmmnzZA=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH 1/5] dt-bindings: sound: Add Apple Macs sound system
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <9e3ba11c-d179-c229-fb7c-bf5611a15b1b@linaro.org>
Date:   Thu, 31 Mar 2022 08:57:12 +0200
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
Message-Id: <DAFA4249-4B0A-4D1F-A36A-4352FE783488@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-2-povik+lin@cutebit.org>
 <9e3ba11c-d179-c229-fb7c-bf5611a15b1b@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31. 3. 2022, at 8:43, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 31/03/2022 02:04, Martin Povi=C5=A1er wrote:
>> Add binding for Apple Silicon Macs' machine-level sound system.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>> .../bindings/sound/apple,macaudio.yaml        | 103 =
++++++++++++++++++
>> 1 file changed, 103 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/sound/apple,macaudio.yaml
>>=20
>=20
> Commit title does not match subsystem.

Tell more please. I don=E2=80=99t see it.

>=20
>> diff --git =
a/Documentation/devicetree/bindings/sound/apple,macaudio.yaml =
b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
>> new file mode 100644
>> index 000000000000..a6380e4bdd1a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
>> @@ -0,0 +1,103 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/apple,macaudio.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple Silicon Macs integrated sound system
>> +
>> +maintainers:
>> +  - Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> +
>=20
> Add description.
>=20
>> +definitions:
>=20
> This does not make code more readable.

Are you sure? It prevents duplication later on for =E2=80=98codec' and =
=E2=80=98cpu=E2=80=99.

>=20
>> +  dai:
>> +    type: object
>> +    properties:
>> +      sound-dai: true
>> +    required:
>> +      - sound-dai
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - apple,j274-macaudio
>> +          - apple,j293-macaudio
>> +          - apple,j314-macaudio
>> +      - const: apple,macaudio
>=20
> Open example-schema.yaml and look at formatting plus general coding
> style. You miss line breaks making it unreadable.
>=20
>> +  "#address-cells":
>> +    const: 1
>> +  "#size-cells":
>> +    const: 0
>> +  model:
>> +    description: |
>> +      Model name to use when the sound system is presented to users =
as a sound card.
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +
>> +patternProperties:
>> +  "^dai-link(@[0-9a-f]+)?$":
>> +    description: |
>> +      A DAI link comprising of CPU and CODEC DAI specifiers and =
supplemental properties.
>> +    type: object
>> +    properties:
>> +      reg:
>> +        maxItems: 1
>> +      mclk-fs:
>> +        description: |
>> +          Forced MCLK/samplerate factor (optional).
>=20
> Optional is obvious from !required.
>=20
> Description is different than existing field in simple card. Is this =
the
> same field or not?

It is the same. I didn=E2=80=99t want to copy the simple card text =
because this is optionally BSD,
simple card wasn=E2=80=99t.

>=20
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +      link-name:
>> +        description: Name for the DAI link to present to users.
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +      cpu:
>> +        $ref: "#/definitions/dai"
>> +      codec:
>> +        $ref: "#/definitions/dai"
>=20
> missing maxItems for DAI phandles.

Well there=E2=80=99s not a maximum.

>=20
> Best regards,
> Krzysztof

Martin

