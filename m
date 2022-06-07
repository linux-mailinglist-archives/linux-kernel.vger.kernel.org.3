Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BBE53F79B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbiFGHst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbiFGHsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:48:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD506929E;
        Tue,  7 Jun 2022 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654588114;
        bh=XYARkqqaVqftLCqlQUQeDaR5u91Hn+J10YMbU4qU9lI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=aaDhxrBZiU8ke+OssL/f4KmK+EvroqqN5BazzLkRXc4yMfKheYXz4pEFA59Xw+yab
         UfKtHvUrBTQkSmUdIQ+tqHuxfZPanLB6AlNnzJsBXvj5RrNPZA7gqna6LAD/gJZR06
         LAJ5zhnxiMbhTP5taz/QYaVQo8qoWtDXzLmkyqOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.67] ([62.143.94.109]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1nnjPG1Yl6-0124IT; Tue, 07
 Jun 2022 09:48:34 +0200
Message-ID: <7657a50f-20c0-9ad0-aecb-5b3e71feb18c@gmx.de>
Date:   Tue, 7 Jun 2022 09:48:33 +0200
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
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20220606184243.1057145-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I3YB0lPaJUOplx/vQSPeHGrtDco826MdF1hF1rUuKn3lzH5qILv
 Kz671t5zpPHDFolDtg7q+QWzW8o1OoLhtXH8zkJrWvU2XxrmOKCWMJ9IOEq9uLmCEV7hwK4
 Otv/QOnJ+eVUOeQEJSa8XEDfDBj1h64voFHz72OhMTKYbdS83kdJiSmlvDLi5vrzTzo2YAj
 ivQq5wamhdNzlfPZ8lBGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p0NOTkT/fgY=:NVIzx0j8BCwuY+DFtAGDkp
 FbExGYS/rBzpWs5t1sd+FOB2OqMl5YSeP/EjiFjrlszqXToRjY+xCLvqWypE7WG+eTJuXzi1M
 PIjfRGyGe+VRg5P7A2D0TkKbsxR4YUn6rEJzIXvCGA9ZlJ57xkxuOowWvaqzPtLiYPUdGCLD4
 nRIO5+u5u0+UUSynnnFk+NcKq+Yelda4ajhj1CqACydpIFXetCIDfnpTtDXNtdz0vEXuWbQwF
 1kUOhf/nqs+VF4e9ZWoOVSvhYCwabeiNzm/L1Pc0dwuZRzHXre8Zu5JTLMRy7ZgIPE6/yvfhQ
 0Af/MYwXyCDXibViPAA4IOFWf3ieQSDTFcvDkR0xo0XEBYdpSMGV/f5fdHxEpV8UVYXWtWkel
 MKNC9m3trHrTz62cJX9lMOv1B9MN8gbKl/WVvyQP77ffEDPl0t9K5jTLLzvYv6plVvHgS3fnF
 13btvpP9bOyVimjJtwKpsUNJOM1ppXPQ8v+WacreXFP2T0X43WPJSmIlhjVUTKkh4Ucx1dfG2
 Bh8zg0rryOEilVeU4Wu/YYzmSMggP6iezmG5OVn8qdQM0WcPIbg71iyJP7aeL56ZwyA5kbdvd
 dNwrHH23IwVlISKc0qKrjfy3aHnkuNeodbUoz6c0zg0V5ilJI4+T2EDQlJjN1Q+rwTFkVWhPL
 9+WdcJnJrHRTBbIkC3Qy9UAMxnl0ztl8GPVsu3mlHgLpD+fDI7ip/caglr9V9tkuk305WnOwO
 bIBsPhF/JKKo/aifAX7FFB7iPN9V6kN4Fj+q7vUvDdUAvbJTLzaklzFoUpgxchQ4IQmtXhuLr
 dopUQfy8CRL2L/UfAvb/5i1e6BxEu4gHfltsEoc9RD0QzR9UJFvF15Jjt585fxs0LdJaShOeC
 ZpsG9YHNgfAaI9lszZUXk6Zv9pC3DVb8oylI0bE6hfJQ1kmOdmJCFdGErW7SzTmwDJWupRWG0
 q5D4m5CJaV1p0zlOLDd0D3D/tERUBC6rKRiNoYdzusWxMdx8XL/wxaDzna9if0cdNKJ7gHpfc
 J1HmkA9ZDR4i1a6ibY91VoGIG8B0ijTb4tzkW7IoV/RbmA/Bcxa9iqsb3JM8Kq/gZr9gL7GfC
 zcXGNRwRMru03bTrEHF92ncTnez4mJwSiR+1Ek5SVUSndoC8VyEH3+9Pg==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 20:42, Rob Herring wrote:
> Convert the adc-keys binding to DT schema format.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/input/adc-keys.txt    |  67 ------------
>   .../devicetree/bindings/input/adc-keys.yaml   | 103 ++++++++++++++++++
>   2 files changed, 103 insertions(+), 67 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/input/adc-keys.tx=
t
>   create mode 100644 Documentation/devicetree/bindings/input/adc-keys.ya=
ml
>
> diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Docu=
mentation/devicetree/bindings/input/adc-keys.txt
> deleted file mode 100644
> index 6c8be6a9ace2..000000000000
> --- a/Documentation/devicetree/bindings/input/adc-keys.txt
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -ADC attached resistor ladder buttons
> -------------------------------------
> -
> -Required properties:
> - - compatible: "adc-keys"
> - - io-channels: Phandle to an ADC channel
> - - io-channel-names =3D "buttons";
> - - keyup-threshold-microvolt: Voltage above or equal to which all the k=
eys are
> -			      considered up.
> -
> -Optional properties:
> -	- poll-interval: Poll interval time in milliseconds
> -	- autorepeat: Boolean, Enable auto repeat feature of Linux input
> -	  subsystem.
> -
> -Each button (key) is represented as a sub-node of "adc-keys":
> -
> -Required subnode-properties:
> -	- label: Descriptive name of the key.
> -	- linux,code: Keycode to emit.
> -	- press-threshold-microvolt: voltage above or equal to which this key =
is
> -				     considered pressed.
> -
> -No two values of press-threshold-microvolt may be the same.
> -All values of press-threshold-microvolt must be less than
> -keyup-threshold-microvolt.
> -
> -Example:
> -
> -#include <dt-bindings/input/input.h>
> -
> -	adc-keys {
> -		compatible =3D "adc-keys";
> -		io-channels =3D <&lradc 0>;
> -		io-channel-names =3D "buttons";
> -		keyup-threshold-microvolt =3D <2000000>;
> -
> -		button-up {
> -			label =3D "Volume Up";
> -			linux,code =3D <KEY_VOLUMEUP>;
> -			press-threshold-microvolt =3D <1500000>;
> -		};
> -
> -		button-down {
> -			label =3D "Volume Down";
> -			linux,code =3D <KEY_VOLUMEDOWN>;
> -			press-threshold-microvolt =3D <1000000>;
> -		};
> -
> -		button-enter {
> -			label =3D "Enter";
> -			linux,code =3D <KEY_ENTER>;
> -			press-threshold-microvolt =3D <500000>;
> -		};
> -	};
> -
> -+--------------------------------+------------------------+
> -| 2.000.000 <=3D value             | no key pressed         |
> -+--------------------------------+------------------------+
> -| 1.500.000 <=3D value < 2.000.000 | KEY_VOLUMEUP pressed   |
> -+--------------------------------+------------------------+
> -| 1.000.000 <=3D value < 1.500.000 | KEY_VOLUMEDOWN pressed |
> -+--------------------------------+------------------------+
> -|   500.000 <=3D value < 1.000.000 | KEY_ENTER pressed      |
> -+--------------------------------+------------------------+
> -|              value <   500.000 | no key pressed         |
> -+--------------------------------+------------------------+
> diff --git a/Documentation/devicetree/bindings/input/adc-keys.yaml b/Doc=
umentation/devicetree/bindings/input/adc-keys.yaml
> new file mode 100644
> index 000000000000..a3a1af9550bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adc-keys.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/adc-keys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADC attached resistor ladder buttons
> +
> +maintainers:
> +  - Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks for converting to yaml.

I only contributed a single patch. I am not a maintainer. Please, remove
that line.

scripts/get_maintainer.pl
Documentation/devicetree/bindings/input/adc-keys.txt yields
Dmitry Torokhov <dmitry.torokhov@gmail.com> (maintainer:INPUT (KEYBOARD,
MOUSE, JOYSTICK, TOUCHSCREEN)...)

It would be preferable to have a single reference point for
maintainership: file /MAINTAINERS.


> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +allOf:
> +  - $ref: /schemas/input/input.yaml#
> +
> +properties:
> +  compatible:
> +    const: adc-keys
> +
> +  io-channels:
> +    maxItems: 1

Please, add a description to each property.

> +
> +  io-channel-names:
> +    const: buttons
> +
> +  keyup-threshold-microvolt:
> +    description:
> +      Voltage above or equal to which all the keys are considered up.
> +
> +patternProperties:
> +  '^button-':
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Each button (key) is represented as a sub-node.
> +
> +    properties:
> +      label: true

Please, add a description.

> +
> +      linux,code:
> +        description: Keycode to emit.
> +        $ref: /schemas/types.yaml#/definitions/uint32

Unfortunately usable values are only defined in
include/uapi/linux/input-event-codes.h up to now. Please, consider
adding that link to the description.

It is unclear to me if using values above KEY_MAX (=3D0x2ff) could make
sense of should be forbidden by this yaml file.

For interoperability of device-trees with other operating systems we
should have a yaml file defining an enum with used values and their meanin=
g.

> +
> +      press-threshold-microvolt:
> +        description:
> +          Voltage above or equal to which this key is considered presse=
d. No
> +          two values of press-threshold-microvolt may be the same. All =
values
> +          of press-threshold-microvolt must be less than
> +          keyup-threshold-microvolt.
> +
> +    required:
> +      - label

Property label is not used in our the driver code. It only exists for
human readability. Why is it marked as required? Stripping the labels
would reduce the DT size.

Best regards

Heinrich

> +      - linux,code
> +      - press-threshold-microvolt
> +
> +required:
> +  - compatible
> +  - io-channels
> +  - io-channel-names
> +  - keyup-threshold-microvolt
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/input/input.h>
> +    // +--------------------------------+------------------------+
> +    // | 2.000.000 <=3D value             | no key pressed         |
> +    // +--------------------------------+------------------------+
> +    // | 1.500.000 <=3D value < 2.000.000 | KEY_VOLUMEUP pressed   |
> +    // +--------------------------------+------------------------+
> +    // | 1.000.000 <=3D value < 1.500.000 | KEY_VOLUMEDOWN pressed |
> +    // +--------------------------------+------------------------+
> +    // |   500.000 <=3D value < 1.000.000 | KEY_ENTER pressed      |
> +    // +--------------------------------+------------------------+
> +    // |              value <   500.000 | no key pressed         |
> +    // +--------------------------------+------------------------+
> +
> +    adc-keys {
> +        compatible =3D "adc-keys";
> +        io-channels =3D <&lradc 0>;
> +        io-channel-names =3D "buttons";
> +        keyup-threshold-microvolt =3D <2000000>;
> +
> +        button-up {
> +            label =3D "Volume Up";
> +            linux,code =3D <KEY_VOLUMEUP>;
> +            press-threshold-microvolt =3D <1500000>;
> +        };
> +
> +        button-down {
> +            label =3D "Volume Down";
> +            linux,code =3D <KEY_VOLUMEDOWN>;
> +            press-threshold-microvolt =3D <1000000>;
> +        };
> +
> +        button-enter {
> +            label =3D "Enter";
> +            linux,code =3D <KEY_ENTER>;
> +            press-threshold-microvolt =3D <500000>;
> +        };
> +    };
> +...

