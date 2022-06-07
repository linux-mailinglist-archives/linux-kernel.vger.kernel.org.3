Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF9542401
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359796AbiFHBnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449441AbiFGXJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:09:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7871F5E2F;
        Tue,  7 Jun 2022 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654634777;
        bh=1XNiGX/khM+S8gmD65pIw9fIxxv7YQTuxd2uCADNsgQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VvCLkNnEALv7AAJcpWeT7O7vBkzc+N22YMkSgmYp0SrhRxaix8/rZdYllgEHPJit4
         7c7wiQOgCt9s+YrLyXVZGj8PCHoGAztaIpFVL2SRqVpMoKbNnubH+c68K6im78zxCw
         2Jv9JPV86aHNXxaYPpqZH+LOc85yNT/BZwnzYGAk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.94] ([62.143.94.109]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXBj-1o2kZ746wj-00DYs2; Tue, 07
 Jun 2022 22:46:17 +0200
Message-ID: <eb0ea0d5-0650-53e8-f83c-eb4b82343c7a@gmx.de>
Date:   Tue, 7 Jun 2022 22:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: input: Convert adc-keys to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220606184243.1057145-1-robh@kernel.org>
 <7657a50f-20c0-9ad0-aecb-5b3e71feb18c@gmx.de>
 <20220607150338.GA3189983-robh@kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20220607150338.GA3189983-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sAJO+crPttf9E9cY2pdNq2SJkxUR9xDLYLA0dhas5UqVhJrZNl7
 styEa0zHdms+U38XCb4gvu3NexRnuNOs2tJ+tvqSnigb5Q9vPgab3tCkaPA8+LXB005VJMX
 zq1lJpvf6JMbvTx/ObF/Z7RuPMmQbwfHvyIfpG5qkiS8UjOg1KYaRgFMofhwJsj3G6OjDC4
 mE5RpYto0rOddNGCIe8uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E0MskkJOt7Q=:A/CRL5GzQpI9aoeoKqV6Oz
 xMfXWSi+WwDIzLig9sTBwZfDH55fTlhnByZJbXP3C80YX+TLtkYhqCKXKSUPZNkkbLx7NCqDc
 QX04Li+78ojXyEs04SIEk8xWevK84nkF+1ufY+1LDJPQ0FGAp1CtsLKZXKvZRcj/YenW/EXYL
 +tcUioZtlFk7CPpV7NeCQ0DgAei2lTMvlw3lq+ctZtxc0HvyrgKIB3HVNGOzs/y8JfKx+W+G7
 RWOW+bJvfjUCms9+1VN4XSgHh7zFBZVgSHjjyuTgcRHvjceBoaq9pyGP2F6SuV2X/pVL4XsSR
 GuKqUFkx8SChDv5a0z4BxWytX1ycQf0DW9stm9rn9AILE5eICNs+hm7jiZKt+qKh2pt5391bi
 fDV7vIbbDQTtG/ObvIIiRU7E+h2CJqI5l3ssBpBZ4ctram3dpGCao4cY/K0tGyUMQ7QWMnbl2
 3K6PGtETgoD+Gs7k0Dt23hbRhz/HvmEAj7plcTtFtWYgYEQ7cUhDcu2pi0MJdyA+TU4j69OyD
 7dkTePsKb3luXZKDbmjdDLNm4AJYRr9UMQ8oEdWAsMcubOIRvyZ/SCgv8ndjJBg382B4vDDzi
 +s23TJACxK6uaB5TsaU8Q336aoOomfSXiBZ5JFI1e8bdalncgJkTIEU0nTmy7EuNKbTKVE+NZ
 eHWCYAiAc0Dp1EoKjr7d7LFi4dxer8zRukF3KnmXDXvAqzkhdogi28FMg8TlH63Ovv1PDoS+z
 wLxHujOrw+yfmHTnv87N531fdrMzLmmWrPRPGTtuS+ASmp0XiYoo5XBXgcN8SnfBz7AxbF9JV
 TRBRjwZwxtwJGwKBv8VXt4n86WoA3I7bBZ3i67tzZhCo1DQiMSkp4yINpZp2B/MyrXcdT9uyw
 7FWP5aAOkSwS1meFBUdoe6j7xbEZSX/g7GI+l/jJhWI0TR6N1Dmlmdss7AzgUSuYfTMvyv/nj
 20AWqTnu5im6YuMqqpH60bkqMe8KwOEP1KHHRqEuh8l8zC+ntoo7KVuK+XnBQOZ4stdoel5Pd
 Y+UeyGo3iz6S5V34bbi9IW9wFmK+vPPv8ea+rV7Wd/7HbJo5yvfZYRi33B5zNBiLcNmMHGN3p
 IzSJLKrIo25OvfJJGwLuAklNOoU3etitrQUBA5MkDhLch6p0vfDPynq7w==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 17:03, Rob Herring wrote:
> On Tue, Jun 07, 2022 at 09:48:33AM +0200, Heinrich Schuchardt wrote:
>> On 6/6/22 20:42, Rob Herring wrote:
>>> Convert the adc-keys binding to DT schema format.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>    .../devicetree/bindings/input/adc-keys.txt    |  67 ------------
>>>    .../devicetree/bindings/input/adc-keys.yaml   | 103 +++++++++++++++=
+++
>>>    2 files changed, 103 insertions(+), 67 deletions(-)
>>>    delete mode 100644 Documentation/devicetree/bindings/input/adc-keys=
.txt
>>>    create mode 100644 Documentation/devicetree/bindings/input/adc-keys=
.yaml
>
>>> -+--------------------------------+------------------------+
>>> diff --git a/Documentation/devicetree/bindings/input/adc-keys.yaml b/D=
ocumentation/devicetree/bindings/input/adc-keys.yaml
>>> new file mode 100644
>>> index 000000000000..a3a1af9550bc
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/input/adc-keys.yaml
>>> @@ -0,0 +1,103 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/input/adc-keys.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ADC attached resistor ladder buttons
>>> +
>>> +maintainers:
>>> +  - Heinrich Schuchardt <xypron.glpk@gmx.de>
>>
>> Thanks for converting to yaml.
>>
>> I only contributed a single patch. I am not a maintainer. Please, remov=
e
>> that line.
>
> Okay.
>
>> scripts/get_maintainer.pl
>> Documentation/devicetree/bindings/input/adc-keys.txt yields
>> Dmitry Torokhov <dmitry.torokhov@gmail.com> (maintainer:INPUT (KEYBOARD=
,
>> MOUSE, JOYSTICK, TOUCHSCREEN)...)
>
> The maintainer here is supposed to be someone that cares about this
> particular binding, not who applies patches. IOW, who would care if the
> binding was deleted.
>
>> It would be preferable to have a single reference point for
>> maintainership: file /MAINTAINERS.
>
> There's 2 main reasons why it is not. MAINTAINERS doesn't work for the
> DT only tree we generate[1]. Second, having an entry in MAINTAINERS
> for bindings is not consistent. With it in the schema, I don't have to
> check, the tools do it for me.
>
>>> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/input/input.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: adc-keys
>>> +
>>> +  io-channels:
>>> +    maxItems: 1
>>
>> Please, add a description to each property.
>
> Common properties don't get descriptions unless there is something
> specific about this binding to say. What would that be?
>
>
>>> +  io-channel-names:
>>> +    const: buttons
>>> +
>>> +  keyup-threshold-microvolt:
>>> +    description:
>>> +      Voltage above or equal to which all the keys are considered up.
>>> +
>>> +patternProperties:
>>> +  '^button-':
>>> +    type: object
>>> +    additionalProperties: false
>>> +    description:
>>> +      Each button (key) is represented as a sub-node.
>>> +
>>> +    properties:
>>> +      label: true
>>
>> Please, add a description.
>
> No, common property.
>
>>> +      linux,code:
>>> +        description: Keycode to emit.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Unfortunately usable values are only defined in
>> include/uapi/linux/input-event-codes.h up to now. Please, consider
>> adding that link to the description.
>
> linux,code is common for lots of bindings, so really the type,
> description, and any common constraints need to be documented somewhere
> common. I'm not sure if input.yaml makes sense given that includes a
> bunch of other properties.
>
>> It is unclear to me if using values above KEY_MAX (=3D0x2ff) could make
>> sense of should be forbidden by this yaml file.
>
> Shrug. I have no idea.
>
>> For interoperability of device-trees with other operating systems we
>> should have a yaml file defining an enum with used values and their mea=
ning.
>
> Certainly, but that's an orthogonal issue.

Yes, it is orthogonal.

git grep -ni keycode Documentation/devicetree/bindings/
finds 15+ documents referring to key-codes.

So this will be a worthwhile undertaking.

Best regards

Heinrich

>
>>> +
>>> +      press-threshold-microvolt:
>>> +        description:
>>> +          Voltage above or equal to which this key is considered pres=
sed. No
>>> +          two values of press-threshold-microvolt may be the same. Al=
l values
>>> +          of press-threshold-microvolt must be less than
>>> +          keyup-threshold-microvolt.
>>> +
>>> +    required:
>>> +      - label
>>
>> Property label is not used in our the driver code. It only exists for
>> human readability. Why is it marked as required? Stripping the labels
>> would reduce the DT size.
>
>>From the original:
>
>>> -Required subnode-properties:
>>> -	- label: Descriptive name of the key.
>
> But I'll drop it.
>
> Rob
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetre=
e-rebasing.git/tree/

