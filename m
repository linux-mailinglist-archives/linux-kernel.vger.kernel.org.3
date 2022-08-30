Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487135A6668
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiH3Oho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiH3Ohl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:37:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4308DD4DF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:37:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w19so8613708ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=S7F9EmKhAxxlR+AEkU5K8Cyl9dGbdduAx/ZasRGJQAw=;
        b=kixapq35uVt4DzdUz9BbgA9n3vUIV7izZddPnm1MWYzS3VY72nTrczIB17rUlvUCxV
         XKDOGRYQI7cwYzV4oOXMXzaKgcn0uqtrGMV+gqqkc60BylWldlJ3V1uVO2GP3JXsyoDv
         s/QD1tdIWmdWVVuFdFM2Oef5KZXFvQnh50xnzzebENuNuztfq0bh4+9bmhXGuOVu8mjT
         5GJ7w+YcZwqMesnfiEoxw4ZfaMcgDfmKhLZQbeXVVXMpJidc4A2iyDO8/aboHFVLT+kT
         tEtlEGMV4wP7yUx2z3fHlL2/NUhkJuFYebQJfu26jaTNb6SGAtH30fAGyJH+TLG5vjbA
         ln2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=S7F9EmKhAxxlR+AEkU5K8Cyl9dGbdduAx/ZasRGJQAw=;
        b=OlQ+3QnXfrkoZjkEEDmANvhm740eUHz12NsrGsHhZr1Dt4KOQAUFOZ2BmmP7bb6sY3
         /MnAemg7J3N1RXQTop/cX01PGsKlpT21eVNuIQpMPU1jQCJQILgDkAcM2S/Eadewx2gD
         ogu+AjrPPvlmg7HcUtvJs40TJfubWdyGIM1nARCnXAvt5WqnDdBxo/JES5O3BeuR68Gt
         mAwTfqHKxLm55W0Tl3Bd+DSGpuXoVES5gTOejNBxnxffnemWX7ZLLNDg7yI6ECty1SsN
         dKJ05ynlSifdsOkTsNq9wM384unSGoowEO/0GgyUoiXkoK50BxA7piYQn7jFRaOgAPE7
         ttig==
X-Gm-Message-State: ACgBeo3xOIOZoHcyJ36eFXopXkuvk+6K0tlHs41nItHwAMwBY+NOBnPU
        DKd8GrEWPOEEXciiQG1+EM8R8w==
X-Google-Smtp-Source: AA6agR7PccUNihvG+BB4x1t3fmKV5KUECGFzGTU7UR1DHggFInARzwQIRqnDF8wEfYC1iIDZ6xekDQ==
X-Received: by 2002:a2e:bd8b:0:b0:264:8256:c23f with SMTP id o11-20020a2ebd8b000000b002648256c23fmr3305328ljq.508.1661870258088;
        Tue, 30 Aug 2022 07:37:38 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id f13-20020a056512092d00b00492ed031aacsm1629189lft.173.2022.08.30.07.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 07:37:37 -0700 (PDT)
Message-ID: <a3a8e2ba-a6bd-6e66-fd04-e3a46661a34d@linaro.org>
Date:   Tue, 30 Aug 2022 17:37:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/9] dt-bindings: riscv: microchip: document the aries
 m100pfsevp
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220830101803.1456180-1-conor.dooley@microchip.com>
 <20220830101803.1456180-3-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830101803.1456180-3-conor.dooley@microchip.com>
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

On 30/08/2022 13:17, Conor Dooley wrote:
> Add compatibles for both configurations of the Aries Embedded
> M100PFSEVP SOM + EVK platform.
> 
> Link: https://www.aries-embedded.com/polarfire-soc-fpga-microsemi-m100pfs-som-mpfs025t-pcie-serdes
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/microchip.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
> index 485981fbfb4b..04ebd48caaa7 100644
> --- a/Documentation/devicetree/bindings/riscv/microchip.yaml
> +++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
> @@ -27,9 +27,12 @@ properties:
>  
>        - items:
>            - enum:
> +              - aries,m100pfsevp-emmc
> +              - aries,m100pfsevp-sdcard

Usually sd card is pluggable, so what is the actual difference here? For
example this one:
https://shop.aries-embedded.de/evaluation-kit/m/m100pfsevp/445/m100pfsevp-250baab
has eMMC and SD card...

>                - sundance,polarberry
>            - const: microchip,mpfs
>  
> +

No need for line break.

Best regards,
Krzysztof
