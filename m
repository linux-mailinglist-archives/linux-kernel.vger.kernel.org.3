Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD10558057F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiGYUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbiGYUZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:25:36 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78875FB8;
        Mon, 25 Jul 2022 13:25:35 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id d12-20020a4aeb8c000000b004214e709b72so2370112ooj.6;
        Mon, 25 Jul 2022 13:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JQxHu4a4wv2GlB8Ke6rSU0zLRfgHSssjYhuNGcsfE8k=;
        b=Myn894LFJdEqif41FpCbBCWOJsynURpAlklFxRrvYD0h2UG56OPLAaaiWWzDoq/jcJ
         SgfVNZYZny0EasKaLVCiZr08RdQhGxeNB3JZq3/Oqn1lBFK1NRQhNomrzOpbDsQvCezD
         0kWD2NUWKjZ+q56G1Ce0KDLE2629BTwAvfL8t7f7q9siLRg4jzgPx+nr22+R8qV0IPV/
         d6LwQWUAMTh5jluf19q6lDPOF/92cJc8V9tfC1oojvyKJI6Smu0D+zaQcNyHYRh+c05L
         nlATWsEu5SqLia5R2G47egb8mGVN9/A3KXUbLGPQQZqqOizffpvbIOnv1n7rHt+RJ9R2
         7zyA==
X-Gm-Message-State: AJIora/LdizHLTSIpvflRlzdmPZjhGRRlKBHhRoLUwYhAEjOplaqxirk
        b68iMFuNk0K6tbIhRo7rx2RNEUWOHA==
X-Google-Smtp-Source: AGRyM1ufpwvixikt2/t7xfjuqVSdirOL2BSlmwLs0O8Fo9v7BwWEXhEzAf5A/d5CnHVJOb+TzO0vUw==
X-Received: by 2002:a4a:c716:0:b0:435:f656:70f8 with SMTP id n22-20020a4ac716000000b00435f65670f8mr221794ooq.27.1658780735033;
        Mon, 25 Jul 2022 13:25:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5f4ad194bsm6947011oao.25.2022.07.25.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:25:34 -0700 (PDT)
Received: (nullmailer pid 2653284 invoked by uid 1000);
        Mon, 25 Jul 2022 20:25:32 -0000
Date:   Mon, 25 Jul 2022 14:25:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,sai: Convert format to json-schema
Message-ID: <20220725202532.GA2626016-robh@kernel.org>
References: <1658741467-32620-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658741467-32620-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 05:31:07PM +0800, Shengjiu Wang wrote:
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

You need to define the order and combinations which are valid.

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
> +    maxItems: 2
> +    description:
> +      Must contain a list of pairs of references to DMA specifiers, one for
> +      transmission, and one for reception.

No need for generic descriptions.

> +
> +  dma-names:
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      enum:
> +        - tx
> +        - rx

We really need to support either order?

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

Again, need to define the order.

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

Common property, already has a type and description.

> +    description: |
> +      Boolean property, required if all the SAI
> +      registers are big-endian rather than little-endian.
> +
> +  fsl,sai-synchronous-rx:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      This is a boolean property. If present, indicating
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

Schema already says it is boolean property, don't need that in plain 
text.

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

Looks like constraints:

items:
  items:
    - description: ...
      enum: [ 1, 2 ]
    - ...
    - ...

> +      second one is dataline mask for 'rx'
> +      third one is dataline mask for 'tx'.
> +      for example: fsl,dataline = <1 0xff 0xff 2 0xff 0x11>;

Perhaps add to the actual example.

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
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/vf610-clock.h>
> +    sai2: sai@40031000 {
> +        compatible = "fsl,vf610-sai";
> +        reg = <0x40031000 0x1000>;
> +        interrupts = <86 IRQ_TYPE_LEVEL_HIGH>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_sai2_1>;
> +        clocks = <&clks VF610_CLK_PLATFORM_BUS>,
> +                 <&clks VF610_CLK_SAI2>,
> +                 <&clks 0>, <&clks 0>;
> +        clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +        dma-names = "rx", "tx";
> +        dmas = <&edma0 0 20>,
> +               <&edma0 0 21>;
> +        big-endian;
> +        lsb-first;
> +    };
