Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D2E5328FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiEXL3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbiEXL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:29:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD815880C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:29:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v8so28376214lfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3emZod9jR3q6gCFyPwhXNHJRJq7F+FIV2jGAwBzwi58=;
        b=PnUGqZ1pyposeXIbHLumD+wEv3S0Cs1Wpjjwnkxvb7fzp2T735cLUxZ+diQBX72rOj
         mC+thfNM/6t90Vvel23DzqlzhPsVg3meCoI7/MhhGAOJiAlr+oUDgEtRBOnzNnivmbmr
         zy8xa8X+cAtOOo/0gEqv1UpSdxgqPfs+zN7mZPfS2rJNbJ3tijxU5Z2yHMIzTaIAAn9t
         VjTNPFK0t6Hsx3jj7T7eqNhW7lDK0pcFFzOe+dr0KGLpS02wjGhTkdvBS0gtl25dKQ17
         zR4lAbnSbNtBAc2r00xrsEWHMGw6j+ZSjrbwMoWY0cJX5/Qjz4L6CCuSe0yjcjaZBt/p
         lvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3emZod9jR3q6gCFyPwhXNHJRJq7F+FIV2jGAwBzwi58=;
        b=Ivo4xl8qInNSFyMLQTczp333vWe1lOXyo0v/PEcsDCgtpYnUqfEn4RAiyg/WKJm5NH
         lIdhsfhL4yWxuSwf1xEEuPoJulMdoogj12TASPyiPyhjjNbO6dQU2jDlNXBLbzoUBu6M
         J3FYsIZCGgzY4MczJanYuqsgwVWnC4ShSsO/2v1nyL4XRYR2asmhdu12BbHSbK0NI24w
         YjmBLAHaPEq65ilxwJZ+aLTCKViJLTDfmXKehMNbE2XMlmRsbl6Sv5BSw7n5P5ZJsQCM
         BJYb/vMurHveE01+lfpf5HQ1a1d3YibvKKOVlcX0jjkp/VJr3CcEC2p7mx7Z/5fF+Nka
         STQA==
X-Gm-Message-State: AOAM532K8t+t8jwbuW6kvwkY831jQDZGC8nsHIB0ZKnVmIBQ/rCo0JQf
        O+EFDAc6XJNRfBSI77pR3pIpjg==
X-Google-Smtp-Source: ABdhPJxOJolQvOT14QtdpEQ2d2/n0h6xMUoAUUyC7pPRF3QAELSY8PwJkQeSwOq0216GCHYbyanDHg==
X-Received: by 2002:ac2:550f:0:b0:477:bc6e:9bcc with SMTP id j15-20020ac2550f000000b00477bc6e9bccmr19354559lfk.279.1653391773176;
        Tue, 24 May 2022 04:29:33 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512218400b0047255d21177sm2486692lft.166.2022.05.24.04.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 04:29:32 -0700 (PDT)
Message-ID: <2f49aa26-23f7-833c-b01d-9dfb2603603c@linaro.org>
Date:   Tue, 24 May 2022 13:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: input: use generic node names
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220524093136.7980-1-krzysztof.kozlowski@linaro.org>
 <20220524131152.3d749a9d@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220524131152.3d749a9d@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2022 13:11, Andreas Kemnade wrote:
> Hi,
> 
> On Tue, 24 May 2022 11:31:36 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>> index 7fe1966ea28a..93f601c58984 100644
>> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>> @@ -127,13 +127,13 @@ examples:
>>          compatible = "gpio-keys";
>>          autorepeat;
>>  
>> -        up {
>> +        key-up {
>>              label = "GPIO Key UP";
>>              linux,code = <103>;
>>              gpios = <&gpio1 0 1>;
>>          };
>>  
>> -        down {
>> +        key-down {
>>              label = "GPIO Key DOWN";
>>              linux,code = <108>;
>>              interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> hmm, what about changing
> patternProperties:
>   ".*":
> 
> to enforce this format instead of allowing anything?

It will cause a lot, a lot of warnings, so first these would need to be
fixed in every DTS. That's also doable, might help if these gpio-keys
bindings need any other object like property.


Best regards,
Krzysztof
