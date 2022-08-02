Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D85877C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiHBH1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHBH06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:26:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70088101FF
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:26:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u1so10467694lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d4HkZdDOv7XNMC5h/HfkGuuWra/wdCBUbN3rR8kUcYw=;
        b=IVrIhKV6TQ2LB8/agWnpQ42D82tl2sCEUmqpSES2WT3nhnptLgRnpkPPtUsiLmXRfM
         gT+gL3l8RtiOZd9IwL/KWUMsd67aEritX51QDojFFghkW7gzh//2J5KrMZ8Iu1qhHqe4
         4a1pcioPuluo5PnBnsOPTnAlVi09nbdP6eNqkkSITGgzdAqYzhhXdqrWpVBcyMOCKvlP
         5s6LgVu5mhBKl3tD/pikVQJ6HZY9jR/Msqt9E1mb+aoHG5UnIBinhhGjXi9zaKOwmbFm
         twYYtXscQfoMAUZBxUnedqv/CaIouL2hhOTt7LNPKJxRcQsqiqpUE6mLiL8lSKwxZKjr
         TJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d4HkZdDOv7XNMC5h/HfkGuuWra/wdCBUbN3rR8kUcYw=;
        b=ySzMKzFlhDJ2nFOSWgOkBAfGex92Ir9oZYRsI0YmTy0A5urjy/XGmvJn9DwyFxlhF3
         ozUsE28wG5qX8Xt7glG9VZNpiTke803dIB4Y4Wwfac+Y3ePVEUrZ+xhh5z9O/Xg0iLzm
         TiY8Ss2D0JoObYJxVg+oGRtRWnXlKZcyyXIOkWTLu43zM54s/HKv6nNqgM40uIjdMvWw
         vDmGIT2oHRnRE0jG9weQlFsseEHj6Il0bbUI1TcPteNN8T2vbicjFz4jA0CXOdW0bFTd
         opCwJ3Xwa5S07lMyNVHrFzkvom3Dy4JA6+0xdLi/bThE8UYEQgcuhlDQ5EgsAvqM4kfw
         y2mQ==
X-Gm-Message-State: ACgBeo2nLnH/lUzeD0U6fIva2DeP5gmbhSer1KFbF/5n4mma3xnZlMPy
        rQvwVFRaiTcQXeUxJ8X+/AwCMYHFCdxJ3F1T
X-Google-Smtp-Source: AA6agR4qI7vkwPxXKnLuW4SI41fSrQ+0NIFPJ6qbvRABceYlNlsRqTf7UV8Y8TYIvB6PTniHjU07Pw==
X-Received: by 2002:a05:6512:3990:b0:48a:e4ca:7ec0 with SMTP id j16-20020a056512399000b0048ae4ca7ec0mr5902895lfu.146.1659425215752;
        Tue, 02 Aug 2022 00:26:55 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id bf17-20020a056512259100b0048ad4ca88afsm1616699lfb.102.2022.08.02.00.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:26:55 -0700 (PDT)
Message-ID: <ba6bc0e8-8b64-aa7f-241e-1e88dd9cfaa5@linaro.org>
Date:   Tue, 2 Aug 2022 09:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] ASoC: dt-bindings: fsl,sai: Convert format to
 json-schema
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
References: <1659060632-4880-1-git-send-email-shengjiu.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1659060632-4880-1-git-send-email-shengjiu.wang@nxp.com>
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

On 29/07/2022 04:10, Shengjiu Wang wrote:
> Convert the NXP SAI binding to DT schema format using json-schema.
> 
> The Synchronous Audio Interface (SAI) provides an interface that
> supports full-duplex serial interfaces with frame synchronization
> formats such as I2S, AC97, TDM, and codec/DSP interfaces.
> 
> Beside conversion, 'fsl,shared-interrupt' and '#sound-dai-cells'
> are added for they are already used by some dts.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v3
> - address comments from Krzysztof
> 
> changes in v2
> - fix exclusive property issue
> - fix order issue of compatible, clock-names, dma-names
> 
>  .../devicetree/bindings/sound/fsl,sai.yaml    | 221 ++++++++++++++++++
>  .../devicetree/bindings/sound/fsl-sai.txt     |  95 --------
>  2 files changed, 221 insertions(+), 95 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,sai.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl-sai.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> new file mode 100644
> index 000000000000..86ee46755b0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> @@ -0,0 +1,221 @@
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
> +    oneOf:
> +      - enum:
> +          - fsl,vf610-sai
> +          - fsl,imx6sx-sai
> +          - fsl,imx6ul-sai
> +          - fsl,imx7ulp-sai
> +          - fsl,imx8mq-sai
> +          - fsl,imx8qm-sai
> +          - fsl,imx8ulp-sai
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-sai
> +              - fsl,imx8mn-sai
> +              - fsl,imx8mp-sai
> +          - const: fsl,imx8mq-sai
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: receive and transmit interrupt
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    maxItems: 2
> +
> +  clocks:
> +    items:
> +      - description: The ipg clock for register access
> +      - description: master clock source 0 (obsoleted)
> +      - description: master clock source 1
> +      - description: master clock source 2
> +      - description: master clock source 3
> +      - description: PLL clock source for 8kHz series
> +      - description: PLL clock source for 11kHz series
> +    minItems: 4
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: bus
> +          - const: mclk0
> +          - const: mclk1
> +          - const: mclk2
> +          - const: mclk3
> +          - const: pll8k
> +          - const: pll11k
> +        minItems: 4
> +      - items:
> +          - const: bus
> +          - const: mclk1
> +          - const: mclk2
> +          - const: mclk3
> +          - const: pll8k
> +          - const: pll11k
> +        minItems: 4
> +
> +  lsb-first:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Configures whether the LSB or the MSB is transmitted
> +      first for the fifo data. If this property is absent,
> +      the MSB is transmitted first as default, or the LSB
> +      is transmitted first.
> +    type: boolean

The type: boolean goes instead of $ref, not additionally to it. Just
like below...

> +
> +  big-endian:
> +    description: |
> +      required if all the SAI registers are big-endian rather than little-endian.
> +    type: boolean

... be consistent.

> +
> +  fsl,sai-synchronous-rx:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      SAI will work in the synchronous mode (sync Tx with Rx) which means
> +      both the transmitter and the receiver will send and receive data by
> +      following receiver's bit clocks and frame sync clocks.
> +    type: boolean
> +

Best regards,
Krzysztof
