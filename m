Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1785804FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiGYUFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiGYUFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:05:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF9CCE3B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:05:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z25so19777160lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Oceg/Pf4ocpuzyoJ2bDgrLZz3+Hr4ukfCLs2bjellJ0=;
        b=xbvE7pFXaNjrko+nOS903yex+fY9Lqzl/dugltKs7yyRNlL+RipCTRGxarErqqJZqz
         4323Yf7eoI2STUWZBo0sLNSMAL+Lvk4Gc+q1BiGtv/otu+DtzAGz/oJnf4hdTLOfEMor
         zW+A2MqNv4K4M0+88vRPGZbhKKfab4zW/98PjLXa/mkO2zdJkJIUlHhzax1vmiOIpgXY
         IwzxgPZagbt9D7kYbIemJKzG51xcpUujcMEeqQ/c8lUnxXrwuWvw83qOXIUonPeMAWuQ
         mo9gvw4nCivKxT/AtVeTkFMPlLqpFZhRT3/yrATPYtKee7jccdFpJgzkOJ6nIH6J22v4
         do3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Oceg/Pf4ocpuzyoJ2bDgrLZz3+Hr4ukfCLs2bjellJ0=;
        b=EMQi8uxHvMRefn6f+lMhFTEt/AmY7HZwwfJnawR7XynWNwwNMasKrliyBOCHESyz8k
         XsqeJtkJMTAQ9QjKPkCwo8tjHEx/a0ksE2ngEktWDWwAbsLuIPkUFOp9ZBEWUldZETaU
         LJOfAA/M/wbIpMvMasrrtR8bw8dRwl05CklAF5D8VYXXcUqCghSR4AAecFgCW1lVr17/
         eq6t90dnTXVA0PJX0e0KpPobY7lSkLQzEhcxEh4gQa12sQXOEJTlq17EmvVtkBcDEq34
         BaWgRjGnsjwO29NCBwQD9DRhQL7WgAXWw6gm+l7q7QXOO13Y8v45BLP5lay8I3OgdxUl
         903w==
X-Gm-Message-State: AJIora8TguHFXOpfn7MJ7A70IDj/YaPl1vQzVVAIkmJX5Nv5at8dZbbl
        kfnmF2cIYfPLdHGTVAV8IbcuiA==
X-Google-Smtp-Source: AGRyM1sXYCp4Q9ED/TciKrz8jGk4K3lXUkvrseaBvwYdeuV8O0x0U1uIFfHVolrbyOo9xURBlysiIA==
X-Received: by 2002:a05:6512:a84:b0:48a:556d:5539 with SMTP id m4-20020a0565120a8400b0048a556d5539mr5400698lfu.6.1658779536913;
        Mon, 25 Jul 2022 13:05:36 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b0048a9d0242c9sm182844lfr.210.2022.07.25.13.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:05:36 -0700 (PDT)
Message-ID: <e81d657f-edea-4c5d-e546-e3bdb379c659@linaro.org>
Date:   Mon, 25 Jul 2022 22:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,sai: Convert format to json-schema
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
References: <1658741467-32620-1-git-send-email-shengjiu.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1658741467-32620-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 11:31, Shengjiu Wang wrote:
> Convert the NXP SAI binding to DT schema format using json-schema.
> 
> The Synchronous Audio Interface (SAI) provides an interface that
> supports full-duplex serial interfaces with frame synchronization
> formats such as I2S, AC97, TDM, and codec/DSP interfaces.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,sai.yaml    | 175 ++++++++++++++++++
>  .../devicetree/bindings/sound/fsl-sai.txt     |  95 ----------
>  2 files changed, 175 insertions(+), 95 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,sai.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl-sai.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> new file mode 100644
> index 000000000000..adcd77531eba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Synchronous Audio Interface (SAI).
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +description: |
> +  The SAI is based on I2S module that used communicating with audio codecs,
> +  which provides a synchronous audio interface that supports fullduplex
> +  serial interfaces with frame synchronization such as I2S, AC97, TDM, and
> +  codec/DSP interfaces.
> +
> +properties:
> +  compatible:
> +    minItems: 1
> +    maxItems: 2

