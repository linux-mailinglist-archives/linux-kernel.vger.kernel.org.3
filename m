Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B384889E2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 15:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiAIO3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 09:29:38 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42742 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiAIO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 09:29:37 -0500
Received: by mail-wr1-f54.google.com with SMTP id k30so4231462wrd.9;
        Sun, 09 Jan 2022 06:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6vusuoGgFhIQldYYTqym1GNWUHt9Sbkb9h6Y3zeW90=;
        b=vEokctVJwD0jg8gNg2AA7a6gUwNuAxOXIwmfp+C21ws9pJV4bZCVwSCW097oaqsyDy
         aO6idH2NrrHwLdeL9E01CplBm1xF3VeorkB/1Jv+1cGkyG+MJdM92nmNsMX2BWkiQmNV
         KgTM8Wl0QmsC7hbMmBl865NxrBC8i3NH2dW94yGcl82doBMe5RuWy+zte2L2UppuJshG
         WpzwymOY7fciKCIe0O7dEgAWDgpkdUpd2DHhqnAHoz8fzoeE25fyxtJwXd6WwbmIp2c7
         Q2MDQTiUhhAM6sTZJnrgFhbGbT4Q7TH7LlJReoX0549sLWZHABjtlVH+86POLJ2K5ZM3
         Z3jw==
X-Gm-Message-State: AOAM530LRE6DQes05oZiuyNF9bA2sPemPLdiKO/xPJmwEjpe2ymNzd2G
        JIVfBHD444woBD8ftKn5Tto=
X-Google-Smtp-Source: ABdhPJyPfRH0EX49U3mc9LdD4d+2EFaa7YnbLuqbjGOWqAvBFgw9QVJA+vefWLACccaKWAvC/X9WzQ==
X-Received: by 2002:a5d:5186:: with SMTP id k6mr4140258wrv.514.1641738576332;
        Sun, 09 Jan 2022 06:29:36 -0800 (PST)
Received: from stewarton.localnet ([84.9.151.116])
        by smtp.gmail.com with ESMTPSA id u16sm4248400wrn.24.2022.01.09.06.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 06:29:35 -0800 (PST)
From:   iain@hunterembedded.co.uk
To:     Iain Hunter <drhunter95@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     iain@hunterembedded.co.uk, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Add binding for ti,adc1018. It allows selection of channel as a Device Tree property
Date:   Sun, 09 Jan 2022 14:29:34 +0000
Message-ID: <6839827.31r3eYUQgx@stewarton>
In-Reply-To: <20220109111718.49d2d2cb@jic23-huawei>
References: <20211231131951.1245508-1-drhunter95@gmail.com> <20220109111718.49d2d2cb@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 9 January 2022 11:17:18 GMT Jonathan Cameron wrote:
> On Fri, 31 Dec 2021 13:19:15 +0000
> 
> Iain Hunter <drhunter95@gmail.com> wrote:
> > New binding file uses the adc.yaml to define channel selection
> > 
> > Signed-off-by: Iain Hunter <drhunter95@gmail.com>
> 
> Hi Iain,
> 
> A few comments in addition to those Rob sent.
> It's worth noting that there is a lot of 'history' in IIO bindings so
> sometimes copying stuff from an existing binding is no longer the way
> things should be done.
> 
> Jonathan

Hi Jonathan and Rob,

Thanks for your comments. I'd say my fundamental problem is that I am 
stumbling about in the dark. To be honest I haven't even worked out the benefit 
of the yaml bindings.

I identified the stm32adc binding as the most up to date file to use as a 
reference. If there is a better one then can you let me know.

I will work through the comments to try to understand and then implement them.
Thanks, Iain  
> 
> > ---
> > 
> >  .../bindings/iio/adc/ti,ads1018.yaml          | 126 ++++++++++++++++++
> >  1 file changed, 126 insertions(+)
> >  create mode 100644
> >  Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml> 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> > b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml new file mode
> > 100644
> > index 000000000000..a65fee9d83dd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> > @@ -0,0 +1,126 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI ADS1018 4 channel I2C analog to digital converter
> > +
> > +maintainers:
> > +  - Iain Hunter <iain@hunterembedded.co.uk>
> > +
> > +description: |
> > +  Datasheet at: https://www.ti.com/lit/gpn/ads1018
> > +  Supports both single ended and differential channels.
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,ads1018
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +  spi-max-frequency: true
> > +  spi-cpol: true
> > +  spi-cpha: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - spi-cpha
> > +
> > +additionalProperties: false
> > +
> > +patternProperties:
> > +  "^channel@([0-3])$":
> > +    $ref: "adc.yaml"
> > +    type: object
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +            Must be 0, actual channel selected in ti,adc-channels for
> > single ended +            or ti-adc-channels-diff for differential
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0]
> 
> No.  Should be some sort of index value. If I recall correctly, existing use
> is reg == channel number when single ended and more loosely defined for
> differential.  In many cases first of the pair, but that's not always
> guaranteed to be unique (e.g. 0-1 and 0-3 in this case).
> > +
> > +      ti,adc-channels:
> > +        description: |
> > +          List of single-ended channels muxed for this ADC. It can have
> > up to 4 +          channels numbered 0-3
> 
> This is a new binding, so how can we have deprecated properties?
> Also seems very odd indeed to have a list of channels defined inside a per
> channel node.
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        deprecated: true
> > +

As you can guess, it's because I don't understand it properly :)

> 
> > +      ti,adc-diff-channels:
> Can this use diff-channels in the standard adc binding:
> Documentation/devicetree/bindings/iio/adc/adc.yaml
> 
> > +        description: |
> > +          List of differential channels muxed for this ADC between the
> > pins vinp +          and vinn. The 4 possible options are:
> > +          vinp=0, vinn=1
> > +          vinp=0, vinn=3
> > +          vinp=1, vinn=3
> > +          vinp=2, vinn=3
> > +
> > +          They are listed in a pair <vinp vinn>.
> > +
> > +          Note: At least one of "ti,adc-channels" or
> > "ti,adc-diff-channels" is +          required.
> > +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +        items:
> > +          items:
> > +            - description: |
> > +                "vinp" indicates positive input number
> > +              minimum: 0
> > +              maximum: 2
> > +            - description: |
> > +                "vinn" indicates negative input number
> > +              minimum: 1
> > +              maximum: 3
> 
> This should be a pair based constraint as not all options possible.
> Something like oneOf:
>             - items:
>                 - const: 0
>                 - const: 1
>             - items:
>                 - enum: [0, 1, 2]
> 		- const: 3
> 
> > +
> > +
> > +    required:
> > +      - reg
> > +
> > +examples:
> > +  - |
> > +    // example on SPI1 with single ended channel 1
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@1 {
> > +            compatible = "ti,ads1018";
> > +            reg = <0x0>;
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            spi-cpha;
> > +            ti,adc-channels = <1>;
> 
> More recent approach to this is the one you've used for differential
> channels - 1 child node per channel.
> 
> > +        };
> > +    };
> > +  - |
> > +    // example on SPI0 with differential between inputs 0 and 3
> 
> The SPI0 vs 1 is correctly not part of this example, so drop that from
> the comment.
> 
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@0 {
> > +            compatible = "ti,ads1018";
> > +            reg = <0x0>;
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            spi-cpha;
> > +            ti,adc-diff-channels = <0 3>;
> 
> This doesn't obey the schema you have above at all. Would looks something
> like channel@0 {
>                  diff-channels = <0 3>;
>                }
> 
> > +        };
> > +    };
> > +
> > +...




