Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2381653DC8B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350868AbiFEPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiFEPTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:19:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D0F4D245
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 08:19:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id s12so17384735ejx.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oeQ2dBbbrjJ6UjOHnoNRGdpPlY/rG7Jr2C3iHZsv+HE=;
        b=oTm1oQMbPRUQIXsFdPGs0cXFmlS91JQKghH8GGXYLwio/Zd1/TFtX4vwLTfGdTFsvO
         YYaAP1sBe/XcQu/itUuZqqXDp/PvsRsQxx4B0JxanSDeX2g06dksjQcbX2nRwcjRcsyd
         9v+AHNzSe7JXcm/MALbds9Sn314r1FDCJJYKcH5fhyvemUXWIdn5Yfh/5ipl2Cl9zsVu
         RUdPIKara9ivGqb4QoKdQeR2uCwMpi13n/hq/g+xXtFHUuaFJT713dI1tTEd+p/RG0FM
         SSlYLeW5W3tfP8+L2F4M7mfbT4/drVrc/l53Ns2axfnZv8z3kcjgkk8D4fvuKE8Qs7UE
         n/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oeQ2dBbbrjJ6UjOHnoNRGdpPlY/rG7Jr2C3iHZsv+HE=;
        b=wOKyCwOI2qlPo4LLnlGsH27GRWdHTR9MwnlgOoIlbBMb/IAwfFO5XXs5sFKzOtJtUR
         8bSKq7GfzwVLlhb9SLCFW3p9wTL25RyGbtERaGYrzjHG6z+FgkLu6I4EM310iDXL19Kg
         ugUyMz3iwAsmhiC2eLMqOB+5gRLC4bdcur1fYoc9BxQOk58FIT1+z7RCXopCsfRN/Xuz
         lZxQPnAIGTDyW5CDhPx+6L6/KxaJJsHyrKih/JxqGdl7W6syyfbqqCFmAxEHQEUy/QZ+
         ZCju90GwNz8l0UgtlSJt//yxS4MvHuJ3/ngGBoiVfNICljeSLIQ1mdMDRJl5mHN8SpaP
         vqKQ==
X-Gm-Message-State: AOAM530WPl9eG9srmkTL4hSkjMzImeMFyBPpQSyO3VlvsESZZ+cTjbVl
        doQobkOm/yi+4av2GQaBzQw1sA==
X-Google-Smtp-Source: ABdhPJzVoJ6Se+FuCA6xFekej6gyRSmzPsQJBHjvW6oiErYsWGKgoEFaqQxzSzhoPyw7FwcDYFKL3A==
X-Received: by 2002:a17:906:c01:b0:711:917c:4c58 with SMTP id s1-20020a1709060c0100b00711917c4c58mr4557355ejf.291.1654442388812;
        Sun, 05 Jun 2022 08:19:48 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l15-20020aa7c3cf000000b0042bdb6a3602sm6755364edr.69.2022.06.05.08.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 08:19:48 -0700 (PDT)
Message-ID: <da07167c-bef3-dfac-c7eb-863913f774fe@linaro.org>
Date:   Sun, 5 Jun 2022 17:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] dt-bindings: pinctrl: deprecate header with register
 constants
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20220526143707.767490-1-krzysztof.kozlowski@linaro.org>
 <20220526143707.767490-8-krzysztof.kozlowski@linaro.org>
 <CACRpkdYS1yV5v7MfqF1hcTe7ETjqOjCYzyLB6KeHHzTzaJbLsA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdYS1yV5v7MfqF1hcTe7ETjqOjCYzyLB6KeHHzTzaJbLsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2022 00:20, Linus Walleij wrote:
> On Thu, May 26, 2022 at 4:37 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> For convenience (less code duplication, some meaning added to raw
>> number), the pin controller pin configuration register values
>> were defined in the bindings header.  These are not some IDs or other
>> abstraction layer but raw numbers used in the registers
>>
>> These constants do not fit the purpose of bindings.  They do not provide
>> any abstraction, any hardware and driver independent ID.  With minor
>> exceptions, the Linux drivers actually do not use the bindings header at
>> all.
>>
>> All of the constants were moved already to headers local to DTS
>> (residing in DTS directory), so remove any references to the bindings
>> header and add a warning tha tit is deprecated.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> This looks like something that needs to be merged on top of the
> other patches so if you wanna merge this through ARM SoC:
> Reviewed-by: Linus Walleij <linus.wallej@linaro.org>
> 
> Else just tell me a merging strategy and I'll use it!

Thanks, actually I should split the bindings from driver changes and
then the driver part could be applied independently. I'll send a v3 and
then I can actually handle cross-tree dependencies between both of my
Samsung tree - SoC and pinctrl.

Best regards,
Krzysztof