You allow anything here, so it's not acceptable. This has to be strictly
defined.

> +    items:
> +      enum:
> +        - fsl,vf610-sai
> +        - fsl,imx6sx-sai
> +        - fsl,imx6ul-sai
> +        - fsl,imx7ulp-sai
> +        - fsl,imx8mq-sai
> +        - fsl,imx8qm-sai
> +        - fsl,imx8mm-sai
> +        - fsl,imx8mn-sai
> +        - fsl,imx8mp-sai
> +        - fsl,imx8ulp-sai
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: receive and transmit interrupt
> +
> +  dmas:
> +    minItems: 2

No need for minItems.

> +    maxItems: 2
> +    description:
> +      Must contain a list of pairs of references to DMA specifiers, one for
> +      transmission, and one for reception.

Skip description and instead describe items like you did for interrupts.

> +
> +  dma-names:
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      enum:
> +        - tx
> +        - rx

No, this has to be strictly defined, so items with tx and rx (or
reversed order).

> +
> +  clocks:
> +    minItems: 4
> +    items:
> +      - description: The ipg clock for register access
> +      - description: master clock source 0 (obsoleted, compatible for old dts)
> +      - description: master clock source 1
> +      - description: master clock source 2
> +      - description: master clock source 3
> +      - description: PLL clock source for 8kHz series
> +      - description: PLL clock source for 11kHz series
> +
> +  clock-names:
> +    minItems: 4
> +    maxItems: 7
> +    items:
> +      enum:
> +        - bus
> +        - mclk0
> +        - mclk1
> +        - mclk2
> +        - mclk3
> +        - pll8k
> +        - pll11k

Ditto. minItems:4 could stay, but the rest is not correct. This has to
be strictly ordered/defined list.

> +
> +  lsb-first:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Configures whether the LSB or the MSB is transmitted
> +      first for the fifo data. If this property is absent,
> +      the MSB is transmitted first as default, or the LSB
> +      is transmitted first.
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Boolean property, required if all the SAI
> +      registers are big-endian rather than little-endian.
> +
> +  fsl,sai-synchronous-rx:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      This is a boolean property. 

Skip such description, it's useless... Further as well.

If present, indicating
> +      that SAI will work in the synchronous mode (sync Tx
> +      with Rx) which means both the transmitter and the
> +      receiver will send and receive data by following
> +      receiver's bit clocks and frame sync clocks.
> +      fsl,sai-asynchronous and fsl,sai-synchronous-rx are exclusive.
> +
> +  fsl,sai-asynchronous:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      This is a boolean property. If present, indicating
> +      that SAI will work in the asynchronous mode, which
> +      means both transmitter and receiver will send and
> +      receive data by following their own bit clocks and
> +      frame sync clocks separately.
> +      If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
> +      default synchronous mode (sync Rx with Tx) will be used, which means both
> +      transmitter and receiver will send and receive data by following clocks
> +      of transmitter.
> +      fsl,sai-asynchronous and fsl,sai-synchronous-rx are exclusive.
> +
> +  fsl,dataline:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: |
> +      configure the dataline. it has 3 value for each configuration
> +      first one means the type: I2S(1) or PDM(2)
> +      second one is dataline mask for 'rx'
> +      third one is dataline mask for 'tx'.
> +      for example: fsl,dataline = <1 0xff 0xff 2 0xff 0x11>;
> +      it means I2S type rx mask is 0xff, tx mask is 0xff, PDM type
> +      rx mask is 0xff, tx mask is 0x11 (dataline 1 and 5 enabled).
> +
> +  fsl,sai-mclk-direction-output:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      This is a boolean property. If present,
> +      indicates that SAI will output the SAI MCLK clock.
> +
> +  fsl,shared-interrupt:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      This is a boolean property. If present,
> +      indicates that interrupt is shared with other modules.
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - dmas
> +  - dma-names
> +  - clocks
> +  - clock-names

You need to express the exclusiveness of properties.
allOf:if:required:then:... would work, like here:
https://elixir.bootlin.com/linux/v5.17-rc2/source/Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml#L155


Best regards,
Krzysztof
