Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8AD544352
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbiFIFuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiFIFuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:50:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3435A31CCB6;
        Wed,  8 Jun 2022 22:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654753790;
        bh=hj2U7yuMok6Ib8HHjFzrEGP7nopOKjtnj5FIUTpawz8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XWsA0ZWme/FE9k51fBe/oPfyJT27jh5mSEGxa9lywQPgdvSoZpNRJ/+kRsArVFY9h
         EjyE7aNoUQWiQAxjWmd4uGORQixghQlQie70jwnkzJMruwYeihQu5TsE0oz9Z8/gSq
         OZX5Ujy3Kt9laDHUMAYsUAWC6ZJqhwux1kB3jmNE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.0.188] ([62.143.94.109]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1naeuN2dgn-012Dch; Thu, 09
 Jun 2022 07:49:50 +0200
Message-ID: <21f59c3b-1d54-6980-8e25-af7532a1cbae@gmx.de>
Date:   Thu, 9 Jun 2022 07:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/5] dt-bindings: input: Convert adc-keys to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20220608211207.2058487-1-robh@kernel.org>
 <20220608211207.2058487-6-robh@kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20220608211207.2058487-6-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pL2QTWV+NbBYavH/k02ABqocu/FgbCa7bQ8dsUAziDBVB/0AqVN
 YFIzOTPIotSO55gexHi1kLEMJ9ae7XiT8jcCOx41CqWyaYiCKngzQSFDOjBx5iLPXKhVOPG
 Dupd0cEhtYW1tI1kkzy+48bpzpT58JPL4Sjqn6wYLc/qA3s1uKhoinAfDG7VhGdw20jrTXA
 I//T+pGZNQVW/3GAZZ6JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mN4qq9Fl2jg=:kXv14h3qt/nOfz4mY7L3TQ
 twVvv04PjZRSScTAeVhVKDT0nZyPmOnkWKVEfj6OM87Dx5SJ2usAspp3zaQEE45R/xmUQi+O8
 dQFPEERogBK0nBtqHm67suhEKpl68aagj5/JhiVyKwQMmAEHJ2t1z9HuvWRb6z1bgFS/gdHK5
 S5DXAu/5yL9I7zR7jiiHEhl8OgIdz8G7Ygp71rrgQTFZ34w4r8K1wEllVBM0zWulk/azXvxFS
 8WN9tjUTX/GtfZ0iqYVx0LjGmo8+Q4K35GSXVPioDiYkhgxnii7JatuJAuWp/5rZjlk1ipvaB
 srIDtrOI2XYxf2whkGDEsnjawipUNjS+11FETO3+pNTMDi9v+OYhmiydmm92NoqrvhF3opfWS
 R8Zl2SMT2jSIksSoNrYFzp0U+w9ZW5Jel9HZxBylTXWG7g67BWK6oiJIJkV77Ah/dn0+rZhxi
 3lGUIJlTfSIi+S1PPJY0kOm3oWxn+kVdnVoFTuYSALcqnN76hFulmdOEZIzmq7kHVvUSU4Hiw
 3hMQp+1b9a9PLJVWMuRn7QXA5btSs5LvmYjpylnJaGHE2/lP8FD5f7XPKD4tXId1gqcGOMJxY
 OHwTms3xof2QpX1BQaR9T5AfEegeLiH+x7QG5MGuWePBfl85GOZKfKgV3KBQ/P3/nnFoliLg5
 ULkN29Q7xSqdSN/F6mAnYF7M2NyEPenrJQqOxv5HIq6ubuUtSC4oqEazPwQeyflBfQKSjh+3L
 n/HpwxLR56i5NivA60pTHacyCFxeM/iECYjQo4kTFus29FgcqH3uTtW8p/FWWZxcS5nSTfhlb
 bAUzT2whaXffvFdGnwXRRqYpLCItAzRmbu2Ee8O4K5HxSJ5t+53MnCiqp0n/9kXb3zqu6d0qR
 59C2maIdfQIieeScRQZZaewsrk0tIvHYJcpx3H+v+pyt85SbMgmtKcUwnIzcDwHKBdxdTQhdq
 AsiWssQ6f3XJVtFFJSZZ8T2p1ann5qTn37F+TBPddll2HOObemw/w2BOsk157/cns5GoNipEl
 9hXTVhyxF+TLrmhj1p/cvHHxKaPmrHDoub/tlwCJ1wzbTO74zVoZ5psg3o1QP+MftpwsadPBG
 FQnvkxIaASa0rbT4c2DlRKvvNWb2NVHg/e3/FUqqL4peSlUgJCrnCGPrA==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 23:12, Rob Herring wrote:
> Convert the adc-keys binding to DT schema format.
>
> The old binding has 'label' as required, but it should never be
> required given it's just a human readable description.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>   - Drop Heinrich as a maintainer
>   - Use common linux,code definition
>   - Drop label as required
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
> index 000000000000..7aa078dead37
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
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +allOf:
> +  - $ref: input.yaml#
> +
> +properties:
> +  compatible:
> +    const: adc-keys
> +
> +  io-channels:
> +    maxItems: 1
> +
> +  io-channel-names:
> +    const: buttons
> +
> +  keyup-threshold-microvolt:
> +    description:
> +      Voltage above or equal to which all the keys are considered up.
> +
> +  poll-interval: true
> +  autorepeat: true
> +
> +patternProperties:
> +  '^button-':
> +    type: object
> +    $ref: input.yaml#
> +    additionalProperties: false
> +    description:
> +      Each button (key) is represented as a sub-node.
> +
> +    properties:
> +      label: true
> +
> +      linux,code: true

Can we provide a reference to a new type in
Documentation/devicetree/bindings/input/input.yaml limiting the range to
0 - 0x2ff?

Best regards

Heinrich

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
> +      - linux,code
> +      - press-threshold-microvolt
> +
> +required:
> +  - compatible
> +  - io-channels
> +  - io-channel-names
> +  - keyup-threshold-microvolt
> +
> +additionalProperties: false
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

