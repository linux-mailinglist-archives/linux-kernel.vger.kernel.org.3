Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3B2525BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377489AbiEMGyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377470AbiEMGy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:54:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B724281356
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:54:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l38-20020a05600c1d2600b00395b809dfbaso3931613wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dM/UD60XbLSqMSyvvmaAVE8YFnIIDSQD84l1NW2QFkM=;
        b=VEYC8qqTXzfWb0QEif5PNJykYQO2QMEHHxuUPsk8euwok+lzR4x7eMx/R6UBl2VbM2
         zPD2aJhPyax/zoEp6ayuyi5l14kz9tjijTYv7vWBA9Nq79oqf3ByGeQMErpcBND4zH1n
         5WVSNFayFhj5tUK9qCM2IL8HsavT1HdKFS4TCRK4HmUBGduucBocNPF1xDbI+XFlCWxO
         Hjm2K5VU/6bwSkOGfyX3g0aMKWE/o9nb3BSRlrvtaSvCbOo3SFr93oZmU7tUcPwCm9+E
         9lvj4jWfY5UPlaL33d/qwjjZtAK0/6+Jq8AywKz65u/n8SsSg6sOtYbmygitx3KA7wVY
         bKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dM/UD60XbLSqMSyvvmaAVE8YFnIIDSQD84l1NW2QFkM=;
        b=064Xi/WHaXR6FGsColwQguPZmhFIjBHdkHr97JD77eCltSt0O13g7Ce3HWt1rN5r8w
         9DkeNqSgpqnexDdXz+i2ghIZzn3pinLZmIP+R1suwxyDmqNHCAx4b96Z5nm4O7kSTqzf
         WKWUfFHIDnXswo6UnXf8JwFyS8hE9mq0hTymCEJ9UHWaergxwTHQdDZqGXhsGDgWyWEx
         8wZwnIRLmIMEx/Y4/VmdAOu6IDfPyQRTZfTFc1Yw2IKYOrSHr52u0IjLtYVxWIDjY9XZ
         grck2iiRMa5nXO/oWjhyffaRJ3GBjvl1jhCcZteUWv1195AFcLhEoETe3x3OWQjguJF8
         41Ug==
X-Gm-Message-State: AOAM5335Z+7ziPe+0EZIWsEcVSsnu1szPqN5oD7G7BWuU3sItSPwVZ2J
        EeS3MB99/DfpbdCEpWNMioXAdg==
X-Google-Smtp-Source: ABdhPJwC6TTLPwnjJetSBa1icGzmaERJpO9MhpyPTBXywNPqL/UclEMB/4tvt4EiXqAN46CARvLc0Q==
X-Received: by 2002:a05:600c:382:b0:394:6172:59dc with SMTP id w2-20020a05600c038200b00394617259dcmr13436287wmd.120.1652424864766;
        Thu, 12 May 2022 23:54:24 -0700 (PDT)
Received: from [192.168.0.167] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d10-20020adfa34a000000b0020cdec3d6dfsm1277477wrb.53.2022.05.12.23.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 23:54:24 -0700 (PDT)
Message-ID: <d2c29e7f-4a16-7abe-fed4-2e4112548a0c@linaro.org>
Date:   Fri, 13 May 2022 08:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V4 2/5] dt-bindings: clock: Document MA35D1 clock
 controller bindings
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ychuang570808@gmail.com
Cc:     robh+dt@kernel.org, sboyd@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, olof@lixom.net, catalin.marinas@arm.com,
        will@kernel.org, soc@kernel.org, cfli0@nuvoton.com
References: <20220510032558.10304-1-ychuang3@nuvoton.com>
 <20220510032558.10304-3-ychuang3@nuvoton.com>
 <f0969769-9f24-7e48-6a60-adeea94404e1@linaro.org>
 <2786221c-d0a5-9bce-70d3-385dc419591a@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2786221c-d0a5-9bce-70d3-385dc419591a@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 08:25, Jacky Huang wrote:
> 
> 
> On 2022/5/12 下午 10:04, Krzysztof Kozlowski wrote:
>> On 10/05/2022 05:25, Jacky Huang wrote:
>>> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
>>>
>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>>> +
>>> +    clk: clock-controller@40460200 {
>>> +        compatible = "nuvoton,ma35d1-clk";
>>> +        reg = <0x0 0x40460200 0x0 0x100>;
>> I don't think you tested your bindings. This fails.
>>
>> clock-names below as well. Please do not send untested code.
>>
>> Testing is explained here:
>> https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.18-rc6%2Fsource%2FDocumentation%2Fdevicetree%2Fbindings%2Fwriting-schema.rst%23L111&amp;data=05%7C01%7Cychuang3%40nuvoton.com%7C7f9b081f94a642e8b40b08da34204e53%7Ca3f24931d4034b4a94f17d83ac638e07%7C0%7C0%7C637879610603173566%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=kqInjscLvZpOSWtsN%2BPW3s%2BPeaK5KCD1weTH2JiHqxg%3D&amp;reserved=0
>>
>> Best regards,
>> Krzysztof
> 
> I run the test  make DT_CHECKER_FLAGS=-m dt_binding_check, but not run 
> dtbs_check.

It is the `make dt_binding_check` which fails here, so what do you mean
that you run it? It cannot pass, the code is clearly not correct.


Best regards,
Krzysztof
