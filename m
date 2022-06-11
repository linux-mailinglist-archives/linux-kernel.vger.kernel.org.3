Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C021E5474BB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiFKNHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiFKNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:07:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F462D1D6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 06:07:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg6so2921374ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t3xj8kLCMLC4vvamPsMzSiJ2niC/wuVI+iAvhlePD7o=;
        b=uX6WgOkG9xeUEUQuPGDSp3BweCStVxvXtlyk0B3FBwtjym/rD9MMlngFbaQABDAmgi
         9CSCdNhrnd1RvoBLmRErP9H4SmS9R2t+7PynV0tQO0+H3ZLNpi2d9Z+8c0RlW0wopeVA
         evrNF74tBijpawDoPa5EitKkHmeYE1lt29RO1qjFRaUtoJju9Y3nQKdxDsX2qWaf2XWM
         YyEURFz2dnwagNa6YWFubYUv/mV5XThSB2iagI/5Qcyt1EjmjgI0YP3nbIsaTsUWGXOE
         BWq8yyADYYhqDG15Y2s+JkPzgiL/gyxOIbMTV3pytHNXsWDxlvOlRSZcLdL6dklRQZWm
         N4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t3xj8kLCMLC4vvamPsMzSiJ2niC/wuVI+iAvhlePD7o=;
        b=ISh0s7Z6GRyVf9FDatGoyt8FI3RDeO9V+rTUOhdbzpwIesuwWGSCAxbtKf3kGp/uu1
         knXmT++4mH+Quqx96JjXOeouhz1wvTmD/53wSxxgXzXxTQutviFiZfzrB2Lln1VVnda0
         dzedSIyMNo94Wb9VyhttCFs5Cm8vVEZnHA72amjamVQcCELUXf/RmCfgipl+4BDe5J7c
         4gNU8xZUF2oI2wDI4GrjjqdGjyX+n8pGB+fl4YZkwd7biM1GLk5AIPvhQf/3rgIi8T7B
         dDks5LXydfW67QBp5gvF1ooI2Y+B7C7yR3aKVB+WAOM5Kz7XN+RuagHRYeaC1tdSPSTu
         1pQw==
X-Gm-Message-State: AOAM532MtFTjxmtmOGvdPXzhHE4IOCNC1zXtzb3LnR0LO2YbU0cijEhr
        XPDzFvONnNaac3/ZAWd/k2V7aw==
X-Google-Smtp-Source: ABdhPJxukTgXWKlc1cHbTbw+Z5q7M3h2i8LlNSYby1pDuVGRC9L+CC2PcCGZvNHYqZrpem+lL2G+Qw==
X-Received: by 2002:a17:906:f84e:b0:70e:6ec8:cc4a with SMTP id ks14-20020a170906f84e00b0070e6ec8cc4amr37889671ejb.694.1654952843286;
        Sat, 11 Jun 2022 06:07:23 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906318200b007121361d54asm1033191ejy.25.2022.06.11.06.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 06:07:22 -0700 (PDT)
Message-ID: <89d6735a-61eb-08cf-8d4a-6fb1b2d457ad@linaro.org>
Date:   Sat, 11 Jun 2022 15:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Kumar Gala <galak@codeaurora.org>
References: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
 <20220529202629.47588-2-krzysztof.kozlowski@linaro.org>
 <20220605150747.GA3465286-robh@kernel.org>
 <54015d41-d4eb-12ae-5bd1-00d2c3cf7814@linaro.org>
 <20220610163343.GA1787330-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220610163343.GA1787330-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 18:33, Rob Herring wrote:
> On Tue, Jun 07, 2022 at 01:15:51PM +0200, Krzysztof Kozlowski wrote:
>> On 05/06/2022 17:07, Rob Herring wrote:
>>> On Sun, May 29, 2022 at 10:26:26PM +0200, Krzysztof Kozlowski wrote:
>>>> The top level qcom,msm-id and qcom,board-id properties are utilized by
>>>> bootloaders on Qualcomm MSM platforms to determine which device tree
>>>> should be used and passed to the kernel.
>>>>
>>>> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
>>>> compatible format") from 2015 was a consensus during discussion about
>>>> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
>>>> problems with that consensus:
>>>> 1. It was reached 7 years ago but it turned out its implementation did
>>>>    not reach all possible products.
>>>>
>>>> 2. Initially additional tool (dtbTool) was needed for parsing these
>>>>    fields to create a QCDT image consisting of multiple DTBs, later the
>>>>    bootloaders were improved and they use these qcom,msm-id and
>>>>    qcom,board-id properties directly.
>>>>
>>>> 3. Extracting relevant information from the board compatible requires
>>>>    this additional tool (dtbTool), which makes the build process more
>>>>    complicated and not easily reproducible (DTBs are modified after the
>>>>    kernel build).
>>>>
>>>> 4. Some versions of Qualcomm bootloaders expect these properties even
>>>>    when booting with a single DTB.  The community is stuck with these
>>>>    bootloaders thus they require properties in the DTBs.
>>>>
>>>> Since several upstreamed Qualcomm SoC-based boards require these
>>>> properties to properly boot and the properties are reportedly used by
>>>> bootloaders, document them.
>>>
>>> My primary issue here is accepting this will be an endorsement for 
>>> other vendors doing something similar. I'm not against an ID 
>>> property(ies) in the root node, but would rather see something common 
>>> if we do anything.
>>
>> Hi Rob,
>>
>> A more common approach was merged back in 2015 - encoding this ID
>> information in the board compatibles. If I understood previous
>> discussion correctly, this common method was later used by Qualcomm DTB
>> post-processing tool. At least for some of the cases.
>>
>> Other cases (several Qualcomm boards from different vendors) still use
>> these ID properties. It even turns out they use it differently between
>> vendors (e.g. Xiaomi vs OnePlus).
>>
>> Important arguments for documenting these properties:
>> 1. These ID properties are already on released boards where changing
>> bootloader is non-trivial or even not possible. It will not be possible
>> to remove these properties, without seriously affecting the community
>> working with them.
> 
> Accepting things because they are already in use is also not a path we 
> want to go down. If it's the color of the bike shed, then fine.
> 
>> 2. According to Konrad [1] (second paragraph), newer chipsets (starting
>> with sm8350 released in 2021) do not use these properties. These newer
>> DTS do not have them.
>>
>> Considering 1+2 above, maybe let's document these properties as
>> compatible? Would that solve your point of "endorsement for other vendors"?
> 
> What do you mean? Only allow them for certain root compatible strings? I 
> suppose that would be okay by me. It would also be useful documentation 
> of where they are needed.

Bah, I wrote something else than I had in mind. So one more try:

Considering 1+2 above, maybe let's document these properties as
*deprecated*? Would that solve your point of "endorsement for other
vendors"?

However the idea to restrict them per-compatible, is also nice. Although
I cannot guarantee the list will not grow for older SoCs.


Best regards,
Krzysztof
