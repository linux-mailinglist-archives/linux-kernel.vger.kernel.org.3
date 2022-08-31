Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94045A7A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiHaJVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiHaJUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:20:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3910122BE9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:20:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p7so7941304lfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=12RSIGhRtr9b6edhSOV22TS2WqSvQe+u6liWCFLrqB8=;
        b=qCcg3POQ4tieRM9QtfwABLWGqpnyEEaniTbHu1ugJvp9sKy34auvnTs0lEqBSN/Z0K
         fD5UWIgOsYGFoKST0bwvUA7y41KcLsUHwKIn2X3USm1SlqUXVAsBcScaCkeuYuqK/ezS
         iJG9+udA0KscuWNVSE5rwJgx1d2qY+n5IyVu5nG9V9OP5arQBohFctnbKXH+CtS56hJF
         2U4UEhxVrvQhFrc3IiKOtxf2R2CkopRklw6tO/MdgHHMlBFoHTDdh4qDNLuk77V+iPcr
         Bxh+gokElxLaJlNPnsAE08ytcNb5z5uc3djnzdeZ5v+pp/ll60Ds0sLkEs3KRr5uyCm7
         piAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=12RSIGhRtr9b6edhSOV22TS2WqSvQe+u6liWCFLrqB8=;
        b=4bOemUtoqGwRTlSQITKGFXSbpJqArbh04M8gyPqKvc0cE7Deg77BZtEVevX6jfu7+g
         U52heHkxC6phznMfxGj9VcYarcXlpKbBgsthvRV2pBQ2fWxWYf5uL1R1hwPH0ola+mte
         VF8Z/a8OPwcaJEI1yswsVHoW6IBCpXAGC6eZUs3uPxFemInM6iJU4rzmVABzVIjNmCaD
         HVjLaf67i+XncQVVK0K9ZLAvPeHUPs8vQEzBehCPfjdaFPum/nCf6FLQnDzvJ9aEkYcq
         Im9lZjUEMqplgeWVpdSRlEfZpEkFsV4nVDGfF6uzX+/93WqIR2EGgOsNMtGOMM1jn5Tr
         lPBg==
X-Gm-Message-State: ACgBeo0HghODth2bQKQov90rATEOr3ux0jTbmn75k97IqhU3m3MN/ziy
        j0T8ODLJsUmEzJVw7n5Fl5H0rA==
X-Google-Smtp-Source: AA6agR7ifW8MY/9QxhMLiGwfPS/TPCoSLZpYTgLp1IaXRvqBoxDCCGiXCLstB8TPs0RtAsIfWIxIVQ==
X-Received: by 2002:a05:6512:6c8:b0:494:796e:93b6 with SMTP id u8-20020a05651206c800b00494796e93b6mr2297183lff.213.1661937624340;
        Wed, 31 Aug 2022 02:20:24 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id t5-20020a2e5345000000b0025ddad51e48sm1921317ljd.140.2022.08.31.02.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 02:20:23 -0700 (PDT)
Message-ID: <08916db2-65f3-5e0b-7b98-7cbaff5b7059@linaro.org>
Date:   Wed, 31 Aug 2022 12:20:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/6] ASoC: codecs: wsa-macro: add support for sm8450 and
 sc8280xp
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
 <20220818134619.3432-3-srinivas.kandagatla@linaro.org>
 <20220818171222.GG1978870-robh@kernel.org>
 <9c9226d9-8470-6672-d8ce-3fb1e4df3fda@linaro.org>
 <5da6171a-4949-9cc7-2967-6cc39a7955c8@linaro.org>
In-Reply-To: <5da6171a-4949-9cc7-2967-6cc39a7955c8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 12:19, Krzysztof Kozlowski wrote:
> On 31/08/2022 12:17, Srinivas Kandagatla wrote:
>>
>>
>> On 18/08/2022 18:12, Rob Herring wrote:
>>> On Thu, Aug 18, 2022 at 02:46:15PM +0100, Srinivas Kandagatla wrote:
>>>> Add compatible for sm8450 and sc8280xp.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>   sound/soc/codecs/lpass-wsa-macro.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
>>>> index 27da6c6c3c5a..f82c297ea3ab 100644
>>>> --- a/sound/soc/codecs/lpass-wsa-macro.c
>>>> +++ b/sound/soc/codecs/lpass-wsa-macro.c
>>>> @@ -2561,6 +2561,8 @@ static const struct dev_pm_ops wsa_macro_pm_ops = {
>>>>   static const struct of_device_id wsa_macro_dt_match[] = {
>>>>   	{.compatible = "qcom,sc7280-lpass-wsa-macro"},
>>>>   	{.compatible = "qcom,sm8250-lpass-wsa-macro"},
>>>> +	{.compatible = "qcom,sm8450-lpass-wsa-macro"},
>>>> +	{.compatible = "qcom,sc8280xp-lpass-wsa-macro" },
>>>
>>> Looks like these are backwards compatible with the existing versions,
>>> why not reflect that in the binding?
>> Backward compatibility is not always true, some of the registers and 
>> there defaults tend to change across SoCs. Having SoC specific 
>> compatible could help us deal with this and also make code more inline 
>> with other codec macros in LPASS IP.
> 
> I am not saying that there should be no SoC specific compatible. This

s/I am/We are/
I really thought that it was my comment. :)

> one is a must, but the question why duplicating the entries and not
> using fallback?

Best regards,
Krzysztof
