Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17F1545541
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiFIUD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbiFIUDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:03:21 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65FD1B047B;
        Thu,  9 Jun 2022 13:03:18 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id s23so23261611iog.13;
        Thu, 09 Jun 2022 13:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YIBDdnaZYLksYYYPf5RgtDeURkWNaVlTx9hps6JOyrA=;
        b=Gp/t0cXubNN0qwJ9lqk9oK+S5cGnpuZW6+SxKw4yJdQIT3QH8HfBAUr3qb16ugOWXg
         5XZSBgWXtQzYja1talTCgdtPEdAcDsUKgLXobIIFhe/s+TkbwTvdXw0aDXUHguof5ZXA
         96arKy8dLxOQ/BFHGsVEk92V2yBq30Jb5+bxCjHwV69Jcy4/nbwJxll1sTNtrhWZc2/8
         Izx1jdq8qQTNk2CzRwj6gqYqwQFmamHL3CyhI2xsRe/DPIL1SwYd5b7AX8UH4PwUU3SN
         gBBSSgXc9I8yHKEKxSdv2rE8c+YKUglmZFrhQXWLoCroJTZCY/VGP2SuPfI0R2WICrur
         Eq7A==
X-Gm-Message-State: AOAM531ZT4hwD8tAOxy6Od08mz0sWQRnf3FaAHoU6St0ruWLrZsvuoP9
        a4MzUfGXZDn+CZEdQk89Zg==
X-Google-Smtp-Source: ABdhPJy0vfyMpwM45x4ogND18CT2vn+ZjeUa7zjShMYEiRxo1t+KyCiUektlzUYCaCXcm2mJGqeGzA==
X-Received: by 2002:a05:6602:2a48:b0:669:3d64:c53b with SMTP id k8-20020a0566022a4800b006693d64c53bmr13824103iov.77.1654804997929;
        Thu, 09 Jun 2022 13:03:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a18-20020a6b6d12000000b0066938e02579sm7471108iod.38.2022.06.09.13.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:03:17 -0700 (PDT)
Received: (nullmailer pid 12357 invoked by uid 1000);
        Thu, 09 Jun 2022 20:03:16 -0000
Date:   Thu, 9 Jun 2022 14:03:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev
Subject: Re: [RFC PATCH v2 2/5] dt-bindings: sound: Add Apple Macs sound
 peripherals
Message-ID: <20220609200316.GA4097800-robh@kernel.org>
References: <20220606191910.16580-1-povik+lin@cutebit.org>
 <20220606191910.16580-3-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220606191910.16580-3-povik+lin@cutebit.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:19:07PM +0200, Martin Povišer wrote:
> Add binding for Apple Silicon Macs' machine-level integration of sound
> peripherals.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
>  .../bindings/sound/apple,macaudio.yaml        | 157 ++++++++++++++++++
>  1 file changed, 157 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/apple,macaudio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/apple,macaudio.yaml b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
> new file mode 100644
> index 000000000000..f7c12697beab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
> @@ -0,0 +1,157 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/apple,macaudio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Silicon Macs integrated sound peripherals
> +
> +description: |
> +  This binding represents the overall machine-level integration of sound
> +  peripherals on 'Apple Silicon' machines by Apple.
> +
> +maintainers:
> +  - Martin Povišer <povik+lin@cutebit.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,j274-macaudio
> +          - apple,j293-macaudio
> +          - apple,j314-macaudio
> +      - const: apple,macaudio
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  model:
> +    description: |

Don't need '|' if there's no formatting to preserve.

> +      Model name for presentation to users
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +patternProperties:
> +  "^dai-link(@[0-9a-f]+)?$":
> +    description: |
> +      Node for each sound peripheral such as the speaker array, headphones jack,
> +      or microphone.
> +    type: object

blank line

> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      link-name:
> +        description: |
> +          Name for the peripheral, expecting 'Speaker' or 'Speakers' if this is
> +          the speaker array.
> +        $ref: /schemas/types.yaml#/definitions/string
> +
> +      cpu:
> +        type: object

           additionalProperties: false

blank line before properties.

> +        properties:
> +          sound-dai:
> +            description: |
> +              DAI list with CPU-side I2S ports involved in this peripheral.
> +            minItems: 1
> +            maxItems: 2

blank line

> +        required:
> +          - sound-dai
> +
> +      codec:
> +        type: object

blank line

> +        properties:
> +          sound-dai:
> +            description: |
> +              DAI list with the CODEC-side DAIs connected to the above CPU-side
> +              DAIs and involved in this sound peripheral.
> +
> +              The list is in left/right order if applicable. If there are more
> +              than one CPU-side DAIs (there can be two), the CODECs must be
> +              listed first those connected to the first CPU, then those
> +              connected to the second.
> +
> +              In addition, on some machines with many speaker codecs, the CODECs
> +              are listed in this fixed order:
> +
> +              J293: Left Front, Left Rear, Right Front, Right Rear
> +              J314: Left Woofer 1, Left Tweeter, Left Woofer 2,
> +                    Right Woofer 1, Right Tweeter, Right Woofer 2
> +            minItems: 1
> +            maxItems: 8

blank line

> +        required:
> +          - sound-dai
> +
> +    required:
> +      - reg
> +      - cpu
> +      - codec
> +
> +    additionalProperties: false

I prefer this to be above 'properties' in the indented cases. 

> +
> +required:
> +  - compatible
> +  - model
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mca: mca@9b600000 {
> +      compatible = "apple,t6000-mca", "apple,mca";
> +      reg = <0x9b600000 0x10000>,
> +            <0x9b500000 0x20000>;
> +
> +      clocks = <&nco 0>, <&nco 1>, <&nco 2>, <&nco 3>;
> +      power-domains = <&ps_audio_p>, <&ps_mca0>, <&ps_mca1>,
> +                      <&ps_mca2>, <&ps_mca3>;
> +      dmas = <&admac 0>, <&admac 1>, <&admac 2>, <&admac 3>,
> +             <&admac 4>, <&admac 5>, <&admac 6>, <&admac 7>,
> +             <&admac 8>, <&admac 9>, <&admac 10>, <&admac 11>,
> +             <&admac 12>, <&admac 13>, <&admac 14>, <&admac 15>;
> +      dma-names = "tx0a", "rx0a", "tx0b", "rx0b",
> +                  "tx1a", "rx1a", "tx1b", "rx1b",
> +                  "tx2a", "rx2a", "tx2b", "rx2b",
> +                  "tx3a", "rx3a", "tx3b", "rx3b";
> +
> +      #sound-dai-cells = <1>;
> +    };
> +
> +    sound {
> +      compatible = "apple,j314-macaudio", "apple,macaudio";
> +      model = "MacBook Pro J314 integrated audio";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      dai-link@0 {
> +        reg = <0>;
> +        link-name = "Speakers";
> +
> +        cpu {
> +          sound-dai = <&mca 0>, <&mca 1>;
> +        };
> +        codec {
> +          sound-dai = <&speaker_left_woof1>,
> +                      <&speaker_left_tweet>,
> +                      <&speaker_left_woof2>,
> +                      <&speaker_right_woof1>,
> +                      <&speaker_right_tweet>,
> +                      <&speaker_right_woof2>;
> +        };
> +      };
> +
> +      dai-link@1 {
> +        reg = <1>;
> +        link-name = "Headphones Jack";
> +
> +        cpu {
> +          sound-dai = <&mca 2>;
> +        };
> +        codec {
> +          sound-dai = <&jack_codec>;
> +        };
> +      };
> +    };
> -- 
> 2.33.0
> 
> 
