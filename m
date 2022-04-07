Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932B44F7817
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbiDGHu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbiDGHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:50:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BE88EB5F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:48:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id q26so5386191edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7eOOLrAKkfSspaBOmVeWY/1P1p3w24BPhUI3ADFJBCI=;
        b=sogAdtsAFC5HCuOZDlP9hCKRUcFarSAAFtArxcpakHbjtI+H6rlxyAdZEWFLiv3Ew0
         ZiX/ecvjddUhTtCRabR7BgUoqBDDKxzxu5kKlGDuxPv1RYCalrkCJ7aDGWwQ0oKQG+H+
         wWrk8gsx7JZHJSziIF4YYk+huAMheAeS92FXTkdOAdHYrU1ZfJCa41bjAIpJY8/gBI5x
         Z13miNyaXnegSrvQi6qzse8DCg5Q1LotTJtkFOgzarqJI5gapKutHVVGlw2tnrrBMbrE
         rQnYTR14EEKGq61ygs7BSzBZejgH0+DC+46oXgFRHZQWkpr53Q08n05BcMKaE7MQPMb6
         HtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7eOOLrAKkfSspaBOmVeWY/1P1p3w24BPhUI3ADFJBCI=;
        b=yviRpHOFIPI6X1puHZ6/Wd0a2mwEu0ayKWKmfTRJzfFFpO6NHEis/CaqrvE/G3mWBG
         4cPLVeOKWLre+cJ5ewR+F2eiTDD+wgI8atr03DLq951IVtQe9u5GKKX0u3tHPi//FzNi
         4Si2XZMy5HwvN/MVe5C69yYSx4EjNu/BzokVjuVGftPVtUuwe4ejs66aBvOTeZ+crH5r
         335yLIUEImWbuElDoq2erodne/knNoDGVG4nsSrL40EgZCyK91LADcZv93Ysl7Zttgab
         7/tpOY1wi4S82r2TzTFR3/8vHCcNTOeg3KnSe6icmN31Xxyxjq6KrcShNT6HHCD1m1lm
         8Vlw==
X-Gm-Message-State: AOAM531F0qbSyeFa7wpTe9OFixatZwUeiWxq660E77tOMBWAaVlfP8X1
        a7i2KJOrZqccvkyQwZivttV9dg==
X-Google-Smtp-Source: ABdhPJzKpXrgUntAlAYZkvnH4zfUSRM5PQ4E+Cc2yBNkZba/USPxqi82SB3TMQkqjHPHvGE7GCEhtg==
X-Received: by 2002:a05:6402:26d0:b0:419:75eb:b3a with SMTP id x16-20020a05640226d000b0041975eb0b3amr13084176edd.0.1649317731392;
        Thu, 07 Apr 2022 00:48:51 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n25-20020aa7db59000000b00415965e9727sm8747258edt.18.2022.04.07.00.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 00:48:50 -0700 (PDT)
Message-ID: <8d0d8b27-35ff-3693-cf80-897b80c26b4e@linaro.org>
Date:   Thu, 7 Apr 2022 09:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for
 Sercomm parser
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406195946.2019-1-csharper2005@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 21:59, Mikhail Zhilkin wrote:
> Add YAML binding for Sercomm partition parser.
> 
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> ---
>  .../mtd/partitions/sercomm,sc-partitions.yaml | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
> 

(...)


> +
> +properties:
> +  compatible:
> +    const: sercomm,sc-partitions
> +
> +  scpart-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Partition id in Sercomm partition map

Do you really need it? The reg should define the order, unless you
expect some incomplete partition list?

In any case this requires vendor prefix.

> +
> +required:
> +  - compatible

Missing reg.

> +  - scpart-id
> +
> +additionalProperties: false

Are you sure that you tested your bindings? You miss here address/size
cells and children, so you should have big fat warning.

Plus your DTS example has error and does not compile...

Best regards,
Krzysztof
