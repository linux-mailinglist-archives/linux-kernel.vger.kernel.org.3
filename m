Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6358D538
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbiHIIP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbiHIIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:15:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782942BC4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:15:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w15so12267461ljw.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i4iQuVbI+9d0zd0b0jhQFCRBZoVGPueKM3RZjVMejCI=;
        b=WcPB8C9Wpy4JKS+wa3ogqDTCTitNjB5xjbl3GVmJmBFnwN57erFosPTxu4Bghu9Gvd
         hWhwv0ojAxwP6jOEiri1EAKImG5N+yBtIHLuRUkZsWEn/Kvf9pBA09AehAP7swtTHk+v
         ryY8ZsTY+cFpzv51ckXN9xnCOKSC/oGHjvNmxHuVN+viA7vudsmpY2fHuPLz7u4RDKRE
         cUC96d/urQdJGb+GvEkBG4k+GLTjVjZTrdI6N2UpgpMXTXulCXiOBuvcWVuzGogD+9fD
         2vMoj/aE7Ony9MFMdKoVLyg5tsiVL8deafhCdTSszOFZkw5gnwqIsek0OyJonNc5F7kG
         OSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i4iQuVbI+9d0zd0b0jhQFCRBZoVGPueKM3RZjVMejCI=;
        b=C8pDzBshRhTmKYeqo/Eo9kJjNjamzGiKrzYQxqx1gDLpBpkdKb7wBNVUH+QO6AqKCU
         F1jhwUFl6KIpyv6jv1eweY3qP5CMueiyHVPxpg2AQRSmmRfi1zmVIZ6lhfuqLeaEMBkx
         k6eJNE5Xrn95lgWd/xNyUBe1FFjkxe3HcchMpOqDomG0xtG4iczTZav2F4Fwq4xKmPhS
         zs1ugovR+c6eJHdPcbyIERNykHSNNVqgqDShCEnyzGMlFIhGZrjK9AEB/NAfPCzB5JWv
         mmTjK6/bc2+ruLBbvmvyTQNWsE8onSwzx+Nvu0PkGt3J4eBIB/8VkdIJzGKN9jRweysW
         tqOw==
X-Gm-Message-State: ACgBeo1WxRtcmIDBXXOsnV22fNVx48sUU48fkKqJswIwegCGhXbswoBH
        7uO7qmAUA6bkOCUNTOvFCXEbIg==
X-Google-Smtp-Source: AA6agR6d09fbMfwW14RfB+trmeqi+0SytmqBmON06AUpmV6tqXMlZsMQJgE6vxkA86T2hfetncSzNA==
X-Received: by 2002:a05:651c:92:b0:25f:f326:f2c1 with SMTP id 18-20020a05651c009200b0025ff326f2c1mr633512ljq.273.1660032952859;
        Tue, 09 Aug 2022 01:15:52 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id k21-20020ac24f15000000b0048ae66976ffsm1672088lfr.47.2022.08.09.01.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 01:15:51 -0700 (PDT)
Message-ID: <8ce59940-f559-35cb-5f86-37399da166a1@linaro.org>
Date:   Tue, 9 Aug 2022 11:15:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: sound: Add Apple MCA I2S transceiver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220808224153.3634-1-povik+lin@cutebit.org>
 <20220808224153.3634-2-povik+lin@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808224153.3634-2-povik+lin@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 01:41, Martin Povišer wrote:
> Add binding schema for MCA I2S transceiver found on Apple M1 and other
> chips.


Thank you for your patch. There is something to discuss/improve.

> +title: Apple MCA I2S transceiver
> +
> +description: |
> +  MCA is an I2S transceiver peripheral found on M1 and other Apple chips. It is
> +  composed of a number of identical clusters which can operate independently
> +  or in an interlinked fashion. Up to 6 clusters have been seen on an MCA.
> +
> +maintainers:
> +  - Martin Povišer <povik+lin@cutebit.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-mca
> +          - apple,t6000-mca

How about alphabetical order?

> +      - const: apple,mca
> +
> +  reg:
> +    items:
> +      - description: Register region of the MCA clusters proper
> +      - description: Register region of the DMA glue and its FIFOs
> +
> +  interrupts:
> +    minItems: 4
> +    maxItems: 6
> +    description:
> +      One interrupt per each cluster
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  dmas:
> +    minItems: 16
> +    maxItems: 24
> +    description:
> +      DMA channels corresponding to the SERDES units in the peripheral. They are
> +      listed in groups of four per cluster, and within the group they are given
> +      as associated to the TXA, RXA, TXB, RXB units.
> +
> +  dma-names:
> +    minItems: 16
> +    maxItems: 24
> +    items:
> +      pattern: '^(tx|rx)[0-5][ab]$'

Use consistent quotes (everywhere " or ').

Describe the items because otherwise you allow any order. The list will
be unfortunately quite long, but still readable enough.


> +    description: |
> +      Names for the DMA channels: 'tx'/'rx', then cluster number, then 'a'/'b'
> +      based on the associated SERDES unit.
> +
> +  clocks:
> +    minItems: 4
> +    maxItems: 6
> +    description:
> +      Clusters' input reference clock.
> +
> +  resets:
> +    maxItems: 1
> +
> +  power-domains:
> +    minItems: 5
> +    maxItems: 7
> +    description:
> +      First a general power domain for register access, then the power
> +      domains of individual clusters for their operation.
> +
> +  "#sound-dai-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - dmas
> +  - dma-names
> +  - clocks
> +  - power-domains
> +  - '#sound-dai-cells'

Use consistent quotes (everywhere " or ').

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mca: mca@9b600000 {

You called it I2S transceiver but isn't it also actually I2S controller?
If yes, then the node name should be probably "i2s".

> +      compatible = "apple,t6000-mca", "apple,mca";
> +      reg = <0x9b600000 0x10000>,
> +            <0x9b200000 0x20000>;
> +


Best regards,
Krzysztof
