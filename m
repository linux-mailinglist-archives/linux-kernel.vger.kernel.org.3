Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760DF590C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiHLHfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbiHLHft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:35:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C3054655
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:35:48 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w15so167912ljw.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=crf/lK1s1ldsW0Tw+pD5ZUVc6HtWvvcIF4KEVSHKYCs=;
        b=MfvFWerjwE77AMLPjqKIegxdoqhOqfeQHdlO/9wkZV8Ij6ZLgc2ol2zQPgQeWsj/cb
         73haqi/mTZaglW2d9895VCaJISlsrujvoqxmq0cOEDO7VkYXH6VUxmVTO4BoILtdY5vE
         UempconjzeH7i57ydpUcpD0RQ06+algfRdpTwWNf9x0xGVA1VtARrXXCiE60EHpSua3T
         isrJnW182uUbzmoNuVyGYw5kQ43DIkENrudblAvGJi2l5Hib86Dd9CqUlmbW1TaP7Jet
         TtxSbGSn6SfZNs/6oUI5PcdaZGBAqhrvTc3jQW181cTTgirqhvd30CEL2iHTqAP9kF7t
         sBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=crf/lK1s1ldsW0Tw+pD5ZUVc6HtWvvcIF4KEVSHKYCs=;
        b=XZZQh2LNQqYqVM0ebF6RFYh3SZVePRQL4Pwy5cwhqcEaUqwVyGLDQ/KJtPuBDUg8/7
         JQxZhMBixZ0n6mEAVe412mdS8Y6WBLIngUfixgv7bef0reivVmhugdKyyfb1CF5j9/Vh
         i0R0SUPtsESVps4Yn7A3tjLzWWFQrJnw1xg/IAEax/xPHgFPTqY2gXjHpkeuClGohMwu
         8M9xh7hAQPIicyWFmJpsat56AgSLG0tvKuiqaKqMI5d6r7d0eybb+4t5LLyPq7P8Cgef
         zASSvIzO6x3tIJfJQMTC25OuWoWwRsfaMyP1c2HN583b78Be7nvhBo9oxKdhg+ZGj0Kd
         hLJQ==
X-Gm-Message-State: ACgBeo21fB8VR7yHAb/dsjGBKxn52Rch+Vh4P6BMAxaZs2g1FO2PMSTk
        iZGQOJeitZV6GhvCvQlL4uRzBw==
X-Google-Smtp-Source: AA6agR4psy2iVI6/fRchmfquS+bif8PW2q7V1EgYmOZnqcSeinMvmGjxODB1u3SfgOJboPsudN4f0w==
X-Received: by 2002:a2e:bf16:0:b0:25f:f90a:b856 with SMTP id c22-20020a2ebf16000000b0025ff90ab856mr866672ljr.473.1660289746838;
        Fri, 12 Aug 2022 00:35:46 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id p2-20020a05651211e200b0048af60faabcsm118423lfs.131.2022.08.12.00.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 00:35:46 -0700 (PDT)
Message-ID: <99b5bddb-4a09-a3ac-e01b-d0ae624ad2f8@linaro.org>
Date:   Fri, 12 Aug 2022 10:35:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] dt-bindings: PCI: microchip,pcie-host: fix missing
 clocks properties
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220811203306.179744-1-mail@conchuod.ie>
 <20220811203306.179744-3-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220811203306.179744-3-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2022 23:33, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Upgrading dt-schema to v2022.08 reveals unevaluatedProperties issues
> that were not previously visible, such as the missing clocks and
> clock-names properties for PolarFire SoC's PCI controller:
> arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'legacy-interrupt-controller', 'microchip,axi-m-atr0' were unexpected)
>         From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 
> The clocks are required to enable interfaces between the FPGA fabric
> and the core complex, so add them to the binding.
> 
> Fixes: 6ee6c89aac35 ("dt-bindings: PCI: microchip: Add Microchip PolarFire host binding")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> index edb4f81253c8..2a2166f09e2c 100644
> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> @@ -25,6 +25,31 @@ properties:
>        - const: cfg
>        - const: apb
>  
> +  clocks:
> +    description:
> +      Fabric Interface Controllers, FICs, are the interface between the FPGA
> +      fabric and the core complex on PolarFire SoC. The FICs require two clocks,
> +      one from each side of the interface. The "FIC clocks" described by this
> +      property are on the core complex side & communication through a FIC is not
> +      possible unless it's corresponding clock is enabled. A clock must be
> +      enabled for each of the interfaces the root port is connected through.
> +    minItems: 1
> +    items:
> +      - description: FIC0's clock
> +      - description: FIC1's clock
> +      - description: FIC2's clock
> +      - description: FIC3's clock
> +
> +  clock-names:
> +    items:
> +      enum:
> +        - fic0
> +        - fic1
> +        - fic2
> +        - fic3
> +    minItems: 1
> +    maxItems: 4

No need for maxItems.

Best regards,
Krzysztof
