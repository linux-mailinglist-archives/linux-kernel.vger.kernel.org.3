Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7BE5505BF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 17:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiFRPaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 11:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiFRPaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:30:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4B310FD2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 08:30:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c2so11077154lfk.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=1/e1mvC387Kg6krxrVdOK9bDUmZD/rSMjrmBoVChUyY=;
        b=Y6VCMxYgNgyNPMj9zsdsppQoeYQwMpNdVVxdTH+8Wpo+3GjeF3AxYzywaHrQVhf4zb
         19in/R4gVpRDUjzMjunejVzUb8hOvn3teiZsRMiBn5iJDl+14pD2w6cCBWTcWm/qeoai
         fv/OHOcSJ+7AhdkgrXNTwvhqbJtF98snKZKjLEJK3lKgNKHwImezsz4rBuDhhanMzi8w
         GfVjBU/Cl+6ODiKsaabsRg+TgY0E5WZHT5rL6EcbTFh+oHEVRAXLmVYo5hdmtqm4hCLz
         MmnEZDgSBPiigVlx8jvAv6ID84L3mQyXwnAO+mBczGM99ERk46lyHncxt7MKNTkMczWi
         AZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=1/e1mvC387Kg6krxrVdOK9bDUmZD/rSMjrmBoVChUyY=;
        b=n34aUDTi+og3OuSS91DjeHzj3rNeAKADwmkL0NllVbGSivmuoZjm4guLuf9hcrjUQ0
         UEEMYl8TM5RZ0tokGMAdG3HfDa0URLvhdbAF0hjbJJZoW5C4HXhbN4Yjji+xVAFhkqmJ
         dBNoRJP4lQTGqifpjrSBBTXZGEgZQwMHhS+7D1IvtrfOsOCizJbSPYzhVb2LazudF4sS
         gWTEyyPOtGp+JwF0fNe5tQfcvaV4dRWM9GVvRMjuOQVkw5pJJsTbFNzO43RUaaqK2mgq
         rHnfqYpC/UJwINiS1HOSFw4vjocLHlyxaiuXtfsuTRCt5Ut0EMmko7M19pQEhIaU+nca
         1DFQ==
X-Gm-Message-State: AJIora8tvl/HZT+eIUy0Av2XK+2ltj8lkYl+1TeQ1PLcjLxwSuK1S5AA
        jWhq+a5wh1Xw2Pc8i6wRdxnrCQ==
X-Google-Smtp-Source: AGRyM1vsx6BcY+vFiaMfP9N84rL3oHIMRfiZTZnNSPFSz6sBhlqco/EbWtj99hbdbLhtparSH3ujEQ==
X-Received: by 2002:a05:6512:238d:b0:479:2116:8598 with SMTP id c13-20020a056512238d00b0047921168598mr8709693lfv.322.1655566201316;
        Sat, 18 Jun 2022 08:30:01 -0700 (PDT)
Received: from [192.168.43.7] ([188.162.65.10])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9d07000000b002556cf330e8sm956719lji.99.2022.06.18.08.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 08:30:00 -0700 (PDT)
Message-ID: <4f1ae43c-0f22-19fe-0794-3cc268104396@linaro.org>
Date:   Sat, 18 Jun 2022 18:29:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/2] spmi: pmic-arb: Add support for PMIC v7
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201134108.2677578-1-vkoul@kernel.org>
 <YhUVAwtfjuIdKrRQ@matsya> <1c66890b-6736-61ef-7d16-619f90ced4a0@linaro.org>
In-Reply-To: <1c66890b-6736-61ef-7d16-619f90ced4a0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 22:41, Dmitry Baryshkov wrote:
> On 22/02/2022 19:53, Vinod Koul wrote:
>> On 01-02-22, 19:11, Vinod Koul wrote:
>>> Hello,
>>>
>>> The is version 3 of support for PMIC v7. I have added a new property
>>> qcom,bus-id for supporting v7 and then add driver changes for v7
>>>
>>> This depends on yaml conversion patch:
>>> https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/ 
>>>
>>
>> Any feedback on this...
> 
> Another gracious reminder about these patches. At this moment this is 
> one of the important pieces lacking for the full SM8450 support in the 
> upstream kernel.

Stephen, yet another ping. This is the blocking point for the further 
SM8450 progress.

>>> Changes since v2:
>>>   - Drop yaml conversion patch
>>>   - Fix author for spmi patch
>>> Changes since v1:
>>>   - Add yaml conversion patch and new binding
>>>   - fix driver bug report by Jonathan
>>>
>>> David Collins (1):
>>>    spmi: pmic-arb: Add support for PMIC v7
>>>
>>> Vinod Koul (1):
>>>    dt-bindings: spmi: Add qcom,bus-id
>>>
>>>   .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  11 +
>>>   drivers/spmi/spmi-pmic-arb.c                  | 233 ++++++++++++++++--
>>>   2 files changed, 225 insertions(+), 19 deletions(-)
>>>
>>> -- 
>>> 2.31.1
>>
> 
> 


-- 
With best wishes
Dmitry
